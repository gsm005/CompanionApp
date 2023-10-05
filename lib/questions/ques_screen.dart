import 'package:companionapp_mh/screens/home/home.dart';
import 'package:flutter/material.dart';
import 'package:companionapp_mh/models/auser.dart';
import 'package:companionapp_mh/questions/answers/ans_model.dart';
import 'package:companionapp_mh/questions/ques_model.dart';
import 'package:companionapp_mh/questions/rdb_connect.dart';
import 'package:companionapp_mh/questions/widgets/next_but.dart';
import 'package:companionapp_mh/questions/widgets/question_wid.dart';
import 'package:companionapp_mh/questions/widgets/res_box.dart';
import 'package:companionapp_mh/shared/loading.dart';
import 'package:provider/provider.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  var db = DBconnect();
  late Future<List<Question>> _questions;
  Map<String, int> _answers = {}; // Use a Map to store answers
  int index = 0;

  @override
  void initState() {
    _questions = get();
    super.initState();
  }

  Future<List<Question>> get() async {
    return db.fetchQuestions();
  }

  void _navigateToHomeScreen() {
    Navigator.pop(context);
  }


  void nextQuestion(int quesLength) async {
    var questions = await _questions;
    final currentUser = Provider.of<Auser?>(context, listen: false);
    final String uid = currentUser?.uid ?? '';

    if (index == quesLength - 1) {
      showDialog(
        context: context,
        barrierDismissible: true,
        builder: (ctx) => ResultBox(onBackToHome: _navigateToHomeScreen),
      );

      // Add the last answer to the _answers Map
      final currentResponse = questions[index].response;
      final questionId = questions[index].id;
      _answers[questionId] = currentResponse;

      try {
        // Update all the user's answers in the database after the last question
        await db.updateAnswer(uid, _answers);
      } catch (error, stackTrace) {
        print('Error while updating answers: $error');
        print('Stack Trace: $stackTrace');
      }

    } else {
      final currentResponse = questions[index].response;
      final questionId = questions[index].id;

      // Add the new answer to the _answers Map
      _answers[questionId] = currentResponse;

      try {
        // Update all the user's answers in the database
        await db.updateAnswer(uid, _answers);
      } catch (error, stackTrace) {
        print('Error while updating answers: $error');
        print('Stack Trace: $stackTrace');
      }

      setState(() {
        index++;
      });
    }
  }
  Color _calculateSliderActiveColor(double value) {
    int r = 255;
    int g = ((1 - (value / 100)) * 255).toInt();
    int b = 0;
    return Color.fromARGB(255, r, g, b);
  }

  @override
  Widget build(BuildContext context) {
    final currentUser = Provider.of<Auser?>(context);
    final String uid = currentUser?.uid ?? '';
    return FutureBuilder(
      future: _questions,
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else if (snapshot.hasData) {
            var extractedData = snapshot.data as List<Question>;
            return Scaffold(
              backgroundColor: Colors.purple[50],
              appBar: AppBar(
                automaticallyImplyLeading: false,
                backgroundColor: Colors.deepPurpleAccent,
                title: Text('Welcome to the Mental Assessment'),
              ),
              body: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20),
                    QuestionWidget(
                      question: extractedData[index].ques,
                      indexAction: index,
                      totalquestion: extractedData.length,
                    ),
                    const SizedBox(height: 10),
                    const Divider(color: Colors.blue,thickness: 10),
                    const SizedBox(height: 150),
                    Container(
                      width: 500, // Set the desired width here
                      child: Column(
                        children: [
                          Stack(
                            children: [
                              Center(
                                // Wrap the Slider and Positioned with Center widget
                                child: SliderTheme(
                                  data: SliderThemeData(
                                    trackHeight: 50, // Increase the slider track height
                                    thumbShape: RoundSliderThumbShape(
                                      enabledThumbRadius: 15, // Increase the slider thumb radius
                                    ),
                                    activeTrackColor:
                                    _calculateSliderActiveColor(extractedData[index].response.toDouble()),
                                    inactiveTrackColor: Colors.yellow[extractedData[index].response * 10],
                                    thumbColor: Colors.yellow[extractedData[index].response * 10],
                                  ),
                                  child: Slider(
                                    min: 0.0,
                                    max: 100.0,
                                    divisions: 100,
                                    value: extractedData[index].response.toDouble(),
                                    onChanged: (val) {
                                      setState(() {
                                        extractedData[index].response = val.toInt();
                                      });
                                    },
                                  ),
                                ),
                              ),
                              Positioned.fill(
                                // Make the Positioned widget fill the available space
                                child: Align(
                                  alignment: Alignment.bottomCenter,
                                  // Align the text to the bottom center
                                  child: Text(
                                    '${extractedData[index].response}',
                                    // Display the current value of the slider
                                    style: TextStyle(
                                      fontSize: 24,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              floatingActionButton: GestureDetector(
                onTap: () => nextQuestion(extractedData.length),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 50),
                  child: NextButton(),
                ),
              ),
              floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
            );
          }
        } else {
          return Center(
            child: Loading(),
          );
        }
        return const Center(
          child: Text('No Data'),
        );
      },
    );
  }
}
