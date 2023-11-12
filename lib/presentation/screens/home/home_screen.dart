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
    final screenWidth = MediaQuery.of(context).size.width;

    const String backgroundImageUrl = 'assets/images/airplane.jpg';

    final List<String> imageList = [
      'https://picsum.photos/id/256/800/200',
      'https://picsum.photos/id/265/800/200',
      'https://picsum.photos/id/212/800/200',
    ];

    final List<String> descriptions = [
      'Explore the vibrant culture and rich history of this stunning destination.',
      'Discover breathtaking landscapes and outdoor adventures.',
      'Experience the ultimate city life with endless entertainment and dining options.'
    ];

    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              Image.network(
                backgroundImageUrl,
                height: screenHeight * 0.55,
                width: screenWidth,
                fit: BoxFit.cover,
              ),
              Container(
                height: screenHeight * 0.55,
                width: screenWidth,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
              const Text(
                'With Tripster, find the perfect flight at swift routes, and from a variety of airlines.',
                style: TextStyle(
                  fontSize: 24,
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Expanded(
            child: Container(
              width: screenWidth,
              color: Colors.grey[200],
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: imageList.asMap().entries.map((entry) {
                    int index = entry.key;
                    String url = entry.value;

                    return Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: _ImageCards(
                            url: url,
                            screenHeight: screenHeight,
                            descriptions: descriptions,
                            index: index,
                            colors: colors),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ImageCards extends StatelessWidget {
  const _ImageCards({
    required this.url,
    required this.screenHeight,
    required this.descriptions,
    required this.index,
    required this.colors,
  });

  final String url;
  final double screenHeight;
  final List<String> descriptions;
  final int index;
  final ColorScheme colors;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            flex: 3,
            child: ClipRRect(
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(8.0)),
              child: Image.network(
                url,
                fit: BoxFit.cover,
                height: screenHeight * 0.2,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  descriptions[index],
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: colors.onSurface,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
