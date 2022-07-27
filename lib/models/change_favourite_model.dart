class SocialLikeModel
{
  bool? isLike = false;
  String? userId;

  SocialLikeModel({this.isLike, this.userId});

  SocialLikeModel.fromJson(Map<String , dynamic>? json)
  {
    isLike = json!['isLike'];
    userId = json['userId'];
  }
  Map<String , dynamic> toMap()
  {
    return {
      'isLike':isLike,
      'userId' : userId,
    };
  }
}