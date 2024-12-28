import 'package:flutter/material.dart';

import 'package:currency_exchange_app/model/euro_currency_model.dart';
import 'package:currency_exchange_app/model/currency_model.dart';
import 'package:currency_exchange_app/services/response/api_response.dart';
import 'package:currency_exchange_app/repository/currency_converter_repository.dart';

class CurrencyConverterViewModel extends ChangeNotifier {

  CurrencyConverterViewModel(){
    fetchEuroCurrencies();
    fetchCurrencies();
    
  }


  final _myRepo = CurrencyConverterRepository();

  ApiResponse<CurrencyModel> currencies = ApiResponse.loading();
  ApiResponse<EuroCurrencyModel> euros = ApiResponse.loading();

  List<MapEntry<String, String>> currencyList = [];

  List<String> currencyNamesList = [];
  List<String> currencyCodes = [];

  String? selectedCurrencyToConvert;
  String? selectedCurrencyNameToConvert;

  String? selectedCurrencyConverted;
  String? selectedCurrencyNameConverted;


  late double amountToConvert;

  double convertedAmount =0.0;

  get selectedItem => null;

  void setEuros(ApiResponse<EuroCurrencyModel> response) {
    euros = response;
    print("Euro response: ${response.toString()}");
    notifyListeners();
  }

  void setCurrencies(ApiResponse<CurrencyModel>response){
    currencies = response;
    print(currencies.data!.currencies.entries.first);
    notifyListeners();
  }

  Future<void> fetchEuroCurrencies() async {
    setEuros(ApiResponse.loading());
    try {
      final euroCurrencies = await _myRepo.getEuroCurrencies();
      setEuros(ApiResponse.completed(euroCurrencies));
    } catch (error, stackTrace) {
      print("Error fetching Euro currencies: $error");
      print("StackTrace: ${stackTrace}");
      setEuros(ApiResponse.failed());
    }
  }

  Future<void> fetchCurrencies() async {
    print("fetch Currencies Function Called!");
    _myRepo.getCoinCurrencies().then((value){
      print(value);
      setCurrencies(ApiResponse.completed(value));
      setCurrenciesList(value.currencies);
    }).onError((error, stackTrace){
      print("error:${error}");
      print("stackTrace:${stackTrace}");
      setCurrencies(ApiResponse.failed());
    });
  }

  void setCurrenciesList(Map<String, String> currencies){
    currencyList  = currencies.entries.toSet().toList();
    getCurrenciesNames();
    notifyListeners();
  }

  void getCurrenciesNames(){
    for(var currency in currencyList){
      currencyNamesList.add(currency.value);
    }
    notifyListeners();
  }

  void getCurrencies(){
    for(var currency in currencyList){
      currencyCodes.add(currency.key);
    }
    notifyListeners();
  }

  void setSelectedItem(String? item){
    selectedCurrencyNameToConvert = item;
    print(item);
    notifyListeners();
  }

  void setConvertedItem(String?item){
    selectedCurrencyNameConverted = item;
    print(item);
    notifyListeners();
  }

  void calculateConversion(String amount) {
  double? parsedAmount = double.tryParse(amount);

  // Check if the parsed amount is valid and other required variables are not null
  if (parsedAmount == null || parsedAmount <= 0 || selectedCurrencyToConvert == null || selectedCurrencyConverted == null) {
    return;
  }

  // Check if the selected currencies exist in the 'eur' map
  if (!euros.data!.eur.containsKey(selectedCurrencyToConvert!) ||
      !euros.data!.eur.containsKey(selectedCurrencyConverted!)) {
    return;
  }

  // Perform conversion to Euro
  double amountInEuro = parsedAmount / euros.data!.eur[selectedCurrencyToConvert!]!;
  print("Amount In Euro: $amountInEuro");

  // Convert the Euro amount to the target currency
  convertedAmount = amountInEuro * euros.data!.eur[selectedCurrencyConverted!]!;
  print("Amount Converted: $convertedAmount");

  // Notify listeners about the update
  notifyListeners();
}


  String? findToConvertCode(String currencyName){
    selectedCurrencyToConvert= currencyList.firstWhere((item)=> item.value == currencyName).key;
    print(selectedCurrencyToConvert);
    notifyListeners();
    return null;
  }

  String? findConvertedCode(String currencyName){
    selectedCurrencyConverted = currencyList.firstWhere((item)=>item.value == currencyName).key;
    print(selectedCurrencyConverted);
    notifyListeners();
    return null;
  }
}
