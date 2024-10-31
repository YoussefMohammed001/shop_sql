import 'package:flutter/material.dart';
import 'package:shop_sql/features/archive/presentation/view/screen/archive_screen.dart';
import 'package:shop_sql/features/favourite/presentation/view/screen/fav_screen.dart';
import 'package:shop_sql/features/home/presentation/view/screen/home_screen.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  List<Widget> widgetList = [
    const HomeScreen(),
     FavScreen(),
    ArchiveScreen()
  ];

  int index = 0;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            setState(() {
              index = value;
            });

            print("index===>$index");
            print(value);


          },
          type: BottomNavigationBarType.fixed,
          elevation: 10.0,
          backgroundColor: Colors.blueAccent,
          selectedItemColor: Colors.white,
          unselectedItemColor: Colors.black,
          currentIndex: index,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.favorite), label: "favorites"),
            BottomNavigationBarItem(
                icon: Icon(Icons.archive_outlined), label: "Archive"),
          ],
        ),
        body: Center(child: widgetList[index]),
      ),
    );
  }
}
