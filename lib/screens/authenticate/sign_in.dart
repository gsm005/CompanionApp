import 'package:companionapp_mh/services/auth.dart';
import 'package:companionapp_mh/shared/constants.dart';
import 'package:companionapp_mh/shared/loading.dart';
import 'package:flutter/material.dart';

class SignIn extends StatefulWidget {
  final Function toggleView;
  SignIn({required this.toggleView});


  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formkey=GlobalKey<FormState>();
  final AuthService _auth=AuthService();
  bool loading=false;
  //text field state
  String email='';
  String password='';
  String error='';

  @override
  Widget build(BuildContext context) {
    return loading? Loading():Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        backgroundColor: Colors.white30,
        elevation: 0,
        title: Text('Sign In to App'),
        actions: [
          TextButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon:Icon(Icons.person),
              label: Text('Sign Up')
          )
        ],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20,horizontal: 50),
        child:Form(
          key: _formkey,
          child: Column(
            children: [
              SizedBox(height:20),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'enter email'),
                  validator: (val)=>val?.isEmpty?? true? 'Enter an email':null,
                  onChanged: (val){setState(()=>email=val);
                }
              ),
              SizedBox(height: 20),
              TextFormField(
                  decoration: textInputDecoration.copyWith(hintText: 'enter password'),
                  validator: (val) => (val?.length ?? 0) < 6 ? 'Password length greater than 6 is mandatory' : null,
                  obscureText: true,
                  onChanged: (val){setState(()=>password=val);
                }
              ),
              SizedBox(height: 20),
              ElevatedButton(
                  onPressed: ()async {
                    if(_formkey.currentState?.validate()??false){
                      setState(()=>loading=true);
                      dynamic res=await _auth.signInwithEandP(email, password);
                      if(res==null){
                        setState((){
                          loading=false;
                          error='invalid credentials';
                        });
                      }
                    }
                  },
                  child: Text(
                    'Sign In',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                  )
              ),
              SizedBox(height: 20),
              Text(
                error,
                style: TextStyle(color: Colors.red,fontSize: 14),
              ),
            ],
          ),
        )
      ),
    );
  }
}
