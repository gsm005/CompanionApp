import 'package:companionapp_mh/questions/ques_model.dart';
import 'package:companionapp_mh/screens/wrapper.dart';
import 'package:companionapp_mh/services/auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:provider/provider.dart';
import 'package:companionapp_mh/models/auser.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamProvider<Auser?>.value(
      initialData: null,
      value: AuthService().user,
      child: MaterialApp(
          debugShowCheckedModeBanner:false,
          home: Wrapper(),
      ),
    );
  }
}

