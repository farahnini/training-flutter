import 'package:fgv_data_record/constant.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ShowRecord extends StatefulWidget {
  const ShowRecord({super.key, required this.title});
  final String title;

  @override
  State<ShowRecord> createState() => _ShowRecordState();
}

class _ShowRecordState extends State<ShowRecord> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Show Details'),
        backgroundColor: primaryColor,
      ),
      body: Container(
          margin: EdgeInsets.all(2.h),
          padding: EdgeInsets.all(2.h),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(5),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Title: ${widget.title}',
                  style: TextStyle(
                      fontSize: 20.sp,
                      color: Colors.black,
                      fontWeight: FontWeight.bold)),
              SizedBox(
                height: 2.h,
              ),
              Text('Description 1',
                  style: TextStyle(fontSize: 18.sp, color: Colors.grey)),
              SizedBox(
                height: 10.h,
              ),
              Container(
                  width: 100.w,
                  height: 40.h,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(5),
                  ))
            ],
          )),
    );
  }
}
