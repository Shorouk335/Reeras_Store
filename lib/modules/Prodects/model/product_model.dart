class productsModel {
  bool? status;
  List<Products>? products;
  int? lastPage;

  productsModel({this.status, this.products, this.lastPage});

  productsModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    if (json['products'] != null) {
      products = <Products>[];
      json['products'].forEach((v) {
        products!.add(new Products.fromJson(v));
      });
    }
    lastPage = json['last_page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.products != null) {
      data['products'] = this.products!.map((v) => v.toJson()).toList();
    }
    data['last_page'] = this.lastPage;
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
  String? image;

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
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['barcode'] = this.barcode;
    data['name'] = this.name;
    data['description'] = this.description;
    data['category_id'] = this.categoryId;
    data['cost'] = this.cost;
    data['price'] = this.price;
    data['sale_price'] = this.salePrice;
    data['onsale'] = this.onsale;
    data['active'] = this.active;
    data['has_attribute'] = this.hasAttribute;
    if (this.variations != null) {
      data['variations'] = this.variations!.map((v) => v.toJson()).toList();
    }
    data['unit'] = this.unit;
    data['stock'] = this.stock;
    data['image'] = this.image;
    return data;
  }
}
