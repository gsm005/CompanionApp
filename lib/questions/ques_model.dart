class Question {
  final String id;
  final String ques;
  int response;

  Question({
    required this.id,
    required this.ques,
    this.response = 0,
  });

  @override
  String toString() {
    return 'Question(id:$id,title:$ques,response:$response)';
  }
}
