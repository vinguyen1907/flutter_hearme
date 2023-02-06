part of 'onboarding_bloc.dart';

class OnboardingEvent extends Equatable {
  const OnboardingEvent();

  @override
  List<Object> get props => [];
}

class SetNewIndex extends OnboardingEvent {
  final int newIndex;
  const SetNewIndex({required this.newIndex});

  @override
  List<Object> get props => [newIndex];
}
