// To parse this JSON data, do
//
//     final analysisMessage = analysisMessageFromJson(jsonString);

// To parse this JSON data, do
//
//     final analysisMessage = analysisMessageFromJson(jsonString);

import 'package:meta/meta.dart';
import 'dart:convert';

List<AnalysisMessage> analysisMessageFromJson(String str) =>
    List<AnalysisMessage>.from(
        json.decode(str).map((x) => AnalysisMessage.fromJson(x)));

String analysisMessageToJson(List<AnalysisMessage> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class AnalysisMessage {
  AnalysisMessage({
    this.isDepredator,
    this.firstPerson,
    this.secondPerson,
    this.conversation,
  });

  bool? isDepredator;
  Person? firstPerson;
  Person? secondPerson;
  String? conversation;

  factory AnalysisMessage.fromJson(Map<String, dynamic> json) =>
      AnalysisMessage(
        isDepredator:
            json["is_depredator"] == null ? null : json["is_depredator"],
        firstPerson: json["first_person"] == null
            ? null
            : Person.fromJson(json["first_person"]),
        secondPerson: json["second_person"] == null
            ? null
            : Person.fromJson(json["second_person"]),
        conversation:
            json["conversation"] == null ? null : json["conversation"],
      );

  Map<String, dynamic> toJson() => {
        "is_depredator": isDepredator == null ? null : isDepredator,
        "first_person": firstPerson == null ? null : firstPerson?.toJson(),
        "second_person": secondPerson == null ? null : secondPerson?.toJson(),
        "conversation": conversation == null ? null : conversation,
      };
}

class Person {
  Person({
    this.firstName,
    this.username,
  });

  String? firstName;
  String? username;

  factory Person.fromJson(Map<String, dynamic> json) => Person(
        firstName: json["first_name"] == null ? null : json["first_name"],
        username: json["username"] == null ? null : json["username"],
      );

  Map<String, dynamic> toJson() => {
        "first_name": firstName == null ? null : firstName,
        "username": username == null ? null : username,
      };
}
