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
  final List<String> moods = ['happy', 'sad', 'angry', 'depressed'];
  final List<String> moodEmojis = ['😊', '😢', '😡', '😞'];
  String _currentName = '';
  String _currentMood = 'happy';
  String  _currentProfession = 'self employed';
  int _currentAge = 0; // Updated the initial value to 1

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<Auser>(context);
    return StreamBuilder<UserData>(
      stream: DatabaseService(uid: user.uid).userdata,
      builder: (context, snapshot) {
        if(snapshot.hasData){
          UserData userData = snapshot.data!;
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
                  initialValue: userData.name ?? 'new user',
                  decoration: textInputDecoration,
                  validator: (val) => val?.isEmpty == true ? 'Please enter a name' : null,
                  onChanged: (val) => setState(() => _currentName = val),
                ),
                SizedBox(height: 20),
                TextFormField(
                  initialValue: userData.age.toString() ?? '--',
                  decoration: textInputDecoration.copyWith(hintText: 'Enter your age'),
                  keyboardType: TextInputType.number,
                  validator: (val) => val?.isEmpty == true ? 'Enter your age' : null,
                  onChanged: (val) => setState(() => _currentAge = int.tryParse(val) ?? _currentAge),
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
                  value: _currentMood ?? userData.mood,
                  items: moods.map((mood) {
                    int index = moods.indexOf(mood);
                    return DropdownMenuItem(
                      value: mood,
                      child: Row(
                        children: [
                          Text(
                            moodEmojis[index],
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 10),
                          Text("$mood"),
                        ],
                      ),
                    );
                  }).toList(),
                  onChanged: (val) => setState(() => _currentMood = val as String),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () async {
                    if(_formkey.currentState?.validate() ?? false) {
                      await DatabaseService(uid: user.uid).updateUserData(
                        _currentMood ?? userData.mood,
                        _currentName ?? userData.name,
                        _currentProfession ?? userData.profession,
                        _currentAge ?? userData.age,
                      );
                    }
                    Navigator.pop(context);
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all<Color>(
                      Colors.deepPurpleAccent,
                    ),
                    shape: MaterialStateProperty.all<
                        RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                    ),
                  ),
                  child: Text(
                    'Update',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          );
        } else {
          return Loading();
        }
      },
    );
  }
}
