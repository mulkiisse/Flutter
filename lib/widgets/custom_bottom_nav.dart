import 'package:flutter/material.dart';

import '../screens/add_screen.dart';
import '../screens/home_screen.dart';
import '../screens/overview_screen.dart';
import '../screens/profile_screen.dart';
import '../theme/app_theme.dart';

/// Shared four-tab bottom navigation used by every main MoneyTrack screen.
class CustomBottomNav extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  const CustomBottomNav({
    super.key,
    required this.currentIndex,
    required this.onTap,
  });

  static const List<IconData> _icons = [
    Icons.home_rounded,
    Icons.add_circle_outline_rounded,
    Icons.grid_view_rounded,
    Icons.person_outline_rounded,
  ];

  static const List<String> _labels = [
    'Home',
    'Add',
    'Overview',
    'Profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.black,
      padding: const EdgeInsets.only(top: 12),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_labels.length, (index) {
            final bool active = index == currentIndex;
            final Color color = active ? primaryGreen : Colors.white70;

            return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => onTap(index),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(_icons[index], color: color, size: 23),
                    const SizedBox(height: 4),
                    Text(
                      _labels[index],
                      style: TextStyle(
                        color: color,
                        fontSize: 11,
                        fontWeight:
                            active ? FontWeight.w600 : FontWeight.normal,
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Navigates between the four main screens without stacking tab screens.
void navigateToScreen(BuildContext context, int index) {
  final Widget target;

  switch (index) {
    case 0:
      target = const HomeScreen();
      break;
    case 1:
      target = const AddScreen();
      break;
    case 2:
      target = const OverviewScreen();
      break;
    case 3:
      target = const ProfileScreen();
      break;
    default:
      target = const HomeScreen();
  }

  if (ModalRoute.of(context)?.settings.name == target.runtimeType.toString()) {
    return;
  }

  Navigator.pushReplacement(
    context,
    PageRouteBuilder(
      settings: RouteSettings(name: target.runtimeType.toString()),
      pageBuilder: (_, __, ___) => target,
      transitionDuration: Duration.zero,
      reverseTransitionDuration: Duration.zero,
    ),
  );
}
