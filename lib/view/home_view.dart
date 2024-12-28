import 'package:currency_exchange_app/constants/app_strings.dart';
import 'package:currency_exchange_app/widgets/currency_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:currency_exchange_app/view_model/currency_converter_view_model.dart';
import 'package:currency_exchange_app/services/response/status.dart';
import 'package:currency_exchange_app/widgets/drop_down_button_widget.dart';
import 'package:currency_exchange_app/widgets/currency_row.dart';

class HomeView extends StatefulWidget {
  const HomeView({super.key});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final toConvertController = TextEditingController();
  final convertedController = TextEditingController();
  final CurrencyConverterViewModel _currencyConverterViewModel =
      CurrencyConverterViewModel();
  @override
  void initState() {
    _currencyConverterViewModel.fetchCurrencies();
    print("Function Called");
  }

  @override
  void dispose() {
    super.dispose();
    toConvertController.dispose();
    convertedController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black12,
      body: Consumer<CurrencyConverterViewModel>(
          builder: (context, provider, child) {
        switch (provider.euros.status) {
          case Status.loading:
            return const Center(child: CircularProgressIndicator());
          case Status.failed:
            return const Center(
              child: Text("Failed to load data"),
            );
          case Status.completed:
            if (provider.currencyList.isEmpty) {
              provider.setCurrenciesList(provider.currencies.data!.currencies);
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    AppStrings.currencyConverter,
                    style: const TextStyle(
                        fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    AppStrings.checkLiveRates,
                    style: const TextStyle(fontSize: 16, color: Colors.black),
                  ),
                  const SizedBox(height: 45),
                  CurrencyCard(
                    toConvertRow: CurrencyRow(
                      hintText: '0.00',
                      dropDownButton: DropDownButtonWidget(
                        currencyNames: provider.currencyNamesList,
                        selectedItem:
                            provider.selectedCurrencyNameToConvert ??
                                "Select an item",
                        onPressed: (String? value) {
                          provider.setSelectedItem(value);
                          provider.findToConvertCode(value.toString());
                        },
                      ),
                      controller: toConvertController,
                    ),
                    convertedRow: CurrencyRow(
                      dropDownButton: DropDownButtonWidget(
                        currencyNames: provider.currencyNamesList,
                        selectedItem:
                            provider.selectedCurrencyNameConverted ??
                                "Select an item",
                        onPressed: (String? value) {
                          provider.setConvertedItem(value);
                          provider.findConvertedCode(value.toString());
                        },
                      ),
                      controller: convertedController,
                      hintText: provider.convertedAmount.toStringAsFixed(2),
                    ),
                    onPressed: () {provider.calculateConversion(toConvertController.text);},
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            );

          default:
            return Container(
              color: Colors.red,
            );
        }
      }),
    );
  }
}
