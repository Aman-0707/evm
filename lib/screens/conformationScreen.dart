import 'package:flutter/material.dart';
import '../customwigdets/my_button.dart';
import '../screens/bottomnavbar.dart';

class ConfirmationPage extends StatelessWidget {
  final Map<String, dynamic> formData;

  ConfirmationPage({required this.formData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(vertical: 90, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Registration Details',
              style: TextStyle(fontSize: 26, color: Colors.purpleAccent),
            ),
            SizedBox(height: 16),
            _buildDetailItem('Name', formData['name']),
            _buildDetailItem('Email', formData['email']),
            _buildDetailItem('Phone', formData['phone']),
            _buildDetailItem('Event Date', formData['event_date'].toString()),
            _buildDetailItem('Event Type', formData['event_type']),
            _buildDetailItem('Comments', formData['comments'] ?? 'No comments'),
            SizedBox(height: 24),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                mybutton(
                  fontSize: 16,
                  color: Colors.green,
                  ontap: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(content: Text('Registration confirmed!')),
                    );
                    Future.delayed(Duration(seconds: 2), () {
                      Navigator.of(context).pushAndRemoveUntil(
                        MaterialPageRoute(builder: (context) => Mainscreen()),
                        (Route<dynamic> route) => false,
                      );
                    });
                  },
                  btext: 'Confirm',
                ),
                mybutton(
                  fontSize: 16,
                  color: Colors.red,
                  ontap: () {
                    Navigator.of(context).pop();
                  },
                  btext: 'Edit',
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailItem(String label, String value) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 100,
            child: Text(
              '$label:',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: Text(value),
          ),
        ],
      ),
    );
  }
}
