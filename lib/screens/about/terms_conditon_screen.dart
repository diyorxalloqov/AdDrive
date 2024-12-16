import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:get/get.dart';

class TermsCondition extends StatefulWidget {
  const TermsCondition({super.key});

  @override
  TermsConditionState createState() => TermsConditionState();
}

class TermsConditionState extends State<TermsCondition> {
  final _repository = Get.find<Repository>();
  String? data;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future fetchData() async {
    final response = await _repository.termsConditions();
    if (response?.success == true) {
      setState(() {
        data = response!.data!.en;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('terms_conditions'.tr,
            style: const TextStyle(color: Colors.white)),
      ),
      body: SingleChildScrollView(
        child: data != null
            ? Html(data: data)
            : SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
