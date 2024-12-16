import 'package:after_layout/after_layout.dart';
import 'package:flutter/material.dart';

class LocationPermissionDialog extends StatefulWidget {
  const LocationPermissionDialog({Key? key}) : super(key: key);

  @override
  LocationPermissionDialogState createState() => LocationPermissionDialogState();
}

class LocationPermissionDialogState extends State<LocationPermissionDialog> with AfterLayoutMixin<LocationPermissionDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void afterFirstLayout(BuildContext context) {
    _neverSatisfied();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        decoration: const BoxDecoration(color: Colors.red),
      ),
    );
  }

  Future<void> _neverSatisfied() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Location permission'),
          content: SingleChildScrollView(
            child: ListBody(
              children: [
                const Text('You have to grant background location permission if you want to use the application.'),
                Text(prominentDisclosure),
                const SizedBox(height: 36.0,),
                Text(denyMessage),
              ],
            ),
          ),
          actions: <Widget>[
            MaterialButton(
              child: const Text('Approve'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            MaterialButton(
              child: const Text('Deny'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  String denyMessage = 'if the permission is rejected, then you have to manually go to the settings to enable it';
  String prominentDisclosure = 'AdGari collects location data to enable tracking driver location, Calculate distance and also calculate monthly amount even when the app is closed or not )';
}
