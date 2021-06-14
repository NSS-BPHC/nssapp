import 'package:flutter/material.dart';
import 'package:nssapp/models/announcementModel.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/models/volunteerModel.dart';
import 'package:nssapp/views/widgets/eventCard.dart';

class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({Key? key}) : super(key: key);

  @override
  _VolunteerProfileScreenState createState() => _VolunteerProfileScreenState();
}

final List<EventModel> items = [
  EventModel(
      id: "60c339d6ee14fd461c0a30e1",
      title: "Mysterious Island",
      date: "03-Jun-2020",
      startTime: "1:20:47",
      endTime: "3:26:43",
      withDrawTime: "12:49:08",
      location: "Subrag",
      description:
          "Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.\n\nIn quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.\n\nMaecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.",
      organiser: "Hope",
      noOfVolunteers: 31,
      v: 0,
      eventModelId: "60c339d6ee14fd461c0a30e1"),
  EventModel(
      id: "60c339d6ee14fd461c0a30e1",
      title: "Mysterious Island",
      date: "21-Aug-2020",
      startTime: "1:20:47",
      endTime: "3:26:43",
      withDrawTime: "12:49:08",
      location: "Subrag",
      description:
          "Nullam sit amet turpis elementum ligula vehicula consequat. Morbi a ipsum. Integer a nibh.\n\nIn quis justo. Maecenas rhoncus aliquam lacus. Morbi quis tortor id nulla ultrices aliquet.\n\nMaecenas leo odio, condimentum id, luctus nec, molestie sed, justo. Pellentesque viverra pede ac diam. Cras pellentesque volutpat dui.",
      organiser: "Hope",
      noOfVolunteers: 31,
      v: 0,
      eventModelId: "60c339d6ee14fd461c0a30e1"),
  EventModel(
      id: "60c339cdee14fd461c0a30e0",
      title: "King of Comedy (Hei kek ji wong)",
      date: "01-Sept-2021",
      startTime: "21:03:50",
      endTime: "11:37:15",
      withDrawTime: "2:05:44",
      location: "Tenggun Dajah",
      description:
          "Morbi non lectus. Aliquam sit amet diam in magna bibendum imperdiet. Nullam orci pede, venenatis non, sodales sed, tincidunt eu, felis.\n\nFusce posuere felis sed lacus. Morbi sem mauris, laoreet ut, rhoncus aliquet, pulvinar sed, nisl. Nunc rhoncus dui vel sem.\n\nSed sagittis. Nam congue, risus semper porta volutpat, quam pede lobortis ligula, sit amet eleifend pede libero quis orci. Nullam molestie nibh in lectus.",
      organiser: "Penn",
      noOfVolunteers: 27,
      v: 0,
      eventModelId: "60c339cdee14fd461c0a30e0"),
];
final List<VolunteerModel> panel = [
  VolunteerModel(
    name: "Gandhi Puttu",
    phoneNumber: "9876543210",
    dateOfJoining: "1-Sept-2018",
    role: "President",
    id: '2019A7PS0049H',
  ),
  VolunteerModel(
    name: "Parvez Mushraff",
    phoneNumber: "9876543210",
    dateOfJoining: "1-Sept-2018",
    role: "President",
    id: '2019A7PS0049H',
  ),
  VolunteerModel(
    name: "Chaitanya",
    phoneNumber: "9876543210",
    dateOfJoining: "1-Sept-2018",
    role: "President",
    id: '2019A7PS0049H',
  ),
  VolunteerModel(
    name: "Gandhi Puttu",
    phoneNumber: "9876543210",
    dateOfJoining: "1-Sept-2018",
    role: "President",
    id: '2019A7PS0049H',
  ),
  VolunteerModel(
    name: "Gandhi Puttu",
    phoneNumber: "9876543210",
    dateOfJoining: "1-Sept-2018",
    role: "President",
    id: '2019A7PS0049H',
  ),
  VolunteerModel(
    name: "Gandhi Puttu",
    phoneNumber: "9876543210",
    dateOfJoining: "1-Sept-2018",
    role: "President",
    id: '2019A7PS0049H',
  ),
  VolunteerModel(
    name: "Gandhi Puttu",
    phoneNumber: "9876543210",
    dateOfJoining: "1-Sept-2018",
    role: "President",
    id: '2019A7PS0049H',
  ),
  VolunteerModel(
    name: "Gandhi Puttu",
    phoneNumber: "9876543210",
    dateOfJoining: "1-Sept-2018",
    role: "President",
    id: '2019A7PS0049H',
  ),
  VolunteerModel(
    name: "Gandhi Puttu",
    phoneNumber: "9876543210",
    dateOfJoining: "1-Sept-2018",
    role: "President",
    id: '2019A7PS0049H',
  ),
  VolunteerModel(
    name: "Gandhi Puttu",
    phoneNumber: "9876543210",
    dateOfJoining: "1-Sept-2018",
    role: "President",
    id: '2019A7PS0049H',
  ),
];

final List<AnnouncementModel> announcement = [
  AnnouncementModel(
      title: "Happy Independence Day!",
      description: "Independence day special 2K run starts at SAC in 10 mins",
      time: "15-Aug-2021 00:00"),
  AnnouncementModel(
      title: "All Volunteer Meet",
      description: "All the volunteers should be here in F102 in 10 mins",
      time: "15-Aug-2021 17:50"),
  AnnouncementModel(
      title: "All Volunteer Meet",
      description: "All the volunteers should be here in F102 in 10 mins",
      time: "15-Aug-2021 17:50"),
];

class _VolunteerProfileScreenState extends State<VolunteerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        title: Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Rohith ',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                  color: Colors.black),
            ),
            Text(
              'Kumar Gattu',
              style: TextStyle(
                fontSize: 20,
                color: Colors.black,
              ),
            ),
          ],
        ),
        centerTitle: false,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Core Team Member',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      '2019A7PS0049H',
                      style: TextStyle(fontSize: 18),
                    ),
                    Row(
                      children: [
                        Icon(Icons.phone),
                        SizedBox(
                          width: 5,
                        ),
                        Text('9502986243')
                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.calendar_today),
                        SizedBox(
                          width: 5,
                        ),
                        Text('01-Sept 2019'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('-'),
                        SizedBox(
                          width: 5,
                        ),
                        Text('present')
                      ],
                    ),
                  ],
                ),
                Container(
                  width: 80.0,
                  height: 80.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      width: 2.0,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      '100',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 38),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Events Participated',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 15,
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return EventCard(
                  eventModel: items[index],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
