import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Widget textFormWidget({String? txt ,TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    validator: (value) {
      if (value == null || value.isEmpty) {
        return 'Please enter $txt';
      }

      return null;
    },

    inputFormatters: [
      (txt == "Cost" || txt == "Price" || txt == "stock") ?
      FilteringTextInputFormatter.allow(RegExp(r'[0-9]')) :
      FilteringTextInputFormatter.singleLineFormatter,
    ],

    // عشان امنع الكوبي بيست
    //enableInteractiveSelection: false,

     keyboardType: (txt == "Cost" || txt == "Price"|| txt == "stock") ? TextInputType.number :TextInputType.text ,
    // لاخفاء واظهار النص
    cursorColor: Colors.red,
    decoration: InputDecoration(
//استايل الكلام الخفي
      hintText: "$txt",
      hintStyle: const TextStyle(color: Colors.grey, fontSize: 15.0,),
//حاله الفورم لو ضغط عليها
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: Colors.black26,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
// حاله الفورم لو مضغطش
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(color: Colors.black26),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}