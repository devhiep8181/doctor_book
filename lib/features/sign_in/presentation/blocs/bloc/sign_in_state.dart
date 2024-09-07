part of 'sign_in_bloc.dart';

enum SignInStatus { init, loading, success, error, noFind }

extension SignInStatusX on SignInStatus {
  bool get isSucees => [SignInStatus.success].contains(this);
  bool get isNoFind => [SignInStatus.noFind].contains(this);
  bool get isLoading => [SignInStatus.loading].contains(this);
}

class SignInState extends Equatable {
  const SignInState(
    this.signInStatus, this.user,
  );

  final SignInStatus signInStatus;
  final UserModel user;

  @override
  List<Object> get props => [signInStatus, user];

  SignInState copyWith({
    SignInStatus? signInStatus,
    UserModel? user,
  }) {
    return SignInState(
      signInStatus ?? this.signInStatus,
      user ?? this.user,
    );
  }
}
