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

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});
  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final ctrl = injector.get<AuthViewmodel>();

  final validator = CredentialsValidator();
  final credentials = Credentials();

  @override
  void initState() {
    super.initState();
    ctrl.loginCommand.addListener(_listenable);
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
                  Text('teste',
                      style: GoogleFonts.lemon(
                        textStyle: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                          color: context.colors.light,
                        ),
                      )),
                  const SizedBox(height: 10),
                  Icon(FontAwesomeIcons.moneyBillTransfer,
                      size: 80, color: context.colors.light),
                  const SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: 140,
                        child: Divider(
                          color: context.colors.light,
                          thickness: 2,
                          height: 10,
                        ),
                      ),
                      Text(
                        'Cadastre-se',
                        style: TextStyle(
                            color: context.colors.light,
                            fontSize: 16,
                            fontWeight: FontWeight.w600),
                      ),
                      SizedBox(
                        width: 140,
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
                          labelText: 'nome completo',
                          prefixIcon: Icon(Icons.person)),
                    ),
                    const SizedBox(height: 20),
                    TextFormField(
                      onTap: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime.now()
                              .subtract(const Duration(days: 36500)),
                          lastDate:
                              DateTime.now().add(const Duration(days: 365)),
                        ).then((value) {
                          if (value != null) {
                            credentials.setEmail(value.toString());
                          }
                        });
                      },
                      onChanged: credentials.setEmail,
                      readOnly: true,
                      validator: validator.byField(credentials, 'email'),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      decoration: const InputDecoration(
                          labelText: 'data de nascimento',
                          prefixIcon: Icon(Icons.calendar_month)),
                    ),
                    const SizedBox(height: 20),
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
                                      }
                                      log('Email: ${credentials.email}');
                                      log('Password: ${credentials.password}');
                                    },
                              child: ctrl.loginCommand.isRunning
                                  ? const SizedBox(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator())
                                  : const Text(
                                      'Cadastrar-se',
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w800),
                                    ),
                            );
                          }),
                    ),
                    TextButton(
                      onPressed: () {
                        // Add navigation to signup page
                      },
                      child: Text(
                        'JÁ TENHO UMA CONTA',
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
