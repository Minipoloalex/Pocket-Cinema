import 'package:heroicons/heroicons.dart';

class NavigationItem {
  const NavigationItem(this.label, this.icon, this.selectedIcon);

  final String label;
  final HeroIcon icon;
  final HeroIcon selectedIcon;
}