// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

GetEvents getEventFromJson(String str) => GetEvents.fromJson(json.decode(str));

String getEventToJson(GetEvents data) => json.encode(data.toJson());

class GetEvents {
  GetEvents({
    required this.status,
    required this.message,
    required this.eventsList,
  });

  bool status;
  String message;
  List<EventsList> eventsList;

  factory GetEvents.fromJson(Map<String, dynamic> json) => GetEvents(
        status: json["status"],
        message: json["message"],
        eventsList: List<EventsList>.from(
            json["eventsList"].map((x) => EventsList.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "eventsList": List<dynamic>.from(eventsList.map((x) => x.toJson())),
      };
}

class EventsList {
  EventsList({
    required this.tags,
    required this.hostedDate,
    required this.finalisedMembers,
    required this.id,
    required this.title,
    required this.category,
    required this.eventCharges,
    required this.eventThumbNail,
  });

  List<Tag> tags;
  DateTime hostedDate;
  List<dynamic> finalisedMembers;
  String id;
  String title;
  Category category;
  int eventCharges;
  String eventThumbNail;

  factory EventsList.fromJson(Map<String, dynamic> json) => EventsList(
        tags: List<Tag>.from(json["tags"].map((x) => Tag.fromJson(x))),
        hostedDate: DateTime.parse(json["hostedDate"]),
        finalisedMembers:
            List<dynamic>.from(json["finalisedMembers"].map((x) => x)),
        id: json["_id"],
        title: json["title"],
        category: Category.fromJson(json["category"]),
        eventCharges: json["eventCharges"],
        eventThumbNail: json["eventThumbNail"],
      );

  Map<String, dynamic> toJson() => {
        "tags": List<dynamic>.from(tags.map((x) => x.toJson())),
        "hostedDate": hostedDate.toIso8601String(),
        "finalisedMembers": List<dynamic>.from(finalisedMembers.map((x) => x)),
        "_id": id,
        "title": title,
        "category": category.toJson(),
        "eventCharges": eventCharges,
        "eventThumbNail": eventThumbNail,
      };
}

class Category {
  Category({
    required this.id,
    required this.categoryName,
  });

  String id;
  String categoryName;

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["_id"],
        categoryName: json["category_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "category_name": categoryName,
      };
}

class Tag {
  Tag({
    required this.id,
    required this.tagName,
  });

  String id;
  String tagName;

  factory Tag.fromJson(Map<String, dynamic> json) => Tag(
        id: json["_id"],
        tagName: json["tag_name"],
      );

  Map<String, dynamic> toJson() => {
        "_id": id,
        "tag_name": tagName,
      };
}
