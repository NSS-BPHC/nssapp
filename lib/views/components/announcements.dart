import 'package:flutter/material.dart';
import 'package:nssapp/utilities/utilityFunctions.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/services/getApi.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/dashboard/addAnnouncement.dart';
import 'package:nssapp/views/widgets/announcementCard.dart';
import 'package:provider/provider.dart';

class AnnouncementsComponent extends StatefulWidget {
  @override
  _AnnouncementsComponentState createState() => _AnnouncementsComponentState();
}

class _AnnouncementsComponentState extends State<AnnouncementsComponent> {
  bool viewAll = false;
  @override
  void initState() {
    super.initState();
    // context.read<GetAPIProvider>().getAnnouncements();
  }

  @override
  Widget build(BuildContext context) {
    final loading = Provider.of<GetAPIProvider>(context).announcementsLoading;
    final announcements = context.watch<GetAPIProvider>().announcements;
    announcements?.sort(
        (a, b) => a.time.toDateTime().isBefore(b.time.toDateTime()) ? 1 : 0);
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
                      if ((context.watch<LoginManager>().isAdmin))
                        InkWell(
                          onTap: () async {
                            final wasCreated = await Navigator.push<bool>(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddAnnouncementScreen(),
                              ),
                            );
                            if (wasCreated == true) {
                              context
                                  .read<GetAPIProvider>()
                                  .getAnnouncements(wasPulledToRefresh: true);
                            }
                          },
                          child: Icon(
                            Icons.add,
                            color: Colors.white,
                          ),
                        )
                    ],
                  ),
                  if ((announcements?.length ?? 0) > 2)
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.5),
                        borderRadius: BorderRadius.all(
                          Radius.circular(10.0),
                        ),
                      ),
                      child: InkWell(
                        onTap: () {
                          setState(() {
                            viewAll = !viewAll;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            !viewAll ? 'View more' : "View less",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18.0,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                    )
                ],
              ),
              if (loading) CircularProgressIndicator(),
              if (announcements != null)
                RefreshIndicator(
                  onRefresh: () async {
                    await context
                        .read<GetAPIProvider>()
                        .getAnnouncements(wasPulledToRefresh: true);
                  },
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: ((announcements.length) > 2 && !viewAll
                        ? 2
                        : announcements.length),
                    itemBuilder: (context, index) {
                      if (index >= announcements.length)
                        return SizedBox(height: 40);
                      return AnnouncementCard(
                        announcementModel: announcements[index],
                      );
                    },
                  ),
                ),
              if (announcements == null || announcements.isEmpty && !loading)
                Center(
                  child: Text("No announcements yet"),
                )
            ],
          ),
        ),
      ),
    );
  }
}
