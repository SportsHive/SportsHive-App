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


