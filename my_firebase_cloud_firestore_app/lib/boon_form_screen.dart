import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:my_firebase_cloud_firestore_app/boon.dart'; //แก้ชื่อfolder
import 'package:cloud_firestore/cloud_firestore.dart';


class BoonFormScreen extends StatefulWidget {
  const BoonFormScreen({super.key});

  @override
  State<BoonFormScreen> createState() => _BoonFormScreenState();
}

class _BoonFormScreenState extends State<BoonFormScreen> {
  final GlobalKey<FormState> _boonformkey = GlobalKey<FormState>();

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descController = TextEditingController();
  final TextEditingController _eventDateController = TextEditingController();
  final TextEditingController _startHourController = TextEditingController();
  final TextEditingController _startMinuteController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();

  bool viewOnly = false;

  @override
  void dispose() {
    _titleController.dispose();
    _descController.dispose();
    _eventDateController.dispose();
    _startHourController.dispose();
    _startMinuteController.dispose();
    _locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final docSetting =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    var viewOnly = docSetting['viewOnly'];
    var docId = docSetting['docId'];

    if (docId != null) {
      final docRef = FirebaseFirestore.instance
          .collection("BoonCollection")
          .doc(docId.toString());
      docRef.get().then((DocumentSnapshot doc) {
        final data = doc.data() as Map<String, dynamic>;
        final boon = Boon.fromMap(data);
        _titleController.text = boon.title;
        _eventDateController.text = boon.eventDate;
        _descController.text = boon.desc!;
        _startHourController.text = boon.startHour;
        _startMinuteController.text = boon.startMinute;
        _locationController.text = boon.location;
      }, onError: (e) => debugPrint("Error getting document: $e"));
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 153, 153, 153),
      appBar: AppBar(
        title: Text(
          viewOnly
              ? 'View Boon'
              : docId == null
                  ? 'Create Boon'
                  : 'Update Boon',
          style: TextStyle(color: const Color.fromARGB(255, 0, 42, 255)),
        ),
        backgroundColor: const Color.fromARGB(255, 0, 255, 247),
        centerTitle: true,
      ),
      body: Container(
        padding: const EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Form(
            key: _boonformkey,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: _titleController,
                    decoration: const InputDecoration(
                      hintText: 'Enter title',
                      labelText: 'Title',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Title CANNOT be empty';
                      }
                      return null;
                    },
                    readOnly: viewOnly,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                      controller: _descController,
                      decoration: const InputDecoration(
                        hintText: 'Enter description',
                        labelText: 'Description',
                        border: OutlineInputBorder(),
                      ),
                      readOnly: viewOnly),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: _eventDateController,
                    decoration: const InputDecoration(
                      hintText: 'Enter event date: mm/dd/yyyy',
                      labelText: 'Event Date',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Event Date CANNOT be empty';
                      }
                      return null;
                    },
                    readOnly: viewOnly,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: _startHourController,
                    decoration: const InputDecoration(
                      hintText: 'Enter start hour: hh',
                      labelText: 'Start hour',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Start Hour CANNOT be empty';
                      }
                      return null;
                    },
                    readOnly: viewOnly,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: _startMinuteController,
                    decoration: const InputDecoration(
                      hintText: 'Enter start minute: mm',
                      labelText: 'Start minute',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Start Minute CANNOT be empty';
                      }
                      return null;
                    },
                    readOnly: viewOnly,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: TextFormField(
                    controller: _locationController,
                    decoration: const InputDecoration(
                      hintText: 'Enter location',
                      labelText: 'Location',
                      border: OutlineInputBorder(),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Location CANNOT be empty';
                      }
                      return null;
                    },
                    readOnly: viewOnly,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Visibility(
                      visible: !viewOnly,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: const Color.fromARGB(255, 0, 13, 255),
                              backgroundColor: Colors.green),
                          onPressed: () {
                            if (_boonformkey.currentState!.validate()) {
                              final title = _titleController.text.trim();
                              final desc = _descController.text.trim();
                              final eventDate =
                                  _eventDateController.text.trim();
                              final startHour =
                                  _startHourController.text.trim();
                              final startMinute =
                                  _startMinuteController.text.trim();
                              final location = _locationController.text.trim();

                              try {
                                DateTime myEventDate =
                                    DateFormat("MM/dd/yyyy").parse(eventDate);

                                docId ??=
                                    'boon_${myEventDate.month}${myEventDate.day}${myEventDate.year}_$startHour$startMinute';

                                final db = FirebaseFirestore.instance;
                                final CollectionReference boonCollection =
                                    db.collection("BoonCollection");

                                final boonMapDoc = <String, dynamic>{
                                  "title": title,
                                  "desc": desc,
                                  "eventDate": eventDate,
                                  "startHour": startHour,
                                  "startMinute": startMinute,
                                  "location": location,
                                };
                                boonCollection
                                    .doc(docId.toString())
                                    .set(boonMapDoc);
                                Navigator.pop(context);
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text("Error: ${e.toString()}"),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text('Save')),
                    ),
                    Visibility(
                      visible: !viewOnly,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              foregroundColor: Colors.white,
                              backgroundColor: Colors.red),
                          onPressed: () {
                            _boonformkey.currentState!.reset();
                          },
                          child: const Text('Reset')),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
