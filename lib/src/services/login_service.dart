import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';

const baseURL = "http://IP:PORTA";

class LoginResponse {
  String message;
  int id;
}

void getUser() async {
  try {
    print('getting');
    Response response;
    response = await Dio().get('$baseURL/user');
    print(response.data);
  } catch (e) {
    print('erro mano');
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
