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
        backgroundColor: Color(0xff5271ff),
        elevation: 0.0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 200,
            decoration: BoxDecoration(
              color: Color(0xff5271ff),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(20),
                  bottomRight: Radius.circular(20)),
            ),
            child: Padding(
              padding: const EdgeInsets.all(14.0),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.baseline,
                    textBaseline: TextBaseline.alphabetic,
                    children: [
                      Text(
                        'Rohith ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 28,
                            color: Colors.white),
                      ),
                      Text(
                        'Kumar Gattu',
                        style: TextStyle(
                          fontSize: 20,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  Container(
                    height: 130,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Core Team Member',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Text(
                              '2019A7PS0049H',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white),
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.phone,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '9502986243',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )
                              ],
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.calendar_today,
                                  color: Colors.white,
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '01-Sept 2019',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '-',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  'present',
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                )
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
                              color: Colors.white,
                            ),
                          ),
                          child: Center(
                            child: Text(
                              '100',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 38,
                                  color: Colors.white),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Events Participated',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Text(
                  'View All',
                  style: TextStyle(
                    decoration: TextDecoration.underline,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: items.length,
              itemBuilder: (context, index) {
                return EventCard(
                  eventModel: items[index],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
