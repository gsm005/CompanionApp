import 'package:flutter/material.dart';

class JournalPage extends StatefulWidget {
  @override
  _JournalPageState createState() => _JournalPageState();
}

class _JournalPageState extends State<JournalPage> {
  TextEditingController _journalController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.purple[50],
      appBar: AppBar(
        title: Text('Write Your Day !'),
        backgroundColor: Colors.deepPurpleAccent,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white, // Set the background color of the TextField to white
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: TextField(
                  controller: _journalController,
                  maxLines: null, // Allow multiple lines for journal writing
                  style: TextStyle(fontSize: 16, color: Colors.black),
                  decoration: InputDecoration.collapsed(
                    hintText: 'Write about your day...',
                    hintStyle: TextStyle(color: Colors.grey, fontSize: 20),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                IconButton(
                  onPressed: () {
                    // Save the journal entry (You can implement the save functionality here)
                    saveJournalEntry();

                    // Show the alert dialog
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: Text('Well done! You have completed a task.',style: TextStyle(fontSize: 24,color: Colors.deepPurpleAccent)),
                          actions: [
                            ElevatedButton(
                              onPressed: () {
                                // Close the dialog and navigate back to the home screen
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.white, // Set the background color to white
                              ),
                              child: Text(
                                'OK',
                                style: TextStyle(
                                  color: Colors.green, // Set the text color to green
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                  icon: Icon(Icons.save),
                  iconSize: 50,
                  color: Colors.deepPurpleAccent,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void saveJournalEntry() {
    // For this example, we will simply print the journal entry to the console
    String journalEntry = _journalController.text;
    print(journalEntry);

    // You can implement the actual saving logic here (e.g., save to a database, file, etc.)
    // Remember to handle edge cases and validation as needed.
  }
}
