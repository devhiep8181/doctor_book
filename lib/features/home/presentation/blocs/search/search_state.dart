part of 'search_bloc.dart';

class SearchState extends Equatable {

  final String message;
  final List<Doctor> listDoctor;
  final List<Doctor> listDoctorSearch;
  const SearchState({
    required this.message,
    required this.listDoctor,
    required this.listDoctorSearch,
  });

  @override
  List<Object> get props => [message, listDoctor, listDoctorSearch];

  SearchState copyWith({
    String? message,
    List<Doctor>? listDoctor,
    List<Doctor>? listDoctorSearch,
  }) {
    return SearchState(
      message: message ?? this.message,
      listDoctor: listDoctor ?? this.listDoctor,
      listDoctorSearch: listDoctorSearch ?? this.listDoctorSearch,
    );
  }
}
