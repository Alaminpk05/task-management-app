part of 'bottom_nav_bloc.dart';

@immutable
sealed class BottomNavEvent {}

final class BottomNavbarChangedEvent extends BottomNavEvent {
  final int currentIndex;

  BottomNavbarChangedEvent({required this.currentIndex});
}
