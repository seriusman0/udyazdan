import 'package:currency_text_input_formatter/currency_text_input_formatter.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../controllers/check_out_controller.dart';

class CheckOutView extends GetView<CheckOutController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('CheckOutView'),
        centerTitle: true,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Total Tagihan"),
          Padding(
              padding: const EdgeInsets.all(8),
              child: Container(
                  child: Obx((() => Text(
                      style: TextStyle(fontSize: 30),
                      textAlign: TextAlign.right,
                      NumberFormat.currency(
                              locale: 'id', decimalDigits: 0, symbol: "Rp ")
                          .format(controller.totalC.value)))))),
          Container(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Center(
                child: Text(
                  "Bayar",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 8),
            child: TextField(
                controller: controller.bayarC.value,
                autofocus: true,
                textAlign: TextAlign.center,
                inputFormatters: [
                  CurrencyTextInputFormatter(
                      locale: 'id', decimalDigits: 0, symbol: 'Rp ')
                ],
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20)),
                ),
                onChanged: (value) {}),
          ),
          SizedBox(
            height: 20,
          ),
          Obx((() => Text(controller.kembaliC.value.toString()))),
        ],
      ),
    );
  }
}
