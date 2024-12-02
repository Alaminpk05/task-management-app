import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:stylish_bottom_bar/stylish_bottom_bar.dart';
import 'package:task_management_app/features/completed.dart';
import 'package:task_management_app/features/reminders.dart';
import 'package:task_management_app/features/report/presentation/reports.dart';
import 'package:task_management_app/features/task/presentation/pending.dart';



class BottomNav extends StatefulWidget {
  const BottomNav({super.key});

  @override
  State<BottomNav> createState() => _BottomNavState();
}
int index=0;
List<Map<String, dynamic>> pageDetails = [
  {

    'page':  Pending(),
  },
  {

    'page':  Completed(),
  },
  {

    'page':  Reminders(),
  }, {

    'page':  Reports(),
  },
];

class _BottomNavState extends State<BottomNav> {
   Color selectedColor = Color.fromRGBO(80, 203, 222, 1);
   Color unSelectedColor = Color(0xff8C8C8C);
  @override
  Widget build(BuildContext context) {
    return Scaffold (
      body: pageDetails[index]['page'],

      bottomNavigationBar:StylishBottomBar(

        items: [
          BottomBarItem(
            icon: const Icon(
              Icons.style_outlined,
            ),
            selectedIcon: const Icon(
              Icons.style,
            ),
            selectedColor:selectedColor,
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
        currentIndex: index,
        onTap: (value) {
          setState(() {
            index=value;
           
          });
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
      floatingActionButton: index==0?FloatingActionButton(
        backgroundColor: Color.fromRGBO(0, 188, 212,1),
        shape:  CircleBorder(),
          child: Icon(Icons.edit,color: Colors.black,),
          onPressed: (){

            showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AddTaskCard();
          });

          }):null,

    );
  }
}

class AddTaskCard extends StatelessWidget {
  const AddTaskCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 6, sigmaY: 6),
      child: AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        title: Column(
          children: [
            Container(
              height: 45,
              width: 45,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 20,
                    spreadRadius: 0,
                    offset: Offset(0, 0),
                  )
                ],
                color: Colors.white,
              ),
              child: const Icon(
                Icons.note_alt_outlined,
                color: Color.fromARGB(255, 143, 128, 128),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                'New task',
                style: TextStyle(
                  fontSize: 23,
                  color: const Color.fromARGB(255, 143, 128, 128),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        content: SizedBox(
          height: 9.h,
          child: TextField(

             maxLines: null,
            expands: false,
            style: TextStyle(
              color: const Color.fromARGB(255, 128, 124, 124),
            ),
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(18.sp),
              ),
              filled: false,
              hintText: 'What are you planning?',
              hintStyle:TextStyle(
                color: const Color(0xff9C9A9A),
              ),
            ),
    // controller: textEditingController,
            onChanged: (value) {

            },
            onTapOutside: (event) {

            },
          ),
        ),
        actionsAlignment: MainAxisAlignment.spaceEvenly,
        actions: <Widget>[
          TextButton(
            child: Text(
              "Cancel",
              style: TextStyle(
                fontSize: 15,
                color: Colors.red,
              ),
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            onPressed: (){},
            child: Text(
              "Create",
              style: TextStyle(
                fontSize: 15,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
