import 'package:flutter/material.dart';
import 'worker_list.dart' show WorkerListScreen;
import 'worker_dashboard.dart' show WorkerDashboard;
import 'location_service.dart'; // Ensure this file exists in your lib folder

void main() {
  runApp(const BuildQApp());
}

class BuildQApp extends StatelessWidget {
  const BuildQApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.indigo,
        fontFamily: 'Poppins',
      ),
      home: const LoginScreen(),
    );
  }
}

// --- 1. LOGIN SCREEN ---
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _phoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 100),
              const Center(
                child: Text("BUILDQ", 
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold, letterSpacing: 4, color: Colors.indigo)
                )
              ),
              const SizedBox(height: 50),
              const Text("Welcome!", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Text("Enter phone number to continue", style: TextStyle(color: Colors.grey)),
              const SizedBox(height: 30),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: const Color(0xFFF8F9FB),
                  borderRadius: BorderRadius.circular(15),
                  border: Border.all(color: Colors.indigo.withOpacity(0.1)),
                ),
                child: TextField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.phone, color: Colors.indigo), 
                    hintText: "Phone Number", 
                    border: InputBorder.none
                  ),
                ),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_phoneController.text.length >= 10) {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => OTPScreen(phoneNumber: _phoneController.text)),
                      );
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.indigo, 
                    padding: const EdgeInsets.symmetric(vertical: 15), 
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                  ),
                  child: const Text("GET OTP", style: TextStyle(fontSize: 16, color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// --- 2. OTP SCREEN ---
class OTPScreen extends StatelessWidget {
  final String phoneNumber;
  const OTPScreen({super.key, required this.phoneNumber});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(backgroundColor: Colors.white, elevation: 0, iconTheme: const IconThemeData(color: Colors.black)),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Verify Phone", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
            Text("Code sent to $phoneNumber", style: const TextStyle(color: Colors.grey)),
            const SizedBox(height: 40),
            const Text("Please enter 4-digit code", style: TextStyle(fontSize: 14)),
            const SizedBox(height: 40),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const HomePage())),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.indigo, 
                  padding: const EdgeInsets.symmetric(vertical: 15), 
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15))
                ),
                child: const Text("VERIFY & CONTINUE", style: TextStyle(color: Colors.white)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// --- 3. HOME PAGE ---
class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String userCity = "Detecting...";
  final List<Map<String, dynamic>> allCategories = [
    {'name': 'Plumber', 'icon': Icons.plumbing, 'color': Colors.blue},
    {'name': 'Mason', 'icon': Icons.foundation, 'color': Colors.orange},
    {'name': 'Electrician', 'icon': Icons.bolt, 'color': Colors.yellow.shade700},
    {'name': 'Painter', 'icon': Icons.format_paint, 'color': Colors.pink},
    {'name': 'Carpenter', 'icon': Icons.handyman, 'color': Colors.brown},
    {'name': 'Cleaner', 'icon': Icons.cleaning_services, 'color': Colors.green},
  ];

  late List<Map<String, dynamic>> filteredCategories;

  @override
  void initState() {
    super.initState();
    filteredCategories = allCategories;
    _loadLocation();
  }

  _loadLocation() async {
    String city = await LocationService.getCurrentCity();
    if (mounted) {
      setState(() {
        userCity = city;
      });
    }
  }

  void _filter(String query) {
    setState(() {
      filteredCategories = allCategories
          .where((cat) => cat['name'].toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8F9FB),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: GestureDetector(
          onTap: () => _loadLocation(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Location", style: TextStyle(fontSize: 10, color: Colors.grey)),
              Row(
                children: [
                  const Icon(Icons.location_on, color: Colors.indigo, size: 16),
                  const SizedBox(width: 4),
                  Text(userCity, style: const TextStyle(fontSize: 14, color: Colors.black, fontWeight: FontWeight.bold)),
                  const Icon(Icons.keyboard_arrow_down, color: Colors.black, size: 16),
                ],
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.engineering, color: Colors.indigo), 
            onPressed: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const WorkerDashboard()))
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("Find a Pro,", style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold)),
              const Text("Quality Skills, Quick Connections", style: TextStyle(fontSize: 16, color: Colors.grey)),
              const SizedBox(height: 25),
              
              // Search Bar
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                decoration: BoxDecoration(
                  color: Colors.white, 
                  borderRadius: BorderRadius.circular(15), 
                  boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 10)]
                ),
                child: TextField(
                  onChanged: _filter,
                  decoration: const InputDecoration(
                    icon: Icon(Icons.search, color: Colors.indigo), 
                    hintText: "Search for a worker...", 
                    border: InputBorder.none
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              const Text("Categories", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
              const SizedBox(height: 15),

              // Categories Grid
              filteredCategories.isEmpty 
              ? const Center(child: Padding(
                  padding: EdgeInsets.only(top: 20),
                  child: Text("No pro found in this category"),
                ))
              : GridView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, 
                    crossAxisSpacing: 15, 
                    mainAxisSpacing: 15, 
                    childAspectRatio: 1.1
                  ),
                  itemCount: filteredCategories.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () => Navigator.push(
                        context, 
                        MaterialPageRoute(builder: (context) => WorkerListScreen(category: filteredCategories[index]['name']))
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white, 
                          borderRadius: BorderRadius.circular(20), 
                          border: Border.all(color: Colors.black.withOpacity(0.05))
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(filteredCategories[index]['icon'], size: 40, color: filteredCategories[index]['color']),
                            const SizedBox(height: 10),
                            Text(filteredCategories[index]['name'], style: const TextStyle(fontWeight: FontWeight.w600)),
                          ],
                        ),
                      ),
                    );
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}