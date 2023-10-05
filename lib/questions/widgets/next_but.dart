import 'package:flutter/material.dart';

class NextButton extends StatelessWidget {
  const NextButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color:Colors.deepPurpleAccent,
      ),
      padding: const EdgeInsets.symmetric(vertical: 10,horizontal: 10),
      child: Text('NEXT',textAlign: TextAlign.center,
      style: TextStyle(fontSize: 37,color: Colors.white)),
    );
  }
}
