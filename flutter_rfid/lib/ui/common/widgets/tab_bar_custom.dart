import 'package:flutter/material.dart';

class TabbarWithIndicator extends StatelessWidget {
  const TabbarWithIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TabBar(
            isScrollable: true,
            labelColor: Colors.amber,
            unselectedLabelColor: Color(0xFF5E5E5E),
            labelStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            unselectedLabelStyle:
                TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
            dividerColor: Colors.transparent,
            indicatorPadding: EdgeInsets.only(right: 10),
            indicatorColor: Colors.amber,
            tabs: [
              Tab(text: 'Home'),
              Tab(text: 'Contact'),
              Tab(text: 'About'),
            ],
          ),
        ],
      ),
    );
  }
}
