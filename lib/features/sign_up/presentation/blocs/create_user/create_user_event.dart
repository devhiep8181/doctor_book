part of 'create_user_bloc.dart';

class CreateUserEvent extends Equatable {
  const CreateUserEvent();

  @override
  List<Object> get props => [];
}

class CreatedUserWithEmail extends CreateUserEvent {
  final String email;
  final String passWord;
  final String name;
  const CreatedUserWithEmail({
    required this.email,
    required this.passWord,
    required this.name,
  });
}
