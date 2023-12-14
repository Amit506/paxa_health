import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:paxa_health/screens/todo_screen.dart';
import 'package:paxa_health/service/api_service.dart';
import 'package:paxa_health/state_provider.dart';
import 'package:paxa_health/utils/loadin_overlay.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController usernameController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return CupertinoPageScaffold(
      child: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 25),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120,
                height: 120,
                decoration: const BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.black,
                ),
                child: const Icon(
                  Icons.person,
                  size: 80,
                  color: Colors.white,
                ),
              ),
              const SizedBox(height: 50.0),
              CupertinoTextField.borderless(
                controller: usernameController,
                padding:
                    EdgeInsets.only(left: 65, top: 10, right: 6, bottom: 10),
                prefix: Text('Name'),
                textAlign: TextAlign.end,
                placeholder: 'Enter username',
              ),
              // TextField(
              //   controller: usernameController,
              //   style: TextStyle(color: Colors.white),
              //   decoration: InputDecoration(
              //     labelText: 'Username',
              //     labelStyle: TextStyle(color: Colors.white),
              //     prefixIcon: Icon(
              //       Icons.person,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 16.0),
              CupertinoTextField.borderless(
                controller: passwordController,
                padding:
                    EdgeInsets.only(left: 65, top: 10, right: 6, bottom: 10),
                prefix: Text('Password'),
                textAlign: TextAlign.end,
                placeholder: 'Enter password',
              ),
              // CupertionTextF(
              //   controller: passwordController,
              //   obscureText: true,
              //   style: TextStyle(color: Colors.white),
              //   decoration: InputDecoration(
              //     labelText: 'Password',
              //     labelStyle: TextStyle(color: Colors.white),
              //     prefixIcon: Icon(
              //       Icons.lock,
              //       color: Colors.white,
              //     ),
              //   ),
              // ),
              const SizedBox(height: 40.0),
              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: () async {
                    ApiService apiService = ApiService();
                    if (usernameController.text.isEmpty ||
                        passwordController.text.isEmpty) {
                      return;
                    }
                    await LoadingOverlay.of(context)
                        .during(apiService.login(
                            usernameController.text, passwordController.text))
                        .then((value) {
                      if (value != null) {
                        context.read<StateProvider>().setUser(value);
                        Navigator.push(context,
                            CupertinoPageRoute(builder: (_) => TodoScreen()));
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    primary: Colors.black,
                    onPrimary: Colors.white,
                    padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(fontSize: 16.0),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
