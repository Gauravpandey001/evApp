import 'package:flutter/material.dart';
import 'charging_station.dart';

class ChargingStationDetails extends StatelessWidget {
  final ChargingStation station;

  ChargingStationDetails({required this.station});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(station.evseName),
        backgroundColor: Colors.white,
        elevation: 5, // Remove app bar shadow
        actions: [
          _buildHelpPill(context),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset(
                    'assets/station.png',
                    width: 300.0,
                    height: 300.0,
                  ),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Novotel Hotel',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          SizedBox(height: 4),
                          Row(
                            children: [
                              Icon(
                                Icons.location_on,
                                color: Colors.grey,
                                size: 20.0,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                '16 Dawson Street, New Plymouth Central,\nNew Plymouth 4310, USA · 1.4mi',
                                style: TextStyle(fontSize: 14, color: Colors.grey),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Icon and text defining the type of charger
                              Icon(
                                Icons.battery_charging_full,
                                color: Colors.green,
                                size: 20.0,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                _getTypeText(station.connectors[0].powerType),
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              ),
                              SizedBox(width: 8.0),
                              // Yellow pill type charging text
                              Container(
                                padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                                decoration: BoxDecoration(
                                  color: Colors.yellow,
                                  borderRadius: BorderRadius.circular(12.0),
                                ),
                                child: Text(
                                  'Charging',
                                  style: TextStyle(fontSize: 14, color: Colors.black),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              // Star icon with rating
                              Icon(
                                Icons.star,
                                color: Colors.grey,
                                size: 20.0,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                '4.5 (20)',
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              // Max Electric Power
                              Icon(
                                Icons.flash_on,
                                color: Colors.grey,
                                size: 20.0,
                              ),
                              SizedBox(width: 4.0),
                              Text(
                                '${station.connectors[0].maxElectricPower}W',
                                style: TextStyle(fontSize: 14, color: Colors.black),
                              ),
                            ],
                          ),
                          SizedBox(height: 8.0),
                          // Heading for the price per kW
                          Text(
                            '\$4.50/kW',
                            style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 8.0),
                          // Pill containers for navigate and share icons with text
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              _buildPillBox(Icons.navigate_before, 'Navigate'),
                              SizedBox(width: 16.0),
                              _buildPillBox(Icons.share, 'Share'),
                            ],
                          ),
                        ],
                      ),
                      Spacer(),
                      Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 30.0,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Divider(),
            Container(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // About section
                  Text(
                    'About',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'A 7-minute walk from the Wind Wand kinetic\nsculpture, this modest use',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  // Connectors info
                  Text('Connectors:'),
                  for (var connector in station.connectors)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('- Connector ID: ${connector.id}'),
                        Text('- Max Amperage: ${connector.maxAmperage}A'),
                        Text('- Standard: ${connector.standard}'),
                        Text('- Format: ${connector.format}'),
                        Text('- Min Amperage: ${connector.minAmperage}A'),
                        Text('- Max Voltage: ${connector.maxVoltage}V'),
                        Text(
                            '- Max Electric Power: ${connector.maxElectricPower}W'),
                        Text('- Power Type: ${_getTypeText(connector.powerType)}'),
                        Text('- Tariff IDs: ${connector.tariffIds.join(',')}'),
                        Text(
                            '- Connector Status: ${connector.connectorStatus}'),
                        SizedBox(height: 8),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        color: Colors.white,
        elevation: 3, // Remove bottom app bar shadow
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: 30.0, vertical: 8.0),
          child: ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              primary: Colors.blue,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.electric_car, color: Colors.white),
                SizedBox(width: 3.0),
                Text(
                  'Charge Here',
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _getTypeText(String powerType) {
    if (powerType == 'AC_1_PHASE') {
      return 'Type 1';
    } else if (powerType == 'AC_2_PHASE') {
      return 'Type 2';
    } else {
      return 'NA';
    }
  }

  Widget _buildHelpPill(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 16.0),
      child: ElevatedButton(
        onPressed: () {
          _showContactDetailsDialog(context);
        },
        style: ElevatedButton.styleFrom(
          primary: Colors.blue,
        ),
        child: Row(
          children: [
            Icon(Icons.help, color: Colors.white),
            SizedBox(width: 4.0),
            Text(
              'Help',
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPillBox(IconData icon, String label) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey,
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Row(
        children: [
          Icon(icon, color: Colors.black),
          SizedBox(width: 4.0),
          Text(
            label,
            style: TextStyle(color: Colors.black),
          ),
        ],
      ),
    );
  }

  void _showContactDetailsDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text("Contact Information"),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Call us at: 987654321'),
              Text('Mail us at: help@company.com'),
            ],
          ),
        );
      },
    );
  }
}
