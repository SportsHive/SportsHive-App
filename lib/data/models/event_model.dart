import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';

class EventsModel {
  String? title;
  //late String desc;
  String? SportRelated;
  String? date;
  String? location;
  String? start_time;
  String? posterURL;
  int? seats_registered;
  int? seats_available;
  List<dynamic> registered = List<dynamic>.empty();

  EventsModel({
    this.title,
    this.SportRelated,
    this.date,
    this.location,
    this.start_time,
    this.posterURL,
    this.seats_available,
    this.seats_registered,
    required this.registered,
  });

  Map<String, dynamic> toJson() {
    return {
      "title": title,
      "sport_related": SportRelated,
      "location": location,
      "date": date,
      "start_time": start_time,
      "posterURL": posterURL,
      "seats_registered": seats_registered,
      "seats_available": seats_available,
    };
  }

  factory EventsModel.fromSnapshot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data();
    return EventsModel(
        title: data!["title"],
        SportRelated: data["sport_related"],
        location: data["location"],
        date: data["date"],
        start_time: data["start_time"],
        posterURL: data["posterURL"],
        seats_available: data["seats_available"],
        seats_registered: data["seats_registered"],
        registered: data["registered"]);
  }
}
