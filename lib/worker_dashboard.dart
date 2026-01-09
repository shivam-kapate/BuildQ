import 'package:flutter/material.dart';

class WorkerDashboard extends StatefulWidget {
  const WorkerDashboard({super.key});

  @override
  State<WorkerDashboard> createState() => _WorkerDashboardState();
}

class _WorkerDashboardState extends State<WorkerDashboard> {
  bool isOnline = true; // State for availability

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: isOnline ? const Color(0xFFF8F9FB) : Colors.grey[200],
      appBar: AppBar(
        title: const Text("My Dashboard", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
        actions: [
          // Availability Toggle
          Row(
            children: [
              Text(isOnline ? "ONLINE" : "OFFLINE", 
                style: TextStyle(color: isOnline ? Colors.green : Colors.red, fontWeight: FontWeight.bold, fontSize: 12)),
              Switch(
                value: isOnline,
                activeColor: Colors.green,
                onChanged: (val) {
                  setState(() => isOnline = val);
                },
              ),
            ],
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // 1. Status Banner
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: isOnline ? Colors.indigo : Colors.grey[700],
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  const CircleAvatar(radius: 30, backgroundColor: Colors.white, child: Icon(Icons.person, size: 35)),
                  const SizedBox(width: 15),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Welcome back, Ramesh!", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
                      Text(isOnline ? "You are visible to customers" : "You are currently hidden", 
                        style: TextStyle(color: Colors.white.withOpacity(0.8))),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 30),

            // 2. Quick Stats
            const Text("Performance", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildStatCard("Total Calls", "45", Icons.phone, Colors.blue),
                const SizedBox(width: 15),
                _buildStatCard("Rating", "4.8", Icons.star, Colors.orange),
              ],
            ),
            const SizedBox(height: 30),

            // 3. Profile Completion Tip
            if (isOnline) Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(color: Colors.orange.shade50, borderRadius: BorderRadius.circular(15), border: Border.all(color: Colors.orange.shade200)),
              child: const Row(
                children: [
                  Icon(Icons.lightbulb, color: Colors.orange),
                  SizedBox(width: 10),
                  Expanded(child: Text("Tip: Upload recent work photos to get 2x more calls!", style: TextStyle(fontSize: 13))),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String title, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(20), boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]),
        child: Column(
          children: [
            Icon(icon, color: color, size: 30),
            const SizedBox(height: 10),
            Text(value, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            Text(title, style: const TextStyle(color: Colors.grey, fontSize: 12)),
          ],
        ),
      ),
    );
  }
}