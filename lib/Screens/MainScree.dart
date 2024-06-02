import 'package:faculty_review/Screens/user_profile_page.dart';
import 'package:faculty_review/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:faculty_review/Screens/HomePage.dart';
import 'Developers_page.dart';
import 'RegisterPage.dart';

class MainScreen extends ConsumerStatefulWidget {
  const MainScreen({super.key});

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends ConsumerState<MainScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey<ScaffoldState>();
  final PageController _pageController = PageController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      appBar: AppBar(
        title: Text("AcademiQ"),
        leading: IconButton(
          icon: Icon(Icons.menu),
          onPressed: () => _key.currentState?.openDrawer(),
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            SizedBox(
              height: 150, // Set the desired height here
              child: DrawerHeader(
                decoration: BoxDecoration(
                  color: brownColor,
                ),
                child: Text(
                  'Menu',
                  style: TextStyle(
                    color: Colors.white,
                    fontFamily: 'Space Mono',
                    fontWeight: FontWeight.bold,
                    fontSize: 28,
                  ),
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                _pageController.jumpToPage(0);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.search),
              title: Text('Search'),
              onTap: () {
                _pageController.jumpToPage(1);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.people),
              title: Text('UserProfile'),
              onTap: () {
                _pageController.jumpToPage(2);
                Navigator.pop(context); // Close the drawer
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Author'),
              onTap: () {
// move to this page : SupportTheAuthorPage
                Navigator.pop(context); // Close the drawer
                _pageController.jumpToPage(3);



              },
            ),
            ListTile(
              leading: Icon(Icons.logout),
              title: Text('Logout'),
              onTap: () {
                // Logout
                Navigator.pop(context); // Close the drawer
              },
            )
          ],
        ),
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: (index) {},
        children: [
          HomePage(),
          RegisterPage(),
          UserProfilePage(),
          SupportTheAuthorPage(),
        ],
      ),
    );
  }
}
