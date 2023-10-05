import 'package:flutter/material.dart';
class TaskCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final VoidCallback onTap;

  const TaskCard({
    required this.title,
    required this.imageUrl,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 250,
      child: Card(
        child: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: NetworkImage(imageUrl),
              fit: BoxFit.cover,
            ),
          ),
          child: ListTile(
            title: Text(title,style: TextStyle(fontSize: 20)),
            onTap: onTap,
          ),
        ),
      ),
    );
  }
}
