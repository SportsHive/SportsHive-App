import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportshive/data/models/date_model.dart';
import 'package:sportshive/data/models/event_model.dart';
import 'package:sportshive/data/models/event_type_model.dart';
import 'package:sportshive/data/database.dart';
import 'package:sportshive/utils/colors.dart';
import 'package:sportshive/data/repositories/user_repo.dart';

import '../../data/repositories/user_repo.dart';

class EventsScreen extends StatefulWidget {
  const EventsScreen({Key? key}) : super(key: key);
  @override
  _EventsScreenState createState() => _EventsScreenState();
}

class _EventsScreenState extends State<EventsScreen> {
  List<DateModel> dates = <DateModel>[];
  List<EventTypeModel> eventsType = [];
  List<EventsModel> events = <EventsModel>[];

  String todayDateIs = DateTime.now().day.toString();
  final userRepo = Get.put(UserRepository());

  String _currentUserEmail = '';
  String _currentUsername = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dates = getDates();
    events = getEvents();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: Container(
            child: Stack(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(color: mobileBackgroundColor),
                ),
                SingleChildScrollView(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 60, horizontal: 30),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[],
                        ),
                        Row(
                          children: <Widget>[
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text(
                                  "Hello, ${userRepo.userData.username}",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                      fontSize: 21),
                                ),
                                SizedBox(
                                  height: 6,
                                ),
                                Text(
                                  "Let's explore what’s happening nearby",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 15),
                                )
                              ],
                            ),
                            Spacer(),
                            Container(
                              decoration: BoxDecoration(
                                border: Border.all(
                                    width: 3, color: Color(0xffFAE072)),
                                borderRadius: BorderRadius.circular(30),
                              ),
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(30),
                                  child: Image.asset(
                                    "assets/images/profilepicsample.png",
                                    height: 60,
                                  )),
                            )
                          ],
                        ),
                        SizedBox(
                          height: 20,
                        ),

                        /// Dates
                        Container(
                          height: 60,
                          child: ListView.builder(
                              itemCount: dates.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemBuilder: (context, index) {
                                return DateTile(
                                  weekDay: dates[index].weekDay,
                                  date: dates[index].date,
                                  isSelected: todayDateIs == dates[index].date,
                                );
                              }),
                        ),

                        SizedBox(
                          height: 20,
                        ),
                        Text(
                          "EVENTS ",
                          style: TextStyle(
                              color: Colors.orange,
                              fontSize: 22,
                              fontWeight: FontWeight.w800),
                        ),
                        SizedBox(height: 10),
                        Container(
                          child: ListView.builder(
                              itemCount: events.length,
                              shrinkWrap: true,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (context, index) {
                                return PopularEventTile(
                                  desc: events[index].desc,
                                  imgeAssetPath: events[index].imgeAssetPath,
                                  date: events[index].date,
                                  address: events[index]
                                      .address, // Add this line to enable the small image
                                );
                              }),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class DateTile extends StatelessWidget {
  String weekDay;
  String date;
  bool isSelected;
  DateTile(
      {required this.weekDay, required this.date, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 12),
      padding: EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
          color: isSelected ? orange : Colors.transparent,
          borderRadius: BorderRadius.circular(10)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            date,
            style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            weekDay,
            style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600),
          )
        ],
      ),
    );
  }
}

class PopularEventTile extends StatelessWidget {
  String desc;
  String date;
  String address;
  String imgeAssetPath;

  /// later can be changed with imgUrl
  PopularEventTile(
      {required this.address,
      required this.date,
      required this.imgeAssetPath,
      required this.desc});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: Color(0xff29404E), borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: EdgeInsets.only(left: 16),
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    desc,
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/clock_icon.png",
                        height: 12,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        date,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/location_icon.png",
                        height: 12,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        address,
                        style: TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: Image.asset(
                imgeAssetPath,
                height: 100,
                width: 120,
                fit: BoxFit.cover,
              )),
        ],
      ),
    );
  }
}
