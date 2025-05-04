import 'dart:developer';

import 'package:flutter/material.dart';
import 'notification_service.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final NotificationService _notificationService = NotificationService();
  int id = 0;
  @override
  void initState() {
    super.initState();
    _initializeNotifications();
  }

  Future<void> _initializeNotifications() async {
    await _notificationService.initialize();
  }

  Future<void> _scheduleNotification() async {
    id++;
    log('Scheduling Notification');
    try {
      await _notificationService.scheduleNotification(
        id: id,
        title: 'Scheduled Notification',
        body: 'This notification was scheduled 5 seconds ago!',
        scheduledDate: DateTime.now().add(const Duration(minutes: 5)),
      );
      log('Notification scheduled successfully');
    } catch (e) {
      log('Error scheduling notification: $e');
    }
  }

  Future<void> _showImmediateNotification() async {
    try {
      await _notificationService.showNotification(
        id: 1,
        title: 'Immediate Notification',
        body: 'This is an immediate notification!',
      );
      log('Immediate notification shown');
    } catch (e) {
      log('Error showing notification: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification Demo'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: _scheduleNotification,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text(
                'Schedule Notification',
                style: TextStyle(fontSize: 18),
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _showImmediateNotification,
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 32,
                  vertical: 16,
                ),
              ),
              child: const Text(
                'Show Immediate Notification',
                style: TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
