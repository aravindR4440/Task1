import 'package:task1/models/item.dart';

class ItemObj {
  int? totalCount;
  bool? incompleteResults;
  List<Item>? items;

  ItemObj({
    this.totalCount,
    this.incompleteResults,
    this.items,
  });

  factory ItemObj.fromJson(Map<String, dynamic> json) => ItemObj(
    totalCount: json["total_count"],
    incompleteResults: json["incomplete_results"],
    items: json["items"] == null ?null  : List<Item>.from(json["items"]!.map((x) => Item.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "total_count": totalCount,
    "incomplete_results": incompleteResults,
    "items": items?.map((e) => e.toJson()).toList()
  };
}