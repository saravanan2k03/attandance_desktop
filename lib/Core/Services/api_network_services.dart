import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:act/Core/Services/hive_services.dart';
import 'package:act/Core/Services/service_locator.dart';
import 'package:act/Core/Services/session_manager.dart';
import 'package:act/Core/Utils/urls.dart';
import 'package:act/Features/Auth/Bloc/bloc/login_bloc.dart';
import 'package:act/Features/Auth/Repository/auth_repo.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

Future<bool> refreshToken() async {
  String refreshTokenUrl =
      "${ApiConstants.baseUrl}${ApiConstants.refreshToken}";
  try {
    final url = Uri.parse(refreshTokenUrl);
    final session = SessionManagerClass();

    final AuthRepo authRepo = AuthRepo();
    final HiveServices hiveServices = HiveServices();
    //Token
    var token = await session.getRefreshToken();

    /// Params
    final params = {"refresh": token.toString().trim()};

    final response = await http.post(url, body: params);

    if (response.statusCode == 200) {
      var responsdata = jsonDecode(response.body);
      session.setAccessToken(responsdata['access']);
      return true;
    } else if (response.statusCode == 401) {
      getIt.get<LoginBloc>().add(LogOutEvent());
      return false;
    } else {
      throw HttpException('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching refreshToken: $e');
    }
    return false;
  }
}

Future<T> fetchApiData<T>(Uri url, T Function(String) fromJson) async {
  try {
    final session = SessionManagerClass();
    final token = await session.getAccessToken();

    final headers = {"Authorization": "Bearer $token"};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      // log(response.body);
      return fromJson(response.body);
    } else if (response.statusCode == 401) {
      var value = refreshToken();
      if (await value) {
        return fetchApiData(
          url,
          fromJson,
        ); // Recursive call after token refresh
      } else {
        throw HttpException('Failed to fetch token');
      }
    } else {
      throw HttpException('Failed to fetch data: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) {
      print('Error fetching data: $e');
    }
    throw Exception('Failed to fetch data: $e');
  }
}

Future<T> postApiData<T>(
  Uri url,
  Map<String, dynamic> body,
  T Function(String) fromJson,
) async {
  try {
    final session = SessionManagerClass();
    final token = await session.getAccessToken();

    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return fromJson(response.body);
    } else if (response.statusCode == 401) {
      var value = await refreshToken();
      if (value) {
        return postApiData(url, body, fromJson); // Retry
      } else {
        throw HttpException('Failed to fetch token');
      }
    } else {
      throw HttpException('POST failed: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) print('POST Error: $e');
    throw Exception('POST failed: $e');
  }
}

Future<T> loginApiData<T>(
  Uri url,
  Map<String, dynamic> body,
  T Function(String) fromJson,
) async {
  try {
    final headers = {"Content-Type": "application/json"};
    final session = SessionManagerClass();
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      var responsdata = jsonDecode(response.body);
      session.setAccessToken(responsdata['tokens']['access']);
      session.setRefreshToken(responsdata['tokens']['refresh']);
      return fromJson(response.body);
    } else if (response.statusCode == 401) {
      throw HttpException('Failed to login');
    } else {
      throw HttpException('POST failed: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) print('POST Error: $e');
    throw Exception('POST failed: $e');
  }
}

Future<T> postApiWithoutbearer<T>(
  Uri url,
  Map<String, dynamic> body,
  T Function(String) fromJson,
) async {
  try {
    final headers = {"Content-Type": "application/json"};
    final response = await http.post(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200 ||
        response.statusCode == 201 ||
        response.statusCode == 205) {
      return fromJson(response.body);
    } else if (response.statusCode == 401) {
      throw HttpException('Failed to $url');
    } else {
      throw HttpException('POST failed: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) print('POST Error: $e');
    throw Exception('POST failed: $e');
  }
}

Future<T> putApiData<T>(
  Uri url,
  Map<String, dynamic> body,
  T Function(String) fromJson,
) async {
  try {
    final session = SessionManagerClass();
    final token = await session.getAccessToken();

    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    final response = await http.put(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      log(response.body);
      return fromJson(response.body);
    } else if (response.statusCode == 401) {
      var value = await refreshToken();
      if (value) {
        return putApiData(url, body, fromJson);
      } else {
        throw HttpException('Failed to fetch token');
      }
    } else {
      throw HttpException('PUT failed: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) print('PUT Error: $e');
    throw Exception('PUT failed: $e');
  }
}

Future<T> patchApiData<T>(
  Uri url,
  Map<String, dynamic> body,
  T Function(String) fromJson,
) async {
  try {
    final session = SessionManagerClass();
    final token = await session.getAccessToken();

    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    final response = await http.patch(
      url,
      headers: headers,
      body: jsonEncode(body),
    );

    if (response.statusCode == 200) {
      return fromJson(response.body);
    } else if (response.statusCode == 401) {
      var value = await refreshToken();
      if (value) {
        return patchApiData(url, body, fromJson);
      } else {
        throw HttpException('Failed to fetch token');
      }
    } else {
      throw HttpException('PATCH failed: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) print('PATCH Error: $e');
    throw Exception('PATCH failed: $e');
  }
}

Future<bool> deleteApiData(Uri url) async {
  try {
    final session = SessionManagerClass();
    final token = await session.getAccessToken();

    final headers = {
      "Authorization": "Bearer $token",
      "Content-Type": "application/json",
    };

    final response = await http.delete(url, headers: headers);

    if (response.statusCode == 200 || response.statusCode == 204) {
      return true;
    } else if (response.statusCode == 401) {
      var value = await refreshToken();
      if (value) {
        return deleteApiData(url);
      } else {
        throw HttpException('Failed to fetch token');
      }
    } else {
      throw HttpException('DELETE failed: ${response.statusCode}');
    }
  } catch (e) {
    if (kDebugMode) print('DELETE Error: $e');
    throw Exception('DELETE failed: $e');
  }
}

Future<T> getApiData<T>(Uri url, T Function(String) fromJson) async {
  try {
    final headers = {"Content-Type": "application/json"};

    final response = await http.get(url, headers: headers);

    if (response.statusCode == 200) {
      return fromJson(response.body);
    } else {
      throw Exception("Failed: ${response.statusCode} - ${response.body}");
    }
  } catch (e) {
    throw Exception("GET request error: $e");
  }
}

Future<T> postApiDataWithImage<T>(
  Uri url,
  XFile? image,
  XFile? document,
  Map<String, dynamic> fields,
  T Function(String) fromJson,
) async {
  try {
    final session = SessionManagerClass();
    final token = await session.getAccessToken();

    var request = http.MultipartRequest("POST", url)
      ..headers["Authorization"] = "Bearer $token";

    fields.forEach((key, value) {
      request.fields[key] = value;
    });

    if (image != null) {
      if (kIsWeb) {
        final bytes = await image.readAsBytes();
        request.files.add(
          http.MultipartFile.fromBytes(
            'profile_pic',
            bytes,
            filename: 'profile.jpg',
            contentType: MediaType('image', 'jpeg'),
          ),
        );
      } else {
        request.files.add(
          await http.MultipartFile.fromPath(
            'profile_pic',
            image.path,
            contentType: MediaType.parse(
              lookupMimeType(image.path) ?? 'image/jpeg',
            ),
          ),
        );
      }
    }

    if (document != null) {
      request.files.add(
        await http.MultipartFile.fromPath(
          'document',
          document.path,
          contentType: MediaType.parse(
            lookupMimeType(document.path) ?? 'application/pdf',
          ),
        ),
      );
    }

    final streamedResponse = await request.send();
    final responseBody = await streamedResponse.stream.bytesToString();

    if (streamedResponse.statusCode == 200) {
      return fromJson(responseBody);
    } else {
      throw HttpException(
        'Failed: ${streamedResponse.statusCode} - $responseBody',
      );
    }
  } catch (e) {
    if (kDebugMode) print('Multipart POST Error: $e');
    throw Exception('POST with image failed: $e');
  }
}
