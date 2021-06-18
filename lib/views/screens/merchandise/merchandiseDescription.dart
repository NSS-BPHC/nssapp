import 'package:flutter/material.dart';
import 'package:nssapp/models/merchandise.dart';

class MerchandiseDescriptionScreen extends StatefulWidget {
  final Merchandise merchandise;

  const MerchandiseDescriptionScreen({Key? key, required this.merchandise})
      : super(key: key);
  @override
  _MerchandiseDescriptionScreenState createState() =>
      _MerchandiseDescriptionScreenState();
}

class _MerchandiseDescriptionScreenState
    extends State<MerchandiseDescriptionScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: false,
          leading: IconButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              icon: Icon(
                Icons.chevron_left,
                size: 40.0,
                color: Colors.black,
              )),
        ),
        body: Stack(
          children: <Widget>[
            Container(
              height: 450.0,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(45.0),
                  bottomRight: Radius.circular(45.0),
                ),
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  CardsList(merchandise: widget.merchandise),
                  SizedBox(
                    height: 50,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 30.0, vertical: 10.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.merchandise.title,
                              style: TextStyle(
                                  fontSize: 24.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              '₹ ' + widget.merchandise.cost.toString(),
                              style: TextStyle(
                                fontSize: 24.0,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Type : ' + widget.merchandise.merchType,
                              style: TextStyle(
                                  fontSize: 18.0, fontWeight: FontWeight.bold),
                            ),
                            Text(
                              'Description : ' +
                                  widget.merchandise.availableTypes,
                              style: TextStyle(fontSize: 18.0),
                            ),
                          ],
                        ),
                        SizedBox(height: 30),
                        Column(
                          children: [
                            Text(
                              'Visit FabLabs Store',
                              style: TextStyle(fontSize: 18.0),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                color: Color(0xff5271ff),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(24),
                                ),
                              ),
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Text(
                                    "Buy",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 24,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ));
  }
}

class CardsList extends StatefulWidget {
  final Merchandise merchandise;

  const CardsList({Key? key, required this.merchandise}) : super(key: key);
  @override
  _CardsListState createState() => _CardsListState();
}

class _CardsListState extends State<CardsList> {
  int _currentCard = 0;

  final PageController _pageController = PageController(initialPage: 0);
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  _onPageChanged(int index) {
    setState(() {
      _currentCard = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Container(
            height: 400.0,
            child: PageView.builder(
              itemCount: widget.merchandise.imgUrl.length,
              scrollDirection: Axis.horizontal,
              controller: _pageController,
              onPageChanged: _onPageChanged,
              itemBuilder: (context, index) =>
                  CreditCard(imgURL: widget.merchandise.imgUrl[index]),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (int i = 0; i < widget.merchandise.imgUrl.length; i++)
                  if (_currentCard == i)
                    DotIndicator(true)
                  else
                    DotIndicator(false)
              ],
            ),
          )
        ],
      ),
    );
  }
}

class DotIndicator extends StatefulWidget {
  final bool isActive;
  DotIndicator(this.isActive);
  @override
  _DotIndicatorState createState() => _DotIndicatorState();
}

class _DotIndicatorState extends State<DotIndicator> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4.0),
      child: Container(
        height: 12.0,
        width: 12.0,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6.0),
          color: widget.isActive ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}

class CreditCard extends StatefulWidget {
  final String imgURL;

  const CreditCard({Key? key, required this.imgURL}) : super(key: key);
  @override
  _CreditCardState createState() => _CreditCardState();
}

class _CreditCardState extends State<CreditCard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Container(
        height: 300.0,
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage(widget.imgURL),
          ),
          borderRadius: BorderRadius.all(Radius.circular(24.0)),
          color: Colors.redAccent,
        ),
      ),
    );
  }
}
