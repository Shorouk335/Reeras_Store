import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:reeras_store/core/data/data.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/ButtonWidget.dart';
import 'package:reeras_store/modules/Prodects/Presentation/Widget/Variation.dart';
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
  final formKey = GlobalKey<FormState>();
  String? image;
  XFile? pickedFile;
  File? file;
VariablesProduct variablesProduct= VariablesProduct();
  @override
  void initState() {
    super.initState();
    //edddddddit
    if (widget.products != null) {
      variablesProduct.nameController.text = widget.products?.name ?? "name";
      variablesProduct.discController.text = widget.products?.description ?? "dis";
      variablesProduct.costController.text = widget.products?.cost.toString() ?? "25";
      variablesProduct.priceController.text = widget.products?.price.toString() ?? "25";
      variablesProduct.barcodeController.text = widget.products?.barcode ?? "255";
      variablesProduct.switch1 = widget.products?.active ?? true;
      variablesProduct.switch2 = widget.products?.hasAttribute ?? true;
      variablesProduct.unitController.text = widget.products?.unit ?? "unit";
      variablesProduct.stockController.text = widget.products?.stock.toString() ?? "25";
      image = widget.products?.imageUrl ?? "";
      if (widget.products!.variations!.isNotEmpty) {
        variablesProduct.variationsCount = widget.products!.variations!.length;
        widget.products!.variations!.forEach((element) {
          variablesProduct.variationsData.add(element);
        });
      }
    }
  }

  @override
  void dispose() {
    super.dispose();
    variablesProduct.dispose();
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
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      const Image(
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
                    textFormWidget(txt: "name", controller: variablesProduct.nameController),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Prodect Description"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormWidget(
                        txt: "Discription", controller: variablesProduct.discController),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Prodect Price"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormWidget(txt: "Price", controller: variablesProduct.priceController),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Prodect Cost"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormWidget(txt: "Cost", controller: variablesProduct.costController),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("Prodect barcode"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormWidget(
                        txt: "barcode", controller: variablesProduct.barcodeController),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("unit"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormWidget(txt: "unit", controller: variablesProduct.unitController),
                    const SizedBox(
                      height: 20,
                    ),
                    const Text("stock"),
                    const SizedBox(
                      height: 10,
                    ),
                    textFormWidget(txt: "stock", controller: variablesProduct.stockController),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("active"),
                        switchIcon(value: variablesProduct.switch1, type: "1")
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text("has_attribute"),
                        switchIcon(value: variablesProduct.switch2, type: "2")
                      ],
                    ),
                    (variablesProduct.switch2 == true)
                        ? Column(
                            children: [
                              //الحجات الي اضافات قبل كدا
                              ListView.builder(
                                scrollDirection: Axis.vertical,
                                physics: NeverScrollableScrollPhysics(),                                  shrinkWrap: true,
                                itemCount: variablesProduct.variationsCount,
                                itemBuilder: (context, index) {
                                  return Row(
                                    children: [
                                      SucessAddAtribute(
                                        name: variablesProduct.variationsData[index].name,
                                      ),
                                      Spacer(),
                                      TextButton(
                                          onPressed: () {
                                            setState(() {
                                              variablesProduct.variationsCount--;
                                              variablesProduct.variationsData.removeAt(index);
                                            });
                                          },
                                          child: const Text(
                                            "Delete",
                                            style: TextStyle(
                                                color: Colors.red,
                                                fontSize: 10.0),
                                          ))
                                    ],
                                  );
                                },
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              //زرار انه يضيف جديد
                              InkWell(
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    barrierDismissible: true,
                                    builder: (context) {
                                      return AlertDialog(
                                        title: const Text(
                                          'Add Attribute',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        content: addAtribute(context ,variablesProduct),
                                      );
                                    },
                                  ).then((value) {
                                    setState(() {});
                                  });
                                },
                                child: ButtonWidget(buttontxt: "Add Attribute"),
                              ),
                            ],
                          )
                        : const SizedBox(),
                    const SizedBox(
                      height: 10,
                    ),
                    InkWell(
                      onTap: () async {
                        await clickButton(storeCubit, pageNumber: 1);
                      },
                      child: ButtonWidget(
                          buttontxt: widget.products != null
                              ? 'Edit product'
                              : "Post Prodect"),
                    ),
                  ],
                ),
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
        name: variablesProduct.nameController.text,
        price: int.parse(variablesProduct.priceController.text),
        active: variablesProduct.switch1,
        barcode: variablesProduct.barcodeController.text,
        cost: int.parse(variablesProduct.costController.text),
        hasAttribute: variablesProduct.switch2,
        stock: int.parse(variablesProduct.stockController.text),
        unit: variablesProduct.unitController.text,
        description: variablesProduct.discController.text,
        image: (pickedFile != null)
            ? await MultipartFile.fromFile(file!.path, filename: "image")
            : null,
        variations: (variablesProduct.variationsData.isNotEmpty) ? variablesProduct.variationsData : null,
      );
      //ediiiiiiiiiiit
      if (widget.products != null) {
        await storeCubit.editDataCubit(
            id: widget.products!.id!, products: prodect.toJson(), Form: true);
      } //pooooost
      else {
        // ignore: use_build_context_synchronously
        await storeCubit.postProdectCubit(
            data: prodect.toJson(),
            pageNumber: pageNumber,
            context: context,
            Form: true);
      }
    }
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

  Widget switchIcon({required bool? value, required String? type}) {
    return Switch(
      value: value!,
      onChanged: (value) {
        if (type == "1") {
          setState(() {
            variablesProduct.switch1 = value;
          });
        } else {
          setState(() {
            variablesProduct.switch2 = value;
          });
        }
      },
      activeColor: Colors.red,
    );
  }
}
