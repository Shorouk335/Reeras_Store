class ProdectModel {
  bool? status;
  List<Products>? products;
  int? lastPage;

  ProdectModel({this.status, this.products, this.lastPage});

  ProdectModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(Products.fromJson(v));
      });
    }
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    if (products != null) {
      data['products'] = products!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = lastPage;
    return data;
  }
}

class Products {
  int? id;
  String? barcode;
  String? name;
  String? description;
  dynamic categoryId;
  int? cost;
  int? price;
  int? salePrice;
  bool? onsale;
  bool? active;
  bool? hasAttribute;
  List<VariationsItem>? variations;
  String? unit;
  int? stock;
  dynamic image;
  String? imageUrl;

  Products(
      {this.id,
      this.barcode,
      this.name,
      this.description,
      this.categoryId,
      this.cost,
      this.price,
      this.salePrice,
      this.onsale,
      this.active,
      this.hasAttribute,
      this.variations,
      this.unit,
      this.stock,
      this.image});

  Products.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    barcode = json['barcode'];
    name = json['name'];
    description = json['description'];
    categoryId = json['category_id'];
    cost = json['cost'];
    price = json['price'];
    salePrice = json['sale_price'];
    onsale = json['onsale'];
    active = json['active'];
    hasAttribute = json['has_attribute'];
    variations = <VariationsItem>[];
    if (json['variations'] != null) {
      variations = <VariationsItem>[];
      json['variations'].forEach((v) {
        variations!.add(VariationsItem.fromJson(v));
      });
    }
    unit = json['unit'];
    stock = json['stock'];
    imageUrl = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['barcode'] = barcode;
    data['name'] = name;
    data['description'] = description;
    data['cost'] = cost;
    data['price'] = price;
    data['active'] = active == true ? 1 : 0;
    data['has_attribute'] = hasAttribute == true ? 1 : 0;
    data['unit'] = unit;
    data['stock'] = stock;
    data['image'] = image;
    data['variations']=variations?.map((e) => e.toJson()).toList();
    return data;
  }
}

class VariationsItem {
  int? id;
  int? productId;
  String? barcode;
  String? name;
  int? stock;
  int? price;
  String? created_at;
  String? updated_at;

  VariationsItem({
    this.id,
    required this.barcode,
    this.created_at,
    required this.name,
    required this.price,
    this.productId,
    required this.stock,
    this.updated_at,
  });

  VariationsItem.fromJson(Map<String, dynamic> variations) {
    id = variations["id"];
    productId = variations["product_id"];
    barcode = variations["barcode"];
    name = variations["name"];
    stock = variations["stock"];
    price = variations["price"];
    created_at = variations["created_at"];
    updated_at = variations["updated_at"];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> variationsMap = <String, dynamic>{};
   // variationsMap["id"] = id;
    variationsMap["barcode"] = barcode;
    variationsMap["name"] = name;
  //  variationsMap["product_id"] = productId;
    variationsMap["stock"] = stock;
    variationsMap["price"] = price;
   // variationsMap["updated_at"] = updated_at;
   // variationsMap["created_at"] = created_at;

    return variationsMap;
  }
}
