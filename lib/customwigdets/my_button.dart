import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class mybutton extends StatelessWidget {
  final String btext;
  final Color color;
  final void Function()? ontap;
  double fontSize = 16;
  mybutton({
    super.key,
    required this.btext,
    this.ontap,
    required this.color,
    required double fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w, vertical: 10.h),
        child: Container(
          decoration: BoxDecoration(
              color: color, borderRadius: BorderRadius.circular(20.r)),
          width: double.maxFinite,
          height: 50.h,
          child: Center(
            child: Text(
              btext,
              style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                  color: Colors.white),
            ),
          ),
        ),
      ),
    );
  }
}
