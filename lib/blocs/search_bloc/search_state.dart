// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class Searching extends SearchState {}

class Searched extends SearchState {
  final Object filterBy;

  const Searched({this.filterBy = FilterList.all});

  @override
  List<Object> get props => [filterBy];

  Searched copyWith({
    Object? filterBy,
  }) {
    return Searched(
      filterBy: filterBy ?? this.filterBy,
    );
  }
}
