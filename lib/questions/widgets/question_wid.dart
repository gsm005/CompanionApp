import 'package:flutter/material.dart';

class QuestionWidget extends StatelessWidget {
  QuestionWidget({
    Key? key,
    required this.question,
    required this.indexAction,
    required this.totalquestion,
  }) : super(key: key);

  final String question;
  final int indexAction;
  final int totalquestion;

  // List of colors for each question
  final List<Color> questionColors = [
    Colors.purple[200]!,
    Colors.blue[200]!,
    Colors.green[200]!,
    Colors.orange[300]!,
    Colors.yellow[300]!,
    // Add more colors if needed
  ];

  @override
  Widget build(BuildContext context) {
    // Select the color based on the indexAction
    final cardColor = questionColors[indexAction % questionColors.length];

    return Card(
      color: cardColor,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          alignment: Alignment.centerLeft,
          child: Text(
            'Q${indexAction + 1}. $question',
            style: TextStyle(
              fontSize: 30.0,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
