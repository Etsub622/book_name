import 'package:flutter/material.dart';
import 'package:front_end/features/book/presentation/pages/add_books.dart';
import 'package:front_end/features/book/presentation/pages/book_home.dart';
import 'package:front_end/features/book/presentation/pages/search_page.dart';
import 'package:front_end/features/favorites/presntation/pages/favorite_page.dart';
import 'package:front_end/features/onboarding/presentation/pages/home.dart';

class BottomNavBAr extends StatefulWidget {
  const BottomNavBAr({super.key});

  @override
  State<BottomNavBAr> createState() => _BottomNavBArState();
}

class _BottomNavBArState extends State<BottomNavBAr> {
  int curIndex = 0;

  final List<Widget> _screens = [
    BookHome(),
    FavoritesPage(),
    SearchPage(),
    AddBooksPages(),
    // HomePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[curIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.brown,
        unselectedItemColor: Colors.brown[300],
        onTap: (index) {
          setState(() {
            curIndex = index;
          });
        },
        currentIndex: curIndex,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: 'Favorite'),
          BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: 'Add'),
          // BottomNavigationBarItem(icon: Icon(Icons.logout), label: 'logout'),
        ],
      ),
    );
  }
}
