import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'states.dart';

class SocialLoginCubit extends Cubit<SocialLoginStates> {
  SocialLoginCubit() : super(SocialLoginInitialState());



  static SocialLoginCubit get(context) => BlocProvider.of(context);



  void userLogin({
    required String email,
    required String password,
  }) async{

    emit(SocialLoginLoadingState());

   await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: email,
        password: password,
    ).then((value) {

      emit(SocialLoginsSuccessState(value.user!.uid));
    }).catchError((error){
      print(error.toString());
      emit(SocialLoginErrorState(error.toString()));
    });

  }

  IconData suffix = Icons.visibility;
  bool isPassShown = true;

  void changePassVisibility ()
  {
    isPassShown = !isPassShown;
    suffix = isPassShown == true ? Icons.visibility: Icons.visibility_off;
    emit(SocialchangePassVisibilityState());
  }

  signOut() async {
    try{
      await FirebaseAuth.instance.signOut();
      emit(SocialSignOutSuccessState());
    }catch (e){
      print(e);
      emit(SocialSignOutSuccessState());
    }


  }
}
