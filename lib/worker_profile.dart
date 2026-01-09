import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class WorkerProfileScreen extends StatefulWidget {
  final Map<String, dynamic> worker;

  const WorkerProfileScreen({super.key, required this.worker});

  @override
  State<WorkerProfileScreen> createState() => _WorkerProfileScreenState();
}

class _WorkerProfileScreenState extends State<WorkerProfileScreen> {
  bool isPlaying = false;

  // Function to handle Calls
  Future<void> _makeCall(String number) async {
    final Uri url = Uri(scheme: 'tel', path: number);
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    }
  }

  // Function to handle WhatsApp
  Future<void> _openWhatsApp(String number) async {
    final Uri url = Uri.parse("https://wa.me/$number?text=Hello, I found you on BUILDQ!");
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String phone = widget.worker['phone'] ?? "1234567890";

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      extendBodyBehindAppBar: true,
      body: Column(
        children: [
          Container(
            height: 250,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.indigo.shade50,
              borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(50)),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(height: 40),
                const CircleAvatar(radius: 50, backgroundColor: Colors.indigo, child: Icon(Icons.person, size: 50, color: Colors.white)),
                const SizedBox(height: 10),
                Text(widget.worker['name'], style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("Professional ${widget.worker['category'] ?? 'Worker'}", style: const TextStyle(color: Colors.grey)),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Voice Introduction", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () => setState(() => isPlaying = !isPlaying),
                  child: Container(
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(color: isPlaying ? Colors.orange : Colors.indigo.shade700, borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      children: [
                        Icon(isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill, color: Colors.white, size: 40),
                        const SizedBox(width: 15),
                        Text(isPlaying ? "Playing..." : "Listen to Introduction", style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                const Text("Recent Work", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                const SizedBox(height: 10),
                SizedBox(
                  height: 120,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) => Container(
                      width: 120,
                      margin: const EdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: Colors.grey.shade200,
                        borderRadius: BorderRadius.circular(15),
                        image: const DecorationImage(image: NetworkImage("https://picsum.photos/200"), fit: BoxFit.cover),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: const BoxDecoration(color: Colors.white, boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)]),
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _makeCall(phone),
                    icon: const Icon(Icons.call, color: Colors.white),
                    label: const Text("Call Now", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.green, padding: const EdgeInsets.symmetric(vertical: 15)),
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: () => _openWhatsApp(phone),
                    icon: const Icon(Icons.message, color: Colors.white),
                    label: const Text("WhatsApp", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, padding: const EdgeInsets.symmetric(vertical: 15)),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}