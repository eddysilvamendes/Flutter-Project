import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class UtilsServices {
  final storage = const FlutterSecureStorage();

  // Retornar valor em ECV
  String priceToCurrency(double price) {
    NumberFormat numberFormat = NumberFormat.simpleCurrency(locale: 'pt_PT');

    return numberFormat.format(price);
  }

  //Data Format
  String formatDateTime(DateTime dateTime) {
    initializeDateFormatting();

    DateFormat dateFormat = DateFormat.yMd('pt_PT').add_Hm();
    return dateFormat.format(dateTime);
  }

  //Toast Message
  void showToast({required String message, bool isError = false}) {
    Fluttertoast.showToast(
      msg: message,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.BOTTOM,
      timeInSecForIosWeb: 1,
      backgroundColor: isError ? Colors.red : Colors.white,
      textColor: isError ? Colors.white : Colors.black,
      fontSize: 14,
    );
  }

  //Salvar dados Localmente
  Future<void> saveLocalData(
      {required String key, required String data}) async {
    await storage.write(key: key, value: data);
  }

  //Recuperar dados Localmente em seguranca
  Future<String?> getLocalData({required String key}) async {
    return await storage.read(key: key);
  }

  //Remove dados localmente
  Future<void> removeLocalData({required String key}) async {
    await storage.delete(key: key);
  }

  //Converter qrCode
  Uint8List decodeQrCodeImage(String value) {
    String base64String = value.split(',').last;

    return base64.decode(base64String);
  }
}
