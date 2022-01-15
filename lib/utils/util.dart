import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

const USER_NICK_NAME = 'USER_NICK_NAME';
const USER_EMAIL = 'USER_EMAIL';
const STATUS_LOGIN = 'STATUS_LOGIN';
const STATUS_LOGOUT = 'STATUS_LOGOUT';
const TOKEN = 'TOKEN';

void showToast(String message) {
  Fluttertoast.showToast(
    fontSize: 13,
    msg: '   $message   ',
    backgroundColor: Colors.black,
    toastLength: Toast.LENGTH_SHORT,
    gravity: ToastGravity.BOTTOM,
  );
}