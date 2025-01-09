

import 'package:flutter/material.dart';

class DatePickerScreen extends StatefulWidget {
  const DatePickerScreen({Key? key}) : super(key: key);

  @override
  State<DatePickerScreen> createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {
  DateTimeRange? dateRange;
  bool showVehicles = false;

  final List<Map<String, dynamic>> vehicles = [
    //{"name": "Car", "image": "https://via.placeholder.com/150"},
  ];

  void _addBikeData() {
    vehicles.add({
      "name": "Bike",
      "image": null, 
    });
  }

  Future<void> _selectDateRange() async {
    final picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
      builder: (context, child) {
        return Theme(
          data: ThemeData.light().copyWith(
            primaryColor: Colors.teal,
            colorScheme: const ColorScheme.light(primary: Colors.teal),
            buttonTheme: const ButtonThemeData(textTheme: ButtonTextTheme.primary),
          ),
          child: child!,
        );
      },
    );
    if (picked != null) {
      setState(() {
        dateRange = picked;
      });
    }
  }

  void _submitData() {
    if (dateRange != null) {
      setState(() {
        showVehicles = true; 
        _addBikeData(); 
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Data Submitted Successfully!\n'
              'From: ${dateRange!.start.toString().split(' ')[0]} \n'
              'To: ${dateRange!.end.toString().split(' ')[0]}'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please select a date range!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
              "Pick Rental Dates",
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            // Date Picker Button
            Center(
              child: ElevatedButton(
                onPressed: _selectDateRange,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Select Date Range',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),
            const SizedBox(height: 20),

            // Display Selected Date Range
            if (dateRange != null)
              Text(
                "Selected Range: \nFrom: ${dateRange!.start.toString().split(' ')[0]} \nTo: ${dateRange!.end.toString().split(' ')[0]}",
                style: const TextStyle(fontSize: 16),
              ),
            const SizedBox(height: 20),

            // Submit Button with Validation
            Center(
              child: ElevatedButton(
                onPressed: _submitData,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                  backgroundColor: Colors.teal,
                ),
                child: const Text('Submit',
                    style: TextStyle(fontSize: 18, color: Colors.white)),
              ),
            ),

            const SizedBox(height: 30),

            // Show Vehicles After Submission
            if (showVehicles)
              Expanded(
                child: ListView.builder(
                  itemCount: vehicles.length,
                  itemBuilder: (context, index) {
                    return Card(
                      elevation: 3,
                      margin: const EdgeInsets.symmetric(vertical: 10),
                      child: ListTile(
                        leading: vehicles[index]["image"] != null
                            ? Image.network(vehicles[index]["image"]!)
                            : const Icon(Icons.directions_bike, size: 40, color: Colors.teal),
                        title: Text(vehicles[index]["name"]!,
                            style: const TextStyle(fontSize: 18)),
                      ),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
    );
  }
}
