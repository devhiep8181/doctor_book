part of 'create_user_bloc.dart';
 class CreateUserState extends Equatable {
  const CreateUserState();
  
  @override
  List<Object> get props => [];
}

 class CreateUserInitial extends CreateUserState {}


 class CreateUserSuccess extends CreateUserState {}

 class CreateUserLoading extends CreateUserState {}
 
 class CreateUserFailed extends CreateUserState {}