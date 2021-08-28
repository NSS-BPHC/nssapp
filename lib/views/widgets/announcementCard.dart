import 'package:flutter/material.dart';
import 'package:nssapp/models/announcementModel.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/services/getApi.dart';
import 'package:nssapp/utilities/uiFunctions.dart';
import 'package:provider/provider.dart';

class AnnouncementCard extends StatefulWidget {
  final AnnouncementModel announcementModel;

  const AnnouncementCard({Key? key, required this.announcementModel})
      : super(key: key);

  @override
  _AnnouncementCardState createState() => _AnnouncementCardState();
}

class _AnnouncementCardState extends State<AnnouncementCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Container(
        width: 80.0,
        decoration: BoxDecoration(
          color: Color(0xff5271ff),
          borderRadius: BorderRadius.all(Radius.circular(10)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            children: [
              Icon(Icons.notifications, color: Colors.white),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  width: 3,
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                ),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      widget.announcementModel.title,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      widget.announcementModel.description,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          widget.announcementModel.time,
                          style: TextStyle(
                            color: Colors.white,
                            fontStyle: FontStyle.italic,
                            fontSize: 10.0,
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              if (Provider.of<LoginManager>(context).isAdmin)
                InkWell(
                  onTap: () {
                    showConfirmDialog(context,
                        title: "Heads up, Admin",
                        content:
                            "Do you want to delete announcement ${widget.announcementModel.title}?",
                        onConfirm: () {
                      context.read<GetAPIProvider>().loadAnnouncementsUI();
                      widget.announcementModel.delete().then((value) {
                        if (!value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Failed to delete")));
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text("Deleted announcement!")));

                          context.read<GetAPIProvider>().getAnnouncements();
                        }
                      });
                    });
                  },
                  child: Icon(Icons.delete, color: Colors.red),
                )
            ],
          ),
        ),
      ),
    );
  }
}
