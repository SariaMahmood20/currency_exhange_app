import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:currency_exchange_app/view_model/currency_converter_view_model.dart';
import 'package:currency_exchange_app/view/home_view.dart';

void main() {
  WidgetsFlutterBinding();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<CurrencyConverterViewModel>(create: (_)=>CurrencyConverterViewModel())
      ],
      child: MaterialApp(
        home: HomeView()
        ),
    );
  }
}
