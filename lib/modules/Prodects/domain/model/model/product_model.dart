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
        products!.add( Products.fromJson(v));
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
  List<dynamic>? variations;
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
    variations = <dynamic>[];
    // if (json['variations'] != null) {
    //   variations = <dynamic>[];
    // json['variations'].forEach((v) {
    //   variations!.add( variations.fromJson(v));
    //});
    //  }
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
    data['active'] = active==true?1:0;
    data['has_attribute'] =0;
    data['unit'] = unit;
    data['stock'] = stock;
    data['image'] = image ;
    return data;
  }
}
