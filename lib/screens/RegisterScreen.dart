import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../customwigdets/my_button.dart';
import '../screens/conformationScreen.dart';

import '../customwigdets/roundForm.dart';

class EventRegistrationForm extends StatefulWidget {
  @override
  _EventRegistrationFormState createState() => _EventRegistrationFormState();
}

class _EventRegistrationFormState extends State<EventRegistrationForm> {
  final _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Event Registration',
          style: TextStyle(fontSize: 24.sp),
        ),
        backgroundColor: Colors.white,
        elevation: 1,
      ),
      body: Container(
        color: Colors.white,
        padding: EdgeInsets.all(16.w),
        child: SingleChildScrollView(
          child: FormBuilder(
            key: _formKey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildRoundedTextField(
                  name: 'name',
                  labelText: 'Name',
                  icon: Icons.person,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length > 70) {
                      return 'Name should be less than 70 characters';
                    }
                    return null;
                  },
                ),
                buildRoundedTextField(
                  name: 'email',
                  labelText: 'Email',
                  icon: Icons.email,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                        .hasMatch(value)) {
                      return 'Please enter a valid email address';
                    }
                    return null;
                  },
                ),
                buildRoundedTextField(
                  name: 'phone',
                  labelText: 'Phone Number',
                  icon: Icons.phone,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your phone number';
                    }
                    if (!RegExp(r'^\d{10}$').hasMatch(value)) {
                      return 'Please enter a valid 10-digit phone number';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                FormBuilderDateTimePicker(
                  name: 'event_date',
                  inputType: InputType.date,
                  decoration: InputDecoration(
                    labelText: 'Event Date',
                    labelStyle: TextStyle(fontSize: 16.sp),
                  ),
                  validator: (value) {
                    if (value == null) {
                      return 'Please select an event date';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                FormBuilderDropdown<String>(
                  name: 'event_type',
                  decoration: InputDecoration(
                    labelText: 'Event Type',
                    labelStyle: TextStyle(fontSize: 16.sp),
                  ),
                  items: ['Wedding', 'Birthday', 'Corporate', 'Other']
                      .map((type) => DropdownMenuItem(
                            value: type,
                            child:
                                Text(type, style: TextStyle(fontSize: 16.sp)),
                          ))
                      .toList(),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please select an event type';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.h),
                FormBuilderTextField(
                  name: 'comments',
                  decoration: InputDecoration(
                    labelText: 'Comments',
                    labelStyle: TextStyle(fontSize: 16.sp),
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 24.h),
                mybutton(
                  fontSize: 20.sp,
                  color: Colors.purpleAccent,
                  ontap: () {
                    if (_formKey.currentState?.saveAndValidate() ?? false) {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => ConfirmationPage(
                            formData: _formKey.currentState!.value,
                          ),
                        ),
                      );
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content:
                              Text('Please correct the errors in the form.'),
                        ),
                      );
                    }
                  },
                  btext: 'Submit',
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
