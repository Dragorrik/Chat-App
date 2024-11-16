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

  static Widget loginRegEmailFormfield({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
  }) {
    return TextFormField(
      controller: controller,
      decoration: InputDecoration(
        filled: true,
        floatingLabelBehavior: FloatingLabelBehavior.auto,
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

  static Widget loginRegPassFormfield({
    required TextEditingController controller,
    required String labelText,
    required String hintText,
    required ValueNotifier<bool> obscureTextNotifier,
  }) {
    return ValueListenableBuilder<bool>(
      valueListenable: obscureTextNotifier,
      builder: (context, isObscure, _) {
        return TextFormField(
          controller: controller,
          obscureText: isObscure,
          decoration: InputDecoration(
            filled: true,
            floatingLabelBehavior: FloatingLabelBehavior.auto,
            fillColor: Colors.white.withOpacity(0.8),
            labelText: labelText,
            hintText: hintText,
            labelStyle: TextStyle(color: Colors.grey[700]),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(15),
              borderSide: BorderSide.none,
            ),
            suffixIcon: IconButton(
              icon: Icon(
                isObscure ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey[700],
              ),
              onPressed: () {
                obscureTextNotifier.value =
                    !obscureTextNotifier.value; // Toggle visibility
              },
            ),
          ),
        );
      },
    );
  }

  static Widget loginRegButton(String txt, VoidCallback onPressed) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 25, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.teal[500],
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(0),
            bottomLeft: Radius.circular(0),
            bottomRight: Radius.circular(15),
            topLeft: Radius.circular(15),
          ),
        ),
        child: Text(
          txt,
          textAlign: TextAlign.center,
          style: TextStyle(
              fontSize: 16, color: const Color.fromARGB(255, 255, 255, 255)),
        ),
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
