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
          children: [
            Text('Tripster home page'),
          ],
        ),
      ),
    );
  }
}
