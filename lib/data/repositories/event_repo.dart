import "package:cloud_firestore/cloud_firestore.dart";
import "package:flutter/material.dart";
import "package:get/get.dart";
import "../models/event_model.dart";

// class EventsModel {
//   late String title;
//   //late String desc;
//   late String SportRelated;
//   late String date;
//   late String location;
//   late String imgeAssetPath;
//   late String start_time;
//   late String poster;
//   late int seats;
//   late int seats_available;
// }

class EventRepository extends GetxController {
  static EventRepository get instance => Get.find();

  final _db = FirebaseFirestore.instance;
  late List<EventsModel> eventsList = <EventsModel>[];

  void initState() async {
    eventsList = (await getEvents());
  }
 
  //get all events in the db
  Future<List<EventsModel>> getEvents() async {    
    final snapshot = await _db.collection("EVENT").get();
    final eventData =
        snapshot.docs.map((e) => EventsModel.fromSnapshot(e)).toList();
    return eventData;
  }

  //get a single vevent given the date and the title
  Future<EventsModel> getEvent(String title, String date) async {
    final snapshot = await _db.collection("EVENT")
    .where("title", isEqualTo: title).where("date", isEqualTo: date)
    .get();
    final eventData =
        snapshot.docs.map((e) => EventsModel.fromSnapshot(e)).single;
    return eventData;
  }

}