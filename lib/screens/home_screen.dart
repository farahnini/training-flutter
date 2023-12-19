import 'dart:convert';

import 'package:fgv_data_record/constant.dart';
import 'package:fgv_data_record/models/record_model.dart';
import 'package:fgv_data_record/screens/create_record_screen.dart';
import 'package:fgv_data_record/screens/index_plantations.dart';
import 'package:fgv_data_record/screens/profile.dart';
import 'package:fgv_data_record/screens/show_record_screen.dart';
import 'package:fgv_data_record/screens/update_record_screen.dart';
import 'package:fgv_data_record/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../utils/global_variables.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  readRecord() async {
    final storage = await SharedPreferences.getInstance();
    final recordsJson = storage.getString('records');

    if (recordsJson != null) {
      final recordsData = json.decode(recordsJson);
      records = recordsData
          .map<RecordModel>((recordData) => RecordModel(
              id: recordData['id'],
              title: recordData['title'],
              description: recordData['description'],
              imageList: recordData['image_list'],
              latitude: recordData['latitude'],
              longitude: recordData['longitude']))
          .toList();
    }
  }

  saveRecord() async {
    final storage = await SharedPreferences.getInstance();
    final recordJson = json.encode(records
        .map((record) => {
              'id': record.id,
              'title': record.title,
              'description': record.description,
              'image_list': record.imageList,
              'latitiude': record.latitude,
              'longitude': record.longitude,
            })
        .toList());

    await storage.setString('records', recordJson);
  }

  deleteRecord(String id) async {
    records.removeWhere((record) => record.id == id);
    await saveRecord();
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readRecord()!.then((value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FGV Data Record'),
        centerTitle: true,
        backgroundColor: primaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                // Refresh data in shared preference
                final storage = await SharedPreferences.getInstance();
                storage.clear();
                final recordData = storage.getString('records');
                debugPrint('Record from local storage $recordData');
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.amber,
              ),
              child: Text('Drawer Header'),
            ),
            ListTile(
              title: const Text('Profile'),
              onTap: () {
                Get.to(() => ProfileScreen());
                // Update the
                // state of the app.
                // ...
              },
            ),
            ListTile(
              title: const Text(
                'Logout',
                style: TextStyle(color: Colors.red),
              ),
              onTap: () {
                // Get.dialog(AlertDialog());
                // ApiServices().logout();
              },
            ),
            ListTile(
              title: const Text(
                'Ladang',
                style: TextStyle(color: Colors.black),
              ),
              onTap: () {
                Get.to(() => IndexPlantations());
              },
            ),
          ],
        ),
      ),
      body: ListView.builder(
          itemCount: records.length,
          itemBuilder: ((context, index) {
            final record = records[index];
            return ListTile(
              onTap: () {
                print('Record ${index + 1} is clicked');
                Get.to(() => ShowRecord(title: record.title.toString()));
              },
              leading: Icon(Icons.file_copy),
              title: Text('Title: ${record.title}'),
              subtitle: Text('Description: \n${record.description}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  InkWell(
                      onTap: () {
                        Get.to(() => UpdateRecordScreen(
                                  id: record.id.toString(),
                                  title: record.title.toString(),
                                  description: record.description.toString(),
                                ))!
                            .then((value) {
                          setState(() {});
                        });
                      },
                      child: Icon(Icons.edit)),
                  SizedBox(width: 10),
                  InkWell(
                      onTap: () {
                        deleteRecord(record.id.toString());
                        setState(() {});
                      },
                      child: Icon(Icons.delete)),
                ],
              ),
            );
          })),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => CreateRecordScreen())!.then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
    );
  }
}
