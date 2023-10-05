import 'package:flutter/material.dart';

class ProfessionalHelpPage extends StatelessWidget {
  final List<Map<String, dynamic>> doctors = [
    {
      'name': 'Dr. John Doe',
      'contact': '+1 (123) 456-7890',
      'image': 'https://img.freepik.com/free-photo/attractive-young-male-nutriologist-lab-coat-smiling-against-white-background_662251-2960.jpg?w=2000',
      'experience': '10+ years',
    },
    {
      'name': 'Dr. Jane Smith',
      'contact': '+1 (987) 654-3210',
      'image': 'https://img.freepik.com/free-photo/pleased-young-female-doctor-wearing-medical-robe-stethoscope-around-neck-standing-with-closed-posture_409827-254.jpg?w=2000',
      'experience': '8+ years',
    },
    // Add more doctors as needed
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text('Professional Help'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: ListView.builder(
        itemCount: doctors.length,
        itemBuilder: (context, index) {
          return Container(
            width: double.infinity, // Set the width of the container to the maximum available width
            height: 150, // Set the height of each card
            child: DoctorCard(
              name: doctors[index]['name'],
              contact: doctors[index]['contact'],
              image: doctors[index]['image'],
              experience: doctors[index]['experience'],
            ),
          );
        },
      ),
    );
  }
}
class DoctorCard extends StatelessWidget {
  final String name;
  final String contact;
  final String image;
  final String experience;

  DoctorCard({
    required this.name,
    required this.contact,
    required this.image,
    required this.experience,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.all(8),
      elevation: 4,
      child: Stack(
        children: [
          ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(image),
              radius: 45, // Increase the radius for a larger profile image
            ),
            title: Text(name),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 8),
                Text(contact,style: TextStyle(fontWeight: FontWeight.bold,color: Colors.blue,fontSize: 16)),
                SizedBox(height: 8),
                Text(
                  'Experience: $experience', // Display the experience of the doctor
                  style: TextStyle(fontWeight: FontWeight.bold,color: Colors.green,fontSize: 16),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 16,
            right: 8, // Call the function on tap
                child: IconButton(
                  color: Colors.green,
                  icon: Icon(Icons.phone),
                  onPressed: null,
                ) ,
              ),
        ],
      ),
    );
  }
}


