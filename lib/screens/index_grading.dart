import 'package:fgv_data_record/screens/index_plantations.dart';
import 'package:fgv_data_record/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class IndexGrading extends StatefulWidget {
  const IndexGrading({super.key});

  @override
  State<IndexGrading> createState() => _IndexGradingState();
}

class _IndexGradingState extends State<IndexGrading> {
  late Future futureGradings;

  @override
  void initState() {
    super.initState();
    futureGradings = ApiServices().fetchGradings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of Gradings'),
        centerTitle: true,
        backgroundColor: Colors.amber,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(() => IndexPlantations());
            },
            icon: Icon(Icons.add),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              SizedBox(height: 10),
              FutureBuilder(
                future: futureGradings,
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
                        return GestureDetector(
                          onTap: () {},
                          child: Container(
                            margin: EdgeInsets.only(bottom: 10),
                            padding: EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(snapshot.data[index]['stage']['plantation']
                                        ['name']
                                    .toString()),
                                Text(
                                    'Masak quantity: ${snapshot.data[index]['masak_quantity'].toString()}'),
                              ],
                            ),
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
