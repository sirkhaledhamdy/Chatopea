import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../constants/components/components.dart';
import '../../../cubits/cubit/cubit.dart';
import '../../../cubits/cubit/states.dart';
import '../../../models/follow_model.dart';
import '../../../styles/colors.dart';
import '../other_profile/other_profile_screen.dart';

class FollowersScreen extends StatelessWidget {
  const FollowersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultTabController(
      initialIndex: 0,
      length: 2,
      child: BlocConsumer<SocialCubit , SocialStates>(
        listener: (context , state){},
        builder: (context , state){
          return Scaffold(
            appBar: AppBar(
              title: Center(
                child: Text(
                  '${SocialCubit.get(context).userModel!.name}',
                  style: const TextStyle(
                    fontSize: 16,
                  ),
                ),
              ),
              bottom: PreferredSize(
                preferredSize: const Size.fromHeight(50.0),
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.symmetric(
                        horizontal: BorderSide(
                          color: Colors.grey.shade300,
                        )
                    ),
                  ),
                  child: const TabBar(
                    labelColor: Colors.grey,
                    indicatorColor: defaultColor,
                    indicatorSize: TabBarIndicatorSize.label,
                    tabs: <Widget>[
                      Tab(
                        text: 'Followers',
                      ),
                      Tab(
                        text: 'Following',
                      ),
                    ],
                  ),
                ),
              ),
            ),
            body: TabBarView(
              children:  [
                ListView.builder(
                  itemBuilder: (context , index) => buildFollowItem(SocialCubit.get(context).userModel!.followers[index]  , context, index),
                  itemCount: SocialCubit.get(context).userModel!.followers.length,
                ),
                ListView.builder(
                  itemBuilder: (context , index) => buildFollowItem(SocialCubit.get(context).userModel!.following[index]  , context, index),
                  itemCount: SocialCubit.get(context).userModel!.following.length,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}


Widget buildFollowItem(SocialFollowModel? followModel  , context  ,index) => GestureDetector(
  onTap: (){
      navigateTo(context, OtherProfileScreen(uId: followModel!.uId,));
  },
  child: Padding(
    padding: const EdgeInsets.all(16.0),
    child: Row(
      children: [
        CircleAvatar(
          radius: 25,
          backgroundImage: NetworkImage(
              '${followModel!.image}'),
        ),
        const SizedBox(
          width: 15,
        ),
        Text(
          '${followModel.name}',
          style: const TextStyle(
            height: 1.3,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
  ),
);