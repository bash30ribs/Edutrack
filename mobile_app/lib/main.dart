import 'package:flutter/material.dart';
import 'core/constants.dart';
import 'core/api_client.dart';
import 'screens/login_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  final apiClient = ApiClient();
  runApp(EduTrackMobileApp(apiClient: apiClient));
}

class EduTrackMobileApp extends StatelessWidget {
  final ApiClient apiClient;

  const EduTrackMobileApp({Key? key, required this.apiClient}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EduTrack Mobile',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.lightTheme,
      home: LoginScreen(apiClient: apiClient),
    );
  }
}
