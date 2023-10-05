import 'package:flutter/material.dart';

class NearbyPage extends StatelessWidget {
  // List of randomly generated location details for demonstration purposes
  final List<Map<String, String>> randomLocations = [
    {
      'name': 'Park 1',
      'address': '123 Park St',
      'description': 'A beautiful park to relax and unwind.',
    },
    {
      'name': 'Community Center',
      'address': '456 Community Ave',
      'description': 'A gathering place for the community.',
    },
    {
      'name': 'Central Park',
      'address': '789 Central Park Blvd',
      'description': 'A large park with many recreational activities.',
    },
    {
      'name': 'Lakefront Park',
      'address': '555 Lakefront Dr',
      'description': 'A park with a stunning view of the lake.',
    },
    // Add more random locations as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[200],
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        title: Text('Nearby Parks & Community Area'),
      ),
      body: ListView.builder(
        itemCount: randomLocations.length,
        itemBuilder: (context, index) {
          return LocationCard(
            name: randomLocations[index]['name']!,
            address: randomLocations[index]['address']!,
            description: randomLocations[index]['description']!,
          );
        },
      ),
    );
  }
}

class LocationCard extends StatelessWidget {
  final String name;
  final String address;
  final String description;

  LocationCard({
    required this.name,
    required this.address,
    required this.description,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: ListTile(
        title: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10),
            Text(
              address,
              style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey, fontSize: 16),
            ),
            SizedBox(height: 6),
            Text(
              description,
              style: TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
