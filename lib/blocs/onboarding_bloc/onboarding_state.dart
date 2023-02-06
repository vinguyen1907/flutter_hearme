part of 'onboarding_bloc.dart';

class OnboardingState extends Equatable {
  final int currentIndex;
  const OnboardingState({this.currentIndex = 0});

  @override
  List<Object> get props => [currentIndex];
}
