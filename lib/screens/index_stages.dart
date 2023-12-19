import 'package:fgv_data_record/screens/create_grading_form.dart';
import 'package:fgv_data_record/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexStages extends StatefulWidget {
  final String plantationId;
  final String plantationName;
  const IndexStages({
    Key? key,
    required this.plantationId,
    required this.plantationName,
  }) : super(key: key);

  @override
  State<IndexStages> createState() => _IndexStagesState();
}

class _IndexStagesState extends State<IndexStages> {
  late Future futureStages;

  @override
  void initState() {
    super.initState();
    futureStages = ApiServices().fetchStages(widget.plantationId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Stages'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text('This is ${widget.plantationName} Plantation'),
              SizedBox(height: 20),
              FutureBuilder(
                future: futureStages,
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
                              //BAWA ID STAGES KE GRADING FORM
                              Get.to(() => GradingForm(
                                  stagesId:
                                      snapshot.data[index]['id'].toString()));
                            },
                            leading:
                                Icon(Icons.nature_people, color: Colors.amber),
                            title: Text(
                              snapshot.data[index]['name'].toString(),
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            subtitle: Text(snapshot.data[index]['date_planted']
                                .toString()),
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
