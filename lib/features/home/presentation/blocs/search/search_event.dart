part of 'search_bloc.dart';

class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object> get props => [];
}

class SearchInit extends SearchEvent {}

class SearchDoctor extends SearchEvent {
  final String textSearch;
  SearchDoctor({
    required this.textSearch,
  });

  @override
  // TODO: implement props
  List<Object> get props => [textSearch];
}

class SearchDepartment extends SearchEvent {
  final String textSeatch;
  const SearchDepartment({
    required this.textSeatch,
  });

  @override
  List<Object> get props => [textSeatch];
}
