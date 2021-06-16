import 'package:flutter/material.dart';
import 'package:nssapp/data/announcements.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/dashboard/addAnnouncement.dart';
import 'package:nssapp/views/widgets/announcementCard.dart';

class AnnouncementsComponent extends StatefulWidget {
  @override
  _AnnouncementsComponentState createState() => _AnnouncementsComponentState();
}

class _AnnouncementsComponentState extends State<AnnouncementsComponent> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 14.0, bottom: 14.0),
      child: Container(
        decoration: BoxDecoration(
          color: AppTheme.primaryColor,
          borderRadius: BorderRadius.all(
            Radius.circular(12.0),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Announcements',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                          color: Colors.white,
                        ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddAnnouncementScreen()));
                          },
                          child: Icon(Icons.add, color: Colors.white)),
                    ],
                  ),
                  announcementsData.length > 2
                      ? Container(
                          decoration: BoxDecoration(
                            color: Colors.white.withOpacity(0.5),
                            borderRadius: BorderRadius.all(
                              Radius.circular(10.0),
                            ),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(
                              'View all',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18.0,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      : Container(),
                ],
              ),
              ListView.builder(
                shrinkWrap: true,
                itemCount:
                    announcementsData.length > 2 ? 2 : announcementsData.length,
                itemBuilder: (context, index) {
                  return AnnouncementCard(
                    announcementModel: announcementsData[index],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
