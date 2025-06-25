import 'dart:convert';

import 'package:flutter/foundation.dart';

class DeviceListModel {
  List<Devices>? devices;
  DeviceListModel({this.devices});
  DeviceListModel copyWith({List<Devices>? devices}) {
    return DeviceListModel(devices: devices ?? this.devices);
  }

  Map<String, dynamic> toMap() {
    return {'devices': devices?.map((x) => x.toMap()).toList()};
  }

  factory DeviceListModel.fromMap(Map<String, dynamic> map) {
    return DeviceListModel(
      devices: List<Devices>.from(
        map['devices']?.map((x) => Devices.fromMap(x)),
      ),
    );
  }
  String toJson() => json.encode(toMap());
  factory DeviceListModel.fromJson(String source) =>
      DeviceListModel.fromMap(json.decode(source));
  @override
  String toString() => 'DeviceListModel(devices: $devices)';
  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is DeviceListModel && listEquals(other.devices, devices);
  }

  @override
  int get hashCode => devices.hashCode;
}

class Devices {
  int? id;
  String? deviceName;
  String? deviceIp;
  String? devicePort;
  String? syncInterval;
  String? lastSyncInterval;
  bool? isActive;
  String? createdDate;
  int? organizationId;
  Devices({
    this.id,
    this.deviceName,
    this.deviceIp,
    this.devicePort,
    this.syncInterval,
    this.lastSyncInterval,
    this.isActive,
    this.createdDate,
    this.organizationId,
  });
  Devices copyWith({
    int? id,
    String? deviceName,
    String? deviceIp,
    String? devicePort,
    String? syncInterval,
    String? lastSyncInterval,
    bool? isActive,
    String? createdDate,
    int? organizationId,
  }) {
    return Devices(
      id: id ?? this.id,
      deviceName: deviceName ?? this.deviceName,
      deviceIp: deviceIp ?? this.deviceIp,
      devicePort: devicePort ?? this.devicePort,
      syncInterval: syncInterval ?? this.syncInterval,
      lastSyncInterval: lastSyncInterval ?? this.lastSyncInterval,
      isActive: isActive ?? this.isActive,
      createdDate: createdDate ?? this.createdDate,
      organizationId: organizationId ?? this.organizationId,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'deviceName': deviceName,
      'deviceIp': deviceIp,
      'devicePort': devicePort,
      'syncInterval': syncInterval,
      'lastSyncInterval': lastSyncInterval,
      'isActive': isActive,
      'createdDate': createdDate,
      'organizationId': organizationId,
    };
  }

  factory Devices.fromMap(Map<String, dynamic> json) {
    return Devices(
      id: json['id'],
      deviceName: json['device_name'],
      deviceIp: json['device_ip'],
      devicePort: json['device_port'],
      syncInterval: json['sync_interval'],
      lastSyncInterval: json['last_sync_interval'],
      isActive: json['is_active'],
      createdDate: json['created_date'],
      organizationId: json['organization_id'],
    );
  }
  String toJson() => json.encode(toMap());
  factory Devices.fromJson(String source) =>
      Devices.fromMap(json.decode(source));
  @override
  String toString() {
    return 'Devices(id: $id, deviceName: $deviceName, deviceIp: $deviceIp, devicePort: $devicePort, syncInterval: $syncInterval, lastSyncInterval: $lastSyncInterval, isActive: $isActive, createdDate: $createdDate, organizationId: $organizationId)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Devices &&
        other.id == id &&
        other.deviceName == deviceName &&
        other.deviceIp == deviceIp &&
        other.devicePort == devicePort &&
        other.syncInterval == syncInterval &&
        other.lastSyncInterval == lastSyncInterval &&
        other.isActive == isActive &&
        other.createdDate == createdDate &&
        other.organizationId == organizationId;
  }

  @override
  int get hashCode {
    return id.hashCode ^
        deviceName.hashCode ^
        deviceIp.hashCode ^
        devicePort.hashCode ^
        syncInterval.hashCode ^
        lastSyncInterval.hashCode ^
        isActive.hashCode ^
        createdDate.hashCode ^
        organizationId.hashCode;
  }
}
