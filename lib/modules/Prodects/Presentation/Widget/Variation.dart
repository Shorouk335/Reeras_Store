import 'package:flutter/material.dart';
import 'package:reeras_store/core/data/data.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/ButtonWidget.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/TextForm_Widget.dart';
import 'package:reeras_store/modules/Prodects/domain/model/model/product_model.dart';
//show page
Widget? showVariations({
  required String? name,
  required String? barcode,
  required int? price,
  required int? stock,
}) {
  return Padding(
    padding: const EdgeInsets.all(10.0),
    child: Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0), color: Colors.grey[200]),
      child: Column(children: [
        textVariationDesign(title: "Name", disc: name ?? "name"),
        textVariationDesign(title: "Barcode", disc: barcode ?? "barcode"),
        textVariationDesign(title: "Price", disc: price ?? 15),
        textVariationDesign(title: "Stock", disc: stock ?? 15),
      ]),
    ),
  );
}

Widget textVariationDesign({required String? title, required dynamic disc}) {
  return Row(children: [
    Text(
      title ?? "title",
      style: const TextStyle(color: Colors.black, fontSize: 20),
    ),
    Spacer(),
    Text(
      "$disc",
      style: const TextStyle(color: Colors.red, fontSize: 15),
    )
  ]);
}
 //post & edit
Widget? addAtribute(BuildContext context, 
VariablesProduct variablesProduct,
    {String? name, String? barcode, String? price, String? stock}) {
  TextEditingController nameCon = TextEditingController();
  TextEditingController barcodeCon = TextEditingController();
  TextEditingController priceCon = TextEditingController();
  TextEditingController stockCon = TextEditingController();
  final formKey = GlobalKey<FormState>();

  return SingleChildScrollView(
    child: Form(
      key: formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text("Name"),
          const SizedBox(
            height: 10,
          ),
          textFormWidget(txt: "name", controller: nameCon),
          const SizedBox(
            height: 20,
          ),
          const Text("Barcode"),
          const SizedBox(
            height: 10,
          ),
          textFormWidget(txt: "barcode", controller: barcodeCon),
          const SizedBox(
            height: 20,
          ),
          const Text("Price"),
          const SizedBox(
            height: 10,
          ),
          textFormWidget(txt: "Price", controller: priceCon),
          const SizedBox(
            height: 20,
          ),
          const Text("Stock"),
          const SizedBox(
            height: 10,
          ),
          textFormWidget(txt: "stock", controller: stockCon),
          const SizedBox(
            height: 20,
          ),
          InkWell(
              onTap: () {
                if (formKey.currentState!.validate()) {
                  variablesProduct.variationsCount++;
                 variablesProduct.variationsData.add(VariationsItem(barcode: barcodeCon.text, name: nameCon.text, price: int.parse(priceCon.text), stock: int.parse(stockCon.text)));
                  Navigator.of(context).pop();
                }
              },
              child: ButtonWidget(buttontxt: "Add Attribute")),
        ],
      ),
    ),
  );
}

// ignore: non_constant_identifier_names
Widget SucessAddAtribute({required String? name}) {
  return Row(mainAxisAlignment: MainAxisAlignment.start, children: [
    Text(
      "$name ",
      style: TextStyle(fontSize: 10.0, color: Colors.red),
    ),
    const Text(
      "has been successfully added",
      style: TextStyle(
        fontSize: 10.0,
      ),
    ),
  ]);
}
