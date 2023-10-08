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
    final imageHeight = MediaQuery.of(context).size.height * 0.6;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            'assets/images/icon/tripster.png',
            fit: BoxFit.contain,
            height: imageHeight,
          ),
          const _MainButton(
            text: 'Log In',
          ),
          const SizedBox(height: 10),
          const _MainButton(
            text: 'Sign Up',
          ),
        ],
      ),
    );
  }
}

class _MainButton extends StatelessWidget {
  final String text;

  const _MainButton({
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return FilledButton(
      onPressed: () {
        if (text == 'Log In') {
          context.push('/login');
        } else if (text == 'Sign Up') {
          context.push('/register');
        }
      },
      style: ElevatedButton.styleFrom(
        minimumSize: const Size(200, 50),
      ),
      child: Text(text),
    );
  }
}
