import 'package:flutter/material.dart';
import 'worker_profile.dart'; // Ensure you have this file created

class WorkerListScreen extends StatelessWidget {
  final String category;

  // This matches the call from your main.dart
  const WorkerListScreen({super.key, required this.category});

  @override
  Widget build(BuildContext context) {
    // Simulated data based on the category clicked
    final List<Map<String, dynamic>> workers = [
      {
        'name': 'Rahul Sharma',
        'rating': '4.8',
        'phone': '9876543210',
        'experience': '8 Years',
        'category': category,
        'image': 'https://img.freepik.com/free-photo/plumber-working-client-s-home_23-2150990614.jpg',
      },
      {
        'name': 'Amit Patel',
        'rating': '4.5',
        'phone': '8877665544',
        'experience': '5 Years',
        'category': category,
        'image': 'https://img.freepik.com/free-photo/electrician-working-house-construction_23-2148767012.jpg',
      },
      {
        'name': 'Suresh Kumar',
        'rating': '4.9',
        'phone': '7766554433',
        'experience': '12 Years',
        'category': category,
        'image': 'https://img.freepik.com/free-photo/professional-cleaning-service-person-working_23-2150454568.jpg',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        title: Text("$category Experts", style: const TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
        elevation: 0,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Text(
              "Found ${workers.length} professionals near you",
              style: const TextStyle(color: Colors.grey, fontWeight: FontWeight.w500),
            ),
          ),
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              itemCount: workers.length,
              itemBuilder: (context, index) {
                final worker = workers[index];
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => WorkerProfileScreen(worker: worker),
                      ),
                    );
                  },
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withOpacity(0.05),
                          blurRadius: 10,
                          offset: const Offset(0, 5),
                        )
                      ],
                    ),
                    child: Row(
                      children: [
                        // Worker Image
                        ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            worker['image'],
                            width: 80,
                            height: 80,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) => Container(
                              width: 80, height: 80, color: Colors.grey[200],
                              child: const Icon(Icons.person, color: Colors.grey),
                            ),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // Worker Details
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                worker['name'],
                                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 5),
                              Text(
                                "${worker['experience']} Experience",
                                style: const TextStyle(color: Colors.grey, fontSize: 14),
                              ),
                              const SizedBox(height: 8),
                              Row(
                                children: [
                                  const Icon(Icons.star, color: Colors.orange, size: 18),
                                  Text(
                                    " ${worker['rating']}",
                                    style: const TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  const Spacer(),
                                  const Text(
                                    "View Profile",
                                    style: TextStyle(color: Colors.indigo, fontWeight: FontWeight.bold, fontSize: 12),
                                  ),
                                  const Icon(Icons.chevron_right, color: Colors.indigo, size: 16),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
