

import 'package:flutter/material.dart';
import 'package:reeras_store/modules/Prodects/domain/model/model/product_model.dart';
class VariablesProduct{
 TextEditingController nameController = TextEditingController();
TextEditingController discController = TextEditingController();
TextEditingController priceController = TextEditingController();
TextEditingController costController = TextEditingController();
TextEditingController barcodeController = TextEditingController();
TextEditingController unitController = TextEditingController();
TextEditingController stockController = TextEditingController();
bool switch1 = false;
bool switch2 = false;
List<VariationsItem> variationsData = [];
int variationsCount = 0;

  dispose(){ 
  nameController.dispose();
  discController.dispose();
  priceController.dispose();
  costController.dispose();
  barcodeController.dispose();
  unitController.dispose();
  stockController.dispose();

}
}

