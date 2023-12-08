import 'package:fgv_data_record/screens/home_screen.dart';
import 'package:fgv_data_record/screens/loadingscreen.dart';
import 'package:fgv_data_record/services/api_services.dart';
import 'package:fgv_data_record/utils/check_connection.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
          child: Form(
        child: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(screenWidth * 0.05),
            height: screenHeight,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Login',
                        style: TextStyle(
                            fontSize: 40, fontWeight: FontWeight.bold))),
                SizedBox(height: screenHeight * 0.01),
                const Align(
                    alignment: Alignment.centerLeft,
                    child: Text('Keep track of your record. Anytime, anywhere.',
                        style: TextStyle(color: Colors.grey, fontSize: 15))),
                SizedBox(height: screenHeight * 0.05),
                TextFormField(
                    controller: emailController,
                    decoration: const InputDecoration(
                        label: Text('Email'),
                        prefixIcon: Icon(Icons.email),
                        border: OutlineInputBorder())),
                SizedBox(height: screenHeight * 0.01),
                TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                        label: Text('Password'),
                        prefixIcon: Icon(Icons.key),
                        border: OutlineInputBorder())),
                SizedBox(height: screenHeight * 0.01),
                ElevatedButton(
                    onPressed: () {
                      ApiServices().login(emailController.text,
                          passwordController.text, 'playerId_farah', 'PM45');
                    },
                    style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5)),
                        backgroundColor: Colors.blue),
                    child: const Text('Login',
                        style:
                            TextStyle(color: Color.fromARGB(255, 79, 16, 16)))),
                const Text('or'),
                SizedBox(height: screenHeight * 0.01),
                const Text('Login as guest'),
                SizedBox(height: screenHeight * 0.08),
                const Text('Don\'t have an account?'),
                ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.green,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                    ),
                    child: const Text('Create a new account',
                        style: TextStyle(color: Colors.white))),
              ],
            ),
          ),
        ),
      )),
    );
  }
}
