import 'dart:convert';

import 'package:fgv_data_record/constant.dart';
import 'package:fgv_data_record/models/record_model.dart';
import 'package:fgv_data_record/screens/create_record_screen.dart';
import 'package:fgv_data_record/screens/show_record_screen.dart';
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    readRecord();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('FGV Data Record'),
        backgroundColor: primaryColor,
        actions: [
          IconButton(
              onPressed: () async {
                // Refresh data in shared preference
                final storage = await SharedPreferences.getInstance();
                final recordData = storage.getString('records');
                debugPrint('Record from local storage $recordData');
              },
              icon: Icon(Icons.refresh)),
        ],
      ),
      body: ListView.builder(
          itemCount: records.length,
          itemBuilder: ((context, index) {
            return ListTile(
              onTap: () {
                print('Record ${index + 1} is clicked');
                Get.to(() => ShowRecord());
              },
              leading: Icon(Icons.file_copy),
              title: Text('Title: ${records[index].title}'),
              subtitle: Text('Description: ${records[index].description}'),
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.delete),
                  SizedBox(width: 10),
                  Icon(Icons.edit),
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
