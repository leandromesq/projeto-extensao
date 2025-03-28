import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/core/utils/extensions/theme_context_extensions.dart';
import 'package:rachadinha/domain/dtos/credentials.dart';
import 'package:rachadinha/domain/validators/credentials_validator.dart';
import 'package:rachadinha/main.dart';
import 'package:rachadinha/ui/auth/viewmodels/auth_viewmodel.dart';
import 'package:result_command/result_command.dart';
import 'package:routefly/routefly.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final ctrl = injector.get<AuthViewModel>();

  final validator = LoginCredentialsValidator();
  final credentials = Credentials();

  @override
  void initState() {
    super.initState();
    checkSavedLogin();
    ctrl.loginCommand.addListener(_listenable);
  }

  Future<void> checkSavedLogin() async {
    var savedUid = await ctrl.getSavedUID();

    if (savedUid != null && savedUid.isNotEmpty) {
      log('Login automático com UID: $savedUid');
      Routefly.navigate(routePaths.home);
    }
  }

  void _listenable() {
    if (ctrl.loginCommand.isSuccess) {
      Routefly.navigate(routePaths.home);
    }
    if (ctrl.loginCommand.isFailure) {
      final error = ctrl.loginCommand.value as FailureCommand;
      final snackBar = SnackBar(content: Text(error.error.toString()));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    ctrl.loginCommand.removeListener(_listenable);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(flex: 2),
              Column(
                children: [
                  Text('Rachadinha',
                      style: GoogleFonts.lemon(
                        textStyle: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: context.colors.light,
                        ),
                      )),
                  const SizedBox(height: 10),
                  Icon(FontAwesomeIcons.moneyBillTransfer,
                      size: 64, color: context.colors.light),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 160,
                        child: Divider(
                          color: context.colors.light,
                          thickness: 2,
                          height: 10,
                        ),
                      ),
                      Text(
                        'Login',
                        style: TextStyle(
                            color: context.colors.light,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 160,
                        child: Divider(
                          color: context.colors.light,
                          thickness: 2,
                          height: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32.0),
                child: Column(
                  children: [
                    TextFormField(
                      onChanged: credentials.setEmail,
                      validator: validator.byField(credentials, 'email'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: 'email', prefixIcon: Icon(Icons.email)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onChanged: credentials.setPassword,
                      validator: validator.byField(credentials, 'password'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      obscureText: true,
                      decoration: const InputDecoration(
                        labelText: 'senha',
                        prefixIcon: Icon(Icons.lock),
                      ),
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: double.infinity,
                      height: 54,
                      child: ListenableBuilder(
                          listenable: ctrl.loginCommand,
                          builder: (context, _) {
                            return ElevatedButton(
                              onPressed: ctrl.loginCommand.isRunning
                                  ? null
                                  : () {
                                      if (validator
                                          .validate(credentials)
                                          .isValid) {
                                        ctrl.loginCommand.execute(credentials);
                                        log('Email: ${credentials.email}');
                                        log('Password: ${credentials.password}');
                                      }
                                    },
                              child: ctrl.loginCommand.isRunning
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator())
                                  : const Text(
                                      'Login',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                            );
                          }),
                    ),
                    TextButton(
                      onPressed: () {
                        Routefly.navigate(routePaths.auth.register);
                      },
                      child: Text(
                        'AINDA NÃO TENHO UMA CONTA',
                        style: TextStyle(
                          color: context.colors.light,
                          fontWeight: FontWeight.w600,
                          fontSize: 16,
                          decoration: TextDecoration.underline,
                          decorationColor: context.colors.light,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 1),
            ],
          ),
        ),
      ),
    );
  }
}
