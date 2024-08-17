import 'package:flutter/material.dart';

class Category {
  String name;
  String description;
  bool visible;
  Color color;

  Category(
      {required this.color,
      required this.description,
      required this.name,
      required this.visible});

  Map<String, dynamic> toJson() => {
        "name": name,
        "description": description,
        "visible": visible ? 1 : 0,
        "color": color.value
      };

  Category.fromJson(Map<String, dynamic> json)
      : name = json["name"],
        description = json["description"],
        visible = json["visible"] == 1 ? true : false,
        color = Color(json["color"]);

  Category.empty()
      : color = Colors.white,
        description = "",
        name = "",
        visible = true;
}
