import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:get/get.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  PrivacyPolicyState createState() => PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicy> {
  final _repository = Get.find<Repository>();
  String? data;

  @override
  void initState() {
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
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text(
          'privacy_policy'.tr,
          style: const TextStyle(color: Colors.white),
        ),
      ),
      body: SingleChildScrollView(
        child: data != null
            ? Html(
                data: """$data""",
              )
            : SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: const Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }
}
