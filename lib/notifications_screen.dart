import 'package:flutter/material.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Dummy notification data
    final List<Map<String, String>> notifications = [
      {
        'title': 'Welcome to BuildQ!',
        'body': 'Find the best professionals for your home needs today.',
        'time': 'Just now',
        'type': 'info'
      },
      {
        'title': 'Profile Verified',
        'body': 'Your account is now fully active.',
        'time': '2 hours ago',
        'type': 'success'
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text("Notifications", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: notifications.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(15),
              itemCount: notifications.length,
              itemBuilder: (context, index) {
                final item = notifications[index];
                return Card(
                  margin: const EdgeInsets.only(bottom: 10),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: item['type'] == 'info' ? Colors.blue.shade50 : Colors.green.shade50,
                      child: Icon(
                        item['type'] == 'info' ? Icons.notifications : Icons.check_circle,
                        color: item['type'] == 'info' ? Colors.blue : Colors.green,
                      ),
                    ),
                    title: Text(item['title']!, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(item['body']!),
                    trailing: Text(item['time']!, style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  ),
                );
              },
            ),
    );
  }

  Widget _buildEmptyState() {
    return const Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.notifications_off_outlined, size: 80, color: Colors.grey),
          SizedBox(height: 10),
          Text("No new notifications", style: TextStyle(color: Colors.grey)),
        ],
      ),
    );
  }
}
