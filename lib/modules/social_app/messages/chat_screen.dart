import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:iconsax/iconsax.dart';
import '../../../constants/components/components.dart';
import '../../../constants/constants.dart';
import '../../../cubits/cubit/cubit.dart';
import '../../../cubits/cubit/states.dart';
import '../../../models/register_model.dart';
import '../../../styles/adaptive/adaptivw_indicator.dart';
import '../../../styles/colors.dart';
import 'chat_details.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    return BlocConsumer<SocialCubit , SocialStates>(
      listener: (context , state){},
      builder: (context , state){
        return RefreshIndicator(
          onRefresh: ()async{
            await SocialCubit.get(context).getUsers();
          },
          child: Scaffold(
            appBar: AppBar(
              elevation: 0,
              centerTitle: false,
              title: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  children: const [
                    Icon(Iconsax.messages,
                    color: defaultColor,
                    ),
                    SizedBox(width: 10,),
                    Text('Chats',
                    style: TextStyle(
                      color: defaultColor,
                    ),
                    ),
                  ],
                ),
              ),
            ),
            body: (SocialCubit.get(context).allUsers.isNotEmpty )?Padding(
              padding: const EdgeInsets.symmetric(vertical: 8.0,),
              child: Column(
                children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Container(
                  width: double.infinity,
                  height: 1,
                  color: Colors.grey.shade300,
                  ),
                ),
                  SingleChildScrollView(

                    child: ListView.separated(
                      reverse: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemBuilder: (context , index) => buildChatItem(SocialCubit.get(context).allUsers[index] , context),
                      separatorBuilder: (context , index) => Padding(
                        padding: const EdgeInsetsDirectional.only(start: 16 , bottom: 20 , top: 20,),
                        child: Container(
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          height: 1,),
                      ),
                      itemCount: SocialCubit.get(context).allUsers.length ,
                    ),
                  ),
                ],
              ),
            ): Center(child: AdaptiveIndicator(
              os: getOS(),
            ),),
          ),
        );
      },

    );
  }
  Widget buildChatItem(SocialUserModel model , context) => InkWell(
    onTap: (){
      navigateTo(context, ChatDetailsScreen(
        userModel: model,
      ));
    },
    child: Padding(
      padding: const EdgeInsets.all(16.0),
      child: Row(
        children: [
          CircleAvatar(
            radius: 25,
            backgroundImage: NetworkImage(
                '${model.image}'),
          ),
          const SizedBox(
            width: 15,
          ),
          Text(
            '${model.name}',
            style: const TextStyle(
              height: 1.3,
              fontWeight: FontWeight.w600,
            ),
          ),
          const Spacer(),
          IconButton(onPressed: (){}, icon: const Icon(Iconsax.message4,
          color: defaultColor,
          ),)
        ],
      ),
    ),
  );
}