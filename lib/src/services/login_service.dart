import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:simon_game/src/models/usersReponse.dart';

const baseURL = "http://IP:PORTA";

class LoginResponse {
  String message;
  int id;
}

Future<dynamic> getUser() async {
  try {
    print('getting');
    Response response;
    response = await Dio().get('$baseURL/user');

    return response.data;
  } catch (e) {
    print('erro mano');
    return null;
  }
}

Future<int> login(String n, String p) async {
  try {
    print('getting $n $p');
    Response response;
    response = await Dio().post(
      '$baseURL/auth',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
      data: jsonEncode(<String, String>{'nick': n, 'password': p}),
    );
    return (response.data['id']);
  } catch (e) {
    throw e;
  }
}

void createUser(String n, String p) async {
  try {
    print('getting $n $p');
    Response response;
    response = await Dio().post(
      '$baseURL/user',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
      data: jsonEncode(<String, String>{'nick': n, 'password': p}),
    );
    print(response.data);
  } catch (e) {
    throw e;
  }
}

void postRecord(int id, int record) async {
  try {
    print('record $id $record');
    Response response;
    response = await Dio().put(
      '$baseURL/user',
      options: Options(
        headers: {
          HttpHeaders.contentTypeHeader: "application/json",
        },
      ),
      data: jsonEncode(<String, int>{'id': id, 'record': record}),
    );
    print(response.data);
  } catch (e) {
    throw e;
  }
}

Future<dynamic> getRecord(int id) async {
  try {
    print('getting');
    Response response;
    response = await Dio().get('$baseURL/record/$id');

    return response.data;
  } catch (e) {
    print('erro mano');
    return null;
  }
}
