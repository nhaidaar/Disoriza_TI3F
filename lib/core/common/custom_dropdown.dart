import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

import 'colors.dart';
import 'fontstyles.dart';

class CustomDropdown extends StatefulWidget {
  final List<String> items;
  final String initialValue;
  final Function(String) onChanged;

  const CustomDropdown({
    super.key,
    required this.items,
    required this.initialValue,
    required this.onChanged,
  });

  @override
  State<CustomDropdown> createState() => _CustomDropdownState();
}

class _CustomDropdownState extends State<CustomDropdown> {
  late String selectedValue;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.initialValue;
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      initialValue: selectedValue,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
        side: const BorderSide(color: neutral30),
      ),
      elevation: 0,
      position: PopupMenuPosition.under,

      // Do something when choice changed
      onSelected: (value) {
        setState(() => selectedValue = value);
        widget.onChanged(value);
      },

      itemBuilder: (context) {
        return widget.items.map((String item) {
          return PopupMenuItem(
            value: item,
            padding: const EdgeInsets.all(12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(item, style: mediumTS.copyWith(fontSize: 16, color: neutral100)),
                if (selectedValue == item) const Icon(Icons.check, size: 20),
              ],
            ),
          );
        }).toList();
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Text(
              selectedValue,
              style: mediumTS.copyWith(fontSize: 16, color: neutral100),
            ),
            const SizedBox(width: 4),
            const Icon(IconsaxPlusLinear.arrow_down, size: 20),
          ],
        ),
      ),
    );
  }
}
