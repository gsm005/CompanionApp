import 'package:flutter/material.dart';
import 'package:companionapp_mh/questions/answers/ans_model.dart';

class ResultPage extends StatelessWidget {
  final List<Answer> userResponses;

  ResultPage({required this.userResponses});

  double calculateMentalHealthRating(Map<String, int> responses) {
    // Ensure all the questions have been answered before calculating the rating
    if (responses.length < 5) {
      throw ArgumentError('All questions must be answered to calculate the rating.');
    }

    // Define the criteria for each question
    int q1Threshold = 10;
    int q2Threshold = 70;
    int q3Threshold = 60;
    int q4Threshold = 7;
    int q5Threshold = 60;

    // Calculate the score for each question based on the criteria
    int q1Score = responses['first']! >= q1Threshold ? 1 : 0;
    int q2Score = responses['second']! >= q2Threshold ? 1 : 0;
    int q3Score = responses['third']! >=q3Threshold ? 1 : 0;
    int q4Score = responses['xfourth']! > q4Threshold ? 1 : 0;
    int q5Score = responses['yfifth']! >= q5Threshold ? 1 : 0;

    // Calculate the total score and the average rating
    int totalScore = q1Score + q2Score + q3Score + q4Score + q5Score;
    double averageRating = totalScore / 5.0;

    return averageRating;
  }

  String interpretMentalHealthRating(double rating) {
    // Define the thresholds for each mental health category
    double excellentThreshold = 0.8; // 80% and above
    double goodThreshold = 0.6; // 60% and above
    double averageThreshold = 0.4; // 40% and above
    double poorThreshold = 0.2; // 20% and above

    if (rating >= excellentThreshold) {
      return "Excellent";
    } else if (rating >= goodThreshold) {
      return "Good";
    } else if (rating >= averageThreshold) {
      return "Average";
    } else if (rating >= poorThreshold) {
      return "Poor";
    } else {
      return "Very Poor";
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text('Your Mental Health Report'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body:
        ListView.builder(
        itemCount: userResponses.length,
        itemBuilder: (context, index) {
          Answer response = userResponses[index];
          Map<String, dynamic> userResponsesMap = response.answers;

          Map<String, int> userResponsesIntMap = userResponsesMap.map(
                (key, value) {
              if (value is int) {
                return MapEntry(key, value);
              } else if (value is String) {
                // Try parsing the string to an integer
                return MapEntry(key, int.tryParse(value) ?? 0); // Use 0 as default if parsing fails
              } else {
                // Handle other cases (e.g., double, etc.) if necessary
                return MapEntry(key, 0); // Use 0 as default for unknown types
              }
            },
          );


          double mentalHealthRating = calculateMentalHealthRating(userResponsesIntMap);

          String interpretation = interpretMentalHealthRating(mentalHealthRating);

          Widget cardWidget;
          if (mentalHealthRating >= 0.8) {
            cardWidget = WellDoneCard();
          } else if (mentalHealthRating >= 0.6) {
            cardWidget = CompleteTasksCard();
          } else if (mentalHealthRating >= 0.4) {
            cardWidget = CompleteTasksCard(); // You can create a different card widget for Average if needed
          } else {
            cardWidget = SuggestionCard();
          }

          return Card(
            elevation: 4,
            margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'User ID: ${response.uid}',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 8),
                  Divider(color: Colors.grey),
                  SizedBox(height: 8),
                  Text(
                    'Mental Health Rating: ${mentalHealthRating.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Interpretation: $interpretation',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.deepPurple,
                    ),
                  ),
                  SizedBox(height: 16),
                  cardWidget, // Display the selected card widget
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}


class CompleteTasksCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[100], // Customize card color
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Add rounded corners to the card
      child: ListTile(
        title: Text(
          'You are Improving!',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20, // Increase font size
            color: Colors.green[900], // Customize text color
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Stay productive and be happy.',
              style: TextStyle(fontSize: 16), // Customize subtitle font size
            ),
            SizedBox(height: 16), // Add spacing between the two sections

            // Add a container for the suggestions section to add padding and background color
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green[50], // Customize background color
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suggestions:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Customize suggestion header font size
                      color: Colors.green[900], // Customize suggestion header text color
                    ),
                  ),
                  SizedBox(height: 8), // Add spacing between the header and suggestions

                  // List of suggestions
                  Text('- Listen to your favorite music to boost your mood.',style:TextStyle(color: Colors.black,fontSize: 16)),
                  SizedBox(height: 5),
                  Text('- Go outside for a fresh walk to clear your mind.',style:TextStyle(color: Colors.black,fontSize: 16)),
                  SizedBox(height: 5),
                  Text('- Try journaling to reflect on your thoughts and feelings.',style:TextStyle(color: Colors.black,fontSize: 16)),
                  SizedBox(height: 5),
                  Text('- For more suggestions, visit the tasks page.',style:TextStyle(color: Colors.black,fontSize: 16)),
                  SizedBox(height: 5),
                  // Add more suggestions as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
class SuggestionCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.orange[100], // Customize card color
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Add rounded corners to the card
      child: ListTile(
        title: Text(
          'You need to work on Yourself.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20, // Increase font size
            color: Colors.orange[900], // Customize text color
          ),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              'Take some time for yourself and relax.',
              style: TextStyle(fontSize: 16), // Customize subtitle font size
            ),
            SizedBox(height: 16), // Add spacing between the two sections

            // Add a container for the suggestions section to add padding and background color
            Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.green[50], // Customize background color
                borderRadius: BorderRadius.circular(8),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Suggestions:',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20, // Customize suggestion header font size
                      color: Colors.green[900], // Customize suggestion header text color
                    ),
                  ),
                  SizedBox(height: 8), // Add spacing between the header and suggestions

                  // List of suggestions
                  Text('- Take some time for yourself and relax.', style: TextStyle(color: Colors.black, fontSize: 16)),
                  SizedBox(height: 5),
                  Text('- Consider talking to a friend or family member about your feelings.', style: TextStyle(color: Colors.black, fontSize: 16)),
                  SizedBox(height: 5),
                  Text('- Try engaging in activities that bring you joy.', style: TextStyle(color: Colors.black, fontSize: 16)),
                  SizedBox(height: 5),
                  Text('- Consider seeking professional help or counseling.', style: TextStyle(color: Colors.black, fontSize: 16)),
                  SizedBox(height: 5),
                  // Add more suggestions as needed
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}


// Card Widget for Excellent Rating
class WellDoneCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.green[100], // Customize card color
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)), // Add rounded corners to the card
      child: ListTile(
        title: Text(
          'Well Done! Your mental state is good.',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 20, // Increase font size
            color: Colors.green[900], // Customize text color
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Text(
            'You are doing great! Keep up the good work.',
            style: TextStyle(fontSize: 16), // Customize subtitle font size
          ),
        ),
      ),
    );
  }
}
