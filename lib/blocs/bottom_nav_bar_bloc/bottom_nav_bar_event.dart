part of 'bottom_nav_bar_bloc.dart';

abstract class BottomNavBarEvent extends Equatable {
  const BottomNavBarEvent();

  @override
  List<Object> get props => [];
}

class UpdateCurrentIndex extends BottomNavBarEvent {
  final int newIndex;
  const UpdateCurrentIndex({required this.newIndex});

  @override
  List<Object> get props => [newIndex];
}
