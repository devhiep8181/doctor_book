import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ChatModel extends Equatable {
  final String emailPaitent;
  final String emailDoctor;
  final String content;
  final Timestamp timestamp;
  const ChatModel({
    required this.emailPaitent,
    required this.emailDoctor,
    required this.content,
    required this.timestamp,
  });
  
  @override
  List<Object?> get props =>[emailPaitent, emailDoctor, content, timestamp];
  

  // From Firestore
  factory ChatModel.fromFirestore(DocumentSnapshot doc) {
    return ChatModel(
      emailDoctor: doc['emailDoctor']?.toString() ?? '',
      emailPaitent: doc['emailPaitent']?.toString() ?? '',
      content: doc['content']?.toString() ?? '',
      timestamp: doc['timestamp'],
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'emailDoctor': emailDoctor,
      'emailPaitent': emailPaitent,
      'content': content,
      'timestamp': timestamp,
    };
  }

}
