import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:task_type_project/app/styles/text_styles.dart';

class LoginRegWidget {
  static loginRegBg() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Colors.white,
            Colors.teal[200]!,
            Colors.teal[600]!,
          ],
        ),
      ),
    );
  }

  static Widget loginRegTxt(String typeName) {
    return Text(
      typeName,
      style: kLoginRegTxtStyle,
      textAlign: TextAlign.center,
    );
  }

  static Widget loginRegFormfield(
      {required TextEditingController controller,
      required String labelText,
      required String hintText,
      bool obscureText = false}) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        filled: true,
        fillColor: Colors.white.withOpacity(0.8),
        labelText: labelText,
        hintText: hintText,
        labelStyle: TextStyle(color: Colors.grey[700]),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
    );
  }

  static Widget loginRegElevatedButton(String txt, VoidCallback onPressed) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        backgroundColor: Colors.teal[500],
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
      ),
      child: Text(
        txt,
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }

  static Widget createAccountTxt() {
    return TextButton(
      onPressed: () => Get.toNamed('/register'),
      child: Text(
        "Create an Account",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
