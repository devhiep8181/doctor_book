part of 'info_patient_bloc.dart';

enum InfoPatientStatus { init, loading, success, error }

extension InfoPatientStatusX on InfoPatientStatus {
  bool get isSuccess => [InfoPatientStatus.success].contains(this);
}

class InfoPatientState extends Equatable {
  const InfoPatientState(this.infoPatientStatus, this.patientModel, this.message);

  final InfoPatientStatus infoPatientStatus;
  final PatientModel patientModel;
  final String message;

  @override
  List<Object> get props => [infoPatientStatus, patientModel, message];

  InfoPatientState copyWith({
    InfoPatientStatus? infoPatientStatus,
    PatientModel? patientModel,
    String? message,
  }) {
    return InfoPatientState(
      infoPatientStatus ?? this.infoPatientStatus,
      patientModel ?? this.patientModel,
      message ?? this.message,
    );
  }
}
