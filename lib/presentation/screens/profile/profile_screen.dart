import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});
  static const name = '/profile-screen';

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('My Profile'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(flex: 2),
            CircleAvatar(
              radius: 50,
              backgroundColor: colors.primary,
              child: Icon(
                Icons.person,
                size: 50,
                color: colors.onPrimary,
              ),
            ),
            const Spacer(),
            Text(
              'Username',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'user@mail.com',
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                'Hey, this is my profile',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            ),
            const Spacer(flex: 3),
            ElevatedButton(
              onPressed: () {
                context.replace('/');
              },
              child: const Text('Sign Out'),
            ),
            const Spacer(flex: 2),
          ],
        ),
      ),
    );
  }
}
