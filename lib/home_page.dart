import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class ChargingStation {
  final String evseName;
  final String status;
  final String powerType;
  final int maxElectricPower;

  ChargingStation({
    required this.evseName,
    required this.status,
    required this.powerType,
    required this.maxElectricPower,
  });
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'EV Charging Stations',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late List<ChargingStation> _chargingStations;
  String mobileNumber = '123-456-7890'; // Replace with the actual mobile number

  @override
  void initState() {
    super.initState();
    _chargingStations = [];
    _fetchChargingStations();
  }

  Future<void> _fetchChargingStations() async {
    try {
      final response = await http.get(Uri.parse('https://mocki.io/v1/d86221e4-6755-4666-96ba-bf88b61a3cdc'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _chargingStations = data.map((station) {
            return ChargingStation(
              evseName: station['evse_name'] ?? 'NA',
              status: station['status'] ?? 'NA',
              powerType: _getPowerType(station['connectors'][0]['power_type']),
              maxElectricPower: station['connectors'][0]['max_electric_power'] ?? 0,
            );
          }).toList();
        });
      } else {
        print('Failed to load charging stations. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error loading charging stations: $e');
    }
  }

  String _getPowerType(String? powerType) {
    if (powerType == 'AC_1_PHASE') {
      return 'Type: 1';
    } else if (powerType == 'AC_2_PHASE') {
      return 'Type: 2';
    } else {
      return 'NA';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('EV Charging Stations'),
      ),
      body: _chargingStations.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
        itemCount: _chargingStations.length,
        itemBuilder: (context, index) {
          final station = _chargingStations[index];
          return Card(
            margin: EdgeInsets.all(8.0),
            child: ListTile(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChargingStationDetails(station: station),
                  ),
                );
              },
              leading: Image.asset('assets/charger.png', width: 48.0, height: 48.0),
              title: Text(station.evseName),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${station.powerType}'),
                  Text('Wattage: ${station.maxElectricPower}W'),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _buildStatusIndicator(station.status),
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomAppBar(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              icon: Icon(Icons.person),
              onPressed: () {
                _showProfileDialog(context, mobileNumber);
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatusIndicator(String status) {
    Color indicatorColor;
    switch (status.toLowerCase()) {
      case 'available':
        indicatorColor = Colors.green;
        break;
      case 'charging':
        indicatorColor = Colors.blue;
        break;
      case 'unavailable':
        indicatorColor = Colors.red;
        break;
      default:
        indicatorColor = Colors.grey;
    }

    return Container(
      padding: EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        color: indicatorColor,
        borderRadius: BorderRadius.circular(4.0),
      ),
    );
  }

  void _showProfileDialog(BuildContext context, String mobileNumber) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Profile'),
          content: Column(
            children: [
              Text('Mobile Number: $mobileNumber'),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  _logout();
                  Navigator.of(context).pop();
                },
                child: Text('Logout'),
              ),
            ],
          ),
        );
      },
    );
  }

  void _logout() async {
    // Perform logout logic...
    // For example, sign out the user from Firebase Auth

    // Navigate to the login screen
    await FirebaseAuth.instance.signOut();

  }
}

class ChargingStationDetails extends StatelessWidget {
  final ChargingStation station;

  ChargingStationDetails({required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(station.evseName),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Power Type: ${station.powerType}'),
            Text('Wattage: ${station.maxElectricPower}W'),
            Text('Status: ${station.status}'),
          ],
        ),
      ),
    );
  }
}
