import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../models/register_model.dart';
import 'states.dart';

class SocialRegisterCubit extends Cubit<SocialRegisterStates> {
  SocialRegisterCubit() : super(SocialRegisterInitialState());

  static SocialRegisterCubit get(context) => BlocProvider.of(context);

  void userRegister({
    required String email,
    required String password,
    required String name,
    required String phone,
  }) async{
    emit(SocialRegisterLoadingState());

    await FirebaseAuth.instance
        .createUserWithEmailAndPassword(
      email: email,
      password: password,
    )
        .then((value) {

      userCreate(
        uId:value.user!.uid,
        phone: phone,
        email: email,
        name: name,
      );
    }).catchError((error) {
      print(error);
      emit(SocialRegisterErrorState(error.toString()));
    });
  }

  void userCreate({
    required String? email,
    required String? name,
    required String? phone,
    required String? uId,
  }) async{
    SocialUserModel? model = SocialUserModel(
      followers: [],
      following: [],
      title: 'Write your title',
      email: email,
      name: name,
      phone: phone,
      uId: uId,
      bio: 'Write Your bio...',
      isEmailVerified: false,
      image: 'https://img.freepik.com/free-photo/waist-up-portrait-handsome-serious-unshaven-male-keeps-hands-together-dressed-dark-blue-shirt-has-talk-with-interlocutor-stands-against-white-wall-self-confident-man-freelancer_273609-16320.jpg',
    );
   await FirebaseFirestore.instance
        .collection('users')
        .doc(uId)
        .set(model.toMap())
        .then((value) {
          emit(SocialCreateUserSuccessState(model.uId));
    }).catchError((error){
      print(error.toString());
          emit(SocialCreateUserErrorState(error.toString()));
    });
  }




  IconData suffix = Icons.visibility;
  bool isPassShown = true;

  void changePassVisibility() {
    isPassShown = !isPassShown;
    suffix = isPassShown == true ? Icons.visibility : Icons.visibility_off;
    emit(SocialRegisterPassVisibilityState());
  }
}
