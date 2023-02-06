// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'theme_event.dart';
part 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  ThemeBloc() : super(LightTheme()) {
    on<ChangeTheme>(_onChangeTheme);
  }

  _onChangeTheme(event, emit) {
    emit(
      state is LightTheme ? DarkTheme() : LightTheme(),
    );
  }
}
