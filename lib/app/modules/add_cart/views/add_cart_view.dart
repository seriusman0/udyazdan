import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/add_cart_controller.dart';

class AddCartView extends GetView<AddCartController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: Obx(
            () => ListView.builder(
              itemCount: controller.qrCode.length,
              itemBuilder: (context, index) {
                return Container(
                  decoration:
                      BoxDecoration(color: Color.fromRGBO(64, 75, 96, .9)),
                  child: Text(
                      "$index Nama Produk = ${controller.namaBarang[index]}"),
                );
              },
            ),
          )),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    child: Icon(Icons.sync),
                    onPressed: () {
                      controller.getCartProduct();
                    }),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: ElevatedButton(
                    child: Text("TAMBAH"),
                    onPressed: () {
                      controller.scanQR();
                      controller.getCartProduct();
                    }),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
