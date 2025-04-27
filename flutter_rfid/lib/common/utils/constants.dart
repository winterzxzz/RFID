

import 'package:flutter_rfid/data/models/ui_models/home_item.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


          // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.house), label: 'Home'),
          // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.box), label: 'Inventory'),
          // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.box), label: 'Inventory'),
          // BottomNavigationBarItem(icon: FaIcon(FontAwesomeIcons.user), label: 'Profile'),

class Constants {
  static List<HomeItem> homeItems = [
    const HomeItem(title: 'Trang chủ', icon: FontAwesomeIcons.house),
    const HomeItem(title: 'Lịch sử điểm danh', icon: FontAwesomeIcons.userCheck),
    const HomeItem(title: 'Thiết bị', icon: FontAwesomeIcons.desktop),
    const HomeItem(title: 'Cá nhân', icon: FontAwesomeIcons.user),
  ];
}
