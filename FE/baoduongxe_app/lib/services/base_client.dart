import 'dart:convert';

import 'package:baoduongxe_app/model/accessary.dart';
import 'package:baoduongxe_app/model/vehicle.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

import '../model/user.dart';

const String baseUrl = 'https://localhost:44337/api';

class BaseClient {
  var client = http.Client();

  //GET
  Future<dynamic> get(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'F0v2ilKKIQvJAoEsrnX74h4aylpKuce0',
    };

    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
      throw Exception('Request API error!');
    }
  }
  //POST
  Future<dynamic> post(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'F0v2ilKKIQvJAoEsrnX74h4aylpKuce0',
    };

    var response = await client.post(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      return response.body;
    } else {
      //throw exception and catch it in UI
      throw Exception('Request API error!');
    }
  }

  //PUT Request
  Future<dynamic> put(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'F0v2ilKKIQvJAoEsrnX74h4aylpKuce0',
    };

    var response = await client.put(url, body: _payload, headers: _headers);
    if (response.statusCode == 204) {
      return response.body;
    } else {
      //throw exception and catch it in UI
      throw Exception('Request API error!');
    }
  }

  //DELETE
  Future<dynamic> delete(String api) async {
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'F0v2ilKKIQvJAoEsrnX74h4aylpKuce0',
    };

    var response = await client.delete(url, headers: _headers);
    if (response.statusCode == 204) {
      return response.body;
    } else {
      //throw exception and catch it in UI
      throw Exception('Request API error!');
    }
  }

  void login(String api, dynamic object) async {
    var url = Uri.parse(baseUrl + api);
    var _payload = json.encode(object);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'Content-Type': 'application/json',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };

    var response = await client.post(url, body: _payload, headers: _headers);
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      print(data['token']);
      print('Login success!');
    } else {
      //throw exception and catch it in UI
      throw Exception('Request API error!');
    }
  }

  Future<List<User>> fetchUsers(String api) async{
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };
    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return userFromJson(response.body);
    } else {
      //throw exception and catch it in UI
      throw Exception('Request API error!');
    }
  }

  Future<List<Vehicle>> fetchVehicles(String api) async{
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };
    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return vehicleFromJson(response.body);
    } else {
      //throw exception and catch it in UI
      throw Exception('Request API error!');
    }
  }

  Future<List<Accessary>> fetchAccessaries(String api) async{
    var url = Uri.parse(baseUrl + api);
    var _headers = {
      'Authorization': 'Bearer sfie328370428387=',
      'api_key': 'ief873fj38uf38uf83u839898989',
    };
    var response = await client.get(url, headers: _headers);
    if (response.statusCode == 200) {
      return accessaryFromJson(response.body);
    } else {
      //throw exception and catch it in UI
      throw Exception('Request API error!');
    }
  }


  Future<List> getPosts(String api) async {
    try {
      var response = await http.get(Uri.parse(baseUrl + api));
      if (response.statusCode == 200) {
        // return a decoded body
        return jsonDecode(response.body);
      } else {
        // server error
        return Future.error("Server Error !");
      }
    } catch (SocketException) {
      // fetching error
      // may be timeout, no internet or dns not resolved
      return Future.error("Error Fetching Data !");
    }
  }

  Future<String> createPost(Map<String, dynamic> data,String api) async {
    try {
      var response = await http.post(
        Uri.parse(baseUrl + api),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 200) {
        return "success";
      } else {
        print(response.body);
        // server error
        return "err";
      }
    } catch (SocketException) {
      // fetching error
      return "err";
    }
  }

  Future<String> editPost(Map<String, dynamic> data,String api) async {
    try {
      var response = await http.put(
        Uri.parse(baseUrl + api),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      if (response.statusCode == 204) {
        return "success";
      } else {
        print(response.body);
        // server error
        return "err";
      }
    } catch (SocketException) {
      // fetching error
      return "err";
    }
  }

  Future<String> deletePost(Map<String, dynamic> data, String api) async {
    try {
      var response = await http.delete(
        Uri.parse(baseUrl + api),
        body: jsonEncode(data),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
        },
      );
      //
      if (response.statusCode == 204) {
        return "success";
      } else {
        print(response.body);
        // server error
        return "err";
      }
    } catch (SocketException) {
      // fetching error
      return "err";
    }
  }
}
