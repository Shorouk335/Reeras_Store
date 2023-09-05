import 'package:flutter/material.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/store_cubit.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/TextForm_Widget.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class ProdectDialog extends StatefulWidget {
  final Products? products;
  final StoreCubit storeCubit;
  ProdectDialog({super.key, required this.storeCubit, required this.products});

  @override
  State<ProdectDialog> createState() => _ProdectDialogState();
}

class _ProdectDialogState extends State<ProdectDialog> {
  TextEditingController? nameController = TextEditingController();
  TextEditingController? discController = TextEditingController();
  TextEditingController? priceController = TextEditingController();
  TextEditingController? costController = TextEditingController();
  TextEditingController? barcodeController = TextEditingController();
  TextEditingController? unitController = TextEditingController();
  TextEditingController? stockController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool? switch1 = false;
  bool? switch2 = false;

  @override
  void initState() {
    if (widget.products != null) {
      nameController!.text = widget.products!.name!;
      discController!.text = widget.products!.description!;
      costController!.text = widget.products!.cost!.toString();
      priceController!.text = widget.products!.price!.toString();
      barcodeController!.text = widget.products!.barcode!;
      switch1 = widget.products!.active!;
      switch2= widget.products!.hasAttribute!;
      unitController!.text = widget.products!.unit!;
      stockController!.text = widget.products!.stock!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height / 1.4,
        child: ListView(
          children: [
            Text("Prodect Name"),
            SizedBox(
              height: 10,
            ),
            TextFormWidget(txt: "name", controller: nameController),
            SizedBox(
              height: 20,
            ),
            Text("Prodect Description"),
            SizedBox(
              height: 10,
            ),
            TextFormWidget(txt: "Discription", controller: discController),
            SizedBox(
              height: 20,
            ),
            Text("Prodect Price"),
            SizedBox(
              height: 10,
            ),
            TextFormWidget(txt: "Price", controller: priceController),
            SizedBox(
              height: 20,
            ),
            Text("Prodect Cost"),
            SizedBox(
              height: 10,
            ),
            TextFormWidget(txt: "Cost", controller: costController),
            SizedBox(
              height: 20,
            ),
            Text("Prodect barcode"),
            SizedBox(
              height: 10,
            ),
            TextFormWidget(txt: "barcode", controller: barcodeController),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [Text("active"), SwitchIcon(value: switch1, type: "1")],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("has_attribute"),
                SwitchIcon(value: switch2, type: "2")
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Text("unit"),
            SizedBox(
              height: 10,
            ),
            TextFormWidget(txt: "unit", controller: unitController),
            SizedBox(
              height: 20,
            ),
            Text("stock"),
            SizedBox(
              height: 10,
            ),
            TextFormWidget(txt: "stock", controller: stockController),
            SizedBox(
              height: 20,
            ),
            Center(
              child: Container(
                height: 50,
                width: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15.0),
                  color: Colors.red,
                ),
                child: TextButton(
                  child: Text(
                    widget.products != null ? 'Edit product' : "Post Prodect",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15.0,
                    ),
                  ),
                  onPressed: () async {
                    await ClickButton();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  ClickButton() async {
    if (formKey.currentState!.validate()) {
      Products prodect = Products(
        name: nameController!.text,
        price: int.parse(priceController!.text),
        active: switch1 ,
        barcode: barcodeController!.text,
        cost: int.parse(costController!.text),
        hasAttribute:switch2 ,
        stock: int.parse(stockController!.text),
        unit: unitController!.text,
        description: discController!.text,
      );
      //ediiiiiiiiiiit
      if (widget.products != null) {
        await widget.storeCubit
            .EditDataCubit(id: widget.products!.id!, products: prodect)
            .then((value) => Navigator.of(context).pop());
      } //pooooost
      else {
        print(prodect.stock);
        await widget.storeCubit.postProdectCubit(data: prodect.toJson());
      }
    }
  }

  Widget SwitchIcon({required bool? value, required String? type}) {
    return Switch(
        value: value!,
        onChanged: (value) {
          if (type == "1") {
            setState(() {
              switch1 = value;
            });
          } else {
            setState(() {
              switch2 = value;
            });
          }
        },
    activeColor: Colors.red,
    );
  }
}
