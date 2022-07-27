
class SocialFollowModel
{
  String? name;
  String? uId;
  String? image;

  SocialFollowModel({this.name,this.uId ,this.image});

  SocialFollowModel.fromJson(Map<String , dynamic>? json)
  {
    name = json!['name'];
    uId = json['uId'];
    image = json['image'];

  }
  Map<String , dynamic> toMap()
  {
    return {
      'name':name,
      'uId' : uId,
      'image':image,

    };
  }
}