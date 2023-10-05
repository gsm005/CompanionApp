import 'package:companionapp_mh/models/udata.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:companionapp_mh/screens/home/udata_list.dart';
import 'package:companionapp_mh/models/auser.dart';
import 'package:companionapp_mh/services/database.dart';

class UdataPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final Auser? currentUser = Provider.of<Auser?>(context);
    final String uid = currentUser?.uid ?? '';

    return StreamProvider<List<Udata>>.value(
      initialData: [],
      value: DatabaseService(uid: uid).udata,
      child: Scaffold(
        appBar: AppBar(
          title: Text('HeyBuddy! Community'),
          backgroundColor: Colors.deepPurpleAccent,
        ),
        body: Container(
          color: Colors.purple[100],
          child: UdataList(),
        ),
      ),
    );
  }
}
