import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppMessages{
  AppMessages._();

  /// default message
  /// show toast message to user
  static show(String message){
    Fluttertoast.showToast(
        msg: message,
      toastLength: Toast.LENGTH_LONG
    );
  }


  /// show dialog message to user
  static showAppDialog({
    required BuildContext context,
    String? title,
    required String message,}){
    showDialog(
      context: context, builder: (context){
        return CupertinoAlertDialog(
          title: title == null ? null :Text(title),
          content: Text(message,style: Theme.of(context).textTheme.bodyMedium,),
        );
    });
  }
}