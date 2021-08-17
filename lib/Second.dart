import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'Third.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class second extends StatefulWidget {
  @override
  _secondState createState() => _secondState();
}

class _secondState extends State<second> {
  Future fetchtop_rated() async {
    var responsetop_rated = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/top_rated?api_key=f55fbda0cb73b855629e676e54ab6d8e'));
    if (responsetop_rated.statusCode == 200) {
      var object = jsonDecode(responsetop_rated.body);
      return object;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Top Rated',
          style: TextStyle(color: Colors.cyan),
        ),
        backgroundColor: Color(0xff121b28),
      ),
      body: Container(
        color: Color(0xff0b151f),
        width: double.infinity,
        height: double.infinity,
        child: FutureBuilder(
          future: fetchtop_rated(),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Container(
                  width: 50, height: 50, child: CircularProgressIndicator());
            }
            return ListView.builder(
              itemBuilder: (_, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => third(
                          date: snapshot.data['results'][index]['release_date'],
                          about: snapshot.data['results'][index]['overview'],
                          index: index,
                          name: snapshot.data['results'][index]
                              ['original_title'],
                          poster:
                              'https://image.tmdb.org/t/p/original${snapshot.data['results'][index]['poster_path']}',
                        ),
                      ),
                    );
                  },
                  child: card(
                    index: index,
                    name: snapshot.data['results'][index]['original_title'],
                    poster:
                        'https://image.tmdb.org/t/p/original${snapshot.data['results'][index]['poster_path']}',
                    releaseDate: snapshot.data['results'][index]
                        ['release_date'],
                  ),
                );
              },
            );
          },
        ),
        
      ),
    );
  }
}

class card extends StatelessWidget {
  String name, poster, releaseDate;
  final int index;
  card(
      {required this.index,
      required this.name,
      required this.poster,
      required this.releaseDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            child: Container(
              height: 125,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(5)),
              child: Image.network(
                poster,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 15,
                      color: Colors.white),
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    RatingBar.builder(
                      initialRating: 3,
                      itemSize: 10,
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
                      style: TextStyle(
                        color: Colors.grey,
                      ),
                    )
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.access_alarm,
                      color: Colors.grey,
                      size: 15,
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Text('2h 14m',
                        style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
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
                      width: 15,
                    ),
                    Text(releaseDate,
                        style: TextStyle(color: Colors.grey, fontSize: 10)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
