import 'package:http/http.dart' as http;
import 'exceptions.dart';
import 'dart:convert';

dynamic returnResponse(http.Response response) {
  switch (response.statusCode) {
    case 200:
    case 201:
    case 204:
      var responseJson = json.decode(response.body);
      return responseJson;

    case 400:
      throw BadRequestException();

    case 401:
      throw Unauthorized();

    case 403:
      throw Forbidden();

    case 404:
      throw NotFoundException('');

    case 405:
      throw MethodNotAllowed('unknown');

    case 500:
      throw InternalServerError();

    default:
      throw HttpStatusException(response.statusCode,
          'Error occured while Communication with Server with StatusCode');
  }
}
