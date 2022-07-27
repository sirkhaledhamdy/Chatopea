
abstract class SocialLoginStates{}

class SocialLoginInitialState extends SocialLoginStates{}

class SocialLoginLoadingState extends SocialLoginStates{}

class SocialLoginsSuccessState extends SocialLoginStates
{
final String? uId;

  SocialLoginsSuccessState(this.uId);

}

class SocialLoginErrorState extends SocialLoginStates{

  final String error;
  SocialLoginErrorState(this.error);
}
class SocialchangePassVisibilityState extends SocialLoginStates{}

class SocialSignOutSuccessState extends SocialLoginStates{}

class SocialSignOutErrorState extends SocialLoginStates{

  final String error;

  SocialSignOutErrorState(this.error);
}