import 'package:flutter/material.dart';
import 'package:addrive/app_config/utils.dart';
import 'package:get/get.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Image.asset(shapeLoginFlow, width: double.infinity, fit: BoxFit.cover,),
            Padding(
              padding: const EdgeInsets.only(left: 32.0, top: 80, right: 32),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.asset(adgari, height: 45, fit: BoxFit.cover,),
                    const SizedBox(height: 40,),
                    Text('OTP Verification', style: Get.textTheme.displayLarge!.copyWith(fontWeight: FontWeight.w400),),
                    const SizedBox(height: 20,),
                    Text(
                      'Please enter 4 digit code sent to your \nphone number',
                      style: Get.textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.w400, height: 1.4),
                    ),
                    const SizedBox(height: 30,),
                    TextFormField(
                      textAlignVertical: TextAlignVertical.center,
                      validator: (val) => val?.isEmpty == true ? 'enter phone please' : null,
                      style: const TextStyle(color: Colors.black, fontSize: 16.0),
                      decoration: const InputDecoration(
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.black)),
                        hintText: 'OTP',
                        hintStyle: TextStyle(color: Colors.grey, fontSize: 16.0, fontWeight: FontWeight.w400),),
                      onChanged: (val) {
                      },
                    ),
                    const SizedBox(height: 20,),
                    GestureDetector(
                      onTap: () async {},
                      child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.symmetric(vertical: 15.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(25),
                            color: const Color(0xFF041E48)),
                        child: const Center(
                            child: Text('Send', style: TextStyle(color: Colors.white, fontSize: 18),
                        )),
                      ),
                    ),
                    const SizedBox(height: 20.0),
                    Container(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text('Did not receive OTP?', style: Get.textTheme.bodySmall,),
                          GestureDetector(
                            onTap: () {
                              // widget.toggleView();
                            },
                            child: Container(
                              padding: const EdgeInsets.only(left: 5),
                              child: const Text(
                                'Resend', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.red),),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
