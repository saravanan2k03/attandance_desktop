import 'package:act/Core/Data/Models/licence_model.dart';
import 'package:act/Core/Services/api_network_services.dart';
import 'package:act/Core/Utils/urls.dart';

class LicenseRepo {
  Future<LicenseStatusModel> checkLicenseStatus(String licenseKey) async {
    final uri = Uri.parse(
      "${ApiConstants.baseUrl}license/check/?license_key=$licenseKey",
    );

    return await getApiData<LicenseStatusModel>(
      uri,
      LicenseStatusModel.fromJson,
    );
  }
}
