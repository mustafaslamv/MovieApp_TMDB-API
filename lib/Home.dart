import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'Second.dart';
import 'Third.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Future fetchPopular() async {
    var responsetop_rated = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/popular?api_key=f55fbda0cb73b855629e676e54ab6d8e'));
    if (responsetop_rated.statusCode == 200) {
      var object = jsonDecode(responsetop_rated.body);
      return object;
    }
  }

  Future fetchNowPlaying() async {
    var responsetop_rated = await http.get(Uri.parse(
        'https://api.themoviedb.org/3/movie/now_playing?api_key=f55fbda0cb73b855629e676e54ab6d8e'));
    if (responsetop_rated.statusCode == 200) {
      var object = jsonDecode(responsetop_rated.body);
      return object;
    }
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        padding: EdgeInsets.all(20),
        color: Color(0xff0b151f),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "Now Playing",
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.cyanAccent),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => second()));
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.cyanAccent),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 250,
              child: FutureBuilder(
                future: fetchNowPlaying(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return Container(
                      height: 250,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => third(
                                      date: snapshot.data['results'][index]
                                          ['release_date'],
                                      about: snapshot.data['results'][index]
                                          ['overview'],
                                      index: index,
                                      name: snapshot.data['results'][index]
                                          ['original_title'],
                                      poster:
                                          'https://image.tmdb.org/t/p/original${snapshot.data['results'][index]['poster_path']}',
                                    ),
                                  ),
                                );
                              },
                              child: ListItem(
                                index: index,
                                name: snapshot.data['results'][index]
                                    ['original_title'],
                                poster:
                                    'https://image.tmdb.org/t/p/original${snapshot.data['results'][index]['poster_path']}',
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 15,
                            height: 15,
                          );
                        },
                        itemCount: 10,
                      ));
                },
              ),

            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Popular',
                  style: TextStyle(fontSize: 20, color: Colors.white),
                ),
                TextButton(
                  style: TextButton.styleFrom(
                    textStyle: const TextStyle(color: Colors.cyanAccent),
                  ),
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => second()));
                  },
                  child: const Text(
                    'View All',
                    style: TextStyle(color: Colors.cyanAccent),
                  ),
                ),
              ],
            ),
            Container(
              width: double.infinity,
              height: 200,
              child: FutureBuilder(
                future: fetchPopular(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return CircularProgressIndicator();
                  }
                  return Container(
                      height: 200,
                      width: double.infinity,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return GestureDetector(
                              onTap: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => third(
                                      date: snapshot.data['results'][index]
                                          ['release_date'],
                                      about: snapshot.data['results'][index]
                                          ['overview'],
                                      index: index,
                                      name: snapshot.data['results'][index]
                                          ['original_title'],
                                      poster:
                                          'https://image.tmdb.org/t/p/original${snapshot.data['results'][index]['poster_path']}',
                                    ),
                                  ),
                                );
                              },
                              child: Popular(
                                index: index,
                                name: snapshot.data['results'][index]
                                    ['original_title'],
                                poster:
                                    'https://image.tmdb.org/t/p/original${snapshot.data['results'][index]['poster_path']}',
                              ));
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            width: 15,
                            height: 15,
                          );
                        },
                        itemCount: 10,
                      ));
                },
              ),

            )
          ],
        ),
      ),
    );
  }
}

class ListItem extends StatelessWidget {
  final int index;
  String name, poster;
  ListItem({required this.index, required this.name, required this.poster});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            height: 180,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Image.network(
              poster,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            maxLines: 1,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: Colors.white,
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              RatingBar.builder(
                initialRating: 4,
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
                style: TextStyle(color: Colors.grey, fontSize: 10),
              )
            ],
          ),
          SizedBox(
            height: 5,
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
        ],
      ),
    );
  }
}

class Popular extends StatelessWidget {
  String name, poster;
  final int index;
  Popular({required this.index, required this.name, required this.poster});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 130,
            height: 150,
            clipBehavior: Clip.antiAlias,
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(15)),
            child: Image.network(
              poster,
              fit: BoxFit.fill,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            name,
            style: TextStyle(
                fontWeight: FontWeight.bold, fontSize: 15, color: Colors.white),
          ),
        ],
      ),
    );
  }
}
