import 'package:flutter/material.dart';

class WorkerRegistrationScreen extends StatefulWidget {
  const WorkerRegistrationScreen({super.key});

  @override
  State<WorkerRegistrationScreen> createState() => _WorkerRegistrationScreenState();
}

class _WorkerRegistrationScreenState extends State<WorkerRegistrationScreen> {
  String? selectedCategory;
  final List<String> categories = ['Plumber', 'Mason', 'Electrician', 'Painter', 'Carpenter', 'Cleaner'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Register as a Professional")),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("What is your specialty?", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            DropdownButtonFormField<String>(
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)),
                filled: true, fillColor: Colors.grey[100],
              ),
              hint: const Text("Select Category"),
              items: categories.map((cat) => DropdownMenuItem(value: cat, child: Text(cat))).toList(),
              onChanged: (val) => setState(() => selectedCategory = val),
            ),
            const SizedBox(height: 20),
            const Text("Years of Experience", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              keyboardType: TextInputType.number,
              decoration: InputDecoration(hintText: "e.g. 5", border: UnderlineInputBorder()),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () { /* Save Data Logic */ },
                style: ElevatedButton.styleFrom(backgroundColor: Colors.indigo, padding: const EdgeInsets.all(15)),
                child: const Text("COMPLETE PROFILE", style: TextStyle(color: Colors.white)),
              ),
            )
          ],
        ),
      ),
    );
  }
}
