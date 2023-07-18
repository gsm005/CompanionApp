import 'package:companionapp_mh/screens/authenticate/register.dart';
import 'package:flutter/material.dart';
import 'package:companionapp_mh/screens/authenticate/sign_in.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({Key? key});

  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  bool showSignIn=true;
  void toggleView() {
    setState(() => showSignIn = !showSignIn);
  }
  @override
  Widget build(BuildContext context) {
    if(showSignIn){
      return SignIn(toggleView:toggleView);
    }
    else{
      return Register(toggleView:toggleView);
    }
  }
}
