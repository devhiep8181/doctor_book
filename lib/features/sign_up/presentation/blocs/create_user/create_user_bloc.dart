import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_book/base/base_remote_data.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/features/sign_in/data/models/user_model.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../../common/config/app_cache.dart';

part 'create_user_event.dart';
part 'create_user_state.dart';

class CreateUserBloc extends Bloc<CreateUserEvent, CreateUserState> {
  CreateUserBloc() : super(CreateUserInitial()) {
    on<CreatedUserWithEmail>(_onCreatedUserWithEmail);
  }

  FutureOr<void> _onCreatedUserWithEmail(
      CreatedUserWithEmail event, Emitter<CreateUserState> emit) async {

    emit(CreateUserLoading());
    try {
      final firebaseAuth = FirebaseAuth.instance;
      final firebaseStore = FirebaseFirestore.instance;

      final listUser = await BaseRemoteData().getData(
          collectionName: 'user', fromFirestore: UserModel.fromFirestore);

      for (int i = 0; i < listUser.length; i++) {
        if (listUser[i].email == event.email) {
          emit(CreateUserFailed());
          return;
        }
      }
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: event.email,
        password: event.passWord,
      );

      final firebaseUser = firebaseAuth.currentUser;
      log('user: $firebaseUser');

      await firebaseStore.collection('user').doc(event.email).set({
        'name': event.name,
        'email': event.email,
        'password': event.passWord,
        'pushToken': UserSingleton().pushToken,
      }, SetOptions(merge: false)).then((_) {
        log('CREATE USER SUCCESSFULLY');
      });
      AppCache.setString('user', event.email);
      UserSingleton().login(email: event.email, name: event.name);
      log('USERRRRRRRRR =>>>>> ${UserSingleton().email}');
      emit(CreateUserSuccess());
      emit(CreateUserInitial());
    } catch (e) {
      emit(CreateUserFailed());
    }
  }
}
