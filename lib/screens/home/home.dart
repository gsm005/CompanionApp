import 'package:companionapp_mh/models/udata.dart';
import 'package:companionapp_mh/questions/answers/ans_model.dart';
import 'package:companionapp_mh/questions/ques_screen.dart';
import 'package:companionapp_mh/questions/rdb_connect.dart';
import 'package:companionapp_mh/screens/features/journal.dart';
import 'package:companionapp_mh/screens/features/nearby_loc.page.dart';
import 'package:companionapp_mh/screens/features/professionals.dart';
import 'package:companionapp_mh/screens/home/result_page.dart';
import 'package:companionapp_mh/screens/home/setting_form.dart';
import 'package:companionapp_mh/shared/taskcard.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:companionapp_mh/services/auth.dart';
import 'package:companionapp_mh/services/database.dart';
import 'package:companionapp_mh/screens/home/udata_list.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:companionapp_mh/models/auser.dart';
import 'package:companionapp_mh/screens/home/udata_page.dart';
import 'package:companionapp_mh/screens/features/music_page.dart';
import 'package:intl/intl.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> with SingleTickerProviderStateMixin {
  final AuthService _auth = AuthService();
  late String currentDate;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }
  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showProfilePanel() {
    showModalBottomSheet(context: context, builder: (context) {
      return Container(
        padding: EdgeInsets.symmetric(horizontal: 60, vertical: 20),
        child: SettingForm(),
      );
    });
  }

  void _showUdataPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => UdataPage()), // Navigate to UdataPage
    );
  }
  void _showQuizPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => QuizScreen()), // Navigate to QuizPage
    );
  }
  void _showNearbyPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => NearbyPage()), // Navigate to QuizPage
    );
  }
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Start Test'),
          content: Text('Are you sure you want to start the test?'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: Text('No'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                _showQuizPage(); // Navigate to the quiz screen
              },
              child: Text('Yes'),
            ),
          ],
        );
      },
    );
  }
  void _showMusicPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MusicPage()), // Navigate to MusicPage
    );
  }
  void _showProfhelpPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ProfessionalHelpPage()), // Navigate to MusicPage
    );
  }
  void _showJournalPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => JournalPage()), // Navigate to MusicPage
    );
  }
  @override
  Widget build(BuildContext context) {
    final Auser? currentUser = Provider.of<Auser?>(context);
    final String uid = currentUser?.uid ?? '';

    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text('HeyBuddy!'),
        backgroundColor: Colors.deepPurpleAccent,
        elevation: 0,
        actions: [
          TextButton.icon(
            onPressed: () async {
              await _auth.signOut();
            },
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            label: Text(
              'Logout',
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.white,
          tabs: [
            Tab(text: 'Tasks'),
            Tab(text: 'Dashboard'),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.deepPurpleAccent,
                // image:DecorationImage(image:NetworkImage('https://media.istockphoto.com/id/1311246360/vector/white-gray-cat-animal-set-kitten-kitty-friends-cute-cartoon-funny-kawaii-character-childish.jpg?s=612x612&w=is&k=20&c=0uXt1gkheInW4_qcEmcRWg4f39En9hT55erNNzTo4-U='),
                //   fit:BoxFit.cover,
              ),
              child: Text(
                'Hey! ',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.edit),
              title: Text('Edit Profile'),
              onTap: () => _showProfilePanel(),
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('Community'),
              onTap: _showUdataPage,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('Get Professional help'),
              onTap: _showProfhelpPage,
            ),
            // Add more ListTile widgets for additional items
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          Container(
            decoration: BoxDecoration(
              // image: DecorationImage(
              //   image: NetworkImage('https://designimages.appypie.com/appbackground/appbackground-13-petal-plant.webp'),
              //   fit: BoxFit.cover,
              // ),
            ),
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      TaskCard(
                        title: 'Go out and meet new people!',
                        imageUrl: 'https://www.careeraddict.com/uploads/article/60456/illustration-making-friends-at-work.jpg',
                        onTap: () {
                          _showNearbyPage();
                        },
                      ),
                      TaskCard(
                        title: 'Write your Day',
                        imageUrl: 'https://wp.missmalini.com/wp-content/uploads/2020/04/Featured-1-4.jpg',
                        onTap: () {
                          _showJournalPage();
                        },
                      ),
                      TaskCard(
                        title: 'Listen your Favourite tracks',
                        imageUrl: 'https://headphonesproreview.com/wp-content/uploads/2020/06/get-the-body-moving.jpg',
                        onTap: () {
                          _showMusicPage();
                        },
                      ),
                      TaskCard(
                        title: 'Go Out for a Run',
                        imageUrl: 'https://qph.cf2.quoracdn.net/main-qimg-6fe3709e16c988b3c664cc327bc66393',
                        onTap: () {
                          //
                        },
                      ),
                      TaskCard(
                        title: 'Do Some Yoga and Meditation',
                        imageUrl: 'https://blogimage.vantagefit.io/vfitimages/2021/07/14-Fantastic-Benefits-Of-Yoga-In-The-Workplace-.png',
                        onTap: () {
                          // Handle task 3 tap
                        },
                      ),
                    ],
                  ),
                ),
                // Positioned(
                //   bottom: 16,
                //   right: 16,
                //   child: FloatingActionButton(
                //     onPressed: _showUdataPage,
                //     child: Icon(Icons.people),
                //     backgroundColor: Colors.purple,
                //   ),
                // ),
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      children: [
                        Text(
                          'Take a Assessment to Check Your Mental Health Progress',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        SizedBox(height: 20),
                        Align(
                          alignment: Alignment.bottomRight,
                          child: ElevatedButton(
                            onPressed: _showConfirmationDialog,
                            child: Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                              child: Text(
                                'Take Test',
                                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                              ),
                            ),
                            style: ElevatedButton.styleFrom(
                              primary: Colors.deepPurpleAccent,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                SizedBox(
                  width: 250,
                  height: 70,
                  child: ElevatedButton(
                    onPressed: () async {
                      List<Answer> userResponses = await DBconnect().fetchAnswersByUser(uid);
                      if (userResponses.isEmpty) {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: Text('Take Test First'),
                              content: Text('Please take the test first before viewing progress.'),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                  },
                                  child: Text('OK'),
                                ),
                              ],
                            );
                          },
                        );
                      } else {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ResultPage(userResponses: userResponses),
                          ),
                        );
                      }
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                      child: Text(
                        'View Report',
                        style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.deepPurpleAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 230),
                Card(
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 20,
                          color: Colors.black,
                        ),
                        SizedBox(height: 10),
                        Text(
                          'App Information',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'HeyBuddy! is a mental health companion app that helps you take care of your mental well-being.',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                        SizedBox(height: 10),
                        Text(
                          'Version: 1.0.0',
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

        ],
      ),
    );
  }
}
