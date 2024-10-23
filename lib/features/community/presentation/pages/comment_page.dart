import 'package:disoriza/core/common/colors.dart';
import 'package:disoriza/features/community/presentation/widgets/post_card.dart';
import 'package:flutter/material.dart';
import 'package:iconsax_plus/iconsax_plus.dart';

class CommentPage extends StatefulWidget {
  const CommentPage({super.key});

  @override
  State<CommentPage> createState() => _CommentPageState();
}

const List<String> filterMenu = <String>['Terbaru', 'Terpopuler'];

class _CommentPageState extends State<CommentPage> {
  String dropdownValue = filterMenu.first;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(8),
        child: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16), color: neutral10),
          child: Column(
            children: [
              PostCard(),
              Row(
                children: [
                  Text('Komentar'),
                  DropdownButton(
                    value: dropdownValue,
                    icon: Icon(IconsaxPlusLinear.arrow_down),
                    onChanged: (String? value) {
                      setState(() {
                        dropdownValue = value!;
                      });
                    },
                    items: filterMenu.map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
