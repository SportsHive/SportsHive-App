import 'dart:math';
import 'package:sportshive/data/models/date_model.dart';
import 'package:sportshive/data/models/event_model.dart';
import 'package:sportshive/data/models/event_type_model.dart';

List<DateModel> getDates(){

  List<DateModel> dates = <DateModel>[];
  DateModel dateModel = new DateModel();
  List<String> weekdays = ['Mon','Tue','Wed','Thu','Fri','Sat', 'Sun'];

  DateTime t = DateTime.now();

  //2 before
  dateModel.date = t.subtract(Duration(days: 2)).day.toString();
  dateModel.weekDay = weekdays[t.subtract(Duration(days: 2)).weekday - 1];
  dates.add(dateModel);

  dateModel = new DateModel();

  //1 before
  dateModel.date = t.subtract(Duration(days: 1)).day.toString();
  dateModel.weekDay = weekdays[t.subtract(Duration(days: 1)).weekday - 1];
  dates.add(dateModel);

  dateModel = new DateModel();


  dateModel.date = t.day.toString();
  dateModel.weekDay = weekdays[t.weekday - 1];
  dates.add(dateModel);
  dateModel = new DateModel();

  //1 after
  dateModel.date = t.add(Duration(days: 1)).day.toString();
  dateModel.weekDay = weekdays[t.add(Duration(days: 1)).weekday - 1];
  dates.add(dateModel);

  dateModel = new DateModel();

  //2 after
  dateModel.date = t.add(Duration(days: 2)).day.toString();
  dateModel.weekDay = weekdays[t.add(Duration(days: 2)).weekday - 1];
  dates.add(dateModel);

  dateModel = new DateModel();


  //3 after
  dateModel.date = t.add(Duration(days: 3)).day.toString();
  dateModel.weekDay = weekdays[t.add(Duration(days: 3)).weekday - 1];
  dates.add(dateModel);
  dateModel = new DateModel();


  //4 after
  dateModel.date = t.add(Duration(days: 4)).day.toString();
  dateModel.weekDay = weekdays[t.add(Duration(days: 4)).weekday - 1];
  dates.add(dateModel);

  dateModel = new DateModel();

  //5 after
  dateModel.date = t.add(Duration(days: 5)).day.toString();
  dateModel.weekDay = weekdays[t.add(Duration(days: 5)).weekday - 1];
  dates.add(dateModel);

  dateModel = new DateModel();

  return dates;

}

List<EventsModel> getEvents(){

  List<EventsModel> events = <EventsModel>[];
  EventsModel eventsModel = EventsModel();

  //1
  eventsModel.imgeAssetPath = "assets/images/login_bottom.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.desc = "Sports Meet in Galaxy Field";
  eventsModel.address = "Greenfields, Sector 42, Faridabad";
  events.add(eventsModel);

  eventsModel = new EventsModel();

  //2
  eventsModel.imgeAssetPath = "assets/images/login_bottom.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.desc = "Art & Meet in Street Plaza";
      eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
  events.add(eventsModel);

  eventsModel = new EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/images/login_bottom.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = new EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/images/login_bottom.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = new EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/images/login_bottom.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = new EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/images/login_bottom.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = new EventsModel();
  //3
  eventsModel.imgeAssetPath = "assets/images/login_bottom.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = new EventsModel();
  //3
  eventsModel.imgeAssetPath = "assets/images/login_bottom.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = new EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/images/login_bottom.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = new EventsModel();

  //3
  eventsModel.imgeAssetPath = "assets/images/login_bottom.png";
  eventsModel.date = "Jan 12, 2019";
  eventsModel.address = "Galaxyfields, Sector 22, Faridabad";
      eventsModel.desc = "Youth Music in Gwalior";
  events.add(eventsModel);

  eventsModel = new EventsModel();

  return events;

}

