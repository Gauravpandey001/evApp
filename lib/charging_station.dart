import 'dart:convert';

class ChargingStation {
  final String evseName;
  final String status;
  final String powerType;
  final int maxElectricPower;
  final List<Connector> connectors;

  ChargingStation({
    required this.evseName,
    required this.status,
    required this.powerType,
    required this.maxElectricPower,
    required this.connectors,
  });
}

class Connector {
  final String id;
  final double maxAmperage;
  final String standard;
  final String format;
  final double minAmperage;
  final double maxVoltage;
  final int maxElectricPower;
  final String powerType;
  final List<String> tariffIds;
  final String connectorStatus;

  Connector({
    required this.id,
    required this.maxAmperage,
    required this.standard,
    required this.format,
    required this.minAmperage,
    required this.maxVoltage,
    required this.maxElectricPower,
    required this.powerType,
    required this.tariffIds,
    required this.connectorStatus,
  });
}