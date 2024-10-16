import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:async';
import '../customwigdets/eventDeatilCard.dart';

import '../models/events.dart';

class EventListPage extends StatefulWidget {
  const EventListPage({Key? key}) : super(key: key);

  @override
  _EventListPageState createState() => _EventListPageState();
}

class _EventListPageState extends State<EventListPage> {
  List<Event> _allEvents = [];
  List<Event> _filteredEvents = [];
  bool _isLoading = true;
  String _searchText = '';

  @override
  void initState() {
    super.initState();
    _loadEvents();
  }

  Future<void> _loadEvents() async {
    setState(() {
      _isLoading = true;
    });

    List<Event> events = await MockApi.getall();
    setState(() {
      _allEvents = events;
      _filteredEvents = events;
      _isLoading = false;
    });
  }

  void _filterEvents(String query) {
    setState(() {
      _searchText = query;
      _filteredEvents = _allEvents
          .where((event) =>
              event.title.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              'Event List',
              style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.bold),
            ),
          ),
          body: _isLoading
              ? const Center(child: CircularProgressIndicator())
              : Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: TextField(
                        decoration: InputDecoration(
                          labelText: 'Search by Title',
                          labelStyle: TextStyle(fontSize: 16.sp),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                          ),
                          contentPadding: EdgeInsets.symmetric(
                              horizontal: 16.w, vertical: 12.h),
                        ),
                        onChanged: _filterEvents,
                      ),
                    ),
                    Expanded(
                      child: _filteredEvents.isNotEmpty
                          ? ListView.builder(
                              itemCount: _filteredEvents.length,
                              itemBuilder: (context, index) {
                                Event event = _filteredEvents[index];
                                return Padding(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 16.w, vertical: 8.h),
                                  child: EventDetailCard(
                                    title: event.title,
                                    location: event.location,
                                    imageUrl: event.imageUrl,
                                    isLive: event.isLive,
                                  ),
                                );
                              },
                            )
                          : const Center(
                              child: Text('No events found'),
                            ),
                    ),
                  ],
                ),
        );
      },
    );
  }
}
