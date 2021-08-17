import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class third extends StatelessWidget {
  final int index;
  String poster, name, about, date;

  third(
      {required this.index,
      required this.name,
      required this.about,
      required this.poster,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
        ),
        extendBodyBehindAppBar: true,
        body: Stack(
          children: [
            fullinfo(
              about: about,
              index: index,
              name: name,
              poster: poster,
              date: date,
            ),
          ],
        ));
  }
}

class fullinfo extends StatelessWidget {
  final int index;
  String poster, name, about, date;

  fullinfo(
      {required this.index,
      required this.name,
      required this.about,
      required this.poster,
      required this.date});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff0b151f),
      width: double.infinity,
      height: double.infinity,
      child: Column(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              width: double.infinity,
              child: Image.network(
                poster,
                fit: BoxFit.fill,
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              padding: EdgeInsets.all(20),
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                        color: Colors.white),
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      RatingBar.builder(
                        initialRating: 4,
                        itemSize: 15,
                        minRating: 1,
                        direction: Axis.horizontal,
                        allowHalfRating: false,
                        itemCount: 5,
                        itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                        itemBuilder: (context, _) => Icon(
                          Icons.star,
                          color: Colors.cyan,
                        ),
                        onRatingUpdate: (rating) {},
                      ),
                      Text(
                        '2.6k review',
                        style: TextStyle(color: Colors.grey, fontSize: 15),
                      )
                    ],
                  ),
                  SizedBox(
                    height: 15,
                  ),
                  Container(
                    child: Row(
                      children: [
                        Icon(
                          Icons.access_alarm,
                          color: Colors.grey,
                          size: 15,
                        ),
                        SizedBox(
                          width: 5,
                        ),
                        Text('2h 14m',
                            style: TextStyle(color: Colors.grey, fontSize: 10)),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        color: Colors.grey,
                        size: 15,
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(date,
                          style: TextStyle(color: Colors.grey, fontSize: 10)),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Container(
                    height: 70,
                    child: SingleChildScrollView(
                      child: Text(about,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 15,
                            letterSpacing: 1,
                          )),
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
