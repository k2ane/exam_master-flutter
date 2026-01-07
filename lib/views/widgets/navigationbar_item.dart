import 'package:flutter/material.dart';

class NavigationbarItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  NavigationbarItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
  });
}

// 配置导航栏标签
final List<NavigationbarItem> navConfig = [
  NavigationbarItem(
    label: '试炼场',
    icon: Icons.dashboard_outlined,
    selectedIcon: Icons.dashboard,
  ),
  NavigationbarItem(
    label: '排行榜',
    icon: Icons.leaderboard_outlined,
    selectedIcon: Icons.leaderboard,
  ),
  NavigationbarItem(
    label: '个人资料',
    icon: Icons.person_outline,
    selectedIcon: Icons.person,
  ),
];
