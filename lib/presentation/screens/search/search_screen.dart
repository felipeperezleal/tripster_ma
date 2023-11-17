import 'package:flutter/material.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<String?> _cargarPreferencias() async {
  // Obtain shared preferences.
  final SharedPreferences prefs = await SharedPreferences.getInstance();
  final String? action = prefs.getString('token');
  return action;
}

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});
  static const name = 'search-screen';

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<String> orderingList = [];

  void onOrderingListReceived(List<String> list) {
    setState(() {
      orderingList = list;
    });
  }

  @override
  void initState() {
    super.initState();
    // Llama a la función que deseas ejecutar al cargar el screen
    _cargarPreferencias();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              children: [
                SearchForm(
                  onOrderingListReceived: onOrderingListReceived,
                ),
                const SizedBox(height: 20),
                if (orderingList.isNotEmpty)
                  Column(
                    children: [
                      const Text(
                        'Best Route:',
                        style: TextStyle(
                          fontSize: 24,
                        ),
                      ),
                      for (final item in orderingList)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Card(
                            child: Center(
                              child: Container(
                                height: 100,
                                width: double.infinity,
                                padding: const EdgeInsets.all(8),
                                child: Center(
                                  child: Text(
                                    item,
                                    style: const TextStyle(
                                      fontSize: 18,
                                    ),
                                    textAlign: TextAlign.center,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class SearchForm extends StatelessWidget {
  const SearchForm({
    super.key,
    required this.onOrderingListReceived,
  });

  final Function(List<String>) onOrderingListReceived;

  @override
  Widget build(BuildContext context) {
    final TextEditingController originController = TextEditingController();
    final TextEditingController destinyController = TextEditingController();

    final colors = Theme.of(context).colorScheme;

    return Form(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: FutureBuilder<List<String>>(
                  future: getDropdownItems(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return DropdownButtonFormField(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Origin',
                          prefixIcon: Icon(Icons.circle_outlined),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                        value: snapshot.data!.isNotEmpty
                            ? snapshot.data!.first
                            : '-1',
                        items: snapshot.data!
                            .map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          originController.text = value!;
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 3,
                child: FutureBuilder<List<String>>(
                  future: getDropdownItems(),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<String>> snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const CircularProgressIndicator();
                    } else if (snapshot.hasError) {
                      return Text('Error: ${snapshot.error}');
                    } else {
                      return DropdownButtonFormField(
                        isExpanded: true,
                        decoration: const InputDecoration(
                          labelText: 'Destiny',
                          prefixIcon: Icon(Icons.place_outlined),
                          contentPadding: EdgeInsets.all(10),
                          border: OutlineInputBorder(),
                        ),
                        value: snapshot.data!.isNotEmpty
                            ? snapshot.data!.first
                            : '-1',
                        items: snapshot.data!
                            .map((String value) => DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                ))
                            .toList(),
                        onChanged: (String? value) {
                          destinyController.text = value!;
                        },
                      );
                    }
                  },
                ),
              ),
              const SizedBox(width: 20),
              Expanded(
                flex: 1,
                child: SearchButton(
                  colors: colors,
                  originController: originController,
                  destinyController: destinyController,
                  onOrderingListReceived: onOrderingListReceived,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<List<String>> getDropdownItems() async {
    final List<String> orderingList = ['Choose an option'];

    final HttpLink httpLink = HttpLink(
      'http://localhost/graphql?',
    );
    final String? token = await _cargarPreferencias();
    final AuthLink authLink = AuthLink(getToken: () async => 'Bearer $token');
    final Link link = authLink.concat(httpLink);

    final GraphQLClient client = GraphQLClient(
      link: link,
      cache: GraphQLCache(),
    );

    const String getFlights = r'''
      query GetFlights {
        getFlights{
          airport_origin{
            airport_origin_name
          },
          airport_destination{
            airport_destino_name
          }
        }
      }
    ''';

    final QueryResult queryResult = await client.query(
      QueryOptions(
        document: gql(getFlights),
      ),
    );

    if (queryResult.hasException) {
    } else {
      final dropdownItems = queryResult.data!['getFlights'];

      for (final item in dropdownItems) {
        orderingList.add(item['airport_origin']['airport_origin_name']);
        orderingList.add(item['airport_destination']['airport_destino_name']);
      }
    }

    final Set<String> uniqueItems = Set<String>.from(orderingList);
    return uniqueItems.toList();
  }
}

class SearchButton extends StatelessWidget {
  const SearchButton({
    super.key,
    required this.colors,
    required this.originController,
    required this.destinyController,
    required this.onOrderingListReceived,
  });

  final ColorScheme colors;
  final TextEditingController originController;
  final TextEditingController destinyController;
  final Function(List<String>) onOrderingListReceived;

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () async {
        final origin = originController.text;
        final destiny = destinyController.text;

        if ((origin.isNotEmpty && destiny.isNotEmpty) &&
            (origin != destiny) &&
            (origin != 'Choose an option' && destiny != 'Choose an option')) {
          final HttpLink httpLink = HttpLink(
            'http://localhost/graphql?',
          );
          final String? token = await _cargarPreferencias();
          final AuthLink authLink =
              AuthLink(getToken: () async => 'Bearer $token');
          final Link link = authLink.concat(httpLink);

          final GraphQLClient client = GraphQLClient(
            link: link,
            cache: GraphQLCache(),
          );

          const String createRouteMutation = r'''
            mutation CreateNewRoute($input: RouteInput!) {
              createRoute(route: $input) {
                ID,
                origin,
                destiny
              }
            }
          ''';

          final Map<String, dynamic> variables = {
            'input': {
              'origin': origin,
              'destiny': destiny,
            }
          };

          final QueryResult result = await client.mutate(
            MutationOptions(
              document: gql(createRouteMutation),
              variables: variables,
            ),
          );
          if (result.hasException) {
          } else {
            getRouteQuery(result, client);
          }
        }
      },
      style: TextButton.styleFrom(
        minimumSize: const Size(200, 50),
        backgroundColor: colors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
      icon: const Icon(
        Icons.search,
        color: Colors.white,
      ),
    );
  }

  Future<void> getRouteQuery(QueryResult result, GraphQLClient client) async {
    final String createdRouteId = result.data!['createRoute']['ID'];
    final List<String> orderingList;

    const String getRouteQuery = r'''
      query GetRoute($id: ID!) {
        getRoute(id: $id) {
          ID,
          origin,
          destiny,
          numNodes,
          ordering
        }
      }
    ''';

    final Map<String, dynamic> queryVariables = {
      'id': createdRouteId,
    };
    // Imprimir el encabezado aquí antes de realizar la solicitud
    // print("Authorization Header: Bearer ");

    final QueryResult queryResult = await client.query(
      QueryOptions(
        document: gql(getRouteQuery),
        variables: queryVariables,
      ),
    );

    if (queryResult.hasException) {
    } else {
      final routeData = queryResult.data!['getRoute'];

      var orderingString = routeData['ordering'].toString();

      print("Ordering String: $routeData");

      orderingString = orderingString
          .replaceAll(') ', '), ')
          .replaceAll('[', '')
          .replaceAll(']', '');

      orderingList = orderingString.split(', ');

      onOrderingListReceived(orderingList);
    }
  }
}
