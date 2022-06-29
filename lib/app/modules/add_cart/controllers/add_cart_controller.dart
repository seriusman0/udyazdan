import 'dart:convert';
import 'dart:developer' as developer;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddCartController extends GetxController {
  String scannedQrcode = '';
  static const String url =
      'http://192.168.1.53/appkasirudyazdan/api/get_cart.php';
  RxList<String> qrCode = ['1', '2', '3', '4', '1', '2', '3', '4'].obs;
  RxList<String> namaBarang = ['p1', 'p2', 'p3'].obs;
  RxList<String> jumlah = [''].obs;
  RxList<String> total = [''].obs;

  Future<void> scanQR() async {
    try {
      scannedQrcode = await FlutterBarcodeScanner.scanBarcode(
        "#ff6666",
        'Cancel',
        true,
        ScanMode.BARCODE,
      );
      if (scannedQrcode != "-1") {
        Get.snackbar(
          "Result",
          "QR Code " + scannedQrcode,
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );
      }
    } on PlatformException {
    } catch (e) {}
  }

  Future<RxList<String>> getCartProduct() async {
    try {
      final response = await http.get(Uri.parse("$url"));
      if (response.statusCode == 200) {
        this.qrCode.removeRange(0, this.qrCode.length);
        this.namaBarang.removeRange(0, this.namaBarang.length);
        this.jumlah.removeRange(0, this.jumlah.length);
        this.total.removeRange(0, this.total.length);
        for (int i = 0; i < (json.decode(response.body).length); i++) {
          this.qrCode.add(jsonDecode(response.body)[i]['id_barang']);
          this.namaBarang.add(jsonDecode(response.body)[i]['nama_barang']);
          this.jumlah.add(jsonDecode(response.body)[i]['jumlah']);
          this.total.add(jsonDecode(response.body)[i]['total']);
        }
        developer.log(qrCode.toString());
      }
    } catch (e) {
      print("Error $e");
    }
    return this.qrCode;
  }

  final count = 0.obs;
  @override
  onInit() {
    super.onInit();
    WidgetsBinding.instance.addPostFrameCallback((_) => getCartProduct());
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {}
  void increment() => count.value++;
}
