import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:hear_me/constants/constants.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(Searching()) {
    on<UpdateToSearchingState>(_onUpdateSearchingState);
    on<UpdateToSearchedState>(_onUpdateSearchedState);
  }

  _onUpdateSearchingState(event, emit) {
    emit(Searching());
  }

  _onUpdateSearchedState(event, emit) {
    emit(Searched().copyWith(filterBy: event.filterBy));
  }
}
