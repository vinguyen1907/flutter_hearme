import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'bottom_nav_bar_event.dart';
part 'bottom_nav_bar_state.dart';

class BottomNavBarBloc extends Bloc<BottomNavBarEvent, BottomNavBarState> {
  BottomNavBarBloc() : super(BottomNavBarState()) {
    on<UpdateCurrentIndex>(_onUpdateCurrentIndex);
  }

  _onUpdateCurrentIndex(event, emit) {
    emit(BottomNavBarState(currentIndex: event.newIndex));
  }
}
