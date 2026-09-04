import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/constants.dart';
import '../core/api_client.dart';
import '../models/user.dart';
import 'dashboard_screen.dart';
import 'attendance_screen.dart';
import 'timetable_screen.dart';
import 'login_screen.dart';

class HomeScreen extends StatefulWidget {
  final User user;
  final ApiClient apiClient;

  const HomeScreen({Key? key, required this.user, required this.apiClient}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentIndex = 0;

  late final List<Widget> _screens;

  @override
  void initState() {
    super.initState();
    _screens = [
      DashboardScreen(
        user: widget.user,
        onNavigateToAttendance: () => setState(() => _currentIndex = 1),
      ),
      AttendanceScreen(apiClient: widget.apiClient),
      TimetableScreen(apiClient: widget.apiClient, user: widget.user),
      _buildProfileScreen(),
    ];
  }

  Widget _buildProfileScreen() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 36,
                  backgroundColor: AppColors.primary.withOpacity(0.2),
                  child: Text(
                    widget.user.displayName.isNotEmpty ? widget.user.displayName.substring(0, 1).toUpperCase() : 'U',
                    style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: AppColors.primary),
                  ),
                ),
                const SizedBox(height: 14),
                Text(
                  widget.user.displayName,
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.user.email,
                  style: const TextStyle(fontSize: 13, color: AppColors.textSecondary),
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    widget.user.role.toUpperCase(),
                    style: const TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.primary, letterSpacing: 1),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 20),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(LucideIcons.bell, color: AppColors.textSecondary, size: 20),
                  title: const Text('Push Notifications', style: TextStyle(fontSize: 14)),
                  trailing: Switch(
                    value: true,
                    onChanged: (v) {},
                    activeColor: AppColors.accentGreen,
                  ),
                ),
                const Divider(color: AppColors.border, height: 1),
                ListTile(
                  leading: const Icon(LucideIcons.shieldCheck, color: AppColors.textSecondary, size: 20),
                  title: const Text('Biometric Authentication', style: TextStyle(fontSize: 14)),
                  trailing: Switch(
                    value: true,
                    onChanged: (v) {},
                    activeColor: AppColors.primary,
                  ),
                ),
                const Divider(color: AppColors.border, height: 1),
                ListTile(
                  leading: const Icon(LucideIcons.logOut, color: AppColors.accentRose, size: 20),
                  title: const Text('Sign Out', style: TextStyle(fontSize: 14, color: AppColors.accentRose, fontWeight: FontWeight.w600)),
                  onTap: () async {
                    await widget.apiClient.logout();
                    if (!mounted) return;
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (_) => LoginScreen(apiClient: widget.apiClient)),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(LucideIcons.graduationCap, color: AppColors.primary, size: 20),
            ),
            const SizedBox(width: 10),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.user.displayName,
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: AppColors.textPrimary),
                ),
                Text(
                  widget.user.role.toUpperCase(),
                  style: const TextStyle(fontSize: 11, color: AppColors.accentGreen, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
      ),
      body: IndexedStack(
        index: _currentIndex,
        children: _screens,
      ),
      bottomNavigationBar: Container(
        decoration: const BoxDecoration(
          color: AppColors.surface,
          border: Border(top: BorderSide(color: AppColors.border, width: 1)),
        ),
        child: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: (index) => setState(() => _currentIndex = index),
          backgroundColor: Colors.transparent,
          elevation: 0,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: AppColors.accentGreen,
          unselectedItemColor: AppColors.textMuted,
          selectedFontSize: 12,
          unselectedFontSize: 12,
          items: const [
            BottomNavigationBarItem(icon: Icon(LucideIcons.home), label: 'Home'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.navigation), label: 'Attendance'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.calendar), label: 'Timetable'),
            BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profile'),
          ],
        ),
      ),
    );
  }
}
