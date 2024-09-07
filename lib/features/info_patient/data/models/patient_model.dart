import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class PatientModel extends Equatable {
  final String uid;
  final String fullName;
  final String phoneNumber;
  final String birthDay;
  final String gender;
  final String? email;
  final String? city;
  final String? district;
  const PatientModel({
    required this.uid,
    required this.fullName,
    required this.phoneNumber,
    required this.birthDay,
    required this.gender,
    this.email,
    this.city,
    this.district,
  });

  @override
  List<Object?> get props =>
      [uid, fullName, phoneNumber, birthDay, gender, email, city, district];

  // From Firestore
  factory PatientModel.fromFirestore(DocumentSnapshot doc) {
    return PatientModel(
      uid: doc['uid']?.toString() ?? '',
      fullName: doc['fullName']?.toString() ?? '',
      phoneNumber: doc['phoneNumber']?.toString() ?? '',
      birthDay: doc['birthDay']?.toString() ?? '',
      gender: doc['gender']?.toString() ?? '',
      email: doc['email']?.toString() ?? '',
      city: doc['city']?.toString() ?? '',
      district: doc['district']?.toString() ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'fullName': fullName,
      'phoneNumber': phoneNumber,
      'birthDay': birthDay,
      'gender': gender,
      'email': email,
      'city': city,
      'district': district,
    };
  }
}
