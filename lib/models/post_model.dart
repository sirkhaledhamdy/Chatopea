import 'comment_model.dart';

class SocialPostModel
{
  String? name;
  String? uId;
  String? image;
  DateTime? dateTime;
  String? text;
  String? postImage;
  List<String>? likes;
  List<SocialCommentModel>? comments = [];

  SocialPostModel({this.text,this.name,this.uId ,this.image,this.dateTime,this.postImage,this.likes, this.comments});

  SocialPostModel.fromJson(Map<String , dynamic>? json)
  {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];
    dateTime = json['dateTime'].toDate();
    text = json['text'];
    postImage = json['postImage'];
    likes = json['likes'].cast<String>() ;
    json['comments'].forEach((element){
      comments!.add(SocialCommentModel.fromJson(element,),);
    });
  }
  Map<String , dynamic> toMap()
  {
    return {
      'name':name,
      'uId' : uId,
      'image':image,
      'dateTime':dateTime,
      'text':text,
      'postImage':postImage,
      'likes':likes,
      'comments':comments,

    };
  }
}