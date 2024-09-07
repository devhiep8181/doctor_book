import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:doctor_book/base/base_remote_data.dart';
import 'package:doctor_book/features/sign_in/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

part 'forgot_password_event.dart';
part 'forgot_password_state.dart';

class ForgotPasswordBloc
    extends Bloc<ForgotPasswordEvent, ForgotPasswordState> {
  ForgotPasswordBloc() : super(ForgotPasswordInitial()) {
    on<CheckEmail>((event, emit) async {
      emit(ForgotPasswordLoading());

      final listUser = await BaseRemoteData().getData(
          collectionName: 'user', fromFirestore: UserModel.fromFirestore);

      for (int i = 0; i < listUser.length; i++) {
        if (listUser[i].email == event.email) {
          emit(ForgotPasswordOk());
          emit(ForgotPasswordInitial());

          return;
        }
      }
      emit(ForgotPasswordError());
      emit(ForgotPasswordInitial());
    });

    on<UpdatePassword>((event, emit) async {
      emit(ForgotPasswordLoading());

      final listUser = await BaseRemoteData().getData(
          collectionName: 'user', fromFirestore: UserModel.fromFirestore);

      for (int i = 0; i < listUser.length; i++) {
        if (listUser[i].email == event.email) {
          await BaseRemoteData().updatePassword(event.password, event.password);
          emit(ForgotPasswordOk());
          emit(ForgotPasswordInitial());

          return;
        }
      }
      ForgotPasswordError();
      ForgotPasswordInitial();
    });
  }
}
