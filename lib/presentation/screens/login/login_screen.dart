import 'dart:js_interop';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'dart:convert';
import 'dart:developer';

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
                          'http://localhost:5000/graphql?',
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
                        List? repositories = result.data?['token']?['msg'];
                        //log(repositories.token)

                        if (result.hasException) {
                          _showSnackBar(scaffoldContext,
                              'Mutation error: ${result.exception.toString()}');
                        } else {
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
