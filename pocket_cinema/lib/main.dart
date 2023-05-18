import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:heroicons/heroicons.dart';
import 'package:pocket_cinema/controller/lists_provider.dart';
import 'package:pocket_cinema/model/navigation_item.dart';
import 'package:pocket_cinema/view/home/home.dart';
import 'package:pocket_cinema/view/login/login.dart';
import 'package:pocket_cinema/view/register/register.dart';
import 'package:pocket_cinema/view/search/search.dart';
import 'package:pocket_cinema/view/theme.dart';
import 'package:pocket_cinema/view/user_space/user_space.dart';

import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends ConsumerState<MyApp> {
  int selectedPage = 0;

  @override
  void initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((User? user) {
      if (user == null) {
        setState(() {
          selectedPage = 0;
        });
        ref.invalidate(watchListProvider);
        ref.invalidate(toWatchListProvider);
        ref.invalidate(listsProvider);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Pocket Cinema',
      theme: applicationTheme,
      initialRoute: FirebaseAuth.instance.currentUser == null ? '/login' : '/',
      routes: {
        '/login': (context) => const LoginPage(),
        '/register': (context) => const RegisterPage(),
        '/': (context) {
          final pageController = PageController(initialPage: 0);

          return Scaffold(
            body: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              onPageChanged: (newIndex) {
                setState(() {
                  selectedPage = newIndex;
                });
              },
              children: const [
                HomePage(),
                SearchPage(),
                UserSpacePage(),
              ],
            ),
            bottomNavigationBar: NavigationBar(
              selectedIndex: selectedPage,
              onDestinationSelected: (int index) {
                pageController.animateToPage(index,
                    duration: const Duration(microseconds: 300),
                    curve: Curves.easeIn);
              },
              backgroundColor: Theme.of(context).colorScheme.tertiary,
              surfaceTintColor: Theme.of(context).colorScheme.tertiary,
              destinations: navigationItems.map((NavigationItem destination) {
                return NavigationDestination(
                  key:
                      Key("${destination.label.toLowerCase()}NavigationButton"),
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
    return Padding(
        padding: const EdgeInsets.all(30),
        child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Text(title, style: Theme.of(context).textTheme.headlineMedium),
            ]));
  }
}

const List<NavigationItem> navigationItems = <NavigationItem>[
  NavigationItem('News', HeroIcon(HeroIcons.home),
      HeroIcon(HeroIcons.home, style: HeroIconStyle.solid)),
  NavigationItem('Search', HeroIcon(HeroIcons.magnifyingGlass),
      HeroIcon(HeroIcons.magnifyingGlass, style: HeroIconStyle.solid)),
  NavigationItem('My Space', HeroIcon(HeroIcons.user),
      HeroIcon(HeroIcons.user, style: HeroIconStyle.solid)),
];
