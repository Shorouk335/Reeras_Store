import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/showDialogWidget.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storeStates.dart';
import 'package:reeras_store/modules/Prodects/cubit/storeCubit/storecubit.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/TextForm_Widget.dart';
import 'package:reeras_store/modules/Prodects/domain/model/model/product_model.dart';

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
  String? image;
  final formKey = GlobalKey<FormState>();
  bool? switch1 = false;
  bool? switch2 = false;
  XFile? pickedFile;
  File? file;

  @override
  void initState() {
    super.initState();
    if (widget.products != null) {
      nameController!.text = widget.products?.name ?? "name";
      discController!.text = widget.products?.description ?? "dis";
      costController!.text = widget.products?.cost.toString() ?? "25";
      priceController!.text = widget.products?.price.toString() ?? "25";
      barcodeController!.text = widget.products?.barcode ?? "255";
      switch1 = widget.products?.active ?? true;
      switch2 = widget.products?.hasAttribute ?? true;
      unitController!.text = widget.products?.unit ?? "unit";
      stockController!.text = widget.products?.stock.toString() ?? "25";
      image = widget.products?.imageUrl ?? "";
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => StoreCubit(),
      child: BlocConsumer<StoreCubit, StoreState>(
        listener: (context, state) {
          if (state is SuccessfulPostProdectState) {
            showSmartToAst(msg: state.msg);
            Navigator.of(context).pop();
          }
          if (state is SuccefulEditDataState) {
            showSmartToAst(msg: state.msg);
            Navigator.of(context).pop();
          }
        },
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
                      //edit
                      child: (widget.products != null && pickedFile == null)
                          ? InkWell(
                              onTap: () async {
                                await pickedImage();
                              },
                              child: Image(
                                image: NetworkImage(image ?? ""),
                                fit: BoxFit.fill,
                                errorBuilder: (context, error, stackTrace) =>
                                    Image(
                                  image: AssetImage("assets/images/pic.jpeg"),
                                  fit: BoxFit.fill,
                                ),
                              ),
                            )
                          //edit imag or post
                          : (pickedFile != null)
                              ? // عشان اعرض صوره من فيل
                              InkWell(
                                  onTap: () async {
                                    await pickedImage();
                                  },
                                  child: Image.file(
                                    File(pickedFile!.path),
                                    height: 150,
                                    width: 250,
                                  ),
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
                      child: Container(
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

  clickButton(StoreCubit storeCubit, {int? pageNumber}) async {
    if (formKey.currentState!.validate()) {
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
        image: (file != null)
            ? await MultipartFile.fromFile(file!.path, filename: "image")
            : null,
      );
      //ediiiiiiiiiiit
      if (widget.products != null) {
        await storeCubit.editDataCubit(
            id: widget.products!.id!, products: prodect);
      } //pooooost
      else {
        await storeCubit.postProdectCubit(
            data: prodect.toJson(),
            pageNumber: pageNumber,
            context: context,
            Form: true);
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

  pickedImage() async {
    var picked = ImagePicker();
    pickedFile = await picked.pickImage(source: ImageSource.gallery);
    // to refresh screen with new photoe insted of icon
    setState(() {});
    // to create image as form data
    file = File(pickedFile!.path);
    print(" image ddone ");
  }
}
