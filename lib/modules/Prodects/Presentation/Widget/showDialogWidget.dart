import 'package:flutter/material.dart';
import 'package:flutter_smart_dialog/flutter_smart_dialog.dart';

showDialogWidget1({BuildContext? context, String? title, String? body}) {
  return showDialog(
    context: context!,
    barrierDismissible: true,
    builder: (context) {
      return AlertDialog(
          title: Text(
            title!,
            style: TextStyle(color: Colors.red),
          ),
          content: Container(
            height: 200,
            width: 300,
            child: Center(
              child: Text(body!),
            ),
          ));
    },
  );
}

showSmartDialog() {
  SmartDialog.show(builder: (_) {
    return Container(
      height: 80,
      width: 180,
      decoration: BoxDecoration(
        color: Colors.black,
        borderRadius: BorderRadius.circular(10),
      ),
      alignment: Alignment.center,
      child: Column(
        children: [
          Text(
            'easy custom dialog',
            style: TextStyle(color: Colors.white),
          ),
          TextButton(onPressed: () async {}, child: Text("Ok"))
        ],
      ),
    );
  });
}

showLoader() async {
  return await SmartDialog.showLoading(
    msg: "Loading",
  );
}

showSmartToAst({String? msg}) async {
  return await SmartDialog.showToast(
    msg!,

    // builder: (_){
    //   return Padding(
    //     padding: const EdgeInsets.only(bottom: 40.0),
    //     child: SizedBox(
    //     //  height:40 ,
    //    //  width: 300,
    //     // decoration: BoxDecoration(
    //     //   color: Colors.red,
    //     //   borderRadius: BorderRadius.circular(10),
    //     // ),
    //     // alignment: Alignment.center,
    //      child: Padding(
    //        padding: const EdgeInsets.all(8.0),
    //        child: Text(
    //         msg,style: TextStyle(
    //           color: Colors.white,
    //           overflow: TextOverflow.         
    //         ),         
    //        ),
    //      ),
    //     ),
    //   );
    // },
  );
}

dismissDialog() async {
  await SmartDialog.dismiss();
}
