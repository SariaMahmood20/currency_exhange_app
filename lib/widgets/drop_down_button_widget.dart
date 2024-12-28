import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';

class DropDownButtonWidget extends StatelessWidget {
  final List<String> currencyNames;
  final String selectedItem;
  final Function(String? selected) onPressed;
  const DropDownButtonWidget({super.key, required this.currencyNames, required this.selectedItem, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      child: DropdownButton2<String>(
        isExpanded: true,
        hint: Row(
          children: [
            const Icon(Icons.list, size: 16, color: Colors.black,),
            const SizedBox(width: 4,),
            Expanded(
              child: Text(
                selectedItem,
                style:const  TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  color: Colors.black
                ),
                overflow: TextOverflow.ellipsis,
              )
              )
          ],
        ),
        items: currencyNames.map((String item) => DropdownMenuItem(
          value: item,
          child: Text(
            item, 
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              color: Colors.grey
            ),
            overflow: TextOverflow.ellipsis,
            )
          )).toList(),
          value: currencyNames.contains(selectedItem)?selectedItem:null,
          onChanged:(String? value){onPressed(value);} ,
          buttonStyleData: ButtonStyleData(
            height: 40,
            width: 160,
            padding:const  EdgeInsets.symmetric(horizontal: 14),
            decoration: BoxDecoration(
                border: Border.all(color: Colors.black),
                borderRadius: BorderRadius.circular(14),
                color: Colors.white,
            ),
            elevation: 2,
          ),
          iconStyleData: const IconStyleData(
            icon: Icon(Icons.arrow_forward_ios_outlined,),
            iconSize: 14,
            iconEnabledColor: Colors.black,
            iconDisabledColor: Colors.grey
          ),
          dropdownStyleData: DropdownStyleData(
            maxHeight: 200,
            width: 200,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color:Colors.white
            ),
            offset: const Offset(-20, 0),
            scrollbarTheme:const ScrollbarThemeData(
              radius: Radius.circular(14),
              thumbVisibility: WidgetStatePropertyAll<bool>(true),
              thickness: WidgetStatePropertyAll<double>(6)
            ),
          ),
          menuItemStyleData: const MenuItemStyleData(
            height: 40,
            padding: EdgeInsets.symmetric(horizontal: 14),
          ),
      )
      );
  }
}