part of 'get_doctor_bloc.dart';

sealed class GetDoctorEvent extends Equatable {
  const GetDoctorEvent();

  @override
  List<Object> get props => [];
}



class GetDoctorToFirebase extends GetDoctorEvent{
}


class SearchDoctor extends GetDoctorEvent {
  final String search;
  const SearchDoctor({
    required this.search,
  });

  @override
  List<Object> get props => [search];
}