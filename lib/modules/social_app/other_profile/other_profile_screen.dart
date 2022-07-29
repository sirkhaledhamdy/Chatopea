import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatopea/constants/constants.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import '../../../constants/components/components.dart';
import '../../../cubits/cubit/cubit.dart';
import '../../../cubits/cubit/states.dart';
import '../../../models/comment_model.dart';
import '../../../models/post_model.dart';
import '../../../styles/colors.dart';
import '../messages/chat_details.dart';

class OtherProfileScreen extends StatefulWidget {
  String uId;
  OtherProfileScreen({Key? key, required this.uId}) : super(key: key);

  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {
  void clearText() {
    commentController.clear();
  }

  var commentController = TextEditingController();
  DateTime nowTime = DateTime.now();

  @override
  void initState() {
    // TODO: implement initState
    // SocialCubit.get(context).getUserData();
    //     // .then((value){
    //   SocialCubit.get(context).getPosts();
    // });
    SocialCubit.get(context).getAnyUserData(widget.uId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SocialCubit, SocialStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var userModel = SocialCubit.get(context).otherUserModel;
        var myModel = SocialCubit.get(context).userModel;
        print("${widget.uId}");
        print(myModel!.uId);
        print(uId);

        return userModel == null
            ? Container()
            : Scaffold(
                appBar: AppBar(),
                body: SingleChildScrollView(
                  physics: const BouncingScrollPhysics(),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Flexible(
                              child: CircleAvatar(
                                radius: 63,
                                backgroundImage: CachedNetworkImageProvider(
                                    '${userModel.image}'),
                              ),
                            ),
                            Flexible(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        '${userModel.name}',
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          fontWeight: FontWeight.w900,
                                          fontSize: 24,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '${userModel.title}',
                                    style: TextStyle(
                                      fontSize: 15,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey.shade600,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    '${userModel.bio}',
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                    Visibility(
                                      visible: (widget.uId != myModel.uId),
                                      child: Row(
                                        children: [
                                          (SocialCubit.get(context)
                                                  .otherUserModel!
                                                  .followers!
                                                  .where((element) =>
                                                      element.uId == myModel.uId)
                                                  .isEmpty)
                                              ? MaterialButton(
                                                  height: 50,
                                                  minWidth: 100,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            30.0),
                                                  ),
                                                  clipBehavior: Clip.antiAlias,
                                                  elevation: 0.0,
                                                  textColor: Colors.white,
                                                  onPressed: () {
                                                    SocialCubit.get(context)
                                                        .followAndUnfollow();
                                                  },
                                                  color: defaultColor,
                                                  child: const Text(
                                                    'Follow',
                                                  ),
                                                )
                                              : MaterialButton(
                                                  height: 50,
                                                  minWidth: 100,
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              30.0),
                                                      side: const BorderSide(
                                                        color: defaultColor,
                                                        width: 1,
                                                      )),
                                                  clipBehavior: Clip.antiAlias,
                                                  elevation: 2.0,
                                                  textColor: defaultColor,
                                                  onPressed: () {
                                                    SocialCubit.get(context)
                                                        .followAndUnfollow();
                                                  },
                                                  color: secDefaultColor,
                                                  child: const Text(
                                                    'Unfollow',
                                                  ),
                                                ),
                                          const SizedBox(
                                            width: 10,
                                          ),
                                          Container(
                                            padding: EdgeInsets.zero,
                                            width: 60,
                                            height: 50,
                                            child: MaterialButton(
                                                minWidth: 40,
                                                color: defaultColor,
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          200.0),
                                                ),
                                                clipBehavior: Clip.antiAlias,
                                                elevation: 0,
                                                textColor: Colors.white,
                                                onPressed: () {
                                                  navigateTo(
                                                      context,
                                                      ChatDetailsScreen(
                                                        userModel: userModel,
                                                      ));
                                                },
                                                child: const Icon(
                                                    Iconsax.messages_14)),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '${(widget.uId == uId)  ? SocialCubit.get(context).myPosts.length : SocialCubit.get(context).userPosts.length}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'Posts',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '${userModel.followers!.length}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'Followers',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                            Expanded(
                              child: InkWell(
                                child: Column(
                                  children: [
                                    Text(
                                      '${userModel.following!.length}',
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 20,
                                      ),
                                    ),
                                    Text(
                                      'Following',
                                      style:
                                          Theme.of(context).textTheme.caption,
                                    ),
                                  ],
                                ),
                                onTap: () {},
                              ),
                            ),
                          ],
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.all(8.0),
                        child: SizedBox(
                          width: double.infinity,
                          height: 1,
                        ),
                      ),
                      SingleChildScrollView(
                        child: ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) =>  bulidPostItem(
                            (widget.uId == uId) ? SocialCubit.get(context).myPosts[index] :SocialCubit.get(context).userPosts[index],
                            context,
                            index,
                            commentController,
                            nowTime,
                            clearText,
                          ),
                          itemCount: (widget.uId == uId) ? SocialCubit.get(context).myPosts.length : SocialCubit.get(context).userPosts.length,
                        ),
                      ),
                    ],
                  ),
                ),
              );
      },
    );
  }
}

Widget bulidPostItem(
  SocialPostModel model,
  context,
  index,
  commentController,
  nowTime,
  clearText,
) =>
    Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(10),
          topRight: Radius.circular(10),
        ),
        boxShadow: [
          // so here your custom shadow goes:
          BoxShadow(
            color: Colors.black
                .withAlpha(40), // the color of a shadow, you can adjust it
            spreadRadius:
                -9, //also play with this two values to achieve your ideal result
            blurRadius: 7,
            offset: const Offset(0,
                -1), // changes position of shadow, negative value on y-axis makes it appering only on the top of a container
          ),
        ],
      ),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        margin: const EdgeInsets.all(15),
        elevation: 0,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () {
                },
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 25,
                      backgroundImage: NetworkImage('${model.image}'),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                '${model.name}',
                                style: const TextStyle(
                                  height: 1.3,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              const Icon(
                                Iconsax.verify5,
                                color: Colors.lightBlue,
                                size: 15,
                              ),
                            ],
                          ),
                          Text(
                            DateFormat('yyyy-MM-dd hh:mm')
                                .format(model.dateTime!),
                            style:
                                Theme.of(context).textTheme.caption!.copyWith(
                                      height: 1.3,
                                    ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(
                      width: 15,
                    ),
                    IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.more_horiz,
                        size: 16,
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  top: 10,
                  bottom: 10,
                ),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
              ),
              Text(
                '${model.text}',
                style: const TextStyle(fontWeight: FontWeight.w500),
              ),
              Padding(
                padding: const EdgeInsetsDirectional.only(
                  bottom: 10,
                  top: 5,
                ),
                child: Container(
                  width: double.infinity,
                ),
              ),
              if (model.postImage != '')
                Container(
                  padding: EdgeInsets.zero,
                  height: 130,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    image: DecorationImage(
                      image: CachedNetworkImageProvider(
                        '${model.postImage}',
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ), //imagepost
              Padding(
                padding: const EdgeInsets.symmetric(
                  vertical: 5.0,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: InkWell(
                        onTap: () {},
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.heart,
                                size: 16,
                                color: defaultColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                "${model.likes!.length} likes",
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: InkWell(
                        onTap: () {
                          Scaffold.of(context).showBottomSheet<void>(
                            (BuildContext context) {
                              return Container(
                                height: double.infinity,
                                color: Colors.transparent,
                                child: SingleChildScrollView(
                                  child: Center(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: <Widget>[
                                        ListView.separated(
                                          separatorBuilder: (context, index) =>
                                              const SizedBox(
                                            height: 5,
                                          ),
                                          scrollDirection: Axis.vertical,
                                          shrinkWrap: true,
                                          physics:
                                              const BouncingScrollPhysics(),
                                          itemBuilder: (context, index) =>
                                              buildCommentItem(
                                            context: context,
                                            index: index,
                                            model: model.comments![index],
                                          ),
                                          itemCount: model.comments!.length,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              );
                            },
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 10,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Icon(
                                CupertinoIcons.text_bubble,
                                size: 16,
                                color: defaultColor,
                              ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                '${model.comments!.length} Comments',
                                style: Theme.of(context).textTheme.caption,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 10.0),
                child: Container(
                  height: 1,
                  width: double.infinity,
                  color: Colors.grey.shade300,
                ),
              ),
              Row(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 18,
                          backgroundImage: NetworkImage(
                              '${SocialCubit.get(context).userModel!.image}'),
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Flexible(
                          child: TextField(
                            textInputAction: TextInputAction.done,
                            onSubmitted: (String) {
                              SocialCubit.get(context).commentPost(
                                SocialCubit.get(context).postId[index],
                                model,
                                index,
                                nowTime,
                                model.image,
                                commentController.text,
                              );
                              clearText();
                            },
                            keyboardType: TextInputType.multiline,
                            maxLines: null,
                            controller: commentController,
                            decoration: InputDecoration(
                              errorText: commentController == null
                                  ? 'Value Can\'t Be Empty'
                                  : null,
                              contentPadding: const EdgeInsets.all(10),
                              isDense: true,
                              hintText: 'Write a comment',
                              hintStyle: const TextStyle(
                                fontSize: 14,
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              border: OutlineInputBorder(
                                borderSide: const BorderSide(
                                  color: Colors.grey,
                                ),
                                borderRadius: BorderRadius.circular(20),
                              ),
                            ),
                          ),
                        ),
                        TextButton(
                          onPressed: () {
                            print("write a comment >>>>");
                            SocialCubit.get(context).commentPost(
                              SocialCubit.get(context).postId[index],
                              model,
                              index,
                              model.dateTime,
                              model.image,
                              commentController.text,
                            );
                            clearText();
                          },
                          child: const Icon(
                            Iconsax.send1,
                            size: 18,
                          ),
                        )
                      ],
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      SocialCubit.get(context).likePost(
                          SocialCubit.get(context).postId[index], model, index);
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Icon(
                          CupertinoIcons.heart_fill,
                          size: 16,
                          color: (model.likes!
                                  .where((element) => element == uId)
                                  .isEmpty)
                              ? Colors.grey
                              : defaultColor,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Like',
                          style: Theme.of(context).textTheme.caption,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

Widget buildCommentItem({SocialCommentModel? model, context, index}) => Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      margin: const EdgeInsets.all(15),
      elevation: 5,
      clipBehavior: Clip.antiAliasWithSaveLayer,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage('${model!.imageUser}'),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            '${model.name}',
                            style: const TextStyle(
                              height: 1.3,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(
                            width: 5,
                          ),
                        ],
                      ),
                      Text(
                        DateFormat('yyyy-MM-dd hh:mm').format(model.dateTime!),
                        style: Theme.of(context).textTheme.caption!.copyWith(
                              height: 1.3,
                            ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.more_horiz,
                    size: 16,
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 10,
              ),
              child: Container(
                height: 1,
                width: double.infinity,
                color: Colors.grey.shade300,
              ),
            ),
            Text(
              '${model.comment}',
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
            Padding(
              padding: const EdgeInsetsDirectional.only(
                bottom: 10,
                top: 5,
              ),
              child: Container(
                width: double.infinity,
              ),
            ), //imagepost
          ],
        ),
      ),
    );
