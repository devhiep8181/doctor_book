part of 'forgot_password_bloc.dart';

class ForgotPasswordEvent extends Equatable {
  const ForgotPasswordEvent();

  @override
  List<Object> get props => [];
}

class CheckEmail extends ForgotPasswordEvent {
  final String email;
  const CheckEmail({
    required this.email,
  });

  @override
  List<Object> get props => [email];
}

class UpdatePassword extends ForgotPasswordEvent {
  final String email;
  final String password;
  const UpdatePassword( {
    required this.password,
    required this.email,
  });
}
