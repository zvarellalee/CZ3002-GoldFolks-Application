import 'package:flutter/material.dart';
import 'package:goldfolks/widgets/VideoListBuilder.dart';

class ExerciseScreen extends StatefulWidget {
  static String id = 'ExerciseScreen';
  @override
  State<StatefulWidget> createState() {
    return _ExerciseScreenState();
  }
}

class _ExerciseScreenState extends State<ExerciseScreen> {
  PageController _pageController;
  int _currentIndex = 0;
  final List<Widget> _children = [
    PlaceholderWidget(Colors.black12),
    PlaceholderWidget(Colors.black12),
    PlaceholderWidget(Colors.black12),
  ];

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_rounded, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        centerTitle: true,
        title: Text('Exercise Videos'),
        backgroundColor: Colors.redAccent,
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {
          setState(() => _currentIndex = index);
        },
        children: _children,
      ), // new
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onTabTapped, // new
        currentIndex: _currentIndex, // new
        selectedItemColor: Colors.redAccent,
        items: [
          new BottomNavigationBarItem(
            icon: Icon(Icons.sports_handball),
            label: 'Upper Body',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.directions_run),
            label: 'Lower Body',
          ),
          new BottomNavigationBarItem(
            icon: Icon(Icons.accessibility),
            label: 'Aerobics',
          )
        ],
      ),
    );
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      _pageController.animateToPage(index,
          duration: Duration(milliseconds: 150), curve: Curves.easeOut);
    });
  }
}
