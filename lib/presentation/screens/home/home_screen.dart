import 'package:flutter/material.dart';
import 'package:tripster_ma/presentation/widgets/widgets.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  static const name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(0, 50),
        child: Appbar(),
      ),
      body: Center(child: Text("Tripster home page")),
      bottomNavigationBar: BottomNavigation(),
    );
  }
}
