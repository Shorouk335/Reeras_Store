
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

Widget TextFormWidget({String? txt ,TextEditingController? controller}) {
  return TextFormField(
    controller: controller,
    // لاخفاء واظهار النص
    cursorColor: Colors.red,
    decoration: InputDecoration(
//استايل الكلام الخفي
      hintText: "$txt",
      hintStyle: TextStyle(color: Colors.grey, fontSize: 15.0,),
//حاله الفورم لو ضغط عليها
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black26,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
// حاله الفورم لو مضغطش
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.black26),
        borderRadius: BorderRadius.circular(20),
      ),
    ),
  );
}
