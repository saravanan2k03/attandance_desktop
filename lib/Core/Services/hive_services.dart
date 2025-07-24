import 'package:hive/hive.dart';

class HiveServices {
  final String _boxName = "sreeBox";
  Future<Box> get _box async => await Hive.openBox(_boxName);
  //CREATE
  Future<void> createData(String key, dynamic value) async {
    var box = await _box;
    await box.put(key, value);
  }

  //READ
  Future readData(String key) async {
    var box = await _box;
    return await box.get(key);
  }

  //DELETE
  Future<void> deleteData(String key) async {
    var box = await _box;
    await box.delete(key);
  }

  //DELETE ALL THE DATA
  Future<void> deleteallData() async {
    var box = await _box;
    await box.clear();
  }


    Future<void> deleteAllExceptLicenceKey() async {
    var box = await _box;
    final allKeys = box.keys;

    for (var key in allKeys) {
      if (key != 'licencekey') {
        await box.delete(key);
      }
    }
  }
}
