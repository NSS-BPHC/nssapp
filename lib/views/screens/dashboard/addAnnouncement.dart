import 'package:flutter/material.dart';
import 'package:nssapp/services/postApi.dart';

class AddAnnouncementScreen extends StatefulWidget {
  const AddAnnouncementScreen({Key? key}) : super(key: key);

  @override
  _AddAnnouncementScreenState createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final maxLines = 10;
  bool isLoading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        title: Text(
          'Add Announcement',
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 28, color: Colors.black),
        ),
        centerTitle: true,
      ),
      body: Container(
        child: ListView(
          children: [
            Container(
              margin: EdgeInsets.all(12),
              child: TextField(
                controller: titleController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Title',
                ),
              ),
            ),
            Container(
              height: maxLines * 24,
              margin: EdgeInsets.all(12),
              child: TextField(
                maxLines: maxLines,
                controller: descriptionController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Description',
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: () {
                    Navigator.pop(context, false);
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color(0xff5271ff),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Cancel",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () async {
                    if (!isLoading) {
                      setState(() {
                        isLoading = true;
                      });
                      await createAnnouncement(
                        title: titleController.text,
                        description: descriptionController.text,
                      );
                      // isLoading = false;
                      Navigator.pop(context, true);
                    }
                    // Navigator.pop(context);
                  },
                  child: Container(
                    width: 100,
                    decoration: BoxDecoration(
                        color: Color(0xff5271ff),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "Add",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                            color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            if (isLoading) Center(child: CircularProgressIndicator()),
          ],
        ),
      ),
    );
  }
}
