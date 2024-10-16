import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

Widget buildProfileInfoRow(String title, String? value) {
  return Row(
    children: [
      Text(
        '$title: ',
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20.sp),
      ),
      Expanded(
        child: Text(
          value ?? 'N/A',
          style: TextStyle(fontSize: 20.sp),
        ),
      ),
    ],
  );
}

Widget buildEditableTextField({
  required String name,
  required String labelText,
  required String initialValue,
  required IconData icon,
  FormFieldValidator<String>? validator,
}) {
  return FormBuilderTextField(
    name: name,
    initialValue: initialValue,
    decoration: InputDecoration(
      labelText: labelText,
      prefixIcon: Icon(icon),
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(30)),
    ),
    validator: validator,
  );
}
