import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class CheckOutController extends GetxController {
  var totalC = 0.obs;

  Rx<TextEditingController> bayarC = TextEditingController().obs;
  var kembaliC = 0.obs;

  static const String url =
      'http://192.168.88.244/appkasirudyazdan/api/get_total.php';

  final count = 0.obs;
  @override
  Future<void> onInit() async {
    await getTotal();
    super.onInit();
  }

  Future<void> getTotal() async {
    try {
      final response = await http.get(Uri.parse("$url"));
      if (response.statusCode == 200) {
        this.totalC.value = int.parse(jsonDecode(response.body)[0]['total']);
      }
    } catch (e) {
      print("Error $e");
    }
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
