import 'dart:async';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:doctor_book/base/base_remote_data.dart';
import 'package:doctor_book/common/config/app_cache.dart';
import 'package:doctor_book/common/config/user_singleton.dart';
import 'package:doctor_book/features/sign_in/data/models/user_model.dart';
import 'package:equatable/equatable.dart';

part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc()
      : super(const SignInState(
            SignInStatus.init, UserModel(email: '', password: '', name: '', pushToken: ''))) {
    

    on<CheckAccount>(_onCheckAccount);
    on<SubmitSignIn>(_onSubmitSignIn);
  }

  //kiểm tra sự tồn tại của email
  FutureOr<void> _onCheckAccount(
      CheckAccount event, Emitter<SignInState> emit) async {
    emit(state.copyWith(signInStatus: SignInStatus.loading));

    final listUser = await BaseRemoteData().getData(
        collectionName: 'user', fromFirestore: UserModel.fromFirestore);
    UserModel? user;
    for (int i = 0; i < listUser.length; i++) {
      if (listUser[i].email == event.email) {
        user = listUser[i];
        if (user.password == event.password) {
          AppCache.setString('user', user.email);
          UserSingleton().login(email: user.email, name: user.name);
          log('USERRRRRRRRR =>>>>> ${UserSingleton().email}');

          emit(state.copyWith(signInStatus: SignInStatus.success, user: user));
        } else {
          emit(state.copyWith(signInStatus: SignInStatus.error));
        }

        emit(state.copyWith(signInStatus: SignInStatus.init));

        return;
      }
    }
    emit(state.copyWith(signInStatus: SignInStatus.noFind));

    emit(state.copyWith(signInStatus: SignInStatus.init));

    log('list user: ${listUser.length}');
    listUser.forEach((e) {
      log('ELEMENT ============> $e');
    });
  }

  FutureOr<void> _onSubmitSignIn(
      SubmitSignIn event, Emitter<SignInState> emit) {}
}
