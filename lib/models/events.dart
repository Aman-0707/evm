import 'dart:async';

class Event {
  final String id;
  final String title;
  final String date;
  final String location;
  final String imageUrl;
  final String description;
  final bool isLive;

  Event({
    required this.id,
    required this.title,
    required this.date,
    required this.location,
    required this.imageUrl,
    required this.description,
    this.isLive = false,
  });
}

class MockApi {
  static final List<Event> _events = [
    Event(
        id: '1',
        title: 'Birthday Event',
        date: '4th July 2020',
        location: 'Kathmanndu, Nepal',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ',
        imageUrl:
            'https://thumbs.dreamstime.com/b/colorful-pastel-drawing-group-friends-laughing-enjoying-carefree-moment-together-vector-illustration-colorful-322136338.jpg'),
    Event(
        id: '2',
        title: 'Dance Event',
        date: '25th Dec 2020',
        location: 'Kathmandu, Nepal',
        description:
            'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ',
        imageUrl:
            'https://thumbs.dreamstime.com/b/happy-partying-man-woman-cartoon-characters-jumping-air-under-confetti-rain-rejoicing-win-celebrating-success-feeling-301607447.jpg'),
    Event(
      id: '3',
      title: 'Concert',
      date: '10th Nov 2020',
      location: 'Lalitpur, Nepal',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ',
      imageUrl:
          'https://media.istockphoto.com/id/1320733162/vector/international-jazz-day-retro-festival-party-concert-musicians-of-live-music-band.jpg?s=2048x2048&w=is&k=20&c=lmSrIgeyNQnEPBhcvawhFKk98oOdDdADM_w9wKTqGkk=',
      isLive: true,
    ),
    Event(
      id: '4',
      title: 'Drinking Party',
      date: '10th Nov 2020',
      location: 'lalitpur, nepal',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ',
      imageUrl:
          'https://thumbs.dreamstime.com/b/colorful-pastel-drawing-group-friends-laughing-enjoying-carefree-moment-together-vector-illustration-colorful-322136338.jpg',
      isLive: true,
    ),
    Event(
      id: '5',
      title: 'Gathering Party',
      date: '10th Nov 2020',
      location: 'Thamel, ktm',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ',
      imageUrl:
          'https://media.istockphoto.com/id/1320733162/vector/international-jazz-day-retro-festival-party-concert-musicians-of-live-music-band.jpg?s=2048x2048&w=is&k=20&c=lmSrIgeyNQnEPBhcvawhFKk98oOdDdADM_w9wKTqGkk=',
      isLive: false,
    ),
    Event(
      id: '6',
      title: 'Meetup',
      date: '10th Nov 2020',
      location: 'Bouddha, ktm',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ',
      imageUrl:
          'https://media.istockphoto.com/id/1320733162/vector/international-jazz-day-retro-festival-party-concert-musicians-of-live-music-band.jpg?s=2048x2048&w=is&k=20&c=lmSrIgeyNQnEPBhcvawhFKk98oOdDdADM_w9wKTqGkk=',
      isLive: true,
    ),
    Event(
      id: '7',
      title: 'Educaional fare',
      date: '20th Nov 2020',
      location: 'Bouddha, ktm',
      description:
          'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ',
      imageUrl:
          'https://thumbs.dreamstime.com/b/colorful-pastel-drawing-group-friends-laughing-enjoying-carefree-moment-together-vector-illustration-colorful-322136338.jpg',
      isLive: false,
    ),
  ];

  static Future<List<Event>> getPopularEvents() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));
    return _events.where((event) => !event.isLive).toList();
  }

  static Future<List<Event>> getall() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));
    return _events.toList();
  }

  static Future<List<Event>> getRunningEvents() async {
    // Simulate network delay
    await Future.delayed(Duration(seconds: 1));
    return _events.where((event) => event.isLive).toList();
  }
}
