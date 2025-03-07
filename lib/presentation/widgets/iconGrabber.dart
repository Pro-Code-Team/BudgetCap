import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class IconGrabber extends StatelessWidget {
  final String iconName;

  const IconGrabber({super.key, required this.iconName});

  @override
  Widget build(BuildContext context) {
    return Icon(_getIconData(iconName));
  }

  IconData _getIconData(String iconName) {
    final iconData = _iconMap[iconName];
    return iconData ?? Icons.help; // Default icon if no match is found
  }

  static final Map<String, IconData> _iconMap = {
    'fastfood': Icons.fastfood,
    'directions_bus': Icons.directions_bus,
    'movie': Icons.movie,
    'shopping_cart': Icons.shopping_cart,
    'home': Icons.home,
    'directions_car': Icons.directions_car,
    'local_hospital': Icons.local_hospital,
    'school': Icons.school,
    'airplanemode_active': Icons.airplanemode_active,
    'lightbulb': Icons.lightbulb,
    'phone': Icons.phone,
    'wifi': Icons.wifi,
    'shopping_bag': Icons.shopping_bag,
    'videogame_asset': Icons.videogame_asset,
    'savings': Icons.savings,
    'card_giftcard': Icons.card_giftcard,
    'security': Icons.security,
    'pets': Icons.pets,
    'restaurant': Icons.restaurant,
    'fitness_center': Icons.fitness_center,
    'brush': Icons.brush,
    'volunteer_activism': Icons.volunteer_activism,
    'trending_up': Icons.trending_up,
    'receipt_long': Icons.receipt_long,
    'subscriptions': Icons.subscriptions,
    // Add more icons as needed
  };
}
