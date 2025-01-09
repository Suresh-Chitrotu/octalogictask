
import 'package:flutter/material.dart';
import 'package:octalogictask/homescreen/wheelscreen.dart';

class VehicleTypeScreen extends StatelessWidget {
  const VehicleTypeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Map<String, dynamic>> vehicleTypes = [
      {"name": "Car", "icon": Icons.directions_car},
      {"name": "Bike", "icon": Icons.motorcycle},
      {"name": "Truck", "icon": Icons.local_shipping},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Vehicle Rental'),
        backgroundColor: Colors.teal,
        foregroundColor: Colors.white,
      ),
      body: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Select a Vehicle Type",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            Expanded(
              child: ListView.builder(
                itemCount: vehicleTypes.length,
                itemBuilder: (context, index) {
                  return Card(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    child: ListTile(
                      leading: Icon(vehicleTypes[index]["icon"], size: 30),
                      title: Text(
                        vehicleTypes[index]["name"],
                        style: const TextStyle(fontSize: 18),
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WheelsScreen(),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 20),
            Center(
              child: ElevatedButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.teal,
                ),
                child: const Text(
                  'Back',
                  style: TextStyle(fontSize: 18, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
