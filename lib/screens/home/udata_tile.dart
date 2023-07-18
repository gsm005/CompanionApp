import 'package:flutter/material.dart';
import 'package:companionapp_mh/models/udata.dart';

class UdataTile extends StatelessWidget {
  final Udata udata;
  UdataTile({required this.udata});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8),
      child: Card(
        margin: EdgeInsets.fromLTRB(20, 6, 20, 0),
        child: Stack(
          children: [
            ListTile(
              leading: CircleAvatar(
                radius: 25,
                backgroundColor: Colors.purple[udata.age],
                backgroundImage: NetworkImage('https://cdn.vectorstock.com/i/1000x1000/51/99/icon-of-user-avatar-for-web-site-or-mobile-app-vector-3125199.webp'),
                //   child: Icon(
                //   Icons.person,
                //   color: Colors.white,
                // ),
              ),
              title: Text(udata.name),
              subtitle: Text(udata.mood),
            ),
            Positioned(
              top: 8,
              right: 8,
              child:
                TextButton.icon(
                  onPressed:(){},
                  icon:Icon(Icons.add, color: Colors.green, size: 30),
                  label:Text('')
                  ),
              ),
          ],
        ),
      ),
    );
  }
}
