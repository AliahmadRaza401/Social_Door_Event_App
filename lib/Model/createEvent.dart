// To parse this JSON data, do
//
//     final welcome = welcomeFromJson(jsonString);

import 'dart:convert';

CreateEvent welcomeFromJson(String str) => CreateEvent.fromJson(json.decode(str));

String welcomeToJson(CreateEvent data) => json.encode(data.toJson());

class CreateEvent {
    CreateEvent({
        required this.status,
       required  this.message,
       required  this.eventCreationData,
    });

    bool status;
    String message;
    EventCreationData eventCreationData;

    factory CreateEvent.fromJson(Map<String, dynamic> json) => CreateEvent(
        status: json["status"],
        message: json["message"],
        eventCreationData: EventCreationData.fromJson(json["eventCreationData"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "message": message,
        "eventCreationData": eventCreationData.toJson(),
    };
}

class EventCreationData {
    EventCreationData({
        required this.eventChargesList,
        required this.eventRulesList,
       required this.eventPrefrencesList,
       required this.eventAmenitiesList,
       required this.eventCancellationPolicyList,
       required this.eventCategoryList,
    });

    List<EventChargesList> eventChargesList;
    List<EventList> eventRulesList;
    List<EventPrefrencesList> eventPrefrencesList;
    List<EventList> eventAmenitiesList;
    List<EventList> eventCancellationPolicyList;
    List<EventCategoryList> eventCategoryList;

    factory EventCreationData.fromJson(Map<String, dynamic> json) => EventCreationData(
        eventChargesList: List<EventChargesList>.from(json["eventChargesList"].map((x) => EventChargesList.fromJson(x))),
        eventRulesList: List<EventList>.from(json["eventRulesList"].map((x) => EventList.fromJson(x))),
        eventPrefrencesList: List<EventPrefrencesList>.from(json["eventPrefrencesList"].map((x) => EventPrefrencesList.fromJson(x))),
        eventAmenitiesList: List<EventList>.from(json["eventAmenitiesList"].map((x) => EventList.fromJson(x))),
        eventCancellationPolicyList: List<EventList>.from(json["eventCancellationPolicyList"].map((x) => EventList.fromJson(x))),
        eventCategoryList: List<EventCategoryList>.from(json["eventCategoryList"].map((x) => EventCategoryList.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "eventChargesList": List<dynamic>.from(eventChargesList.map((x) => x.toJson())),
        "eventRulesList": List<dynamic>.from(eventRulesList.map((x) => x.toJson())),
        "eventPrefrencesList": List<dynamic>.from(eventPrefrencesList.map((x) => x.toJson())),
        "eventAmenitiesList": List<dynamic>.from(eventAmenitiesList.map((x) => x.toJson())),
        "eventCancellationPolicyList": List<dynamic>.from(eventCancellationPolicyList.map((x) => x.toJson())),
        "eventCategoryList": List<dynamic>.from(eventCategoryList.map((x) => x.toJson())),
    };
}

class EventList {
    EventList({
       required this.icon,
       required this.status,
       required this.id,
       required this.title,
       required this.description,
       required this.createdAt,
       required this.updatedAt,
       required this.v,
       required this.type,
       required this.value,
       required this.ruleImage,
    });

    dynamic icon;
    bool status;
    String id;
    String title;
    String description;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    int type;
    int value;
    dynamic ruleImage;

    factory EventList.fromJson(Map<String, dynamic> json) => EventList(
        icon: json["icon"],
        status: json["status"],
        id: json["_id"],
        title: json["title"],
        description: json["description"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        type: json["type"] == null ? null : json["type"],
        value: json["value"] == null ? null : json["value"],
        ruleImage: json["ruleImage"],
    );

    Map<String, dynamic> toJson() => {
        "icon": icon,
        "status": status,
        "_id": id,
        "title": title,
        "description": description,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "type": type == null ? null : type,
        "value": value == null ? null : value,
        "ruleImage": ruleImage,
    };
}

class EventCategoryList {
    EventCategoryList({
       required this.parentId,
       required this.status,
       required this.id,
       required this.categoryName,
       required this.createdAt,
       required this.updatedAt,
       required this.v,
    });

    String parentId;
    bool status;
    String id;
    String categoryName;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory EventCategoryList.fromJson(Map<String, dynamic> json) => EventCategoryList(
        parentId: json["parentId"],
        status: json["status"],
        id: json["_id"],
        categoryName: json["category_name"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "parentId": parentId,
        "status": status,
        "_id": id,
        "category_name": categoryName,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class EventChargesList {
    EventChargesList({
        required this.eventCreationValueType,
       required this.status,
       required this.id,
       required this.eventCreationEntity,
       required this.eventCreationValue,
       required this.createdAt,
       required this.updatedAt,
       required this.v,
    });

    String eventCreationValueType;
    bool status;
    String id;
    String eventCreationEntity;
    int eventCreationValue;
    DateTime createdAt;
    DateTime updatedAt;
    int v;

    factory EventChargesList.fromJson(Map<String, dynamic> json) => EventChargesList(
        eventCreationValueType: json["eventCreationValueType"],
        status: json["status"],
        id: json["_id"],
        eventCreationEntity: json["eventCreationEntity"],
        eventCreationValue: json["eventCreationValue"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
    );

    Map<String, dynamic> toJson() => {
        "eventCreationValueType": eventCreationValueType,
        "status": status,
        "_id": id,
        "eventCreationEntity": eventCreationEntity,
        "eventCreationValue": eventCreationValue,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
    };
}

class EventPrefrencesList {
    EventPrefrencesList({
       required this.status,
        required this.id,
        required this.prefrenceKey,
       required this.prefrenceValue,
       required this.createdAt,
       required this.updatedAt,
       required this.v,
       required this.prefrenceImage,
    });

    bool status;
    String id;
    String prefrenceKey;
    String prefrenceValue;
    DateTime createdAt;
    DateTime updatedAt;
    int v;
    dynamic prefrenceImage;

    factory EventPrefrencesList.fromJson(Map<String, dynamic> json) => EventPrefrencesList(
        status: json["status"],
        id: json["_id"],
        prefrenceKey: json["prefrenceKey"],
        prefrenceValue: json["prefrenceValue"],
        createdAt: DateTime.parse(json["createdAt"]),
        updatedAt: DateTime.parse(json["updatedAt"]),
        v: json["__v"],
        prefrenceImage: json["prefrenceImage"],
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "_id": id,
        "prefrenceKey": prefrenceKey,
        "prefrenceValue": prefrenceValue,
        "createdAt": createdAt.toIso8601String(),
        "updatedAt": updatedAt.toIso8601String(),
        "__v": v,
        "prefrenceImage": prefrenceImage,
    };
}
