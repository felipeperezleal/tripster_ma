import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';
import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});
  static const name = 'login-screen';

  @override
  LoginFormState createState() => LoginFormState();
}

class LoginFormState extends State<LoginScreen> {
  final TextEditingController userController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  void _showSnackBar(BuildContext scaffoldContext, String message) {
    ScaffoldMessenger.of(scaffoldContext).showSnackBar(
      SnackBar(
        content: Text(message),
        duration: const Duration(seconds: 10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final scaffoldContext = context;
    return Scaffold(
        appBar: AppBar(
          title: const Text('Login'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                maxHeight: MediaQuery.of(context).size.height,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Spacer(flex: 2),
                  Text(
                    'Welcome Back!',
                    style: textTheme.headlineSmall,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Log in to your account',
                    style: textTheme.titleMedium,
                    textAlign: TextAlign.center,
                  ),
                  const Spacer(),
                  TextFormField(
                    controller: userController,
                    decoration: const InputDecoration(
                      labelText: 'Email',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 16),
                  TextFormField(
                    controller: passwordController,
                    decoration: const InputDecoration(
                      labelText: 'Password',
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: () async {
                      final email = userController.text;
                      final password = passwordController.text;

                      if (email.isNotEmpty && password.isNotEmpty) {
                        final HttpLink httpLink = HttpLink(
                          'http://localhost/graphql?',
                        );
                        final GraphQLClient client = GraphQLClient(
                          link: httpLink,
                          cache: GraphQLCache(),
                        );
                        // Define la mutación GraphQL
                        const String createLoginMutation = r'''
                              mutation GetLogin($input: LoginInput!) {
                                getLogin(login: $input) {
                                  token
                                  msg
                                }
                              }
                            ''';
                        // Variables para la mutación
                        final Map<String, dynamic> variables = {
                          'input': {
                            'email': email,
                            'clave': password,
                          },
                        };

                        log(json.encode(variables));
                        // Realiza la mutación
                        final QueryResult result = await client.mutate(
                          MutationOptions(
                            document: gql(createLoginMutation),
                            variables: variables,
                          ),
                        );
                        log(result.data.toString());

                        String key = "";
                        String response = "";
                        if (result.data != null) {
                          // Convertir result.data a formato JSON
                          String jsonData = jsonEncode(result.data);

                          // Imprimir el JSON resultante
                          // print(jsonData);
                          Map<String, dynamic> jsonMap = json.decode(jsonData);
                          // jsonMap[1].toString();

                          if (jsonMap.containsKey("getLogin")) {}

                          for (var entry in jsonMap.entries) {
                            // print('Clave: ${entry.key}, Valor: ${entry.value}');
                            if (entry.key == "getLogin") {
                              Map<String, dynamic> jsonMap2 = entry.value;
                              for (var ent in jsonMap2.entries) {
                                if (ent.value != null) {
                                  key = ent.key;
                                  response = ent.value;
                                  print(
                                      'Clave: ${ent.key}, Valor: ${ent.value}');
                                }
                              }
                            }
                          }
                        } else {
                          print('La propiedad data es nula en el resultado');
                        }

                        if (result.hasException) {
                          _showSnackBar(scaffoldContext,
                              '(LDAP) Mutation error: ${result.exception.toString()}');
                        } else if (key == "msg") {
                          _showSnackBar(scaffoldContext, '${response}');
                        } else {
                          try {
                            SharedPreferences prefs =
                                await SharedPreferences.getInstance();
                            await prefs.setString(key, response);
                            final storage = new FlutterSecureStorage();
                            await storage.write(key: "jwt", value: response);
                          } catch (error) {
                            _showSnackBar(scaffoldContext, '${error}');
                          }

                          context.go('/home');
                        }
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: const Text('Log In'),
                  ),
                  const Spacer(),
                  TextButton(
                    onPressed: () {},
                    child: const Text('Forgot Password?'),
                  ),
                  const Spacer(flex: 2),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text('Don’t have an account?'),
                      TextButton(
                        onPressed: () {
                          context.go('/register');
                        },
                        child: const Text('Sign Up'),
                      ),
                    ],
                  ),
                  const Spacer(flex: 3),
                ],
              ),
            ),
          ),
        ));
  }
}
