import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_book/features/info_patient/data/models/patient_model.dart';
import 'package:doctor_book/features/process_schedule/data/model/schedule_model.dart';
import 'package:firebase_auth/firebase_auth.dart';

class BaseRemoteData {
  final firebaseAuth = FirebaseAuth.instance;
  final firebaseStore = FirebaseFirestore.instance;

  @override
  Future<List<T>> getData<T>(
      {required String collectionName,
      required T Function(DocumentSnapshot<Object?> p1) fromFirestore}) async {
    final listData = <T>[];
    final getDataFireStore =
        await firebaseStore.collection(collectionName).get();
    final data = getDataFireStore.docs;
    for (final doc in data) {
 
      listData.add(fromFirestore(doc));
    }

    return listData;
  }

  Future<void> savePatient(PatientModel patientModel) async {
    await firebaseStore
        .collection("patient")
        .add(patientModel.toJson())
        .then((value) {
      log('===============> ${value.id}');
    });
  }

  Future<void> updatePatient(PatientModel patientModel) async {
    await firebaseStore
        .collection("patient")
        .add(patientModel.toJson())
        .then((value) {
      log('===============> ${value.id}');
    });
  }

  Future<void> schedule(ScheduleModel scheduleMode) async {
    await firebaseStore
        .collection("schedule")
        .add(scheduleMode.toJson())
        .then((value) {
      log('===============> ${value.id}');
    });
  }

  Future<void> updatePassword(String password, String email) async {
    await firebaseStore.collection('user').doc(email).update({
      'password': password,
    }).then((_) {
      print('update password success!');
    });
  }

  Future<void> updateSchedule(String uid, int status) async {
    await firebaseStore.collection('schedule').doc(uid).update({
      'status': status,
    }).then((_) {
      print('update schedule success!');
    });
  }

  Future<void>deleteSchedule(String uid) async{
     await firebaseStore.collection('schedule').doc(uid).delete().then((_) {
    print("success!");
  });
  }
}
