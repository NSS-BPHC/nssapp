import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class VolunteerAboutUsScreen extends StatefulWidget {
  const VolunteerAboutUsScreen({Key? key}) : super(key: key);

  @override
  _VolunteerAboutUsScreenState createState() => _VolunteerAboutUsScreenState();
}

class _VolunteerAboutUsScreenState extends State<VolunteerAboutUsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(
              Icons.chevron_left,
              color: Colors.black,
              size: 35.0,
            )),
        centerTitle: false,
        title: Text(
          'About Us',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 60.0),
        child: Column(
          children: [
            Center(
              child: Hero(
                tag: "logo",
                child: Container(
                  height: 150,
                  width: 150,
                  child: Image(
                    image: AssetImage('assets/images/NSS-symbol.png'),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'The NSS BITS Pilani Hyderabad Campus chapter was sanctioned in March 2009. Since its inception, the NSS BPHC has been galvanising student enthusiasm and commitment to society and channelling it into concrete programs targeting rural citizens, economically disadvantaged school children, orphans and medical patients among others',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.5,
                    height: 1.25),
                textAlign: TextAlign.justify,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'It has now around 150 volunteers working for the social uplift of the down-trodden masses of our nation. We are an organisation through which students get an opportunity to understand the community they work in and their relationship with it.',
                style: TextStyle(
                    fontWeight: FontWeight.normal,
                    fontSize: 15.5,
                    height: 1.25),
                textAlign: TextAlign.justify,
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.only(top: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  SvgPicture.asset('assets/icons/facebook.svg'),
                  SvgPicture.asset('assets/icons/instagram.svg'),
                  SvgPicture.asset('assets/icons/linkedin.svg'),
                  SvgPicture.asset('assets/icons/youtube.svg'),
                  SvgPicture.asset('assets/icons/github.svg'),
                ],
              ),
            ),
            SizedBox(height: 20.0),
            Padding(
              padding: const EdgeInsets.all(14.0),
              child: Text(
                'Know More About Us on our website',
                style: TextStyle(
                  fontWeight: FontWeight.normal,
                  fontSize: 16,
                  letterSpacing: 1.5,
                ),
              ),
            ),
            Text(
              'www.nssbphc.com',
              style: TextStyle(fontWeight: FontWeight.normal, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
