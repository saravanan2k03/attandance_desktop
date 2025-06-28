import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:act/Features/HrManagement/Bloc/DeviceBloc/device_bloc.dart';
import 'package:act/Features/HrManagement/Models/device_list_model.dart';
import 'package:act/Features/HrManagement/Repository/hr_repository.dart';
import 'package:act/Features/HrManagement/Widgets/add_or_update_device.dart';
import 'package:flutter/material.dart';
import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class DeviceInfoCard extends StatefulWidget {
  const DeviceInfoCard({super.key});

  @override
  State<DeviceInfoCard> createState() => _DeviceInfoCardState();
}

class _DeviceInfoCardState extends State<DeviceInfoCard> {
  final DeviceBloc deviceBloc = DeviceBloc();
  List<DataRow> buildDeviceDataRows(DeviceListModel deviceListModel) {
    return deviceListModel.devices?.map((device) {
          return DataRow(
            cells: [
              DataCell(Text(device.id?.toString() ?? '')),
              DataCell(Text(device.deviceName ?? '')),
              DataCell(
                Icon(
                  device.isActive == true ? Icons.check_circle : Icons.cancel,
                  color: device.isActive == true ? Colors.green : Colors.red,
                  size: 20,
                ),
              ),
              DataCell(
                InkWell(
                  onTap: () async {
                    final HrRepository hrRepository = HrRepository();
                    final session = SessionManagerClass();
                    await session.getlicence().then((value) async {
                      final result =
                          await DeviceDialogHelper.showUpdateDeviceDialog(
                            context,
                            licenseKey: value,
                            deviceId: device.id!,
                            initialDeviceName: device.deviceName!,
                            initialDeviceIp: device.deviceIp!,
                            initialLastSyncInterval: device.lastSyncInterval,
                            onSubmit: ({
                              required String licenseKey,
                              int? deviceId,
                              required String deviceName,
                              required String deviceIp,
                              String? lastSyncInterval,
                            }) {
                              return hrRepository.addOrUpdateDevice(
                                licenseKey: licenseKey,
                                deviceId: deviceId,
                                deviceName: deviceName,
                                deviceIp: deviceIp,
                                lastSyncInterval: lastSyncInterval,
                              );
                            },
                          );
                    });

                    /// call bloc
                  },
                  child: Icon(Icons.edit),
                ),
              ),
            ],
          );
        }).toList() ??
        [];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(07.sp),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        // spacing: 07.sp,
        children: [
          AppText.small(
            "Device Details",
            fontSize: 11.sp,
          ).withPadding(padding: EdgeInsets.all(07.sp)),
          Expanded(
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      color: commonColor,
                      borderRadius: BorderRadius.circular(05.sp),
                    ),
                    child: BlocConsumer<DeviceBloc, DeviceState>(
                      bloc: deviceBloc,
                      listener: (context, state) {},
                      builder: (context, state) {
                        if (state is DeviceDataState) {
                          return Column(
                            children: [
                              CustomTable(
                                datacolumns: [
                                  'Id',
                                  'deviceName',
                                  "isActive",
                                  "Action",
                                ],
                                dataRow: buildDeviceDataRows(state.modelData),
                              ),
                            ],
                          );
                        } else {
                          return Center(
                            child: AppText.small("No Data Available!"),
                          );
                        }
                      },
                    ),
                  ),
                ),
                07.height,
                InkWell(
                  onTap: () async {
                    final HrRepository hrRepository = HrRepository();
                    final session = SessionManagerClass();
                    await session.getlicence().then((value) async {
                      final result =
                          await DeviceDialogHelper.showAddDeviceDialog(
                            context,
                            licenseKey: value,
                            onSubmit: ({
                              required String licenseKey,
                              int? deviceId,
                              required String deviceName,
                              required String deviceIp,
                              String? lastSyncInterval,
                            }) {
                              return hrRepository.addOrUpdateDevice(
                                licenseKey: licenseKey,
                                deviceId: deviceId,
                                deviceName: deviceName,
                                deviceIp: deviceIp,
                                lastSyncInterval: lastSyncInterval,
                              );
                            },
                          );
                    });
                  },
                  child: Container(
                    height: 20.sp,
                    width: calcSize(context).longestSide,
                    decoration: BoxDecoration(
                      color: Colors.amber,
                      borderRadius: BorderRadius.circular(07.sp),
                    ),
                    child: Center(
                      child: AppText.small("Add Device", fontSize: 17),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ).withPadding(
        padding: EdgeInsets.symmetric(horizontal: 07.sp, vertical: 07.sp),
      ),
    );
  }
}
