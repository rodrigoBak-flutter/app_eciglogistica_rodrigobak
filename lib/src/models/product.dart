// To parse this JSON data, do

/*
  Modelo en el que me base
  {
    "Products": {
        "categoty": "",
        "description": "",
        "picture": "",
        "title": ""
    }
}

 */



import 'dart:convert';

class Product {
  Product(
      {
      required this.title,
      required this.description,
      this.picture,
      required this.categoty,
      this.id});

 
  String title;
  String description;
  String? picture;
  String categoty;
  String? id;

  factory Product.fromJson(String str) => Product.fromMap(json.decode(str));

  String toJson() => json.encode(toMap());

  factory Product.fromMap(Map<String, dynamic> json) => Product(
        
        title: json["title"],
        description: json["description"],
        picture: json["picture"],
        categoty: json["categoty"],
      );

  Map<String, dynamic> toMap() => {
       
        "title": title,
        "description": description,
        "picture": picture,
        "categoty": categoty,
      };

  Product copy() => Product(
        
        title: title,
        description: description,
        picture: picture,
        categoty: categoty,
        id: id, 
        
      );
}
