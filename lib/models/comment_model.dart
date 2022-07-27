class SocialCommentModel
{
  String? name;
  String? userId;
  String? imageUser ;
  DateTime? dateTime;
  String? comment;


  SocialCommentModel({this.comment, this.userId , this.dateTime , this.name , this.imageUser});

  SocialCommentModel.fromJson(Map<String , dynamic>? json)
  {
    name = json!['name'];
    userId = json['userId'];
    imageUser = json['imageUser'];
    dateTime = json['dateTime'].toDate();
    comment = json['comment'];
  }
  Map<String , dynamic> toMap()
  {
    return {
      'userId' : userId,
      'name' : name,
      'imageUser' : imageUser,
      'dateTime' : dateTime,
      'comment' : comment,
    };
  }
}