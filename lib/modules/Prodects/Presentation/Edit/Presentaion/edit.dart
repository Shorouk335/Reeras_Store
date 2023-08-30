
import 'package:flutter/material.dart';

class Edit_Page extends StatefulWidget {
  const Edit_Page({super.key});
  @override
  State<Edit_Page> createState() => _Edit_PageState();
}

class _Edit_PageState extends State<Edit_Page> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home"),
      ),
      body: Center(
        child: Text(
          "Edit Page"
        ),
      ),
    );
  }
}
