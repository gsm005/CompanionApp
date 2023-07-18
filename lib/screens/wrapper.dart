import 'package:companionapp_mh/screens/authenticate/authenticate.dart';
import 'package:flutter/material.dart';
import 'package:companionapp_mh/screens/home/home.dart';
import 'package:companionapp_mh/models/auser.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  const Wrapper({super.key});

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<Auser?>(context);
    if(user==null) {
      return Authenticate();
    }
    else{
      return Home();
    }
  }
}

