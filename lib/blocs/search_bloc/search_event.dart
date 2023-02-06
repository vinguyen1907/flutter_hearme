part of 'search_bloc.dart';

abstract class SearchEvent extends Equatable {
  const SearchEvent();

  @override
  List<Object?> get props => [];
}

class UpdateToSearchingState extends SearchEvent {}

class UpdateToSearchedState extends SearchEvent {
  final Object? filterBy;

  const UpdateToSearchedState({this.filterBy});

  @override
  List<Object?> get props => [filterBy];
}
