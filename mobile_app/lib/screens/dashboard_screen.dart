import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/constants.dart';
import '../models/user.dart';

class DashboardScreen extends StatelessWidget {
  final User user;
  final VoidCallback onNavigateToAttendance;

  const DashboardScreen({
    Key? key,
    required this.user,
    required this.onNavigateToAttendance,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Geofence Quick Check-in Banner
          GestureDetector(
            onTap: onNavigateToAttendance,
            child: Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    AppColors.accentGreen.withOpacity(0.2),
                    AppColors.surface,
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: AppColors.accentGreen.withOpacity(0.4)),
              ),
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.accentGreen.withOpacity(0.2),
                    ),
                    child: const Icon(LucideIcons.fingerprint, color: AppColors.accentGreen, size: 28),
                  ),
                  const SizedBox(width: 14),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Campus Geofence Active',
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
                        ),
                        SizedBox(height: 2),
                        Text(
                          'Tap to scan biometric attendance now',
                          style: TextStyle(fontSize: 12, color: AppColors.textSecondary),
                        ),
                      ],
                    ),
                  ),
                  const Icon(LucideIcons.chevronRight, color: AppColors.accentGreen, size: 20),
                ],
              ),
            ),
          ),

          const SizedBox(height: 24),
          const Text('OVERVIEW METRICS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textMuted, letterSpacing: 1.2)),
          const SizedBox(height: 12),

          // 2x2 Metrics Grid
          GridView.count(
            crossAxisCount: 2,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisSpacing: 12,
            mainAxisSpacing: 12,
            childAspectRatio: 1.3,
            children: [
              _buildMetricCard(
                title: 'Attendance',
                value: '92.4%',
                subtext: '+2.1% this month',
                icon: LucideIcons.calendarCheck,
                color: AppColors.accentGreen,
              ),
              _buildMetricCard(
                title: 'Cumulative GPA',
                value: '8.8 / 10',
                subtext: 'Dean\'s Honor List',
                icon: LucideIcons.award,
                color: AppColors.primary,
              ),
              _buildMetricCard(
                title: 'Fee Status',
                value: 'Paid in Full',
                subtext: 'AY 2025-26 Term 1',
                icon: LucideIcons.creditCard,
                color: AppColors.accentGreen,
              ),
              _buildMetricCard(
                title: 'EWS Status',
                value: 'Safe Zone',
                subtext: '0 risk flags',
                icon: LucideIcons.shieldCheck,
                color: AppColors.secondary,
              ),
            ],
          ),

          const SizedBox(height: 24),
          const Text('NEXT CLASS', style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold, color: AppColors.textMuted, letterSpacing: 1.2)),
          const SizedBox(height: 12),

          // Next class card
          Container(
            padding: const EdgeInsets.all(18),
            decoration: BoxDecoration(
              color: AppColors.card,
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: AppColors.border),
            ),
            child: Row(
              children: [
                Container(
                  width: 4,
                  height: 48,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(4),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Machine Learning Lab', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16, color: AppColors.textPrimary)),
                      SizedBox(height: 4),
                      Text('10:30 AM • Lab 402 • Dr. Anita Desai', style: TextStyle(fontSize: 13, color: AppColors.textSecondary)),
                    ],
                  ),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.15),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Text('In 25 min', style: TextStyle(color: AppColors.primary, fontSize: 12, fontWeight: FontWeight.bold)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required String subtext,
    required IconData icon,
    required Color color,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.card,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title, style: const TextStyle(fontSize: 12, color: AppColors.textSecondary, fontWeight: FontWeight.w600)),
              Icon(icon, size: 18, color: color),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: TextStyle(fontSize: 20, fontWeight: FontWeight.w800, color: color)),
              const SizedBox(height: 2),
              Text(subtext, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
            ],
          ),
        ],
      ),
    );
  }
}
