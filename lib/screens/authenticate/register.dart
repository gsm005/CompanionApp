import 'package:companionapp_mh/shared/constants.dart';
import 'package:companionapp_mh/shared/loading.dart';
import 'package:flutter/material.dart';
import 'package:companionapp_mh/services/auth.dart';

class Register extends StatefulWidget {
  final Function toggleView;
  Register({required this.toggleView});

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  final AuthService _auth=AuthService();
  final _formkey=GlobalKey<FormState>();
  bool loading=false;
  String password='';
  String email='';
  String error='';
  @override
  Widget build(BuildContext context) {
    return loading?Loading():Scaffold(
      backgroundColor: Colors.white24,
      appBar: AppBar(
        backgroundColor: Colors.white70,
        elevation: 0,
        title: Text('Sign Up to App'),
        actions: [
          TextButton.icon(
              onPressed: (){
                widget.toggleView();
              },
              icon:Icon(Icons.person),
              label: Text('Sign In')
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
                    onChanged: (val){
                      setState(()=>email=val);
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
                        dynamic res=await _auth.registerwithEandP(email, password);
                        if(res==null){
                          setState((){
                              loading=false;
                              error='please provide a valid email id';
                            });
                          }
                        }
                      },
                    child: Text(
                      'Register',
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
