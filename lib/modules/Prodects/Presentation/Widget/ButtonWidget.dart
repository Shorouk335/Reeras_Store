import 'package:flutter/material.dart';

Widget ButtonWidget({required String? buttontxt }){
  return Container(
          height: 50,
          width: double.infinity,
          padding: const EdgeInsets.all(10.0),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15), color: (buttontxt =="Add Attribute")? Colors.red[300] : Colors.red),
          child: Center(
            child:  Text(
              buttontxt!,
              style: const TextStyle(
                color: Colors.white,
              ),
            ),
          ),
        );
}

