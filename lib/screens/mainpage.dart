import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../customwigdets/eventcard.dart';
import '../customwigdets/livecard.dart';
import '../models/events.dart';

class EventFinderScreen extends StatefulWidget {
  @override
  _EventFinderScreenState createState() => _EventFinderScreenState();
}

class _EventFinderScreenState extends State<EventFinderScreen> {
  List<Event> popularEvents = [];
  List<Event> runningEvents = [];

  @override
  void initState() {
    super.initState();
    _fetchEvents();
  }

  Future<void> _fetchEvents() async {
    final popular = await MockApi.getPopularEvents();
    final running = await MockApi.getRunningEvents();

    if (mounted) {
      setState(() {
        popularEvents = popular;
        runningEvents = running;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.purple, Colors.blue],
            ),
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 30.h, horizontal: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Icon(Icons.menu, color: Colors.white, size: 28.w),
                      Icon(Icons.notifications,
                          color: Colors.white, size: 28.w),
                    ],
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    'Register Now on\ntrending events',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 28.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 12.h, horizontal: 16.w),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      children: [
                        Icon(Icons.search, color: Colors.grey, size: 24.w),
                        SizedBox(width: 10.w),
                        Text('Search for events',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: Colors.grey,
                            )),
                      ],
                    ),
                  ),
                  SizedBox(height: 20.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Upcomming events',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18.sp,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        'See all',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10.h),
                  Container(
                    height: 230.h,
                    child: popularEvents.isEmpty
                        ? Center(child: CircularProgressIndicator())
                        : ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: popularEvents.length,
                            itemBuilder: (context, index) {
                              final event = popularEvents[index];
                              return SingleChildScrollView(
                                child: Container(
                                  child: Padding(
                                    padding: EdgeInsets.only(right: 10.w),
                                    child: EventCard(
                                      title: event.title,
                                      date: event.date,
                                      location: event.location,
                                      image: event.imageUrl,
                                      description: event.description,
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                  ),
                  SizedBox(height: 15.h),
                  Text(
                    'Running events',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: 10.h),
                  runningEvents.isEmpty
                      ? Center(child: CircularProgressIndicator())
                      : Column(
                          children: runningEvents
                              .map((event) => Padding(
                                    padding: EdgeInsets.only(bottom: 10.h),
                                    child: RunningEventCard(
                                      title: event.title,
                                      location: event.location,
                                      imageUrl: event.imageUrl,
                                      isLive: event.isLive,
                                    ),
                                  ))
                              .toList(),
                        ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
