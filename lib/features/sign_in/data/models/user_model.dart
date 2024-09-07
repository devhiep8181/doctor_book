import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class UserModel extends Equatable {
  final String email;
  final String password;
  final String name;
  final String pushToken;
  const UserModel({
    required this.email,
    required this.password,
    required this.name,
    required this.pushToken,
  });

  @override
  List<Object?> get props => [email, password, name, pushToken];

  // From Firestore
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    return UserModel(
      email: doc['email']?.toString() ?? '',
      password: doc['password']?.toString() ?? '',
      name: doc['name']?.toString() ?? '',
      pushToken: doc['pushToken']?.toString() ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'name': name,
      'pushToken': pushToken,
    };
  }
}
