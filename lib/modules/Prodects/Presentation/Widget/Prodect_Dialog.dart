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
  TextEditingController? activeController = TextEditingController();
  TextEditingController? hasAtriputeController = TextEditingController();
  TextEditingController? unitController = TextEditingController();
  TextEditingController? stockController = TextEditingController();

  @override
  void initState() {
    if(widget.products != null){
      nameController!.text = widget.products!.name! ;
      discController!.text = widget.products!.description! ;
      costController!.text =widget.products!.cost!.toString();
      priceController!.text =widget.products!.price!.toString();
      barcodeController!.text = widget.products!.barcode! ;
      activeController!.text = widget.products!.active!.toString() ;
      hasAtriputeController!.text = widget.products!.hasAttribute!.toString() ;
      unitController!.text = widget.products!.unit! ;
      stockController!.text = widget.products!.stock!.toString() ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Text("active"),
          SizedBox(
            height: 10,
          ),
          TextFormWidget(txt: "active", controller: activeController),
          SizedBox(
            height: 20,
          ),
          Text("has_attribute"),
          SizedBox(
            height: 10,
          ),
          TextFormWidget(
              txt: "has_attribute", controller: hasAtriputeController),
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
                  widget.products != null ?'Edit product' : "Post Prodect",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.0,
                  ),
                ),
                onPressed: () async {
                  Products prodect = Products(
                    name: nameController!.text,
                    price: int.parse(priceController!.text),
                    active: (activeController!.text == "true") ? true : false,
                    barcode: barcodeController!.text,
                    cost: int.parse(costController!.text),
                    hasAttribute:
                        (hasAtriputeController!.text == "true") ? true : false,
                    stock: int.parse(stockController!.text),
                    unit: unitController!.text,
                    description: discController!.text,
                  );
                  if(widget.products != null){
                    print(nameController!.text);
                   await widget.storeCubit.EditDataCubit(id: widget.products!.id!, products: prodect);
                  }else {
                    await widget.storeCubit
                        .postProdectCubit(data: prodect.toJson());
                  }

                  // Navigator.pop(context);
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
