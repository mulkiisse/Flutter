import 'package:flutter/material.dart';

import '../theme/app_theme.dart';
import '../widgets/custom_bottom_nav.dart';

/// Simple local profile/settings placeholder screen.
class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 8, 20, 0),
          child: Column(
            children: [
              const Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Profile',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(height: 28),
              const CircleAvatar(
                radius: 44,
                backgroundColor: cardDark,
                child: Icon(
                  Icons.person_rounded,
                  color: primaryGreen,
                  size: 48,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Eng. Mulki Isse ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 26),
              Expanded(
                child: ListView(
                  children: [
                    _ProfileItem(
                      icon: Icons.edit_rounded,
                      title: 'Edit Profile',
                      onTap: () {},
                    ),
                    const Divider(color: Colors.white12),
                    _ProfileItem(
                      icon: Icons.notifications_none_rounded,
                      title: 'Notifications',
                      onTap: () {},
                    ),
                    const Divider(color: Colors.white12),
                    _ProfileItem(
                      icon: Icons.attach_money_rounded,
                      title: 'Currency',
                      trailing: const Text(
                        'USD',
                        style: TextStyle(color: greyText),
                      ),
                      onTap: () {},
                    ),
                    const Divider(color: Colors.white12),
                    _ProfileItem(
                      icon: Icons.logout_rounded,
                      title: 'Logout',
                      titleColor: expenseRed,
                      onTap: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CustomBottomNav(
        currentIndex: 3,
        onTap: (index) => navigateToScreen(context, index),
      ),
    );
  }
}

/// One reusable profile/settings row.
class _ProfileItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final Widget? trailing;
  final Color? titleColor;
  final VoidCallback onTap;

  const _ProfileItem({
    required this.icon,
    required this.title,
    required this.onTap,
    this.trailing,
    this.titleColor,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: CircleAvatar(
        radius: 19,
        backgroundColor: Colors.white.withOpacity(0.07),
        child: Icon(icon, color: titleColor ?? Colors.white, size: 19),
      ),
      title: Text(
        title,
        style: TextStyle(
          color: titleColor ?? Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      trailing: trailing ??
          const Icon(
            Icons.chevron_right_rounded,
            color: greyText,
          ),
      onTap: onTap,
    );
  }
}
