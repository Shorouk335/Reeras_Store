import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/states.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Store/cubit/store_cubit.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/TextForm_Widget.dart';
import 'package:reeras_store/modules/Prodects/model/product_model.dart';

class ProdectDialog extends StatefulWidget {
  final Products? products;
  const ProdectDialog({super.key, required this.products});

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
  XFile? pickedFile;
    File? file  ;
  FormData? imageData;

  @override
  void initState() {
    super.initState();
    if (widget.products != null) {
      nameController!.text = widget.products!.name!;
      discController!.text = widget.products!.description!;
      costController!.text = widget.products!.cost!.toString();
      priceController!.text = widget.products!.price!.toString();
      barcodeController!.text = widget.products!.barcode!;
      switch1 = widget.products!.active!;
      switch2 = widget.products!.hasAttribute!;
      unitController!.text = widget.products!.unit!;
      stockController!.text = widget.products!.stock!.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StoreCubit(),
      child: BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {},
        builder: (context, state) {
          StoreCubit storeCubit = StoreCubit.get(context);
          return Form(
            key: formKey,
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height / 1.4,
              child: ListView(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Center(
                      child: (pickedFile != null)
                          ?
                          // عشان اعرض صوره من فيل
                          Image.file(
                              File(pickedFile!.path),
                              height: 150,
                              width: 250,
                            )
                          : InkWell(
                              onTap: () async {
                                await pickedImage();
                              },
                              child: const Icon(
                                Icons.camera_alt_outlined,
                                color: Colors.red,
                                size: 50.0,
                              ),
                            ),
                    ),
                  ),
                  const Text("Prodect Name"),
                  const SizedBox(
                    height: 10,
                  ),
                  textFormWidget(txt: "name", controller: nameController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Prodect Description"),
                  const SizedBox(
                    height: 10,
                  ),
                  textFormWidget(
                      txt: "Discription", controller: discController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Prodect Price"),
                  const SizedBox(
                    height: 10,
                  ),
                  textFormWidget(txt: "Price", controller: priceController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Prodect Cost"),
                  const SizedBox(
                    height: 10,
                  ),
                  textFormWidget(txt: "Cost", controller: costController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("Prodect barcode"),
                  const SizedBox(
                    height: 10,
                  ),
                  textFormWidget(txt: "barcode", controller: barcodeController),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("active"),
                      switchIcon(value: switch1, type: "1")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("has_attribute"),
                      switchIcon(value: switch2, type: "2")
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("unit"),
                  const SizedBox(
                    height: 10,
                  ),
                  textFormWidget(txt: "unit", controller: unitController),
                  const SizedBox(
                    height: 20,
                  ),
                  const Text("stock"),
                  const SizedBox(
                    height: 10,
                  ),
                  textFormWidget(txt: "stock", controller: stockController),
                  const SizedBox(
                    height: 20,
                  ),
                  Center(
                      child: state is! InitialStoreDataState && state is! ErrorPostStoreDataState
                          ? const Padding(
                              padding: EdgeInsets.all(8.0),
                              child: CircularProgressIndicator(
                                color: Colors.red,
                                strokeWidth: 3,
                              ),
                            )
                          : Container(
                              height: 50,
                              width: 250,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15.0),
                                color: Colors.red,
                              ),
                              child: TextButton(
                                child: Text(
                                  widget.products != null
                                      ? 'Edit product'
                                      : "Post Prodect",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 15.0,
                                  ),
                                ),
                                onPressed: () async {
                                  await clickButton(storeCubit, pageNumber: 1);
                                },
                              ),
                            )),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  clickButton(StoreCubit storeCubit,  {int? pageNumber}) async {
    if (formKey.currentState!.validate()) {
     // FormData formData = FormData.fromMap({
     //   "name": nameController!.text,
     //   "price": int.parse(priceController!.text),
     //   "active": switch1,
     //   "barcode": barcodeController!.text,
     //   "cost": int.parse(costController!.text),
     //   "hasAttribute": switch2,
     //   "stock": int.parse(stockController!.text),
     //   "unit": unitController!.text,
      //  "description": discController!.text,
      //  "image": await MultipartFile.fromFile(file!.path,
      //      filename: "image.jpg"),
      //});
      //  imageData = formData;
      Products prodect = Products(
        name: nameController!.text,
        price: int.parse(priceController!.text),
        active: switch1,
        barcode: barcodeController!.text,
        cost: int.parse(costController!.text),
        hasAttribute: switch2,
        stock: int.parse(stockController!.text),
        unit: unitController!.text, 
        description: discController!.text,
       // image: await MultipartFile.fromFile(file!.path,
       //     filename: "image"),
      );
      //ediiiiiiiiiiit
      if (widget.products != null) {
        await storeCubit
            .editDataCubit(id: widget.products!.id!, products: prodect)
            .then((value) => Navigator.of(context).pop());
      } //pooooost
      else {
        await storeCubit
            .postProdectCubit(data: prodect.toJson() , pageNumber: pageNumber ,context: context)
            .then((value){
              if (storeCubit.state is! ErrorPostStoreDataState){
                 Navigator.of(context).pop();
              }

            });
      }
    }
  }

  Widget switchIcon({required bool? value, required String? type}) {
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

  // to check of permision
  //checkPermission()  {
  // ignore: unused_local_variable
  //  Map<Permission, PermissionStatus> states = [
  //    Permission.camera,
  //    Permission.storage
  //  ].request() as Map<Permission, PermissionStatus>;
  //  print("Asked for Permission ");
  //  if (states[Permission.camera] != PermissionStatus.granted ||
  //      states[Permission.storage] != PermissionStatus.granted) {
  //    // to handell error
  //    return;
  //  }
  //   pickedImage();
  //}

  pickedImage() async {
    var picked = ImagePicker();
    pickedFile = await picked.pickImage(source: ImageSource.camera);
    // to refresh screen with new photoe insted of icon
    setState(() {});
    // to create image as form data 
     file = File(pickedFile!.path);
    print(" image ddone ");
  }
}
