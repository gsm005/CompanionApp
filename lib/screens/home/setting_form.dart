import 'package:companionapp_mh/models/auser.dart';
import 'package:companionapp_mh/services/database.dart';
import 'package:companionapp_mh/shared/loading.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:companionapp_mh/shared/constants.dart';
import 'package:provider/provider.dart';

class SettingForm extends StatefulWidget {
  const SettingForm({super.key});

  @override
  State<SettingForm> createState() => _SettingFormState();
}

class _SettingFormState extends State<SettingForm> {
  final _formkey = GlobalKey<FormState>();
  final List<String> moods = ['0', '1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  String _currentName = '';
  String _currentMood = '0';
  String  _currentProfession = 'self employed';
  int _currentAge = 1; // Updated the initial value to 1

  @override
  Widget build(BuildContext context) {
    final user=Provider.of<Auser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid:user.uid).userdata,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData=snapshot.data!;
          return Form(
            key: _formkey,
            child: Column(
              children: [
                Text(
                  'Update profile',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData.name,
                  decoration: textInputDecoration,
                  validator: (val) => val?.isEmpty == true ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData.profession,
                  decoration: textInputDecoration,
                  validator: (val) => val?.isEmpty == true ? 'Enter your job profile' : null,
                  onChanged: (val) => setState(() => _currentProfession = val),
                ),
                SizedBox(height: 20),
                DropdownButtonFormField(
                  decoration: textInputDecoration,
                  value: _currentMood?? userData.mood,
                  items: moods.map((mood) {
                    return DropdownMenuItem(
                      value: mood,
                      child: Text("happiness quotient -- $mood"),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentMood = val as String),
                ),
                Slider(
                  min: 0.0,
                  max: 100.0,
                  divisions: 10,
                  activeColor: Colors.yellow[_currentAge.round() * 10],
                  inactiveColor: Colors.yellow[_currentAge.round() * 10],
                  value: (_currentAge??userData.age).toDouble(),
                  onChanged: (val) => setState(() => _currentAge = val.round()),
                ),
                ElevatedButton(
                  onPressed: () async {
                    if(_formkey.currentState?.validate()??false){
                      await DatabaseService(uid:user.uid).updateUserData(_currentMood ?? userData.mood,_currentName ?? userData.name, _currentProfession ?? userData.profession, _currentAge ?? userData.age);
                    };
                    Navigator.pop(context);
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        }else{
          return Loading();
        }
      }
    );
  }
}
