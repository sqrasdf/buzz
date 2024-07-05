import 'package:chatapp/pages/home_page.dart';
import 'package:chatapp/pages/profile_page.dart';
import 'package:flutter/material.dart';
import 'package:hidden_drawer_menu/hidden_drawer_menu.dart';

class HiddenDrawer extends StatefulWidget {
  const HiddenDrawer({super.key});

  @override
  State<HiddenDrawer> createState() => _HiddenDrawerState();
}

class _HiddenDrawerState extends State<HiddenDrawer> {
  List<ScreenHiddenDrawer> _pages = [];

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _pages = [
      ScreenHiddenDrawer(
          ItemHiddenMenu(
            name: "Chats",
            baseStyle: const TextStyle(
              color: Colors.white,
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
            selectedStyle: const TextStyle(
              color: Colors.white,
              fontSize: 28,
              fontWeight: FontWeight.bold,
            ),
            colorLineSelected: Theme.of(context).primaryColor,
          ),
          const HomePage()),
      ScreenHiddenDrawer(
        ItemHiddenMenu(
          name: "Profile",
          baseStyle: const TextStyle(
            color: Colors.white,
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
          selectedStyle: const TextStyle(
            color: Colors.white,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
          colorLineSelected: Theme.of(context).primaryColor,
        ),
        const ProfilePage(),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return HiddenDrawerMenu(
      screens: _pages,
      backgroundColorMenu: Theme.of(context).primaryColor.withOpacity(0.6),
      initPositionSelected: 0,
      slidePercent: 35,
      contentCornerRadius: 20,
      disableAppBarDefault: true,
    );
  }
}
