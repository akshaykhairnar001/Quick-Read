// To parse this JSON data, do
//
//     final newsModel = newsModelFromJson(jsonString);

import 'dart:convert';

NewsModel newsModelFromJson(String str) => NewsModel.fromJson(json.decode(str));

String newsModelToJson(NewsModel data) => json.encode(data.toJson());

class NewsModel {
  String category;
  List<Datum> data;
  bool success;

  NewsModel({
    required this.category,
    required this.data,
    required this.success,
  });

  factory NewsModel.fromJson(Map<String, dynamic> json) => NewsModel(
        category: json["category"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
        success: json["success"],
      );

  Map<String, dynamic> toJson() => {
        "category": category,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
        "success": success,
      };
}

class Datum {
  String author;
  String content;
  Date date;
  String id;
  String imageUrl;
  String readMoreUrl;
  String time;
  String title;
  String url;

  Datum({
    required this.author,
    required this.content,
    required this.date,
    required this.id,
    required this.imageUrl,
    required this.readMoreUrl,
    required this.time,
    required this.title,
    required this.url,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        author: json["author"],
        content: json["content"],
        date: dateValues.map[json["date"]]!,
        id: json["id"],
        imageUrl: json["imageUrl"],
        readMoreUrl: json["readMoreUrl"],
        time: json["time"],
        title: json["title"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "author": author,
        "content": content,
        "date": dateValues.reverse[date],
        "id": id,
        "imageUrl": imageUrl,
        "readMoreUrl": readMoreUrl,
        "time": time,
        "title": title,
        "url": url,
      };
}

enum Date { THURSDAY_06_JUNE_2024, WEDNESDAY_05_JUNE_2024 }

final dateValues = EnumValues({
  "Thursday, 06 June, 2024": Date.THURSDAY_06_JUNE_2024,
  "Wednesday, 05 June, 2024": Date.WEDNESDAY_05_JUNE_2024
});

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    reverseMap = map.map((k, v) => MapEntry(v, k));
    return reverseMap;
  }
}
