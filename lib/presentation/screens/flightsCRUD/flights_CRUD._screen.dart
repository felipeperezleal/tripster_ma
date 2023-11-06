import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart';

class FlightsCRUD extends StatefulWidget {
  const FlightsCRUD({Key? key}) : super(key: key);
  static const name = 'flights-CRUD';

@override
  _FlightsCRUD createState() => _FlightsCRUD();
}



class _FlightsCRUD extends State<FlightsCRUD> {
  final TextEditingController countryController = TextEditingController();

  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  

  void _showSnackBar(BuildContext scaffoldContext, String message) {
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: Duration(seconds: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final scaffoldContext = context;
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        title: const Text('Registro'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 10),
                width: 300, // Ancho deseado
                child: TextField(
                  controller: countryController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
              ),
              
              ElevatedButton(
                onPressed: () async {
                  // Aquí puedes enviar los datos del formulario a tu backend o realizar otra acción
                  final country = countryController.text;

                  if (country.isNotEmpty != null) {

                    final HttpLink httpLink = HttpLink('http://localhost:5000/graphql?',
                    );
                       // Reemplaza con tu URL GraphQL

                    final GraphQLClient client = GraphQLClient(
                      link: httpLink,
                      cache: GraphQLCache(),
                    );

                    // Define la mutación GraphQL
                    const String createCountryMutation = r'''

                      mutation {
                        createCountry(country_name: {
                          country_name: "Rumania"
                        }) {
                        country_name
                        }
                        }
                      mutation CreateUser($input: UsuarioInput!) {
                        createUsuario(usuario: $input) {
                          email
                          nombre
                          apellido
                          rol
                        }
                      }
                    ''';

                                // Variables para la mutación
                    final Map<String, dynamic> variables = {
                      'input': {
                        'email': email,
                        'nombre': nombre,
                        'apellido': apellido,
                        'direccion': direccion,
                        'clave': clave,
                        'telefono': telefono,
                        'birthday': selectedDate.toString(),
                        'rol': 'user', // Valor fijo del parámetro "rol"
                      },
                    };

                    print(json.encode(variables));
                    // Realiza la mutación
                    final QueryResult result = await client.mutate(
                      MutationOptions(
                        document: gql(createUserMutation),
                        variables: variables,
                      ),
                    );

                    if (result.hasException) {
                      _showSnackBar( scaffoldContext, 'Error en la mutación: ${result.exception.toString()}');
                    } else {
                      _showSnackBar( scaffoldContext, 'Usuario registrado con éxito');
                    }

                  } else {
                    _showSnackBar(scaffoldContext, 'Por favor, completa todos los campos');
                  }
                },
                style: ElevatedButton.styleFrom(
                  minimumSize: const Size(200, 50),
                ),
                child: const Text('Registrarse'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}