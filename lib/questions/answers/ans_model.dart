class Answer {
  final String uid;
  final Map<String, dynamic> answers;

  Answer({
    required this.uid,
    required this.answers,
  });

  // Convert the Answer object to a JSON representation
  Map<String, dynamic> toJson() {
    return {
      'uid': uid,
      'answers': answers,
    };
  }
}
