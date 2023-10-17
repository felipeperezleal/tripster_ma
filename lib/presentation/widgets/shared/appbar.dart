import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              PopupMenuButton(
                onSelected: (value) {
                  if (value == 'logout') {
                    context.replace('/');
                  }
                },
                icon: Icon(Icons.person, color: colors.primary),
                itemBuilder: (BuildContext context) {
                  return [
                    const PopupMenuItem(
                      value: 'logout',
                      child: Text('Log Out'),
                    ),
                  ];
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
