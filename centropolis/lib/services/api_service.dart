import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import 'package:mime_type/mime_type.dart';
import 'package:mime/mime.dart';
import 'package:http_parser/http_parser.dart';

class WebService {
  static final WebService _webService = WebService._internal();

  factory WebService() {
    return _webService;
  }

  WebService._internal();

  Future<http.Response> callDeleteMethod(url, body, token) async {
    http.Response response;
    if (token != null) {
      response = await http.delete(Uri.parse(url),
          headers: <String, String>{
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'Authorization': 'Bearer $token'
          },
          body: json.encode(body));
    } else {
      response = await http.delete(Uri.parse(url),
          headers: <String, String>{
            'Content-type': 'application/json',
            'Accept': 'application/json'
          },
          body: json.encode(body));
    }

    log("Calling url::::: $url");

    return response;
  }

  Future<http.Response> callPostMethodWithRawData(
      url, body, language, token) async {
    log("Calling url::::: $url");
    String xApiKey = 'anE4ser6h1vIc2pM22weB02t02A2ipA8';

    http.Response response;
    if (token != null) {
      response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'token': token,
            'x-api-key': xApiKey,
            'Accept-language': language
          },
          body: json.encode(body));
    } else {
      response = await http.post(Uri.parse(url),
          headers: <String, String>{
            'Content-type': 'application/json',
            'Accept': 'application/json',
            'x-api-key': xApiKey,
            'Accept-language': language
          },
          body: json.encode(body));
    }

    return response;
  }

  Future<http.Response> callPostMethodWithMultipart(url, body, imageFile,
      imageFileKeyName, attachedFile, token, language) async {
    log("Calling url::::: $url");
    var request = http.MultipartRequest('POST', Uri.parse(url));
    String xApiKey = 'anE4ser6h1vIc2pM22weB02t02A2ipA8';

    if (token != null) {
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8;',
        'Accept': 'application/json',
        'token': token,
        'x-api-key': xApiKey,
        'Accept-language': language
      });
    } else {
      request.headers.addAll({
        'Content-Type': 'application/json; charset=UTF-8;',
        'Accept': 'application/json',
        'x-api-key': xApiKey,
        'Accept-language': language
      });
    }

    if (imageFile != null) {
      var mimeType = lookupMimeType(imageFile.path);
      var fileType = mimeType?.split('/');
      if (kDebugMode) {
        print(imageFile);
        print('file type $fileType');
        print(mimeType);
      }

      request.files.add(
        http.MultipartFile.fromBytes(
            imageFileKeyName, File(imageFile.path).readAsBytesSync(),
            filename: imageFile.path.split("/").last,
            contentType: MediaType.parse(mimeType!)),
      );
    }

    if (attachedFile != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
            'attachment', File(attachedFile.path).readAsBytesSync(),
            filename: attachedFile.path.split("/").last),
      );
    }
    if (body != null) {
      request.fields.addAll(body);
    }
    log("Calling url::::: $url");
    if (kDebugMode) {
      print(request);
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  Future<http.Response> callPostMethodWithMultipleImage(
      url, body, imageFile, imageFileKeyName, attachedFile, token) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8;',
      'Accept': 'application/json'
    });

    if (token != null) {
      request.headers.addAll({'Authorization': 'Bearer $token'});
    }
    // 'image/jpeg'
    if (imageFile != null) {
      //var fileType = mimeType?.split('/');

      for (var img in imageFile!) {
        var mimeType = lookupMimeType(img.path);
        request.files.add(
          http.MultipartFile.fromBytes(
              // 'image', File(imageFile.path).readAsBytesSync(),
              imageFileKeyName,
              File(img.path).readAsBytesSync(),
              filename: img.path.split("/").last,
              contentType: MediaType.parse(mimeType!)),
        );
      }

      // request.files
      //     .add(await http.MultipartFile.fromPath('image', imageFile.path));
      // request.files.add(
      //   http.MultipartFile.fromBytes(
      //       // 'image', File(imageFile.path).readAsBytesSync(),
      //       imageFileKeyName,
      //       File(imageFile.path).readAsBytesSync(),
      //       filename: imageFile.path.split("/").last,
      //       contentType: MediaType.parse(mimeType!)),
      // );
    }

    if (attachedFile != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
            'attachment', File(attachedFile.path).readAsBytesSync(),
            filename: attachedFile.path.split("/").last),
      );
    }
    if (body != null) {
      request.fields.addAll(body);
    }
    log("Calling url::::: $url");
    if (kDebugMode) {
      print(request);
    }

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    return response;
  }

  Future<http.Response> callGetMethod(url, token) {
    var uri = Uri.parse(url);
    Map<String, String> headers = {
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    };
    if (token != null) {
      headers['Authorization'] = 'Bearer $token';
    }
    log("Calling url::::: $uri");
    return http.get(uri, headers: headers);
  }

  Future<http.Response> callProfileUpdate(
      url, body, profileImage, bannerImage, token) async {
    var request = http.MultipartRequest('POST', Uri.parse(url));

    request.headers.addAll({
      'Content-Type': 'application/json; charset=UTF-8',
      'Accept': 'application/json'
    });

    if (token != null) {
      request.headers.addAll({'Authorization': 'Bearer $token'});
    }

    if (profileImage != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
            'profile_picture', File(profileImage.path).readAsBytesSync(),
            filename: profileImage.path.split("/").last),
      );
    }

    if (bannerImage != null) {
      request.files.add(
        http.MultipartFile.fromBytes(
            'banner_picture', File(bannerImage.path).readAsBytesSync(),
            filename: bannerImage.path.split("/").last),
      );
    }

    request.fields.addAll(body);

    log("Calling url::::: $url");

    var streamedResponse = await request.send();
    var response = await http.Response.fromStream(streamedResponse);
    return response;
  }
}
