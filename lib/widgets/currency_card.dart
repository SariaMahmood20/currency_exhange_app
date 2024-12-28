import 'package:flutter/material.dart';

import 'package:currency_exchange_app/constants/app_strings.dart';

class CurrencyCard extends StatelessWidget {
  final Widget toConvertRow;
  final Widget convertedRow;
  final Function onPressed;

  const CurrencyCard({
    super.key,
    required this.toConvertRow,
    required this.convertedRow,
    required this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(AppStrings.amount, style: const TextStyle(color: Colors.grey),),
            const SizedBox(height: 5),
            toConvertRow, 
            const SizedBox(height: 15),
            Stack(
              children: [
                // Divider placed at the bottom
                const Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: Divider()
                  ),

                // InkWell placed above the Divider
                Center(
                  child: InkWell(
                    onTap: () => onPressed(),
                    child: Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        color: Colors.blueAccent,
                      ),
                      child: const Center(
                        child: Icon(
                          Icons.currency_exchange_rounded,
                          size: 20,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),

            const SizedBox(height: 10),
            Text(AppStrings.convertedAmount, style: TextStyle(color: Colors.grey),),
            const SizedBox(height: 5),
            convertedRow, 
          ],
        ),
      ),
    );
  }
}
