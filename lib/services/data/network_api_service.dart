import 'dart:convert';
import 'dart:io';

import 'base_api_service.dart';
import 'package:http/http.dart' as http;
import 'package:currency_exchange_app/services/app_exceptions.dart';

class NetworkApiService extends BaseApiService{
  @override
  Future<dynamic> getGetApiResponse(String url) async{
    dynamic responseJson;
    try{
      final response = await http.get(Uri.parse(url));
      responseJson = returnResponse(response);
    }on SocketException{
      throw FetchBadRequestException();
    }
    return responseJson;
  }

  dynamic returnResponse(http.Response response){
    switch(response.statusCode){
      case 200:
        dynamic responseJson = jsonDecode(response.body);
        return responseJson;
      case 400:
        throw FetchBadRequestException();
      case 404:
        throw FetchUnauthorisedAccessException();
      default:
        throw FetchDataException();
    }
  }
  
}