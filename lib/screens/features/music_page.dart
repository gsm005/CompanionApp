import 'package:flutter/material.dart';

class MusicPage extends StatelessWidget {
  // List of music tracks (you can replace this with your actual list of music data)
  final List<String> musicTracks = [
    'Riptide ~Vance Joy',
    'Counting Stars ~OneRepublic',
    'Way down We Go ~KALEO',
    // Add more songs here...
  ];

  void showMusicDrawer(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * 0.6,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Music Tracks',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: musicTracks.length,
                  itemBuilder: (context, index) {
                    return ListTile(
                      title: Text(musicTracks[index]),
                      onTap: () {
                        // Handle tapping on a music track in the list
                        // For example, you can play the selected music track.
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Favorite Tracks'),
        backgroundColor: Colors.deepPurpleAccent,
        actions: [
          IconButton(
            onPressed: () {
              showMusicDrawer(context); // Show the music drawer when the icon is tapped
            },
            icon: Icon(Icons.music_note), // Icon for the rightmost of the AppBar
          ),
        ],
      ),
      body: Container(
        color: Colors.purple[50],
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 40),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Now Playing',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 20),
            CircleAvatar(
              radius: 120,
              backgroundImage: NetworkImage('https://upload.wikimedia.org/wikipedia/commons/thumb/e/e5/Twenty_One_Pilots_Vector_Logo.svg/600px-Twenty_One_Pilots_Vector_Logo.svg.png?20170130203407'),
            ),
            SizedBox(height: 20),
            Text(
              'Ride',
              style: TextStyle(fontSize: 34, fontWeight: FontWeight.bold),
            ),
            Text(
              'Twenty One Pilots',
              style: TextStyle(fontSize: 24, color: Colors.grey),
            ),
            SizedBox(height: 40),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.skip_previous),
                  iconSize: 50,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.play_arrow),
                  iconSize: 80,
                  color: Colors.green,
                ),
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.skip_next),
                  iconSize: 50,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
