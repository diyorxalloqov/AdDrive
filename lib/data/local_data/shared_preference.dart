import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void storeLocalData({required String? key, required String value}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key!, value);
}

void setValue(String key, String? value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    prefs.setString(key, value!);
  } catch (_) {}
}

Future<String?> getValue(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  try {
    var value = prefs.getString(key);
    return value;
  } catch (error) {
    return null;
  }
}

Future<String?> getLocalData({required String? key}) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  return prefs.getString(key!);
}
