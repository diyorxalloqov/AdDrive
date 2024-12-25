import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  PrivacyPolicyState createState() => PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicy> {
  late final Repository _repository;
  String? data;

  @override
  void initState() {
    _repository = Get.find<Repository>();
    super.initState();
    fetchPolicy();
  }

  Future fetchPolicy() async {
    final response = await _repository.privacyPolicy();
    if (response?.success == true) {
      setState(() {
        data = response!.data!.en!;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: context.isDarkMode ? Colors.white : Colors.black),
        title: Text('privacy_policy'.tr,
            style: context.theme.textTheme.labelMedium),
      ),
      body: SingleChildScrollView(
        child: data != null
            ? Html(data: """$data""", style: {
                "p": Style(
                  fontSize: FontSize(16.0),
                  color: context.isDarkMode ? Colors.white : Colors.black,
                ),
                "h1": Style(
                  fontSize: FontSize(24.0),
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                "h2": Style(
                  fontSize: FontSize(20.0),
                  fontWeight: FontWeight.w600,
                  color: Colors.green,
                ),
                "a": Style(
                  textDecoration: TextDecoration.underline,
                  color: Colors.red,
                ),
              })
            : SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(child: Loading()),
              ),
      ),
    );
  }
}
