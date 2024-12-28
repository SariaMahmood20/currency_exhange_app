import 'package:currency_exchange_app/services/data/base_api_service.dart';
import 'package:currency_exchange_app/services/data/network_api_service.dart';
import 'package:currency_exchange_app/constants/api_endpoints.dart';
import 'package:currency_exchange_app/model/euro_currency_model.dart';
import 'package:currency_exchange_app/model/currency_model.dart';

class CurrencyConverterRepository{

  final BaseApiService _apiService = NetworkApiService();

  Future<EuroCurrencyModel> getEuroCurrencies()async{
    try{
      final response = await _apiService.getGetApiResponse(ApiEndpoints.euroUrl);
      // print(response);
      return EuroCurrencyModel.fromJson(response);
    }catch(e){
      rethrow;
    }
  }

  Future<CurrencyModel> getCoinCurrencies()async{
    try{
      final response = await _apiService.getGetApiResponse(ApiEndpoints.currencyUrl);
      print(response.toString()+"asjkhdsjkdfhsak");
      if(response is! Map<String, dynamic>){
        throw Exception("Saria nalla");
      }
      final currencyModel = CurrencyModel.fromJson(response);
      print(currencyModel.toString());
      return currencyModel;
    }catch(e){
      rethrow;
    }
  }

}