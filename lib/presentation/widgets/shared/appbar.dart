import 'package:flutter/material.dart';

class Appbar extends StatelessWidget {
  const Appbar({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: SizedBox(
          width: double.infinity,
          child: Row(
            children: [
              Image.asset('assets/images/icon/tripster.png'),
              const Spacer(),
              IconButton(
                onPressed: () {},
                icon: const Icon(Icons.search),
                color: colors.primary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
