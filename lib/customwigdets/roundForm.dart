import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildRoundedTextField(
    {required String name,
    required String labelText,
    required IconData icon,
    FormFieldValidator<String>? validator}) {
  return Padding(
    padding: EdgeInsets.only(bottom: 16.h),
    child: FormBuilderTextField(
      name: name,
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: TextStyle(fontSize: 16.sp),
        prefixIcon: Icon(icon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(color: Colors.purpleAccent),
        ),
      ),
      validator: validator,
    ),
  );
}
