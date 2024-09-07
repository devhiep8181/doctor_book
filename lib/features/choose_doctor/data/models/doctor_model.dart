import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class Doctor extends Equatable {
  final String fullName;
  final String qualification;
  final String department;
  final String workAddress;
  final int yearsOfExperience;
  final String profilePicture;
  final WorkingHours workingHours;
  final int startDay;
  final int endDay;
  final String email;
  final String hospital;

  const Doctor({
    required this.fullName,
    required this.qualification,
    required this.department,
    required this.workAddress,
    required this.yearsOfExperience,
    required this.profilePicture,
    required this.workingHours,
    required this.startDay,
    required this.endDay,
    required this.email,
    required this.hospital,
  });

  // From Firestore
  factory Doctor.fromFirestore(DocumentSnapshot doc) {
    return Doctor(
      fullName: doc['fullName']?.toString() ?? '',
      qualification: doc['qualification']?.toString() ?? '',
      department: doc['department']?.toString() ?? '',
      workAddress: doc['workAddress']?.toString() ?? '',
      yearsOfExperience: doc['yearsOfExperience'] as int? ?? 0,
      profilePicture: doc['profilePicture']?.toString() ?? '',
      workingHours: WorkingHours.fromFirestore(doc['workingHours']),
      startDay: doc['startDay'] as int? ?? 0,
      endDay: doc['endDay'] as int? ?? 0,
      email: doc['email']?.toString() ?? '',
      hospital: doc['hospital']?.toString() ?? ''
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'qualification': qualification,
      'department': department,
      'workAddress': workAddress,
      'yearsOfExperience': yearsOfExperience,
      'profilePicture': profilePicture,
      'workingHours': workingHours.toJson(),
      'startDay': startDay,
      'endDay': endDay,
      'email': email,
      'hospital': hospital,
    };
  }

  @override
  List<Object?> get props => [
        fullName,
        qualification,
        department,
        workAddress,
        yearsOfExperience,
        profilePicture,
        workingHours,
        startDay,
        endDay,
        email,
        hospital
      ];
}

class WorkingHours extends Equatable {
  final String start;
  final String end;

  const WorkingHours({
    required this.start,
    required this.end,
  });

  // From Firestore
  factory WorkingHours.fromFirestore(Map<String, dynamic> doc) {
    return WorkingHours(
      start: doc['start']?.toString() ?? '',
      end: doc['end']?.toString() ?? '',
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'start': start,
      'end': end,
    };
  }

  @override
  List<Object?> get props => [start, end];
}
