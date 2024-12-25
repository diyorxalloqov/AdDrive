import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:flutter_texi_tracker/global/imports/app_imports.dart';
import 'package:get/get.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  TermsConditionState createState() => TermsConditionState();
}

class TermsConditionState extends State<TermsCondition> {
  late final Repository _repository;
  String? data;
  bool isLoading = true;

  @override
  void initState() {
    _repository = Get.find<Repository>();
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    final response = await _repository.termsConditions();
    if (response?.success == true) {
      setState(() {
        data = response!.data!.en;
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(
            color: context.isDarkMode ? Colors.white : Colors.black),
        title: Text('terms_conditions'.tr,
            style: context.theme.textTheme.labelMedium),
      ),
      body: isLoading
          ? const Loading()
          : SingleChildScrollView(
              child: data != null
                  ? Html(data: data, style: {
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
                      child: const Center(child: CircularProgressIndicator()),
                    ),
            ),
    );
  }
}
