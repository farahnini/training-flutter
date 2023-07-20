import 'package:fgv_data_record/constant.dart';
import 'package:fgv_data_record/screens/create_record_screen.dart';
import 'package:fgv_data_record/screens/show_record_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          itemCount: 3,
          itemBuilder: ((context, index) {
            return ListTile(
              onTap: () {
                print('Record ${index + 1} is clicked');
                Get.to(() => ShowRecord());
              },
              leading: Icon(Icons.file_copy),
              title: Text('Title ${index + 1}'),
              subtitle: Text('Description ${index + 1}'),
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
          Get.to(() => CreateRecordScreen());
        },
        child: Icon(Icons.add),
        backgroundColor: primaryColor,
      ),
    );
  }
}
