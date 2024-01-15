import 'dart:convert';
import 'package:evapp/charging_station.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:http/http.dart' as http;

final chargingStationsProvider = FutureProvider<List<ChargingStation>>((ref) async {
  final response = await http.get(
      Uri.parse('https://mocki.io/v1/d86221e4-6755-4666-96ba-bf88b61a3cdc'));

  if (response.statusCode == 200) {
    final List<dynamic> data = json.decode(response.body);
    return data.map((station) {
      return ChargingStation(
        evseName: station['evse_name'] ?? 'NA',
        status: station['status'] ?? 'NA',
        powerType: _getPowerType(station['connectors'][0]['power_type']),
        maxElectricPower: station['connectors'][0]['max_electric_power'] ?? 0,
        connectors: _parseConnectors(station['connectors']),
      );
    }).toList();
  } else {
    throw Exception('Failed to load charging stations');
  }
});

String _getPowerType(String? powerType) {
  if (powerType == 'AC_1_PHASE') {
    return 'Type: 1';
  } else if (powerType == 'AC_2_PHASE') {
    return 'Type: 2';
  } else {
    return 'NA';
  }
}

List<Connector> _parseConnectors(List<dynamic> connectorsData) {
  return connectorsData.map((connector) {
    return Connector(
      id: connector['id'] ?? 'NA',
      maxAmperage: connector['max_amperage']?.toDouble() ?? 0.0,
      standard: connector['standard'] ?? 'NA',
      format: connector['format'] ?? 'NA',
      minAmperage: connector['min_amperage']?.toDouble() ?? 0.0,
      maxVoltage: connector['max_voltage']?.toDouble() ?? 0.0,
      maxElectricPower: connector['max_electric_power'] ?? 0,
      powerType: connector['power_type'] ?? 'NA',
      tariffIds: List<String>.from(connector['tariff_ids'] ?? []),
      connectorStatus: connector['status'] ?? 'NA',
    );
  }).toList();
}
