import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:rachadinha/core/config/dependencies.dart';
import 'package:rachadinha/core/utils/extensions/screen_extensions.dart';
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
  final ctrl = injector.get<AuthViewModel>();
  var dateFormat = DateFormat('dd/MM/yyyy');
  var dateController = TextEditingController();

  final validator = RegisterCredentialsValidator();
  final credentials = Credentials();

  @override
  void initState() {
    super.initState();
    ctrl.registerCommand.addListener(_listenable);
  }

  void _listenable() {
    if (ctrl.registerCommand.isSuccess) {
      Routefly.navigate(routePaths.home);
    }
    if (ctrl.registerCommand.isFailure) {
      final error = ctrl.registerCommand.value as FailureCommand;
      final snackBar = SnackBar(
          content: Text(error.error.toString().replaceAll('Exception: ', '')));

      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  @override
  void dispose() {
    ctrl.registerCommand.removeListener(_listenable);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    dateController.text = credentials.birthDate != null
        ? dateFormat.format(credentials.birthDate!)
        : '';
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: SizedBox(
              height: context.screenHeight,
              width: context.screenWidth,
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
                      Image.asset(
                        'assets/white_logo.png',
                        width: 150,
                        height: 75,
                      ),
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
                          onChanged: credentials.setName,
                          validator: validator.byField(credentials, 'name'),
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          decoration: const InputDecoration(
                              labelText: 'nome completo',
                              prefixIcon: Icon(Icons.person)),
                        ),
                        const SizedBox(height: 20),
                        TextFormField(
                          controller: dateController,
                          onTap: () {
                            showDatePicker(
                              context: context,
                              initialDate: DateTime.now(),
                              firstDate: DateTime.now()
                                  .subtract(const Duration(days: 36500)),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                credentials.setBirthDate(value);
                                dateController.text =
                                    dateFormat.format(credentials.birthDate!);
                              }
                            });
                          },
                          readOnly: true,
                          validator:
                              validator.byField(credentials, 'birthdate'),
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
                              labelText: 'email',
                              prefixIcon: Icon(Icons.email)),
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
                              listenable: ctrl.registerCommand,
                              builder: (context, _) {
                                return ElevatedButton(
                                  onPressed: ctrl.registerCommand.isRunning
                                      ? null
                                      : () {
                                          if (validator
                                              .validate(credentials)
                                              .isValid) {
                                            ctrl.registerCommand
                                                .execute(credentials);
                                          }
                                          log('Name: ${credentials.name}');
                                          log('Email: ${credentials.email}');
                                          log('Password: ${credentials.password}');
                                          log('BirthDate: ${credentials.birthDate}');
                                        },
                                  child: ctrl.registerCommand.isRunning
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
                            Routefly.navigate(routePaths.auth.login);
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
        ),
      ),
    );
  }
}
