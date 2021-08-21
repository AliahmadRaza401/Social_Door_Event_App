import 'package:flutter/material.dart';
import 'package:gradient_bottom_navigation_bar/gradient_bottom_navigation_bar.dart';
import 'package:social_door/Screens/Home/home.dart';
import 'package:social_door/Screens/Menu/menu.dart';
import 'package:social_door/Screens/create_Event/createEventStepper.dart';

class TabbarMain extends StatefulWidget {
  TabbarMain({Key? key}) : super(key: key);

  @override
  _TabbarMainState createState() => _TabbarMainState();
}

class _TabbarMainState extends State<TabbarMain> {
  int _selectedIndex = 0;

  final _widgetOptions = [
    Home(),
    CreateEventStepper(),
    Text('Index 2: Events'),
    Text('Index 3: Profile'),
    Menu(),
    Text('Dont remove this is the just use for fill length'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(15.0),
          topRight: Radius.circular(15.0),
          bottomLeft: Radius.circular(15.0),
          bottomRight: Radius.circular(15.0),
        ),
        child: GradientBottomNavigationBar(
          backgroundColorStart: Color(0xff1A1A36),
          backgroundColorEnd: Color(0xff1A1A36),
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home_outlined,
                  size: 30,
                  color: _selectedIndex != 0 ? Color(0xff626275) : null,
                ),
                title: Text(
                  'Home',
                  style: TextStyle(
                    color: _selectedIndex != 0 ? Color(0xff626275) : null,
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.add_a_photo,
                  size: 30,
                  color: _selectedIndex != 1 ? Color(0xff626275) : null,
                ),
                title: Text(
                  'Create Event',
                  style: TextStyle(
                    color: _selectedIndex != 1 ? Color(0xff626275) : null,
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.people_outline,
                  size: 30,
                  color: _selectedIndex != 2 ? Color(0xff626275) : null,
                ),
                title: Text(
                  'Events',
                  style: TextStyle(
                    color: _selectedIndex != 2 ? Color(0xff626275) : null,
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.person_outlined,
                  size: 30,
                  color: _selectedIndex != 3 ? Color(0xff626275) : null,
                ),
                title: Text(
                  'Profile',
                  style: TextStyle(
                    color: _selectedIndex != 3 ? Color(0xff626275) : null,
                  ),
                )),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.menu_outlined,
                  size: 30,
                  color: _selectedIndex != 4 ? Color(0xff626275) : null,
                ),
                title: Text(
                  'Menu',
                  style: TextStyle(
                    color: _selectedIndex != 4 ? Color(0xff626275) : null,
                  ),
                )),
          ],
          currentIndex: _selectedIndex,
          onTap: _onItemTapped,
          type: BottomNavigationBarType.fixed,
        ),
      ),
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
