import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:task_management_app/features/bottom_nav_bar/presentation/screens/bloc/bottom_nav_bloc.dart';
import 'package:task_management_app/features/completed.dart';
import 'package:task_management_app/features/reminders.dart';
import 'package:task_management_app/features/report/presentation/reports.dart';
import 'package:task_management_app/features/task/presentation/add_task.dart';
import 'package:task_management_app/features/task/presentation/pending.dart';




class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}

int currentIndex = 0;
class _BottomNavState extends State<BottomNav> {
  Color selectedColor = Color.fromRGBO(80, 203, 222, 1);
  Color unSelectedColor = Color(0xff8C8C8C);
  Widget getPage() {
    switch (currentIndex) {
      case 0:
        return Pending(index: currentIndex);
      case 1:
        return Completed(index: currentIndex);
      case 2:
        return Reminders();
      case 3:
        return Reports();
      default:
        return const Center(child: Text("Page not found"));
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BottomNavBloc, BottomNavState>(
      builder: (context, state) {
        return Scaffold(
          body: getPage(),
          bottomNavigationBar: StylishBottomBar(
            items: [
              BottomBarItem(
                icon: const Icon(
                  Icons.style_outlined,
                ),
                selectedIcon: const Icon(
                  Icons.style,
                ),
                selectedColor: selectedColor,
                unSelectedColor: unSelectedColor,
                title: const Text('Pending'),
              ),
              BottomBarItem(
                icon: const Icon(Icons.star_border_rounded),
                selectedIcon: const Icon(Icons.star_rounded),
                selectedColor: selectedColor,
                unSelectedColor: unSelectedColor,
                title: const Text('Completed'),
              ),
              BottomBarItem(
                icon: const Icon(
                  Icons.access_time_outlined,
                ),
                selectedIcon: const Icon(
                  Icons.access_time_filled_outlined,
                ),
                selectedColor: selectedColor,
                unSelectedColor: unSelectedColor,
                title: const Text('Reminders'),
              ),
              BottomBarItem(
                icon: const Icon(
                  Icons.bar_chart_outlined,
                ),
                selectedIcon: const Icon(
                  Icons.bar_chart_outlined,
                ),
                selectedColor: selectedColor,
                unSelectedColor: unSelectedColor,
                title: const Text('Reports'),
              ),
            ],
            hasNotch: true,
            fabLocation: StylishBarFabLocation.center,
            currentIndex: state.currentIndex,
            onTap: (value) {
             
              currentIndex = value;
              context
                  .read<BottomNavBloc>()
                  .add(BottomNavbarChangedEvent(currentIndex: value));
              
            },
            option: AnimatedBarOptions(
              // iconSize: 32,
              barAnimation: BarAnimation.fade,
              iconStyle: IconStyle.Default,
              // opacity: 0.3,
            ),
          ),
          floatingActionButtonLocation:
              FloatingActionButtonLocation.centerDocked,
          floatingActionButton: currentIndex == 0
              ? FloatingActionButton(
                  backgroundColor: Color.fromRGBO(0, 188, 212, 1),
                  shape: CircleBorder(),
                  child: Icon(
                    Icons.edit,
                    color: Colors.black,
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          return AddTaskCard();
                        });
                  })
              : null,
        );
      },
    );
  }
}
