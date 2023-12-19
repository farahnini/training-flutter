import 'package:fgv_data_record/screens/index_stages.dart';
import 'package:fgv_data_record/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class IndexPlantations extends StatefulWidget {
  const IndexPlantations({super.key});

  @override
  State<IndexPlantations> createState() => _IndexPlantationsState();
}

class _IndexPlantationsState extends State<IndexPlantations> {
  late Future futurePlantation;

  @override
  void initState() {
    super.initState();
    futurePlantation = ApiServices().fetchPlantation();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Plantations'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('This is list of plantations'),
              SizedBox(height: 20),
              FutureBuilder(
                future: futurePlantation,
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator(); // Show loading spinner during waiting state
                  } else if (snapshot.hasError) {
                    return Text(
                        'Error: ${snapshot.error}'); // Show error message if any error occurs
                  } else {
                    return ListView.builder(
                      physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,
                      itemCount: snapshot.data.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        return Container(
                          margin: EdgeInsets.only(bottom: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey,
                            ),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: ListTile(
                            onTap: () {
                              //BAWA ID PLANTATION KE PAGE STAGES
                              Get.to(() => IndexStages(
                                    plantationId:
                                        snapshot.data[index]['id'].toString(),
                                    plantationName:
                                        snapshot.data[index]['name'].toString(),
                                  ));
                            },
                            leading:
                                Icon(Icons.nature_people, color: Colors.amber),
                            title: Row(
                              children: [
                                Text(
                                  snapshot.data[index]['name'].toString(),
                                  style: TextStyle(
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                                SizedBox(width: 20),
                                Text(snapshot.data[index]['code'].toString()),
                              ],
                            ),
                            subtitle:
                                Text(snapshot.data[index]['code'].toString()),
                            trailing: Icon(Icons.arrow_forward),
                          ),
                        );
                      },
                    );
                    // Show data when available
                  }
                },
              )
            ],
          ),
        ),
      ),
    );
  }
}
