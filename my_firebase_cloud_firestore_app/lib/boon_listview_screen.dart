import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:my_firebase_cloud_firestore_app/boon_form_screen.dart';

class BoonListviewScreen extends StatefulWidget {
  const BoonListviewScreen({super.key});

  @override
  State<BoonListviewScreen> createState() => _BoonListviewScreenState();
}

class _BoonListviewScreenState extends State<BoonListviewScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 81, 81, 81),
      appBar: AppBar(
        title: const Text(
          'Boon ListView',
          style: TextStyle(color: Color.fromARGB(255, 2, 36, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 255, 221),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const BoonFormScreen(),
                        settings: RouteSettings(
                            arguments: {'docId': null, 'viewOnly': false})));
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection("BoonCollection")
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              List docList = snapshot.data!.docs;
              return ListView.separated(
                  itemBuilder: (context, index) {
                    DocumentSnapshot document = docList[index];
                    String docId = document.id;
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16.0, vertical: 8.0),
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: EdgeInsets.all(16.0),
                          tileColor: const Color.fromARGB(186, 224, 224, 224),
                          title: Text(
                            document['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          subtitle: Text(
                            "${document['eventDate']} ${document['startHour']}:${document['startMinute']}",
                            style: TextStyle(
                              color: Colors.grey[600],
                            ),
                          ),
                          trailing: Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BoonFormScreen(),
                                            settings: RouteSettings(arguments: {
                                              'docId': docId,
                                              'viewOnly': true
                                            })));
                                  },
                                  icon: Icon(Icons.visibility,
                                      color: const Color.fromARGB(255, 0, 255, 225))),
                              IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const BoonFormScreen(),
                                            settings: RouteSettings(arguments: {
                                              'docId': docId,
                                              'viewOnly': false
                                            })));
                                  },
                                  icon: Icon(Icons.edit, color: const Color.fromARGB(255, 255, 111, 0))),
                              IconButton(
                                  onPressed: () {
                                    FirebaseFirestore.instance
                                        .collection("BoonCollection")
                                        .doc(docId)
                                        .delete()
                                        .then((value) => debugPrint(
                                            "A boon document had been delete successfully!"))
                                        .catchError((error) => debugPrint(
                                            "Failed to delete a boon document: $error"));
                                  },
                                  icon: Icon(Icons.delete, color: const Color.fromARGB(255, 255, 0, 0))),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: docList.length);
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return Center(
                child: Text(
                    "There are some errors reading Firebase Cloud Firestore"),
              );
            }
          }),
    );
  }
}
