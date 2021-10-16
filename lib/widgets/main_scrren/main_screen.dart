import 'package:flutter/material.dart';
import 'package:memofy/widgets/movie_list/movie_list.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedTab = 0;

  static final List<Widget> _widgetOptions = <Widget>[
    Text(
      'News',
    ),
    // Text(
    //   'Index 1: Movies',
    // ),
    MovieList(),
    Text(
      'TV Shows',
    ),
  ];

  void onSelectedTab(int index) {
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('TMDB'),
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          Text(
            'News',
          ),
          // Text(
          //   'Index 1: Movies',
          // ),
          MovieList(),
          Text(
            'TV Shows',
          ),
        ]//_widgetOptions[_selectedTab],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'News',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: 'Movies',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: 'TV Shows',
          ),
        ],
        onTap: onSelectedTab,
      ),
    );
  }
}
