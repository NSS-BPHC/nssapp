import 'package:flutter/material.dart';
import 'package:nssapp/data/eventsData.dart';
import 'package:nssapp/models/eventModel.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/models/userModel.dart';
import 'package:nssapp/services/getApi.dart';
import 'package:nssapp/utilities/styling.dart';
import 'package:nssapp/views/screens/profile/allVolunteerScreen.dart';
import 'package:nssapp/views/widgets/eventCard.dart';
import 'package:provider/provider.dart';

class VolunteerProfileScreen extends StatefulWidget {
  const VolunteerProfileScreen({Key? key}) : super(key: key);

  @override
  _VolunteerProfileScreenState createState() => _VolunteerProfileScreenState();
}

class _VolunteerProfileScreenState extends State<VolunteerProfileScreen> {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<LoginManager>(context).user;
    final isAdmin = context.watch<LoginManager>().userRole == UserRole.Admin;
    final isVisitor =
        context.watch<LoginManager>().userRole == UserRole.Visitor;

    return Scaffold(
      backgroundColor: Colors.white,
      // appBar: AppBar(
      //   backgroundColor: Color(0xff5271ff),
      //   elevation: 0.0,
      // ),
      body: isVisitor
          ? Center(child: Text("You need to Log In first"))
          : isAdmin
              ? ListOfVolunteers()
              : VolunteerProfileDetails(user: user),
    );
  }
}

class VolunteerProfileDetails extends StatelessWidget {
  const VolunteerProfileDetails({
    Key? key,
    required this.user,
  }) : super(key: key);

  final User user;

  @override
  Widget build(BuildContext context) {
    print(user.events);
    final events = context.watch<LoginManager>().user.events;
    return ChangeNotifierProvider.value(
      value: user,
      builder: (context, _) => Consumer<User>(
        builder: (_, user, __) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              // height: 200,
              decoration: BoxDecoration(
                color: Color(0xff5271ff),
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
              ),
              child: Padding(
                padding: const EdgeInsets.all(14.0),
                child: SafeArea(
                  child: Column(
                    children: [
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            user.name.split(" ")[0],
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 28,
                                color: Colors.white),
                          ),
                          Text(
                            user.name.replaceFirst(user.name.split(" ")[0], ""),
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 15),
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
                                  user.roleString,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
                                ),
                                Text(
                                  user.BitsId,
                                  style: TextStyle(
                                      fontSize: 18, color: Colors.white),
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
                                      user.phoneNumber,
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
                                      user.memberSinceDate,
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
                              ),
                              child: Center(
                                child: Column(
                                  children: [
                                    Text(
                                      user.score,
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 38,
                                          color: Colors.white),
                                    ),
                                    Text(
                                      'Score',
                                      style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 20,
                                          color: Colors.white),
                                    ),
                                  ],
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

                  // InkWell(
                  //   onTap: () {
                  //     Navigator.push(
                  //         context,
                  //         MaterialPageRoute(
                  //             builder: (context) => AllVolunteerScreen()));
                  //   },
                  //   child: Text(
                  //     'View All',
                  //     style: TextStyle(
                  //       decoration: TextDecoration.underline,
                  //     ),
                  //   ),
                  // ),
                ],
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Expanded(
              child: RefreshIndicator(
                onRefresh: () async {
                  await context.read<LoginManager>().init(hardRefresh: true);
                },
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount:
                      context.watch<LoginManager>().user.events?.length ?? 0,
                  itemBuilder: (context, index) {
                    if (events?[index] != null)
                      return EventCard(
                          eventModel: EventModel.fromJson(events![index]));
                    return SizedBox();
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
