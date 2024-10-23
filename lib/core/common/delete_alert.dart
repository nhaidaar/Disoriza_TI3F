import 'package:disoriza/core/common/colors.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class DeleteAlert extends StatefulWidget {
  final String titleMessage;
  final String? detailMessage;

  const DeleteAlert({
    super.key,
    required this.titleMessage,
    this.detailMessage,
  });

  @override
  // ignore: library_private_types_in_public_api
  _DeleteAlertState createState() => _DeleteAlertState();
}

class _DeleteAlertState extends State<DeleteAlert> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: neutral10, // Example background color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ), // Rounded corners
      title: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white, // Change to your desired color
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min, // Fit content
          children: [
            const SizedBox(height: 8),
            const Icon(IconsaxPlusLinear.trash,
                color: Colors.red, size: 24), // Trash can icon
            const SizedBox(height: 8),
            Text(
              widget.titleMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: neutral100, fontSize: 18), // Customize your text style
            ),
            const SizedBox(height: 8),
            if (widget.detailMessage !=
                null) // Display detail message if provided
              Text(
                widget.detailMessage!,
                textAlign: TextAlign.center,
                style: const TextStyle(
                    color: neutral90,
                    fontSize: 14), // Customize your text style
              ),
            const SizedBox(height: 16),
          ],
        ),
      ),
      actionsAlignment: MainAxisAlignment.center, // Center align buttons
      actions: [
        SizedBox(
          width: 120,
          height: 44,
          child: TextButton(
            style: TextButton.styleFrom(
              foregroundColor: neutral10, // Button text color
              backgroundColor: dangerMain,
            ),
            onPressed: () {
              // Perform delete action
              Navigator.of(context)
                  .pop(true); // Return true to indicate deletion
            },
            child: const Text("Ya, hapus", style: TextStyle(fontSize: 14)),
          ),
        ),
        SizedBox(
          width: 120,
          height: 44,
          child: TextButton(
            style: TextButton.styleFrom(
                foregroundColor: Colors.black,
                side: const BorderSide(color: neutral30, width: 1)),
            onPressed: () {
              Navigator.of(context)
                  .pop(false); // Return false to indicate cancellation
            },
            child: const Text("Batal", style: TextStyle(fontSize: 14)),
          ),
        ),
      ],
    );
  }
}
