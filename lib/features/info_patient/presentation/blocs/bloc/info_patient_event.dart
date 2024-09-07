part of 'info_patient_bloc.dart';

sealed class InfoPatientEvent extends Equatable {
  const InfoPatientEvent();

  @override
  List<Object> get props => [];
}

class GetInfoPatientEvent extends InfoPatientEvent {}

class SaveInfoPatientEvent extends InfoPatientEvent {
  final PatientModel patientModel;
  const SaveInfoPatientEvent({
    required this.patientModel,
  });
@override
  List<Object> get props => [patientModel];

}


class EditInfoPatientEvent extends InfoPatientEvent{

}