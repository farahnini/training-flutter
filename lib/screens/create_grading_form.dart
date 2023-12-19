// ignore_for_file: prefer_const_constructors

import 'package:fgv_data_record/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class GradingForm extends StatefulWidget {
  final String stagesId;
  const GradingForm({
    Key? key,
    required this.stagesId,
  }) : super(key: key);

  @override
  State<GradingForm> createState() => _GradingFormState();
}

class _GradingFormState extends State<GradingForm> {
  final TextEditingController blockController = TextEditingController();
  final TextEditingController platformController = TextEditingController();
  final TextEditingController masakController = TextEditingController();
  final TextEditingController mengkalController = TextEditingController();
  final TextEditingController mudaController = TextEditingController();
  final TextEditingController kosongController = TextEditingController();
  final TextEditingController busukController = TextEditingController();
  final TextEditingController panjangController = TextEditingController();
  final TextEditingController kotorController = TextEditingController();
  final TextEditingController peramController = TextEditingController();
  final TextEditingController rosakController = TextEditingController();
  final TextEditingController remarkController = TextEditingController();
  List<int> myArray = [1, 2, 3];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create Grading'),
        centerTitle: true,
        backgroundColor: Colors.amber,
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Form(
            child: Column(
              children: [
                TextFormField(
                  controller: blockController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Block',
                  ),
                ),
                TextFormField(
                  controller: platformController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Platform',
                  ),
                ),
                TextFormField(
                  controller: masakController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Masak Quantity',
                  ),
                ),
                TextFormField(
                  controller: mengkalController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Mengkal Quantity',
                  ),
                ),
                TextFormField(
                  controller: mudaController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Muda Quantity',
                  ),
                ),
                TextFormField(
                  controller: kotorController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Kosong Quantity',
                  ),
                ),
                TextFormField(
                  controller: busukController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Busuk Quantity',
                  ),
                ),
                TextFormField(
                  controller: panjangController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Panjang Quantity',
                  ),
                ),
                TextFormField(
                  controller: kosongController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Kotor Quantity',
                  ),
                ),
                TextFormField(
                  controller: peramController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Peram Quantity',
                  ),
                ),
                TextFormField(
                  controller: rosakController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Rosak Quantity',
                  ),
                ),
                TextFormField(
                  controller: remarkController,
                  keyboardType: TextInputType.text,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    labelText: 'Enter Remark',
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                ElevatedButton(
                    onPressed: () {
                      ApiServices().createGrading(
                        widget.stagesId,
                        blockController.text,
                        platformController.text,
                        '12.345678',
                        '12.345678',
                        masakController.text,
                        mengkalController.text,
                        mudaController.text,
                        kotorController.text,
                        busukController.text,
                        panjangController.text,
                        kosongController.text,
                        peramController.text,
                        rosakController.text,
                        remarkController.text,
                        'AAAA',
                      );
                    },
                    child: Text('Submit'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
