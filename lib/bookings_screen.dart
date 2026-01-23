import 'package:flutter/material.dart';

class BookingsScreen extends StatelessWidget {
  const BookingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // Simulated history of workers contacted
    final List<Map<String, dynamic>> bookingHistory = [
      {
        'name': 'Rahul Sharma',
        'category': 'Plumber',
        'date': '10 Jan 2026',
        'status': 'Completed',
        'price': '₹450',
        'icon': Icons.plumbing,
      },
      {
        'name': 'Amit Patel',
        'category': 'Electrician',
        'date': '05 Jan 2026',
        'status': 'Cancelled',
        'price': '₹0',
        'icon': Icons.bolt,
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: const Text("My Bookings", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: bookingHistory.isEmpty
          ? _buildEmptyState()
          : ListView.builder(
              padding: const EdgeInsets.all(20),
              itemCount: bookingHistory.length,
              itemBuilder: (context, index) {
                final booking = bookingHistory[index];
                return Container(
                  margin: const EdgeInsets.only(bottom: 15),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10)],
                  ),
                  child: Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.indigo.shade50,
                        child: Icon(booking['icon'], color: Colors.indigo),
                      ),
                      const SizedBox(width: 15),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(booking['name'], style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            Text("${booking['category']} • ${booking['date']}", style: const TextStyle(color: Colors.grey, fontSize: 12)),
                          ],
                        ),
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(booking['price'], style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.indigo)),
                          const SizedBox(height: 5),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: booking['status'] == 'Completed' ? Colors.green.shade50 : Colors.red.shade50,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: Text(
                              booking['status'],
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.bold,
                                color: booking['status'] == 'Completed' ? Colors.green : Colors.red,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
  Widget _buildEmptyState() {
    return const Center(
      child: Text("No history found"),
    );
  }
}
