import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import '../../constants/constants.dart';
import '../../models/change_favourite_model.dart';
import '../../models/comment_model.dart';
import '../../models/follow_model.dart';
import '../../models/message_model.dart';
import '../../models/post_model.dart';
import '../../models/register_model.dart';
import '../../modules/social_app/feeds/feeds_screen.dart';
import '../../modules/social_app/followers/followers_screen.dart';
import '../../modules/social_app/messages/chat_screen.dart';
import '../../modules/social_app/profile/profile_screen.dart';
import '../../network/local/cache_helper.dart';
import 'states.dart';

class SocialCubit extends Cubit<SocialStates> {
  SocialCubit() : super(SocialInitialState());

  static SocialCubit get(context) => BlocProvider.of(context);

  SocialUserModel? userModel;
  SocialUserModel? otherUserModel;
  SocialPostModel? postModel;
  // SocialCommentModel? commentModel;

  getUserData() async {
    uId = CacheHelper.getData(key: 'uId');
    emit(SocialGetUserLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      if (uId != null) {
        userModel = SocialUserModel.fromJson(value.data());
      }
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  getAnyUserData(uId) async {
    emit(SocialGetUserLoadingState());

    await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .get()
        .then((value) {
      if (uId != null) {
        otherUserModel = SocialUserModel.fromJson(value.data());
      }
      emit(SocialGetUserSuccessState());
    }).catchError((error) {
      print(error.toString());
      emit(SocialGetUserErrorState(error.toString()));
    });
  }

  int currentIndex = 0;

  List<Widget> screens = [
    SocialFeedsScreen(),
    ChatScreen(),
    FollowersScreen(),
    SocialProfileScreen(),
  ];

  void changeBottomNav(int index) {
    if (index == 1) {
      getUsers();
    }
    currentIndex = index;
    emit(SocialBottomNavChangeState());
  }

  File? profileImage;
  final ImagePicker _picker = ImagePicker();

  Future getImage() async {
    final XFile? image =
        await _picker.pickImage(source: ImageSource.gallery, imageQuality: 50);

    if (image != null) {
      profileImage = File(image.path);
      emit(SocialProfilePictureSuccessState());
    } else {
      print('Image not selected');
      emit(SocialProfilePictureErrorState());
    }
  }

  final storage = FirebaseStorage.instance;
  uploadImage({
    required String? name,
    required String? phone,
    required String? bio,
    required String? title,
    String? image,
  }) async {
    emit(SocialUSerUpdateLoadingState());
    await FirebaseStorage.instance
        .ref()
        .child('users/${Uri.file(profileImage!.path).pathSegments.last}')
        .putFile(profileImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        // emit(SocialUploadPictureSuccessState());
        updateUserData(
          name: name,
          phone: phone,
          bio: bio,
          title: title,
          image: value,
        );
      }).catchError((error) {});
    }).catchError((error) {
      emit(SocialUploadPictureErrorState());
      print(error);
    });
  }

  void updateUserData({
    String? name,
    String? phone,
    String? bio,
    String? title,
    String? image,
  }) {
    emit(SocialUSerUpdateLoadingState());
    print(userModel!.followers);
    print(userModel!.following);
    SocialUserModel? model = SocialUserModel(
      name: name ?? userModel!.name,
      title: title ?? userModel!.title,
      bio: bio ?? userModel!.bio,
      phone: phone ?? userModel!.phone,
      email: userModel!.email,
      isEmailVerified: false,
      image: image ?? userModel!.image,
      uId: userModel!.uId,
      followers: userModel!.followers,
      following: userModel!.following,
    );
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .update(model.toMap())
        .then((value) {
      getUserData();
    }).catchError((error) {
      print(error.toString());
      emit(SocialUSerUpdateErrorState());
    });
  }

  //posts.
  void createPost({
    required DateTime? dateTime,
    required String? text,
    String? postImage,
  }) {
    emit(SocialCreatePostLoadingState());
    SocialPostModel? model = SocialPostModel(
      name: userModel!.name,
      image: userModel!.image,
      uId: userModel!.uId,
      dateTime: dateTime,
      text: text,
      postImage: postImage ?? '',
      likes: [],
      comments: [],
    );

    FirebaseFirestore.instance
        .collection('posts')
        .add(model.toMap())
        .then((value) {
      emit(SocialCreatePostSuccessState());
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
    });
  }

  File? postImage;
  Future getPostImage() async {
    final XFile? image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      postImage = File(image.path);
      emit(SocialPostPictureSuccessState());
    } else {
      print('Image not selected');
      emit(SocialPostPictureErrorState());
    }
  }

  void removePostImage() {
    postImage = null;
    emit(SocialPostImageState());
  }

  void uploadPostImage({
    required DateTime? dateTime,
    required String? text,
  }) {
    emit(SocialCreatePostLoadingState());
    FirebaseStorage.instance
        .ref()
        .child('posts/${Uri.file(postImage!.path).pathSegments.last}')
        .putFile(postImage!)
        .then((value) {
      value.ref.getDownloadURL().then((value) {
        createPost(
          text: text,
          dateTime: dateTime,
          postImage: value,
        );
      }).catchError((error) {
        emit(SocialCreatePostErrorState());
      });
    }).catchError((error) {
      emit(SocialCreatePostErrorState());
      print(error);
    });
  }

  List<SocialPostModel> posts = [];
  List<String> postId = [];

  getPosts() async {
    posts = [];
    postId = [];
    myPosts = [];
    userPosts = [];
    FirebaseFirestore.instance
        .collection('posts')
        .orderBy('dateTime', descending: true)
        .snapshots()
        .listen((event) {
      {
        for (var element in event.docs) {
          postId.add(element.id);
          posts.add(SocialPostModel.fromJson(element.data()));
        }
        if (myPosts.isEmpty) {
          myPosts = posts.where((element) => element.uId == uId).toList();
        }
        if (userPosts.isEmpty) {
          userPosts = posts.where((element) => element.uId != uId).toList();
        }
        emit(SocialGetPostSuccessState());
      }
    });
  }

  List<SocialPostModel> myPosts = [];
  List<SocialPostModel> userPosts = [];
  List<SocialPostModel> loadedPosts = [];

  void likePost(String postId, SocialPostModel postModel, int index) async {
    SocialLikeModel? likeModel = SocialLikeModel(
      isLike: true,
      userId: uId,
    );

    loadedPosts = posts;
    posts = [];

    if (postModel.likes!
        .where((element) => element == likeModel.userId)
        .isEmpty) {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayUnion([likeModel.userId]),
      }).then((value) {
        posts[index].likes!.add(likeModel.userId!);
        emit(SocialLikePostSuccessState());
      }).catchError((error) {
        print(error.toString());
        posts = loadedPosts;
        emit(SocialLikePostErrorState(error.toString()));
      });
    } else {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'likes': FieldValue.arrayRemove([likeModel.userId]),
      }).then((value) {
        posts[index].likes!.remove(likeModel.userId!);
        emit(SocialPostDisLikeSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialPostDisLikeErrorState(error.toString()));
      });
    }
  }

  void commentPost(String postId, SocialPostModel postModel, int index,
      DateTime? dateTime, String? userImage, String? comment) async {
    SocialCommentModel? commentModel = SocialCommentModel(
      userId: uId,
      dateTime: dateTime,
      imageUser: userModel!.image,
      comment: comment,
      name: userModel!.name,
    );

    loadedPosts = posts;
    posts = [];

    if (postModel.comments!
        .where((element) => element == commentModel)
        .isEmpty) {
      await FirebaseFirestore.instance.collection('posts').doc(postId).update({
        'comments': FieldValue.arrayUnion([commentModel.toMap()]),
      }).then((value) {
        // posts[index].comments!.add(commentModel);
        print(commentModel.imageUser);
        emit(SocialPostCommentSuccessState());
      }).catchError((error) {
        posts = loadedPosts;
        print(error.toString());
        emit(SocialPostCommentErrorState(error.toString()));
      });
    }
    // else {
    //   await FirebaseFirestore.instance.collection('posts').doc(postId).update({
    //     'comments': FieldValue.arrayRemove([commentModel]),
    //   }).then((value) {
    //     posts[index].comments!.remove(commentModel);
    //     emit(SocialPostDisLikeSuccessState());
    //   }).catchError((error) {
    //     print(error.toString());
    //     emit(SocialPostDisLikeErrorState(error.toString()));
    //   });
    // }
  }

  List<SocialUserModel> allUsers = [];

  getUsers() async {
    allUsers = [];
    if (allUsers.isEmpty) {
      await FirebaseFirestore.instance.collection('users').get().then((value) {
        for (var element in value.docs) {
          if (element.data()['uId'] != userModel!.uId) {
            allUsers.add(SocialUserModel.fromJson(element.data()));
          }
          emit(SocialGetAllUsersSuccessState());
        }
      }).catchError((error) {
        print(error.toString());
        emit(SocialGetAllUsersErrorState(error.toString()));
      });
    }
  }

  sendMessage({
    required String? receiverId,
    required DateTime? dateTime,
    required String? text,
  }) async {
    SocialMessageModel messageModel = SocialMessageModel(
      text: text,
      senderId: userModel!.uId,
      receiverId: receiverId,
      dateTime: dateTime,
    );
    await FirebaseFirestore.instance
        .collection('users')
        .doc(receiverId)
        .collection('chats')
        .doc(userModel!.uId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });

    await FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .add(messageModel.toMap())
        .then((value) {
      emit(SocialSendMessageSuccessState());
    }).catchError((error) {
      emit(SocialSendMessageErrorState(error.toString()));
    });
  }

  bool? loadingMessages;
  List<SocialMessageModel> messages = [];
  getMessages({required String? receiverId}) async {
    loadingMessages = true;
    FirebaseFirestore.instance
        .collection('users')
        .doc(userModel!.uId)
        .collection('chats')
        .doc(receiverId)
        .collection('messages')
        .orderBy(
          'dateTime',
          descending: true,
        )
        .snapshots()
        .listen((event) {
      messages = [];
      event.docs.forEach((element) {
        messages.add(SocialMessageModel.fromJson(element.data()));
      });
      loadingMessages = false;
      emit(SocialGetMessageSuccessState());
    });
  }

  void followAndUnfollow(
      // { required SocialUserModel myModel , required SocialUserModel userModel  }
      ) async {
    SocialFollowModel? followerModel = SocialFollowModel(
      uId: otherUserModel!.uId,
      image: otherUserModel!.image,
      name: otherUserModel!.name,
    );
    SocialFollowModel? myFollowModel = SocialFollowModel(
      uId: userModel!.uId,
      image: userModel!.image,
      name: userModel!.name,
    );
    if (otherUserModel!.followers!
        .where((element) => element.uId == userModel!.uId)
        .isEmpty) {
      //my Following add.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myFollowModel.uId)
          .update({
        'following': FieldValue.arrayUnion([followerModel.toMap()]),
      }).then((value) {
        userModel!.following!.add(followerModel);
      }).catchError((error) {
        print(error.toString());
        emit(SocialFollowErrorState(error.toString()));
      });
      //his Followers add.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(followerModel.uId)
          .update({
        'followers': FieldValue.arrayUnion([myFollowModel.toMap()]),
      }).then((value) {
        otherUserModel!.followers!.add(myFollowModel);
        emit(SocialFollowSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialFollowErrorState(error.toString()));
      });
    } else {
      //my Following remove.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(myFollowModel.uId)
          .update({
        'following': FieldValue.arrayRemove([followerModel.toMap()]),
      }).then((value) {
        userModel!.following!
            .removeWhere((element) => element.uId == followerModel.uId);
      }).catchError((error) {
        print(error.toString());
        emit(SocialUnFollowErrorState(error.toString()));
      });
      //his Followers remove.
      await FirebaseFirestore.instance
          .collection('users')
          .doc(followerModel.uId)
          .update({
        'followers': FieldValue.arrayRemove([myFollowModel.toMap()]),
      }).then((value) {
        otherUserModel!.followers!
            .removeWhere((element) => element.uId == myFollowModel.uId);
        emit(SocialUnFollowSuccessState());
      }).catchError((error) {
        print(error.toString());
        emit(SocialUnFollowErrorState(error.toString()));
      });
    }
  }

  signOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      emit(SocialSignOutSuccessState());
    } catch (e) {
      print(e);
      emit(SocialSignOutSuccessState());
    }
  }
}
