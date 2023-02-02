import 'package:admin_dashboard/providers/auth_provider.dart';
import 'package:admin_dashboard/providers/login_form_provider.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';

import 'package:admin_dashboard/router/router.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/buttons/custom_outlined_button.dart';
import 'package:admin_dashboard/ui/buttons/link_text.dart';
import 'package:provider/provider.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);

    return ChangeNotifierProvider(
      create: (_) => LoginFormProvider(),
      builder: (context, child) {
        final loginProvider = Provider.of<LoginFormProvider>(context);

        return Container(
          margin: const EdgeInsets.only(top: 40),
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 370),
              child: Form(
                // realiza la validacion de manera automatica
                // antes de presionar el boton ingresar
                autovalidateMode: AutovalidateMode.always,
                // connecting the form with the provider
                // da acceso en el provider a todo el estado del formulario
                key: loginProvider.formKey,
                child: Column(
                  children: [
                    //SPRINT
                    TextFormField(
                      // accesso al valor
                      onChanged: (value) => loginProvider.username = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su nombre";
                        }
                        return null;
                      },
                      style: const TextStyle(color: Colors.white),
                      decoration: CustomInputs.loginInputDecoration(
                          hint: "Ingrese su nombre",
                          label: "Nombre",
                          icon: Icons.supervised_user_circle_outlined),
                    ),
                    // SPRINT

                    // //Email
                    // TextFormField(
                    //   // al presionar enter
                    //   onFieldSubmitted: (_) =>
                    //       onFormSubmit(loginProvider, authProvider),
                    //   validator: (value) {
                    //     if (!EmailValidator.validate(value ?? "")) {
                    //       return "Email no valido";
                    //     }
                    //     return null;
                    //   },
                    //   onChanged: (value) => loginProvider.email = value,
                    //   style: const TextStyle(color: Colors.white),
                    //   decoration: CustomInputs.loginInputDecoration(
                    //       hint: "Ingrese su correo",
                    //       label: "Email",
                    //       icon: Icons.email_outlined),
                    // ),

                    const SizedBox(
                      height: 20,
                    ),

                    // Password
                    TextFormField(
                      // presionar enter
                      onFieldSubmitted: (_) =>
                          onFormSubmit(loginProvider, authProvider),
                      onChanged: (value) => loginProvider.password = value,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return "Ingrese su contraseña";
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
                          label: "Contraseña",
                          icon: Icons.lock_outline_rounded),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    CustomOutlinedButton(
                      onPressed: () {
                        onFormSubmit(loginProvider, authProvider);
                      },
                      text: "Ingresar",
                      color: Colors.blue,
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    LinkText(
                      text: "Nueva Cuenta",
                      onPressed: () {
                        // Navigator.pushNamed(context, Flurorouter.registerRoute);
                        Navigator.pushReplacementNamed(
                            context, Flurorouter.registerRoute);
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

  void onFormSubmit(
      LoginFormProvider loginProvider, AuthProvider authProvider) {
    final isValid = loginProvider.validateForm();
    if (isValid) {
      authProvider.login(loginProvider.username, loginProvider.password);
    }
  }
}

// class LoginView extends StatelessWidget {
//   const LoginView({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(top: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 20),
//       child: Center(
//         child: ConstrainedBox(
//           constraints: const BoxConstraints(maxWidth: 370),
//           child: Form(
//             child: Column(
//               children: [
//                 //Email
//                 TextFormField(
//                   // validator: (value) {},
//                   style: const TextStyle(color: Colors.white),
//                   decoration: CustomInputs.loginInputDecoration(
//                       hint: "Ingrese su correo",
//                       label: "Email",
//                       icon: Icons.email_outlined),
//                 ),

//                 const SizedBox(
//                   height: 20,
//                 ),

//                 // Password
//                 TextFormField(
//                   validator: (value) {
//                     if (value == null || value.isEmpty) {
//                       return "Ingrese su contraseña";
//                     }
//                     if (value.length < 6) {
//                       return "La contraseña debe ser de 6 caracteres";
//                     }
//                     return null;
//                   },
//                   obscureText: true,
//                   style: const TextStyle(color: Colors.white),
//                   decoration: CustomInputs.loginInputDecoration(
//                       hint: "*******",
//                       label: "Contraseña",
//                       icon: Icons.lock_outline_rounded),
//                 ),

//                 const SizedBox(
//                   height: 20,
//                 ),

//                 CustomOutlinedButton(
//                   onPressed: () {},
//                   text: "Ingresar",
//                   color: Colors.blue,
//                 ),

//                 const SizedBox(
//                   height: 20,
//                 ),

//                 LinkText(
//                   text: "Nueva Cuenta",
//                   onPressed: () {
//                     Navigator.pushNamed(context, Flurorouter.registerRoute);
//                   },
//                 )
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//METODO PARA CAMBIAR EL ESTILO DE LOS INPUTS
// InputDecoration _buildInputDecoration({
//   required String hint,
//   required String label,
//   required IconData icon,
// }) =>
//     InputDecoration(
//       border: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderSide: BorderSide(color: Colors.white.withOpacity(0.3)),
//       ),
//       hintText: hint,
//       labelText: label,
//       prefixIcon: Icon(
//         icon,
//         color: Colors.grey,
//       ),
//       hintStyle: const TextStyle(color: Colors.grey),
//       labelStyle: const TextStyle(color: Colors.grey),
//     );
// }