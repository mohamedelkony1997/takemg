// ignore_for_file: use_build_context_synchronously, prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:takemg/Screens/home.dart';
import 'package:takemg/bussineslogic/cubit/login_cubit.dart';
import 'package:takemg/consts/colors.dart';
import 'package:takemg/consts/strings.dart';
// Replace with the actual path to your DataCubit file
import 'package:shared_preferences/shared_preferences.dart';
import 'package:takemg/models/login.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  TextEditingController emailCon = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: emailCon,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15.0),
                    borderSide: BorderSide.none,
                  ),
                  prefixIcon: Padding(
                    padding: EdgeInsets.all(5.0),
                    child: Icon(
                      Icons.email_outlined,
                      color: darkFontGrey,
                    ),
                  ),
                  hintText: emailHint,
                  hintStyle: TextStyle(color: fontGrey),
                  contentPadding: const EdgeInsets.symmetric(
                      vertical: 18.0, horizontal: 7.0),
                  filled: true,
                  fillColor: textfieldGrey,
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              SizedBox(
                height: 5,
              ),
              ElevatedButton(
                style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                  ),
                  minimumSize: MaterialStateProperty.all(Size(300, 50)),
                  backgroundColor: MaterialStateProperty.all(green),
                  shadowColor: MaterialStateProperty.all(Colors.transparent),
                ),
                onPressed: () async {
                  final dataCubit = context.read<DataCubit>();

                  if (emailCon.text.isNotEmpty) {
                    await dataCubit.fetchData(emailCon.text);

                  

                    Get.to(HomePage());
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.only(
                    top: 10,
                    bottom: 10,
                  ),
                  child: Text(
                    login,
                    style: TextStyle(fontSize: 18, color: whiteColor),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> saveDataToSharedPreferences(List<DataModel> data) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    final List<Map<String, dynamic>> jsonDataList =
        data.map((d) => d.toJson()).toList();

    final String jsonData = json.encode(jsonDataList);
    print("rrrrrrrrrrr${jsonData}");
    prefs.setString('storedData', jsonData);
  }
}
