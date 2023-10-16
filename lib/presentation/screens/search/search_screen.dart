import 'package:flutter/material.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({super.key});
  static const name = 'search-screen';

  final String getRoute = """
    mutation {
      createRoute(route: {
        origin: "A",
        destiny: "C",
      }){
        ID,
        origin,
        destiny
      }
    }
  """;

  final String getFlights = """
    mutation {
      FlightByOrigDest(orig: "A", dest: "C"){
        ID,
        origin,
        destiny
      }
    }
  """;

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              SearchForm(),
              SizedBox(height: 20),
              Text('Result :p'),
            ],
          ),
        ),
      ),
    );
  }
}

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Origin',
                    prefixIcon: Icon(Icons.circle_outlined),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                child: TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Destiny',
                    prefixIcon: Icon(Icons.location_on_rounded),
                    contentPadding: EdgeInsets.all(10),
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              const SizedBox(width: 20),
              TextButton.icon(
                onPressed: () {},
                style: TextButton.styleFrom(
                  minimumSize: const Size(200, 50),
                  backgroundColor: colors.primary,
                  foregroundColor: Colors.white,
                  padding:
                      const EdgeInsets.all(10), // Ajusta el relleno interno
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                icon: const Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                label: const Text(
                  'Search',
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}
