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
      case 4:
        return const FlightsCRUD();
      default:
        return const _HomePage();
    }
  }
}

class _HomePage extends StatelessWidget {
  const _HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final screenHeight = MediaQuery.of(context).size.height;

    final List<String> imageList = [
      'https://media.istockphoto.com/id/488381656/es/foto/tome-la-salida-de-avión.jpg?s=170667a&w=0&k=20&c=KhctOp64GTb1nFflRDv93J9-goG2NjcEd8gPXWOACQ4=',
      'https://media.istockphoto.com/id/486836087/photo/business-travel.jpg?s=612x612&w=0&k=20&c=B2jcARGGKEQBsc4sl9unuKd9FlkjUkl3jD6MsXYH5Ac=',
    ];

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: screenHeight),
            child: IntrinsicHeight(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Spacer(),
                    Text(
                      'Ready for your next adventure?',
                      style: TextStyle(
                        fontSize: 28,
                        color: colors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 24),
                    SizedBox(
                      height: screenHeight * 0.4,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8.0),
                        child: Image.network(
                          imageList[0],
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      'Discover new destinations and explore the world with Tripster. Find the best travel options tailored to your preferences.',
                      style: TextStyle(
                        fontSize: 16,
                        height: 1.5,
                        color: colors.onSurface,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const Spacer(),
                    ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        foregroundColor: colors.onPrimary,
                        backgroundColor: colors.primary,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 32, vertical: 16),
                      ),
                      child: const Text('Start Exploring'),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
