import 'package:flutter/material.dart';

class NavigationbarItem {
  final String label;
  final IconData icon;
  final IconData selectedIcon;
  final String? badgeTitle;
  NavigationbarItem({
    required this.label,
    required this.icon,
    required this.selectedIcon,
    this.badgeTitle,
  });
}

// 配置导航栏标签
final List<NavigationbarItem> navConfig = [
  NavigationbarItem(
    label: '试炼场',
    icon: Icons.sports_kabaddi_outlined,
    selectedIcon: Icons.sports_kabaddi,
  ),
  NavigationbarItem(
    label: '排行榜',
    icon: Icons.leaderboard_outlined,
    selectedIcon: Icons.leaderboard,
  ),
  NavigationbarItem(
    label: '海邦助手',
    badgeTitle: 'Demo',
    icon: Icons.support_agent_outlined,
    selectedIcon: Icons.support_agent,
  ),
  NavigationbarItem(
    label: '个人资料',
    icon: Icons.person_outline,
    selectedIcon: Icons.person,
  ),
];
