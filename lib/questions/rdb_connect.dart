import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:companionapp_mh/questions/answers/ans_model.dart';
import 'package:companionapp_mh/questions/ques_model.dart';

class DBconnect {
  final String questionsUrl = 'https://buddyapp-1ff21-default-rtdb.firebaseio.com/questions.json';
  final String answersUrl = 'https://buddyapp-1ff21-default-rtdb.firebaseio.com/answers.json';

  Future<List<Question>> fetchQuestions() async {
    final response = await http.get(Uri.parse(questionsUrl));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      List<Question> questions = [];
      data.forEach((key, value) {
        var question = Question(
          id: key,
          ques: value['ques'],
        );
        questions.add(question);
      });
      return questions;
    } else {
      throw Exception('Failed to fetch questions.');
    }
  }

  Future<void> addAnswer(Answer answer) async {
    final response = await http.post(Uri.parse(answersUrl), body: json.encode(answer.toJson()));

    if (response.statusCode != 200) {
      throw Exception('Failed to add answer.');
    }
  }

  Future<void> updateAnswer(String uid, Map<String, dynamic> answers) async {
    final response = await http.put(
      Uri.parse('https://buddyapp-1ff21-default-rtdb.firebaseio.com/answers/$uid.json'),
      body: json.encode(answers),
    );

    print(response.statusCode);
    print(response.body);

    if (response.statusCode != 200) {
      throw Exception('Failed to update answer.');
    }
  }

  Future<List<Answer>> fetchAnswersByUser(String uid) async {
    final response = await http.get(Uri.parse('https://buddyapp-1ff21-default-rtdb.firebaseio.com/answers.json'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body) as Map<String, dynamic>;
      List<Answer> answers = [];
      data.forEach((uniqueAnswerId, value) {
        if (uniqueAnswerId == uid) {
          answers.add(Answer(
            uid: uniqueAnswerId,
            answers: value as Map<String, dynamic>,
          ));
        }
      });
      return answers;
    } else {
      print('Failed to fetch answers by user. Status code: ${response.statusCode}');
      throw Exception('Failed to fetch answers by user.');
    }
  }

}
