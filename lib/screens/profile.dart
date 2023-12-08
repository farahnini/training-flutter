import 'package:fgv_data_record/services/api_services.dart';
import 'package:flutter/material.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late Future futureProfile;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    futureProfile = ApiServices().profile();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Container(
            margin: const EdgeInsets.all(10),
            child: FutureBuilder(
              future: futureProfile,
              builder: (context, AsyncSnapshot snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator(); // Show loading spinner during waiting state
                } else if (snapshot.hasError) {
                  return Text(
                      'Error: ${snapshot.error}'); // Show error message if any error occurs
                } else {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Name: '),
                      Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          snapshot.data['name'].toString(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Email: '),
                      Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          snapshot.data['email'].toString(),
                        ),
                      ),
                      SizedBox(height: 20),
                      Text('Identification Number: '),
                      Container(
                        padding: EdgeInsets.all(9),
                        decoration: BoxDecoration(
                            border: Border.all(color: Colors.black),
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          snapshot.data['nric'].toString(),
                        ),
                      ),
                    ],
                  ); // Show data when available
                }
              },
            )
            // const Column(children: [

            // Align(
            //   child: const CircleAvatar(
            //     child: Icon(
            //       Icons.person,
            //       size: 50,
            //     ),
            //     radius: 7,
            //   ),
            // ),
            // const SizedBox(
            //   height: 20,
            // ),
            // const Text(
            //   // snapshot.data['name'].toString(),
            //   'a',
            //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            // ),
            // const SizedBox(height: 10),
            // const Text(
            //   // snapshot.data['email'].toString(),
            //   'b',
            //   style: TextStyle(
            //     fontSize: 16,
            //   ),
            // ),
            // ]),
            ),
      ),
    );
  }
}
