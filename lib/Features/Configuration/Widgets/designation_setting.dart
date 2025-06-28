import 'package:act/Core/Constants/constant.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Utils/app_text.dart';
import 'package:act/Core/Utils/extension.dart';
import 'package:act/Features/Configuration/Bloc/ConfigurationBloc/configuration_bloc.dart';
import 'package:act/Features/Configuration/Constants/configuration_constants.dart';
import 'package:act/Features/Configuration/Models/designation_list_model.dart';
import 'package:act/Features/Configuration/Repository/configuration_repo.dart';
import 'package:act/Features/EmployeeManagement/Widgets/custom_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sizer/sizer.dart';

class SimpleTextDialog extends StatefulWidget {
  @override
  _SimpleTextDialogState createState() => _SimpleTextDialogState();
}

class _SimpleTextDialogState extends State<SimpleTextDialog> {
  final _textController = TextEditingController();

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Enter Text'),
      content: TextField(
        controller: _textController,
        decoration: InputDecoration(
          hintText: 'Type something...',
          border: OutlineInputBorder(),
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          child: Text('Submit'),
          onPressed: () {
            // Handle submit action
            final text = _textController.text;
            print('Submitted: $text');
            Navigator.of(context).pop(text);
          },
        ),
      ],
    );
  }
}

class DesignationSetting extends StatelessWidget {
  const DesignationSetting({super.key});

  @override
  Widget build(BuildContext context) {
    final ConfigurationBloc configurationBloc = ConfigurationBloc();
    final ConfigurationRepo configurationRepo = ConfigurationRepo();
    List<DataRow> getDesignationTableRows(
      DesingantionListModel designationModel,
    ) {
      return designationModel.designations?.map((designation) {
            return DataRow(
              cells: [
                DataCell(Text(designation.id?.toString() ?? "-")),
                DataCell(Text(designation.designationName ?? "-")),
                DataCell(
                  InkWell(
                    onTap: () {
                      showAddOrUpdateDesignationDialog(
                        title: "Designation",
                        context: context,
                        id: designation.id,
                        initialDesignation: designation.designationName,
                        onSubmit: (designationName, id) {
                          if (id != null) {
                            configurationRepo
                                .updateDesignationApi(id, designationName)
                                .whenComplete(() {
                                  configurationBloc.add(ListDesignation());
                                });
                          }
                        },
                      );
                    },
                    child: Icon(Icons.edit, color: Colors.black),
                  ),
                ),
                // DataCell(
                //   InkWell(
                //     onTap: () {
                //       showDeleteConfirmation(
                //         context: context,
                //         title: "Designation",
                //         name: designation.designationName ?? "",
                //         onConfirm: () {},
                //       );
                //     },
                //     child: Icon(Icons.delete, color: Colors.red),
                //   ),
                // ),
              ],
            );
          }).toList() ??
          [];
    }

    return Container(
      height: 70.sp,
      width: 60.sp,
      decoration: BoxDecoration(color: cardsColors),
      child: Column(
        children: [
          AppText.medium(
            "Designation Setting",
            fontSize: 14.sp,
            fontWeight: FontWeight.bold,
          ),
          07.sp.height,
          Expanded(
            child: Container(
              color: commonColor,
              child: Column(
                children: [
                  BlocConsumer<ConfigurationBloc, ConfigurationState>(
                    bloc: configurationBloc..add(ListDesignation()),
                    listener: (context, state) {},
                    builder: (context, state) {
                      if (state is DesigantionDataState) {
                        designation = state.modelData;
                        return CustomTable(
                          datacolumns: ['ID', 'Designation', 'Action'],
                          dataRow: getDesignationTableRows(designation),
                        );
                      } else {
                        return Center(child: Text("No Data Available!"));
                      }
                    },
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          showAddOrUpdateDesignationDialog(
                            title: "Designation",
                            context: context,
                            onSubmit: (designationName, id) async {
                              final session = SessionManagerClass();
                              await session.getlicence().then((value) {
                                configurationRepo
                                    .addDesignation(designationName, value)
                                    .whenComplete(() {
                                      configurationBloc.add(ListDesignation());
                                    });
                              });
                            },
                          );
                        },
                        child: Container(
                          height: 18.sp,
                          width: 40.sp,
                          decoration: BoxDecoration(
                            color: Colors.amber,
                            borderRadius: BorderRadius.circular(07.sp),
                          ),
                          child: Center(
                            child: AppText.small("Add", fontSize: 17),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ).withPadding(padding: EdgeInsets.all(07.sp)),
            ),
          ),
        ],
      ).withPadding(padding: EdgeInsets.all(07.sp)),
    );
  }
}
