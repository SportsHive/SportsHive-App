import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sportshive/data/models/date_model.dart';
import 'package:sportshive/data/models/event_model.dart';
import 'package:sportshive/data/models/event_type_model.dart';
import 'package:sportshive/data/database.dart';
import 'package:sportshive/utils/colors.dart';
import 'package:sportshive/data/repositories/user_repo.dart';
import "package:sportshive/data/repositories/event_repo.dart";

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

  List<EventsModel> _filterEventsByDate(List<EventsModel> events) {
    return events.where((event) {
      DateTime eventDate = DateTime.parse(event.date!);
      DateTime selectedDate = DateTime(
        DateTime.now().year,
        DateTime.now().month,
        int.parse(_selectedDate),
      );
      return eventDate.day == selectedDate.day &&
          eventDate.month == selectedDate.month;
    }).toList();
  }

  String todayDateIs = DateTime.now().day.toString();
  final userRepo = Get.put(UserRepository());
  final eventRepo = Get.put(EventRepository());

  String _selectedDate = DateTime.now().day.toString();

  void _onDateTileTapped(String date) {
    setState(() {
      _selectedDate = date;
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    dates = getDates();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        minimum: const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
        child: Padding(
          padding: const EdgeInsets.symmetric(),
          child: FutureBuilder(
            future: eventRepo.getEvents(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.hasData) {
                  List<EventsModel> event_data =
                      snapshot.data as List<EventsModel>;
                  return Container(
                    child: Stack(
                      children: <Widget>[
                        Container(
                          decoration:
                              const BoxDecoration(color: mobileBackgroundColor),
                        ),
                        SingleChildScrollView(
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 60, horizontal: 30),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Row(
                                  children: <Widget>[],
                                ),
                                Row(
                                  children: <Widget>[
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Text(
                                          "Hello, ${userRepo.userData.username}",
                                          style: const TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w700,
                                              fontSize: 21),
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        const Text(
                                          "Explore what’s happening nearby",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontSize: 15),
                                        )
                                      ],
                                    ),
                                    const Spacer(),
                                    Container(
                                      decoration: BoxDecoration(
                                        border:
                                            Border.all(width: 3, color: orange),
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(30),
                                          child: Image.asset(
                                            userRepo.userData.avatar!,
                                            height: 40,
                                          )),
                                    )
                                  ],
                                ),
                                const SizedBox(
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
                                        isSelected:
                                            _selectedDate == dates[index].date,
                                        onTap: () => _onDateTileTapped(
                                            dates[index].date),
                                      );
                                    },
                                  ),
                                ),

                                const SizedBox(
                                  height: 20,
                                ),
                                const Text(
                                  "EVENTS ",
                                  style: TextStyle(
                                      color: orange,
                                      fontSize: 22,
                                      fontWeight: FontWeight.w800),
                                ),
                                const SizedBox(height: 10),
                                Container(
                                  child: ListView.builder(
                                      itemCount: event_data.length,
                                      shrinkWrap: true,
                                      scrollDirection: Axis.vertical,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            _showEventDialog(
                                                context, event_data[index]);
                                          },
                                          child: PopularEventTile(
                                            desc: event_data[index].title!,
                                            imgAssetPath:
                                                event_data[index].posterURL!,
                                            date: event_data[index].date!,
                                            address: event_data[index]
                                                .location!, // Add this line to enable the small image
                                            seats_available: event_data[index]
                                                .seats_available!,
                                            seats_registered: event_data[index]
                                                .seats_registered!,
                                          ),
                                        );
                                      }),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                } else if (snapshot.hasError) {
                  return Center(child: Text(snapshot.error.toString()));
                } else {
                  return const Center(child: Text("Something went wrong..."));
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
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
  VoidCallback? onTap;

  DateTile({
    required this.weekDay,
    required this.date,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onTap != null) {
          onTap!();
        }
      },
      child: Container(
        margin: const EdgeInsets.only(right: 12),
        padding: const EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: isSelected ? orange : Colors.transparent,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              date,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              weekDay,
              style: TextStyle(
                color: isSelected ? Colors.black : Colors.white,
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PopularEventTile extends StatelessWidget {
  String desc;
  String date;
  String address;
  String imgAssetPath;
  int seats_available;
  int seats_registered;

  /// later can be changed with imgUrl
  PopularEventTile({
    required this.address,
    required this.date,
    required this.imgAssetPath,
    required this.desc,
    required this.seats_available,
    required this.seats_registered,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
          color: const Color(0xff29404E),
          borderRadius: BorderRadius.circular(8)),
      child: Row(
        children: <Widget>[
          Expanded(
            child: Container(
              padding: const EdgeInsets.only(left: 16),
              width: MediaQuery.of(context).size.width - 100,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    desc,
                    style: const TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/clock_icon.png",
                        height: 12,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        date,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/location_icon.png",
                        height: 12,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        address,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Row(
                    children: <Widget>[
                      Image.asset(
                        "assets/images/line.png",
                        height: 12,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Text(
                        "${seats_registered} seats registered of ${seats_available}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 10),
                      )
                    ],
                  ),
                ],
              ),
            ),
          ),
          ClipRRect(
              borderRadius: const BorderRadius.only(
                  topRight: Radius.circular(8),
                  bottomRight: Radius.circular(8)),
              child: (imgAssetPath == "")
                  ? Image.asset("assets/images/login_bottom.png")
                  : Image.network(imgAssetPath)),
        ],
      ),
    );
  }
}

_showEventDialog(BuildContext context, EventsModel event) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return Dialog(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (event.posterURL != null && event.posterURL!.isNotEmpty)
                  Center(
                    child: Image.network(
                      event.posterURL!,
                      height: 150,
                      width: 150,
                      fit: BoxFit.contain,
                    ),
                  ),
                const SizedBox(height: 16),
                Text(
                  event.title!,
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.location_on,
                      color: orange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      event.location != null && event.location!.isNotEmpty
                          ? event.location!
                          : 'No Info',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.calendar_today,
                      color: orange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      event.date != null && event.date!.isNotEmpty
                          ? event.date!
                          : 'No Info',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    Icon(
                      Icons.event_seat,
                      color: orange,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      event.seats_available != null &&
                              event.seats_registered != null
                          ? 'Spots remaining: ${event.seats_available! - event.seats_registered!}'
                          : 'No Info',
                      style: const TextStyle(fontSize: 14),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    ElevatedButton(
                      onPressed: () {
                        // add your registration logic here
                        Navigator.of(context).pop();
                      },
                      child: const Text('Register'),
                    ),
                    const SizedBox(width: 8),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text('Close'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      );
    },
  );
}