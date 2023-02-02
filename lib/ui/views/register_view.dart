import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/register_form_provider.dart';

import 'package:email_validator/email_validator.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';

class RegisterView extends StatelessWidget {
  const RegisterView({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => RegisterFormProvider(),
      builder: (context, child) {
        final registerProvider =
            Provider.of<RegisterFormProvider>(context, listen: false);
        return Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(
                maxWidth: 370,
              ),
              child: Form(
                autovalidateMode: AutovalidateMode.always,
                // connecting provider to access the form state
                key: registerProvider.formKey,
                child: Column(
                  children: [
                    // //Name
                    // TextFormField(
                    //   // accesso al valor
                    //   onChanged: (value) => registerProvider.name = value,
                    //   validator: (value) {
                    //     if (value == null || value.isEmpty) {
                    //       return "Ingrese su nombre";
                    //     }
                    //     return null;
                    //   },
                    //   style: const TextStyle(color: Colors.white),
                    //   decoration: CustomInputs.loginInputDecoration(
                    //       hint: "Ingrese su nombre",
                    //       label: "Nombre",
                    //       icon: Icons.supervised_user_circle_outlined),
                    // ),

                    //SPRINT
                    TextFormField(
                      // accesso al valor
                      onChanged: (value) => registerProvider.username = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su nombre de usuario";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: "Ingrese su nombre de usuario",
                          label: "Username",
                          icon: Icons.supervised_user_circle_outlined),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      // accesso al valor
                      onChanged: (value) => registerProvider.firstname = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su nombre";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: "Ingrese su nombre",
                          label: "Firstname",
                          icon: Icons.supervised_user_circle_outlined),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    TextFormField(
                      // accesso al valor
                      onChanged: (value) => registerProvider.lastname = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su apellido";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: "Ingrese su apellido",
                          label: "Lastname",
                          icon: Icons.supervised_user_circle_outlined),
                    ),

                    //SPRINT

                    const SizedBox(
                      height: 10,
                    ),

                    //Email
                    TextFormField(
                      onChanged: (value) => registerProvider.email = value,
                      validator: (value) {
                        if (!EmailValidator.validate(value ?? '')) {
                          return "Email no valido";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: "Ingrese su correo",
                          label: "Email",
                          icon: Icons.email_outlined),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    // Password
                    TextFormField(
                      onChanged: (value) => registerProvider.password = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "La contraseña es obligatoria";
                        }
                        if (value.length < 6) {
                          return "La contraseña debe ser de 6 caracteres";
                        }
                        return null;
                      },
                      obscureText: true,
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: "*******",
                          label: "password",
                          icon: Icons.lock_outline_rounded),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    CustomOutlinedButton(
                      onPressed: () {
                        final validForm = registerProvider.validateForm();
                        // si el formulario es invalido no hacemos nada
                        if (!validForm) {
                          return;
                        }

                        // crea el usuario
                        // final authProvider =
                        //     Provider.of<AuthProvider>(context, listen: false);
                        // authProvider.register(
                        //   registerProvider.email,
                        //   registerProvider.password,
                        //   registerProvider.name,
                        // );

                        //SPRINT
                        final authProvider =
                            Provider.of<AuthProvider>(context, listen: false);
                        authProvider.register(
                          registerProvider.username,
                          registerProvider.firstname,
                          registerProvider.lastname,
                          registerProvider.email,
                          registerProvider.password,
                        );

                        //SPRINT
                      },
                      text: "Crear Cuenta",
                      color: Colors.blue,
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    LinkText(
                      text: "Ir al login",
                      onPressed: () {
                        Navigator.pushReplacementNamed(
                            context, Flurorouter.loginRoute);
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
