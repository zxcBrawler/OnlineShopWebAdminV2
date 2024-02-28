import 'package:flutter/material.dart';

class BasicIcon extends StatelessWidget {
  const BasicIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: IconButton(
        padding: EdgeInsets.zero,
        icon: const Icon(
          Icons.chevron_right,
          size: 40,
        ),
        onPressed: () {},
      ),
    );
  }
}
