// To parse this JSON data, do
//
//     final product = productFromMap(jsonString);

import 'dart:convert';

class Product {
  Product(
      {required this.available,
      required this.title,
      required this.description,
      this.picture,
      required this.categoty,
      this.id});

  bool available;
  String title;
  String description;
  String? picture;
  String categoty;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        available: json["available"],
        title: json["title"],
        description: json["description"],
        picture: json["picture"],
        categoty: json["categoty"],
      );

  Map<String, dynamic> toMap() => {
        "available": available,
        "title": title,
        "description": description,
        "picture": picture,
        "categoty": categoty,
      };

  Product copy() => Product(
        available: available,
        title: title,
        description: description,
        picture: picture,
        categoty: categoty,
        id: id, 
        
      );
}
