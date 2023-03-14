import 'package:flutter/material.dart';
import 'package:heroicons/heroicons.dart';
import 'package:movies_with_friends/model/NavigationItem.dart';
import 'package:movies_with_friends/view/library/library.dart';
import 'package:movies_with_friends/view/search/search.dart';

import 'package:movies_with_friends/view/theme.dart';
import 'package:movies_with_friends/view/home/home.dart';
import 'package:movies_with_friends/view/login/login.dart';
import 'package:movies_with_friends/view/register/register.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp>  {

  int selectedPage = 0;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Movies',
      theme: applicationTheme,
      initialRoute: '/login',
      routes: {
      '/login': (context) => const LoginPage(),
      '/register': (context) => const RegisterPage(),
      '/': (context){
        final pageController = PageController(initialPage: 0);

        return Scaffold(
        body: PageView(
          controller: pageController,
          scrollDirection: Axis.horizontal,
          onPageChanged: (newIndex) {
            setState(() {
              selectedPage = newIndex;
            });
          },
          children: const [
            HomePage(),
            SearchPage(),
            LibraryPage(),
          ],
        ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: selectedPage,
        onDestinationSelected: (int index) {
          pageController.animateToPage(index, duration: const Duration(microseconds: 300), curve: Curves.easeIn);
        },
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        surfaceTintColor: Theme.of(context).colorScheme.tertiary,
        
        destinations: navigationItems.map((NavigationItem destination) {
          return NavigationDestination(
            label: destination.label,
            icon: destination.icon,
            selectedIcon: destination.selectedIcon,
            tooltip: destination.label,
          );
        }).toList(),
      ),
    );
    }
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

const List<NavigationItem> navigationItems = <NavigationItem>[
  NavigationItem(
      'News', HeroIcon(HeroIcons.home), HeroIcon(HeroIcons.home, style: HeroIconStyle.solid)),
  NavigationItem(
      'Search', HeroIcon(HeroIcons.magnifyingGlass), HeroIcon(HeroIcons.magnifyingGlass, style: HeroIconStyle.solid)),
  NavigationItem(
      'Library', HeroIcon(HeroIcons.bookmark), HeroIcon(HeroIcons.bookmark, style: HeroIconStyle.solid)),
];