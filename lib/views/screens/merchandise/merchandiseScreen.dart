import 'package:flutter/material.dart';
import 'package:nssapp/data/merchandise.dart';
import 'package:nssapp/models/loginManager.dart';
import 'package:nssapp/models/merchandise.dart';
import 'package:nssapp/models/userModel.dart';
import 'package:provider/provider.dart';

import 'merchandiseDescription.dart';

class MerchandiseScreen extends StatefulWidget {
  @override
  _MerchandiseScreenState createState() => _MerchandiseScreenState();
}

class _MerchandiseScreenState extends State<MerchandiseScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: Text('Merchandise', style: TextStyle(color: Colors.black)),
        centerTitle: false,
        actions: [
          if (context.watch<LoginManager>().userRole == UserRole.Admin)
            IconButton(
                onPressed: () {},
                icon: Icon(
                  Icons.add,
                  color: Colors.black,
                )),
        ],
      ),
      body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: (context.watch<LoginManager>().userRole != UserRole.Admin)
              ? Center(child: Text("No merchandise"))
              : Center(child: Text("Admin form"))
          // : ListView.builder(
          //     shrinkWrap: true,
          //     // gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          //     //   maxCrossAxisExtent: 200,
          //     //   childAspectRatio: MediaQuery.of(context).size.width /
          //     //       (MediaQuery.of(context).size.height / 1.25),
          //     //   crossAxisSpacing: 20,
          //     //   mainAxisSpacing: 20,
          //     // ),
          //     itemCount: merchandiseData.length,
          //     itemBuilder: (BuildContext ctx, index) {
          //       return MerchandiseCard(merchandise: merchandiseData[index]);
          //     }),
          ),
    );
  }
}

class MerchandiseCard extends StatefulWidget {
  final Merchandise merchandise;

  const MerchandiseCard({Key? key, required this.merchandise})
      : super(key: key);
  @override
  _MerchandiseCardState createState() => _MerchandiseCardState();
}

class _MerchandiseCardState extends State<MerchandiseCard> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => MerchandiseDescriptionScreen(
                    merchandise: widget.merchandise)));
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 280.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(widget.merchandise.imgUrl[0])),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    widget.merchandise.title,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18.0,
                    ),
                  ),
                  Text(
                    '₹ ' + widget.merchandise.cost.toString(),
                    style: TextStyle(
                      fontSize: 18.0,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
