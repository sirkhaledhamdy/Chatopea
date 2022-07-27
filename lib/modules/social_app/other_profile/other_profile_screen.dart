import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';

import '../../../constants/components/components.dart';
import '../../../cubits/cubit/cubit.dart';
import '../../../cubits/cubit/states.dart';
import '../../../styles/colors.dart';
import '../messages/chat_details.dart';

class OtherProfileScreen extends StatefulWidget {
  String? uId;
  OtherProfileScreen({Key? key, required this.uId}) : super(key: key);


  @override
  State<OtherProfileScreen> createState() => _OtherProfileScreenState();
}

class _OtherProfileScreenState extends State<OtherProfileScreen> {

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
      listener: (context , state){},
      builder: (context , state){
        var userModel = SocialCubit.get(context).otherUserModel;
        var myModel = SocialCubit.get(context).userModel;

        return
          userModel == null ? Container(): Scaffold(
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
                                '${userModel.image}'
                            ),
                          ),
                        ),
                        Flexible(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
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
                                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                children: [
                                  (SocialCubit.get(context).otherUserModel!.followers.where((element) => element.uId == myModel!.uId).isEmpty) ?MaterialButton(
                                    height: 50,
                                    minWidth: 100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 0.0,
                                    textColor: Colors.white,
                                    onPressed: () {
                                      SocialCubit.get(context).followAndUnfollow();
                                    },
                                    color: defaultColor,
                                    child:  const Text(
                                      'Follow',
                                    ),
                                  ) :MaterialButton(
                                    height: 50,
                                    minWidth: 100,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30.0),
                                      side: const BorderSide(
                                        color: defaultColor,
                                        width: 1,
                                      )
                                    ),
                                    clipBehavior: Clip.antiAlias,
                                    elevation: 2.0,
                                    textColor: defaultColor,
                                    onPressed: () {
                                      SocialCubit.get(context).followAndUnfollow();
                                    },
                                    color: secDefaultColor,
                                    child:  const Text(
                                      'Unfollow',
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Container(
                                    padding:EdgeInsets.zero,
                                    width: 60,
                                    height: 50,
                                    child: MaterialButton(
                                        minWidth: 40,
                                        color: defaultColor,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(200.0),
                                        ),
                                        clipBehavior: Clip.antiAlias,
                                        elevation: 0,
                                        textColor: Colors.white,
                                        onPressed: () {
                                          navigateTo(context, ChatDetailsScreen(
                                            userModel: userModel,
                                          ));
                                        },

                                        child: const Icon(Iconsax.messages_14)
                                    ),
                                  ),
                                ],
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
                                const Text(
                                  '38',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Posts',
                                  style:Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '${userModel.followers.length}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Followers',
                                  style:Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                Text(
                                  '${userModel.following.length}',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Following',
                                  style:Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            child: Column(
                              children: [
                                const Text(
                                  '22',
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                  ),
                                ),
                                Text(
                                  'Photos',
                                  style:Theme.of(context).textTheme.caption,
                                ),
                              ],
                            ),
                            onTap: (){},
                          ),
                        ),

                      ],
                    ),
                  ),
                  Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(children: const [],)
                  ),
                ],
              ),
            ),
          );
      },
    );
  }
}


