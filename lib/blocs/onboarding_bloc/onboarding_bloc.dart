// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'onboarding_event.dart';
part 'onboarding_state.dart';

class OnboardingBloc extends Bloc<OnboardingEvent, OnboardingState> {
  OnboardingBloc() : super(const OnboardingState()) {
    on<SetNewIndex>(_onSetNewIndex);
  }

  _onSetNewIndex(event, emit) {
    emit(OnboardingState(currentIndex: event.newIndex));
  }
}
