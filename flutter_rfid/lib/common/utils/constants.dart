

import 'package:flutter_rfid/data/models/ui_models/home_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


          // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: 'Home'),
          // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.box), label: 'Inventory'),
          // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.box), label: 'Inventory'),
          // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.user), label: 'Profile'),

class Constants {
  static List<HomeItem> homeItems = [
    const HomeItem(title: 'Home', icon: FontAwesomeIcons.house),
    const HomeItem(title: 'User Logs', icon: FontAwesomeIcons.userCheck),
    const HomeItem(title: 'Devices', icon: FontAwesomeIcons.desktop),
    const HomeItem(title: 'Profile', icon: FontAwesomeIcons.user),
  ];
}
