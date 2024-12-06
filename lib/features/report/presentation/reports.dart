import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:task_management_app/features/widgets/text_widget.dart';


class Reports extends StatelessWidget {
   double radius= 30.sp ;
   double centerRadius=25.sp;

  Reports({super.key});
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 3.w, vertical: 3.h),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              textWidget(text:'Task Report',
                fontsize: 19.sp,
                fontwight: FontWeight.bold, color: Colors.black,),
              Stack(
                children: [
                  // Row containing Pie Chart and Legend
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // Pie Chart within AspectRatio for equal width and height
                      SizedBox(
                        height: 30.h,
                        width: 45.w,
                        child: PieChart(
                          PieChartData(
                            sections: [
                              PieChartSectionData(
                                value: 40,
                                color: Colors.blue,
                                title: '40%',
                                radius: radius,
                                titleStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),

                              PieChartSectionData(
                                value: 15,
                                color: Colors.purple,
                                title: '15%',
                                radius: radius,
                                titleStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                              PieChartSectionData(
                                value: 15,
                                color: Colors.green,
                                title: '15%',
                                radius: radius,
                                titleStyle: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                            centerSpaceRadius: centerRadius,
                            sectionsSpace: 2,
                          ),
                        ),
                      ),
                      // Spacing between chart and legend
                      SizedBox(width: 5.w),
                      // Legend (aligned to the right of the pie chart)
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Indicator(color: Colors.blue, text: 'First', isSquare: true),
                          SizedBox(height: 1.h),
                          Indicator(color: Colors.purple, text: 'Third', isSquare: true),
                          SizedBox(height: 1.h),
                          Indicator(color: Colors.green, text: 'Fourth', isSquare: true),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Indicator extends StatelessWidget {
  final Color color;
  final String text;
  final bool isSquare;

  const Indicator({
    required this.color,
    required this.text,
    required this.isSquare,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min, // Ensure the row takes minimal space
      children: <Widget>[
        Container(
          width: 16,
          height: 16,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        SizedBox(width: 4),
        Text(
          text,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
        ),
      ],
    );
  }
}
