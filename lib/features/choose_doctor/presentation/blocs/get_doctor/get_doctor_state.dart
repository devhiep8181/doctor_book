part of 'get_doctor_bloc.dart';

sealed class GetDoctorState extends Equatable {
  const GetDoctorState();

  @override
  List<Object> get props => [];
}

class GetDoctorInitial extends GetDoctorState {}

class GetDoctorLoading extends GetDoctorState {}

class GetDoctorSuccess extends GetDoctorState {
  final List<Doctor> listDoctor;
  const GetDoctorSuccess({
    required this.listDoctor,
  });
}

class GetDoctorError extends GetDoctorState {}


