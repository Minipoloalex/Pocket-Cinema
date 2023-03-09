import 'package:flutter/material.dart';

import 'package:movies_with_friends/view/theme.dart';
import 'package:movies_with_friends/view/home/home.dart';
import 'package:movies_with_friends/view/login/login.dart';

void main() {
  runApp(const MyApp());
}

class PageItem {
  const PageItem(this.label, this.icon, this.selectedIcon);

  final String label;
  final Widget icon;
  final Widget selectedIcon;
}

const List<PageItem> pages = <PageItem>[
  PageItem(
      'News', Icon(Icons.widgets_outlined), Icon(Icons.widgets)),
  PageItem(
      'Search', Icon(Icons.format_paint_outlined), Icon(Icons.format_paint)),
  PageItem(
      'Library', Icon(Icons.text_snippet_outlined), Icon(Icons.text_snippet)),
];

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  {
  
  int _selectedPage = 0;
  final _pageController = PageController(initialPage: 0);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Movies',
      theme: applicationTheme,
      initialRoute: '/login',
      routes: {
      '/login': (context) => const LoginPage(),
      '/': (context) => Scaffold(
        body: PageView(
          controller: _pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (newIndex) {
            setState(() {
              _selectedPage = newIndex;
            });
          },
          children: const [
            Page(title: "Page 1"),
            Page(title: "Page 2"),
            Page(title: "Page 3"),
          ],
          
        ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedPage,
        onDestinationSelected: (int index) {
          //_pageController.animateToPage(index, duration: const Duration(microseconds: 100), curve: Curves.easeIn);
          //_pageController.animateToPage(index, duration: const Duration(microseconds: 300), curve: Curves.easeIn);
        },
        destinations: pages.map((PageItem destination) {
          return NavigationDestination(
            label: destination.label,
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
            tooltip: destination.label,
          );
        }).toList(),
      ),
    )
    },
    );
  }
}

class Page extends StatelessWidget {
  final String title;
 
  const Page({super.key, required this.title});
  @override
  Widget build(BuildContext context) {
    return  Padding(padding: const EdgeInsets.all(30), child: Column(
    mainAxisSize: MainAxisSize.max,
    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
    children: <Widget>[
      Text(title, style: Theme.of(context).textTheme.headlineMedium),
    ]
    ));
  }
}