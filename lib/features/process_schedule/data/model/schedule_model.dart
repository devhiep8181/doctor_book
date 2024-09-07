import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class ScheduleModel extends Equatable {
  final String daySchedule;
  final String timeSchedule;
  final int status; //0: từ chối, 1: đồng ý, 2: đang chờ
  final String uidPatient;
  final String uidDoctor;
  final String? uidSchedule;
  const ScheduleModel({
    required this.daySchedule,
    required this.timeSchedule,
    required this.status,
    required this.uidPatient,
    required this.uidDoctor,
    this.uidSchedule,
  });

  @override
  List<Object?> get props =>
      [daySchedule, timeSchedule, status, uidPatient, uidDoctor, uidSchedule];

  // From Firestore
  factory ScheduleModel.fromFirestore(DocumentSnapshot doc) {
    return ScheduleModel(
      daySchedule: doc['daySchedule']?.toString() ?? '',
      timeSchedule: doc['timeSchedule']?.toString() ?? '',
      status: doc['status'] ?? 0,
      uidPatient: doc['uidPatient']?.toString() ?? '',
      uidDoctor: doc['uidDoctor']?.toString() ?? '',
      uidSchedule: doc.id,
    );
  }

  // To JSON
  Map<String, dynamic> toJson() {
    return {
      'daySchedule': daySchedule,
      'timeSchedule': timeSchedule,
      'status': status,
      'uidPatient': uidPatient,
      'uidDoctor': uidDoctor,
    };
  }

  ScheduleModel copyWith({
    String? daySchedule,
    String? timeSchedule,
    int? status,
    String? uidPatient,
    String? uidDoctor,
    String? uidSchedule,
  }) {
    return ScheduleModel(
      daySchedule: daySchedule ?? this.daySchedule,
      timeSchedule: timeSchedule ?? this.timeSchedule,
      status: status ?? this.status,
      uidPatient: uidPatient ?? this.uidPatient,
      uidDoctor: uidDoctor ?? this.uidDoctor,
      uidSchedule: uidSchedule ?? this.uidSchedule,
    );
  }
}
