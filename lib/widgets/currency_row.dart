import 'package:flutter/material.dart';

class CurrencyRow extends StatelessWidget {
  final String hintText;
  final Widget dropDownButton;
  final TextEditingController controller;
  const CurrencyRow(
      {super.key,
      required this.dropDownButton,
      required this.controller,
      required this.hintText});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          dropDownButton,
          Flexible(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: controller,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none
                  ),

                  fillColor: Colors.black12,
                  filled: true,
                  hintText: hintText,
                  hintStyle: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 15),
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
