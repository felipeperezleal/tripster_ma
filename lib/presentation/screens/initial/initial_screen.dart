import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});
  static const name = 'initial-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _InitialScreen(),
    );
  }
}

class _InitialScreen extends StatelessWidget {
  const _InitialScreen();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final imageHeight = MediaQuery.of(context).size.height * 0.5;
    final padding = MediaQuery.of(context).size.width * 0.1;

    return SafeArea(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              Image.asset(
                'assets/images/icon/tripster.png',
                height: imageHeight,
              ),
              Text(
                'Hey! Welcome to Tripster',
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineMedium?.copyWith(
                  color: theme.colorScheme.primary,
                ),
              ),
              const SizedBox(height: 20),
              Text(
                'Where would you like to go?',
                textAlign: TextAlign.center,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.secondary,
                ),
              ),
              const Spacer(),
              _MainButton(
                text: 'Log In',
                color: theme.colorScheme.primary,
              ),
              const SizedBox(height: 10),
              _MainButton(
                text: 'Sign Up',
                color: theme.colorScheme.secondary,
              ),
              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}

class _MainButton extends StatelessWidget {
  final String text;
  final Color color;

  const _MainButton({
    required this.text,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return ElevatedButton(
      onPressed: () {
        if (text == 'Log In') {
          context.push('/login');
        } else if (text == 'Sign Up') {
          context.push('/register');
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 50),
        backgroundColor: colors.primary,
        foregroundColor: colors.onPrimary,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
      ),
      child: Text(text),
    );
  }
}
