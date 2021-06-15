import 'dart:math';

import 'package:flutter/material.dart';
import 'package:nssapp/views/screens/merchandiseDescription.dart';

class VolunteerMerchandiseScreen extends StatefulWidget {
  const VolunteerMerchandiseScreen({Key? key}) : super(key: key);

  @override
  _VolunteerMerchandiseScreenState createState() =>
      _VolunteerMerchandiseScreenState();
}

class _VolunteerMerchandiseScreenState
    extends State<VolunteerMerchandiseScreen> {
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
        child: GridView.builder(
            shrinkWrap: true,
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 200,
              childAspectRatio: MediaQuery.of(context).size.width /
                  (MediaQuery.of(context).size.height / 1.25),
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
            ),
            itemCount: merchandiseData.length,
            itemBuilder: (BuildContext ctx, index) {
              return MerchandiseCard(merchandise: merchandiseData[index]);
            }),
      ),
    );
  }
}

class Merchandise {
  final List<String> imgUrl;
  final String title;
  final int cost;
  final String availableTypes;
  final String merchType;

  Merchandise({
    required this.imgUrl,
    required this.title,
    required this.cost,
    required this.availableTypes,
    required this.merchType,
  });
}

List<Merchandise> merchandiseData = [
  Merchandise(
    imgUrl: ['asads'],
    cost: 123,
    title: 'Hawa',
    availableTypes: 'XL / L / S',
    merchType: 'hoodie',
  ),
  Merchandise(
    imgUrl: ['asads'],
    cost: 12,
    title: 'Hawa',
    availableTypes: 'XL / L / S',
    merchType: 'hoodie',
  ),
  Merchandise(
    imgUrl: ['asads'],
    cost: 122,
    title: 'Hawaaaa',
    availableTypes: 'XL / L / S',
    merchType: 'hoodie',
  ),
  Merchandise(
    imgUrl: ['asads'],
    cost: 12,
    title: 'Hawaaaa',
    availableTypes: 'XL / L / S',
    merchType: 'hoodie',
  ),
  Merchandise(
    imgUrl: ['asads'],
    cost: 12,
    title: 'Hawaaaa',
    availableTypes: 'XL / L / S',
    merchType: 'hoodie',
  ),
];

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
              width: 200.0,
              height: 250.0,
              decoration: BoxDecoration(
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: NetworkImage(
                        'https://images.unsplash.com/photo-1579572331145-5e53b299c64e?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=656&q=80')),
                borderRadius: BorderRadius.all(Radius.circular(12.0)),
              ),
            ),
            Text(
              widget.merchandise.title,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18.0,
              ),
            ),
            Text(
              '₹ ' + widget.merchandise.cost.toString(),
              style: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
