part of 'bottom_nav_bar_bloc.dart';

class BottomNavBarState extends Equatable {
  int currentIndex;
  BottomNavBarState({this.currentIndex = 0});

  @override
  List<Object> get props => [currentIndex];
}
