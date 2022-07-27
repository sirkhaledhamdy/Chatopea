abstract class SocialStates {}

class SocialInitialState extends SocialStates{}

class SocialGetUserLoadingState extends SocialStates{}

class SocialGetUserSuccessState extends SocialStates{}

class SocialGetUserErrorState extends SocialStates{

  final String error;

  SocialGetUserErrorState(this.error);
}

class SocialGetAllUsersLoadingState extends SocialStates{}

class SocialGetAllUsersSuccessState extends SocialStates{}

class SocialGetAllUsersErrorState extends SocialStates{

  final String error;

  SocialGetAllUsersErrorState(this.error);
}


class SocialGetPostLoadingState extends SocialStates{}

class SocialGetPostSuccessState extends SocialStates{}

class SocialGetPostErrorState extends SocialStates{

  final String error;

  SocialGetPostErrorState(this.error);
}

class SocialGetLikesSuccessState extends SocialStates{}

class SocialGetLikesErrorState extends SocialStates{

  final String error;

  SocialGetLikesErrorState(this.error);
}

class SocialGetCommentsSuccessState extends SocialStates{}

class SocialGetCommentsErrorState extends SocialStates{

  final String error;

  SocialGetCommentsErrorState(this.error);
}

class SocialLikePostSuccessState extends SocialStates{}

class SocialLikePostErrorState extends SocialStates{

  final String error;

  SocialLikePostErrorState(this.error);
}

class SocialCommentPostSuccessState extends SocialStates{}

class SocialCommentPostErrorState extends SocialStates{

  final String error;

  SocialCommentPostErrorState(this.error);
}

class SocialBottomNavChangeState extends SocialStates{}

class SocialNewPostState extends SocialStates{}

class SocialProfilePictureSuccessState extends SocialStates{}

class SocialProfilePictureErrorState extends SocialStates{}

class SocialUploadPictureSuccessState extends SocialStates{}

class SocialUploadPictureErrorState extends SocialStates{}

class SocialUSerUpdateErrorState extends SocialStates{}

class SocialUSerUpdateLoadingState extends SocialStates{}

//create post.
class SocialCreatePostLoadingState extends SocialStates{}

class SocialCreatePostSuccessState extends SocialStates{}

class SocialCreatePostErrorState extends SocialStates{}

class SocialPostPictureSuccessState extends SocialStates{}

class SocialPostPictureErrorState extends SocialStates{}

class SocialPostImageState extends SocialStates{}

class SocialPostDisLikeSuccessState extends SocialStates{}

class SocialPostDisLikeErrorState extends SocialStates{
  final String error;

  SocialPostDisLikeErrorState(this.error);
}

class SocialPostCommentSuccessState extends SocialStates{}

class SocialPostCommentErrorState extends SocialStates{

  final String error;

  SocialPostCommentErrorState(this.error);
}

class SocialSendMessageSuccessState extends SocialStates{}

class SocialSendMessageErrorState extends SocialStates{

  final String error;

  SocialSendMessageErrorState(this.error);
}

class SocialGetMessageSuccessState extends SocialStates{}

class SocialGetMessageErrorState extends SocialStates{

  final String error;

  SocialGetMessageErrorState(this.error);
}


class SocialFollowSuccessState extends SocialStates{}

class SocialFollowErrorState extends SocialStates{

  final String error;

  SocialFollowErrorState(this.error);
}

class SocialUnFollowSuccessState extends SocialStates{}

class SocialUnFollowErrorState extends SocialStates{

  final String error;

  SocialUnFollowErrorState(this.error);
}

class SocialSignOutSuccessState extends SocialStates{}

class SocialSignOutErrorState extends SocialStates{

  final String error;

  SocialSignOutErrorState(this.error);
}



