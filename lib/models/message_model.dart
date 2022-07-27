import 'comment_model.dart';

class SocialMessageModel
{
  String? senderId;
  String? receiverId;
  DateTime? dateTime;
  String? text;


  SocialMessageModel({this.text,this.dateTime, this.receiverId, this.senderId,});

  SocialMessageModel.fromJson(Map<String , dynamic>? json)
  {

    dateTime = json!['dateTime'].toDate();
    text = json['text'];
    receiverId = json['receiverId'];
    senderId = json['senderId'];

  }
  Map<String , dynamic> toMap()
  {
    return {

      'dateTime':dateTime,
      'text':text,
      'senderId':senderId,
      'receiverId':receiverId,


    };
  }
}