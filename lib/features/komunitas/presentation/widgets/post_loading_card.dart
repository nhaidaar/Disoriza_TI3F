import 'package:card_loading/card_loading.dart';
import 'package:flutter/material.dart';

class PostLoadingCard extends StatelessWidget {
  const PostLoadingCard({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(
        5,
        (index) {
          return CardLoading(
            height: 170,
            margin: const EdgeInsets.only(bottom: 8),
            borderRadius: BorderRadius.circular(16),
          );
        },
      ),
    );
  }
}
