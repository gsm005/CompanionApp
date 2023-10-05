import 'package:flutter/material.dart';
class ResultBox extends StatelessWidget {
  final VoidCallback onBackToHome;
  // final VoidCallback onSaveResponses;
  const ResultBox({required this.onBackToHome ,Key? key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.deepPurpleAccent,
      content: Padding(
        padding: const EdgeInsets.all(70),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Thanks For Performing the Test!',
              style: const TextStyle(color: Colors.white, fontSize: 25),
            ),
            const SizedBox(height: 25),
            IconButton(
              onPressed: () {
                // Call the callback function to navigate back to the home screen
                onBackToHome();
                // Close the dialog
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.check_circle_outline,
                color: Colors.green,
                size: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
