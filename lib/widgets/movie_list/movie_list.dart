import 'package:flutter/material.dart';

class Movie {
  final String imageName;
  final String title;
  final String time;
  final String description;

  Movie(
      {required this.imageName,
      required this.title,
      required this.time,
      required this.description});
}

class MovieList extends StatefulWidget {
  MovieList({Key? key}) : super(key: key);

  @override
  _MovieListState createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  final _movies = [
    Movie(
        imageName: 'images/movie.jpg',
        title: 'Black Widow',
        time: ' 07/09/2021',
        description:
            'Natasha Romanoff, also known as Black Widow, confronts the '
            'darker parts of her ledger when a dangerous conspiracy with ties to '
            'her past arises. Pursued by a force that will stop at nothing to bring'
            ' her down, Natasha must deal with her history as a spy and the broken '
            'relationships left in her wake long before she became an Avenger.'),
    Movie(
        imageName: 'images/movie.jpg',
        title: 'Space Jam: A New Legacy',
        time: '07/16/2021 ',
        description:
            'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    Movie(
        imageName: 'images/movie.jpg',
        title: 'The Forever Purge ',
        time: 'Jun 30, 2021',
        description: 'All the rules are broken as a sect of lawless marauders '
            'decides that the annual Purge does not stop at daybreak and instead '
            'should never end as they chase a group of immigrants who they want '
            'to punish because of their harsh historical past.'),
    Movie(
        imageName: 'images/movie.jpg',
        title: 'The Boss Baby: Family Business',
        time: '07/02/2021',
        description:
            'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other. But a new '
            'boss baby with a cutting-edge approach and a can-do attitude is about t'
            'o bring them together again … and inspire a new family business.'),
    Movie(
        imageName: 'images/movie.jpg',
        title: 'The Tomorrow War',
        time: '07/16/2021 ',
        description:
            'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    Movie(
        imageName: 'images/movie.jpg',
        title: 'Luca',
        time: '07/16/2021 ',
        description:
            'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    Movie(
        imageName: 'images/movie.jpg',
        title: 'Awake',
        time: '07/16/2021 ',
        description:
            'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    Movie(
        imageName: 'images/movie.jpg',
        title: 'Infinite',
        time: '07/16/2021 ',
        description:
            'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
    Movie(
        imageName: 'images/movie.jpg',
        title: 'Wrath of Man',
        time: 'Apr 22, 2021',
        description:
            'The Templeton brothers — Tim and his Boss Baby little bro '
            'Ted — have become adults and drifted away from each other.'),
  ];

  var _fillteredMovies = <Movie>[];
  final _searchController = TextEditingController();

  void _searchMovies() {
    final query = _searchController.text;
    print(query);
    if (query.isNotEmpty) {
      _fillteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _fillteredMovies = _movies;
    }
    setState(() {});
  }

  void _searchMovies1(String query) {
   // final query = _searchController.text;
    print(query);
    if (query.isNotEmpty) {
      _fillteredMovies = _movies.where((Movie movie) {
        return movie.title.toLowerCase().contains(query.toLowerCase());
      }).toList();
    } else {
      _fillteredMovies = _movies;
    }
    //setState(() {});
  }

  @override
  void initState() {
    super.initState();
    _fillteredMovies = _movies;
    _searchController.addListener(_searchMovies);

  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        ListView.builder(
          padding: EdgeInsets.only(top: 70.0),
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          itemCount: _fillteredMovies.length,
          itemExtent: 163,
          itemBuilder: (BuildContext context, int index) {
            final movie = _fillteredMovies[index];
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
              child: Stack(
                children: [
                  Container(
                    decoration: BoxDecoration(
                        color: Colors.white,
                        border:
                            Border.all(color: Colors.black.withOpacity(0.2)),
                        borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.1),
                            blurRadius: 8,
                            offset: Offset(0, 2),
                          )
                        ]),
                    clipBehavior: Clip.hardEdge,
                    child: Row(
                      children: [
                        Image(
                          image: AssetImage('images/movie.jpg'),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                movie.title,
                                style: TextStyle(fontWeight: FontWeight.bold),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                movie.time,
                                style: TextStyle(color: Colors.grey),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              SizedBox(
                                height: 20,
                              ),
                              Text(
                                movie.description,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                      ],
                    ),
                  ),
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(10.0),
                      onTap: () {
                        print('tap');
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.all(10.0),
          child: TextField(
            decoration: InputDecoration(
              labelText: 'Search',
              filled: true,
              fillColor: Colors.white.withAlpha(235),
              border: OutlineInputBorder(),
            ),
            controller: _searchController,
            onChanged: (query){
             //_searchMovies1(query);

              // if (query.isNotEmpty) {
              //   _fillteredMovies = _movies.where((Movie movie) {
              //     return movie.title.toLowerCase().contains(query.toLowerCase());
              //   }).toList();
              // } else {
              //   _fillteredMovies = _movies;
              // }
              // print(query);
            },
          ),
        ),

        // added 16.10 ---------------
        Align(
          alignment: Alignment.bottomRight,
          child: FloatingActionButton(
            onPressed: (){},
            child: const Icon(Icons.add),
          ),
        ),
        //---------------
      ],
    );
  }
}
