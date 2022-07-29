import 'follow_model.dart';

class SocialUserModel
{
  String? name;
  String? email;
  String? phone;
  String? uId;
  String? image;
  dynamic title;
  dynamic bio;
  bool? isEmailVerified;
  List<SocialFollowModel>? followers = [];
  List<SocialFollowModel>? following = [];

  SocialUserModel({this.name, this.email, this.phone ,  this.uId , this.isEmailVerified, this.image, this.bio, this.title ,  this.followers ,  this.following});

  SocialUserModel.fromJson(Map<String , dynamic>? json)
  {
    email = json!['email'];
    name = json['name'];
    phone = json['phone'];
    uId = json['uId'];
    isEmailVerified = json['isEmailVerified'];
    image = json['image'];
    bio = json['bio'];
    title = json['title'];
    json['followers'].forEach((element){
      followers!.add(SocialFollowModel.fromJson(element,),);
    });
      json['following'].forEach((element){
        following!.add(SocialFollowModel.fromJson(element,),);
      });

  }
  Map<String , dynamic> toMap()
  {
    return {
      'name':name,
      'email': email,
      'phone': phone,
      'uId' : uId,
      'isEmailVerified':isEmailVerified,
      'image':image,
      'bio':bio,
      'title':title,
      'following':List<dynamic>.from(following!.map((x)=>x.toMap())),
      'followers':List<dynamic>.from(followers!.map((x)=>x.toMap())),



    };
  }
}