import 'package:flutter/material.dart';
import 'package:tripster_ma/presentation/screens/screens.dart';
import 'package:tripster_ma/presentation/widgets/widgets.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});
  static const name = 'home-screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size(
          MediaQuery.of(context).size.width,
          MediaQuery.of(context).size.height * 0.1,
        ),
        child: const Appbar(),
      ),
      body: _buildContent(_selectedIndex),
      bottomNavigationBar: BottomNavigation(
          selectedIndex: _selectedIndex, onItemTapped: _onItemTapped),
    );
  }

  Widget _buildContent(int index) {
    switch (index) {
      case 0:
        return const _HomePage();
      case 1:
        return const SearchScreen();
      case 2:
        return const BookingScreen();
      case 3:
        return const ProfileScreen();
      default:
        return const _HomePage();
    }
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage();

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Where would you like to go today?',
              style: TextStyle(
                fontSize: 24,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Text(
              'Tripster is an application that provides the best travel options based on your flight preferences. Whether your interest is in finding the most affordable flight, reaching a destination quickly, or comparing offers from different airlines, Tripster makes it possible.',
              style: TextStyle(
                fontSize: 16,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
