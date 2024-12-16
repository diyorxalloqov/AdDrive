import 'package:flutter/material.dart';
import 'package:flutter_texi_tracker/controller/auth_controller.dart';
import 'package:flutter_texi_tracker/data/repository/repository.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {

    final formKey = GlobalKey<FormState>();
    final TextEditingController currentPasswordController = TextEditingController();
    final TextEditingController newPasswordController = TextEditingController();
    final TextEditingController confirmPasswordController = TextEditingController();
    final repository = Get.find<Repository>();
    final authController = Get.find<AuthController>();

    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        title: Text('settings'.tr,style: const TextStyle(color: Colors.white),),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Text('change_password'.tr, style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      height: 1.25,
                      letterSpacing: 0.5,
                      color: Color(0xFF222222)
                  ),),

                  TextFormField(
                    obscureText: true,
                    controller: currentPasswordController,
                    textAlignVertical: TextAlignVertical.bottom,
                    validator: (val) => val?.isEmpty == true ? 'enter_current_password'.tr : null,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      hintText: 'current_password'.tr,
                      hintStyle: const TextStyle(color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                  TextFormField(
                    obscureText: true,
                    controller: newPasswordController,
                    textAlignVertical: TextAlignVertical.bottom,
                    validator: (val) =>
                    val?.isEmpty == true
                        ? 'enter_new_password'.tr
                        : null,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      hintText: 'new_password'.tr,
                      hintStyle: const TextStyle(color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                  TextFormField(
                    obscureText: true,
                    controller: confirmPasswordController,
                    textAlignVertical: TextAlignVertical.bottom,
                    validator: (val) =>
                    val?.isEmpty == true ? 'enter_confirm_password'.tr : null,
                    style: const TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                      focusedBorder: const UnderlineInputBorder(
                          borderSide: BorderSide(color: Colors.grey)
                      ),
                      hintText: 'confirm_password'.tr,
                      hintStyle: const TextStyle(color: Colors.grey,
                          fontSize: 16.0,
                          fontWeight: FontWeight.w400),
                    ),
                  ),

                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 8),
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () async {

                        final user = authController.getUser();

                        if (formKey.currentState?.validate() == true) {

                          final data = {
                            "user_id": "${user?.id}",
                            "current_password": currentPasswordController.text,
                            "password": newPasswordController.text,
                            "password_confirmation": confirmPasswordController.text,
                          };

                          final message = await repository.updatePassword(data);

                          if(message?.success == true){
                            await authController.deleteUser();
                            Fluttertoast.showToast(msg: '${message?.message}', backgroundColor: Colors.green);
                            //FlashMsg.success(context, '${message?.message}');
                            Get.back();
                          }else{
                            Fluttertoast.showToast(msg: '${message?.message}', backgroundColor: Colors.red);
                            //FlashMsg.error(context, '${message?.message}');
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        fixedSize: const Size(0, 42), backgroundColor: const Color(0xFF0B2154),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(25),
                        ),
                      ),
                      child: Text('update'.tr,style: const TextStyle(color: Colors.white),),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
