import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import '../core/constants.dart';
import '../core/api_client.dart';
import '../models/user.dart';

class TimetableScreen extends StatefulWidget {
  final ApiClient apiClient;
  final User user;

  const TimetableScreen({Key? key, required this.apiClient, required this.user}) : super(key: key);

  @override
  State<TimetableScreen> createState() => _TimetableScreenState();
}

class _TimetableScreenState extends State<TimetableScreen> {
  final List<String> _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat'];
  int _selectedDayIndex = 0;
  bool _isLoading = false;
  List<dynamic> _classes = [];

  @override
  void initState() {
    super.initState();
    _fetchTimetable();
  }

  Future<void> _fetchTimetable() async {
    setState(() => _isLoading = true);
    try {
      final entries = await widget.apiClient.getTimetable(
        department: 'CSE',
        dayOfWeek: _days[_selectedDayIndex],
      );
      setState(() => _classes = entries);
    } catch (_) {
      // Fallback demo classes if network offline
      setState(() {
        _classes = [
          {
            'subject': 'Machine Learning Lab',
            'time': '10:30 AM - 12:30 PM',
            'room': 'Lab 402',
            'teacher': 'Dr. Anita Desai',
            'status': 'In Progress'
          },
          {
            'subject': 'Database Management Systems',
            'time': '01:30 PM - 02:30 PM',
            'room': 'Room 204',
            'teacher': 'Prof. Rajesh Sharma',
            'status': 'Upcoming'
          },
          {
            'subject': 'Cloud Computing & DevOps',
            'time': '02:45 PM - 04:00 PM',
            'room': 'Hall A',
            'teacher': 'Dr. Sarah Chen',
            'status': 'Upcoming'
          }
        ];
      });
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Day selector tabs
        Container(
          height: 50,
          margin: const EdgeInsets.symmetric(vertical: 12),
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: _days.length,
            itemBuilder: (context, index) {
              final isSelected = index == _selectedDayIndex;
              return GestureDetector(
                onTap: () {
                  setState(() => _selectedDayIndex = index);
                  _fetchTimetable();
                },
                child: Container(
                  margin: const EdgeInsets.only(right: 10),
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : AppColors.card,
                    borderRadius: BorderRadius.circular(14),
                    border: Border.all(color: isSelected ? AppColors.primary : AppColors.border),
                  ),
                  child: Center(
                    child: Text(
                      _days[index],
                      style: TextStyle(
                        color: isSelected ? Colors.white : AppColors.textSecondary,
                        fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),

        // Class list
        Expanded(
          child: _isLoading
              ? const Center(child: CircularProgressIndicator(color: AppColors.primary))
              : ListView.builder(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  itemCount: _classes.length,
                  itemBuilder: (context, index) {
                    final item = _classes[index];
                    final isLive = item['status'] == 'In Progress';

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: AppColors.card,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(color: isLive ? AppColors.accentGreen : AppColors.border),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: (isLive ? AppColors.accentGreen : AppColors.primary).withOpacity(0.15),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: Icon(
                              isLive ? LucideIcons.playCircle : LucideIcons.bookOpen,
                              color: isLive ? AppColors.accentGreen : AppColors.primary,
                              size: 22,
                            ),
                          ),
                          const SizedBox(width: 14),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        item['subject'] ?? 'Course',
                                        style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15, color: AppColors.textPrimary),
                                      ),
                                    ),
                                    if (isLive)
                                      Container(
                                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                                        decoration: BoxDecoration(
                                          color: AppColors.accentGreen.withOpacity(0.2),
                                          borderRadius: BorderRadius.circular(12),
                                        ),
                                        child: const Text('LIVE', style: TextStyle(color: AppColors.accentGreen, fontSize: 10, fontWeight: FontWeight.bold)),
                                      ),
                                  ],
                                ),
                                const SizedBox(height: 6),
                                Row(
                                  children: [
                                    const Icon(LucideIcons.clock, size: 13, color: AppColors.textMuted),
                                    const SizedBox(width: 4),
                                    Text(item['time'] ?? '10:00 AM', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                    const SizedBox(width: 12),
                                    const Icon(LucideIcons.mapPin, size: 13, color: AppColors.textMuted),
                                    const SizedBox(width: 4),
                                    Text(item['room'] ?? 'Room 101', style: const TextStyle(fontSize: 12, color: AppColors.textSecondary)),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  item['teacher'] ?? 'Faculty Member',
                                  style: const TextStyle(fontSize: 11, color: AppColors.textMuted),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
