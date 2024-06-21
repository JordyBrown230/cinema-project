import 'package:flutter/material.dart';

// ignore: constant_identifier_names
enum MenuIcon { Home, Category, Favorite, Person }

class CustomMenuBar extends StatefulWidget {
  final void Function(MenuIcon) onTap;

  const CustomMenuBar({super.key, required this.onTap});

  @override
  CustomMenuBarState createState() => CustomMenuBarState();
}

class CustomMenuBarState extends State<CustomMenuBar> {
  MenuIcon _selectedIcon = MenuIcon.Home;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        color: const Color(0xFF382C3E).withOpacity(0.8),
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.5),
            spreadRadius: 1,
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          IconButton(
            icon: Icon(
              _selectedIcon == MenuIcon.Home ? Icons.home : Icons.home_outlined,
              color:
                  _selectedIcon == MenuIcon.Home ? Colors.white : Colors.grey,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _selectedIcon = MenuIcon.Home;
              });
              widget.onTap(MenuIcon.Home);
            },
          ),
          IconButton(
            icon: Icon(
              _selectedIcon == MenuIcon.Category
                  ? Icons.category
                  : Icons.category_outlined,
              color: _selectedIcon == MenuIcon.Category
                  ? Colors.white
                  : Colors.grey,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _selectedIcon = MenuIcon.Category;
              });
              widget.onTap(MenuIcon.Category);
            },
          ),
          IconButton(
            icon: Icon(
              _selectedIcon == MenuIcon.Favorite
                  ? Icons.favorite
                  : Icons.favorite_outline,
              color: _selectedIcon == MenuIcon.Favorite
                  ? Colors.white
                  : Colors.grey,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _selectedIcon = MenuIcon.Favorite;
              });
              widget.onTap(MenuIcon.Favorite);
            },
          ),
          IconButton(
            icon: Icon(
              _selectedIcon == MenuIcon.Person
                  ? Icons.person
                  : Icons.person_outline,
              color:
                  _selectedIcon == MenuIcon.Person ? Colors.white : Colors.grey,
              size: 30,
            ),
            onPressed: () {
              setState(() {
                _selectedIcon = MenuIcon.Person;
              });
              widget.onTap(MenuIcon.Person);
            },
          ),
        ],
      ),
    );
  }
}
