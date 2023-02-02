// // por defecto el widget Table aplica expanded a cada columna
// // no toma las dimensiones de width establecidas ej Container(width:250)
// // toma todo el espacio disponible de forma equitativa
// // property: ColumnsWidth: permite establecer el width de las columnas

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:email_validator/email_validator.dart';
import 'package:file_picker/file_picker.dart';

import 'package:admin_dashboard/models/usuario.dart';

// import 'package:admin_dashboard/providers/user_form_provider.dart';
// import 'package:admin_dashboard/providers/users_provider.dart';
import 'package:admin_dashboard/providers/providers.dart';

import 'package:admin_dashboard/services/navigation_service.dart';
import 'package:admin_dashboard/services/notifications_service.dart';

import 'package:admin_dashboard/ui/inputs/custom_inputs.dart';
import 'package:admin_dashboard/ui/labels/custom_labels.dart';
import 'package:admin_dashboard/ui/cards/white_card.dart';

class UserView extends StatefulWidget {
  final String id;

  const UserView({Key? key, required this.id}) : super(key: key);

  @override
  _UserViewState createState() => _UserViewState();
}

class _UserViewState extends State<UserView> {
  Usuario? user;

  @override
  void initState() {
    super.initState();
    final usersProvider = Provider.of<UsersProvider>(context, listen: false);
    final userFormProvider =
        Provider.of<UserFormProvider>(context, listen: false);

    usersProvider.getUserById(widget.id).then((userDB) {
      if (userDB != null) {
        userFormProvider.formKey = GlobalKey<FormState>();
        userFormProvider.user = userDB;
        setState(() {
          user = userDB;
        });
      } else {
        NavigationService.replaceTo("/dashboard/users");
      }
    });
  }

  @override
  void dispose() {
    user = null;
    Provider.of<UserFormProvider>(context, listen: false).user = null;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: ListView(
        physics: const ClampingScrollPhysics(),
        children: [
          Text('User View', style: CustomLabels.h1),
          const SizedBox(height: 10),
          if (user == null)
            WhiteCard(
                child: Container(
              alignment: Alignment.center,
              height: 300,
              child: const CircularProgressIndicator(),
            )),
          if (user != null) _UserViewBody()
        ],
      ),
    );
  }
}

class _UserViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Table(
        columnWidths: const {0: FixedColumnWidth(250)},
        children: [
          TableRow(children: [
            // AVATAR
            _AvatarContainer(),

            // Formulario de actualización
            const _UserViewForm(),
          ])
        ],
      ),
    );
  }
}

class _UserViewForm extends StatelessWidget {
  const _UserViewForm({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    return WhiteCard(
        title: 'Información general',
        child: Form(
          key: userFormProvider.formKey,
          autovalidateMode: AutovalidateMode.always,
          child: Column(
            children: [
              // username
              TextFormField(
                initialValue: user.username,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Username',
                    label: 'Username',
                    icon: Icons.supervised_user_circle_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(username: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su nombre de usuario.';
                  }
                  if (value.length < 2) {
                    return 'El nombre de usuario debe de ser de dos letras como mínimo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              // //SPRINT
              //firstname
              TextFormField(
                initialValue: user.firstname,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Firstname',
                    label: 'Firstname',
                    icon: Icons.supervised_user_circle_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(firstname: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su nombre de usuario.';
                  }
                  if (value.length < 2) {
                    return 'El nombre  debe de ser de dos letras como mínimo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              TextFormField(
                initialValue: user.lastname,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Lastname',
                    label: 'Lastname',
                    icon: Icons.supervised_user_circle_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(lastname: value),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Ingrese su apellido de usuario.';
                  }
                  if (value.length < 2) {
                    return 'El apellido  debe de ser de dos letras como mínimo.';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 20),

              //SPRINT

              // correo
              TextFormField(
                initialValue: user.correo,
                decoration: CustomInputs.formInputDecoration(
                    hint: 'Correo del usuario',
                    label: 'Correo',
                    icon: Icons.mark_email_read_outlined),
                onChanged: (value) =>
                    userFormProvider.copyUserWith(correo: value),
                validator: (value) {
                  if (!EmailValidator.validate(value ?? '')) {
                    return 'Email no válido';
                  }
                  return null;
                },
              ),

              const SizedBox(height: 20),

              ConstrainedBox(
                constraints: const BoxConstraints(maxWidth: 120),
                child: ElevatedButton(
                  onPressed: () async {
                    final saved = await userFormProvider.updateUser();
                    log(saved);
                    if (saved) {
                      NotificationsService.showSnackbar('Usuario actualizado');
                      // Provider.of<UsersProvider>(context, listen: false)
                      //     .refreshUser(user);
                    } else {
                      NotificationsService.showSnackbarError(
                          'No se pudo guardar');
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.indigo),
                    shadowColor: MaterialStateProperty.all(Colors.transparent),
                  ),
                  child: Row(
                    children: const [
                      Icon(Icons.save_outlined, size: 20),
                      Text('  Guardar')
                    ],
                  ),
                ),
              )
            ],
          ),
        ));
  }
}

//AVATAR
class _AvatarContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final userFormProvider = Provider.of<UserFormProvider>(context);
    final user = userFormProvider.user!;

    final image = (user.img == null)
        ? const Image(image: AssetImage('no-image.jpg'))
        : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!);

    return WhiteCard(
      width: 250,
      child: Container(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text('Profile', style: CustomLabels.h2),
            const SizedBox(height: 20),
            Container(
                width: 150,
                height: 160,
                child: Stack(
                  children: [
                    ClipOval(
                      child: image,
                    ),
                    Positioned(
                      bottom: 5,
                      right: 5,
                      child: Container(
                        width: 45,
                        height: 45,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(100),
                            border: Border.all(color: Colors.white, width: 5)),
                        child: FloatingActionButton(
                          backgroundColor: Colors.indigo,
                          elevation: 0,
                          child: const Icon(
                            Icons.camera_alt_outlined,
                            size: 20,
                          ),
                          onPressed: () async {
                            FilePickerResult? result =
                                await FilePicker.platform.pickFiles(
                                    // error en el codigo de fernando
                                    // agregar el tipo de archivo
                                    type: FileType.custom,
                                    // las extensiones de imagenes permitidas
                                    allowedExtensions: ["jpg", "jpeg", "png"],
                                    // permite subir multiples imagenes a la vez
                                    allowMultiple: false);

                            if (result != null) {
                              PlatformFile file = result.files.first;
                              print("subiendo");
                              NotificationsService.showBusyIndicator(context);

                              final updatedUser =
                                  await userFormProvider.uploadImage(
                                "/uploads/avataruser/${user.id}",
                                file.bytes!,
                              );
                              print(updatedUser.img);

                              Provider.of<UsersProvider>(context, listen: false)
                                  .refreshUser(updatedUser);

                              Navigator.of(context).pop();
                            } else {
                              // User canceled the picker
                              ("no hay imagen");
                            }
                          },
                        ),
                      ),
                    )
                  ],
                )),
            const SizedBox(height: 20),
            Text(
              user.username,
              style: const TextStyle(fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}







// //AVATAR
// class _AvatarContainer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     final userFormProvider = Provider.of<UserFormProvider>(context);
//     final user = userFormProvider.user!;

//     final image = (user.img == null)
//         ? const Image(image: AssetImage('no-image.jpg'))
//         : FadeInImage.assetNetwork(placeholder: 'loader.gif', image: user.img!);

//     return WhiteCard(
//       width: 250,
//       child: Container(
//         width: double.infinity,
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Text('Profile', style: CustomLabels.h2),
//             const SizedBox(height: 20),
//             Container(
//                 width: 150,
//                 height: 160,
//                 child: Stack(
//                   children: [
//                     ClipOval(
//                       child: image,
//                     ),
//                     Positioned(
//                       bottom: 5,
//                       right: 5,
//                       child: Container(
//                         width: 45,
//                         height: 45,
//                         decoration: BoxDecoration(
//                             borderRadius: BorderRadius.circular(100),
//                             border: Border.all(color: Colors.white, width: 5)),
//                         child: FloatingActionButton(
//                           backgroundColor: Colors.indigo,
//                           elevation: 0,
//                           child: const Icon(
//                             Icons.camera_alt_outlined,
//                             size: 20,
//                           ),
//                           onPressed: () async {
//                             FilePickerResult? result =
//                                 await FilePicker.platform.pickFiles(
//                                     // error en el codigo de fernando
//                                     // agregar el tipo de archivo
//                                     type: FileType.custom,
//                                     // las extensiones de imagenes permitidas
//                                     allowedExtensions: ["jpg", "jpeg", "png"],
//                                     // permite subir multiples imagenes a la vez
//                                     allowMultiple: false);

//                             if (result != null) {
//                               PlatformFile file = result.files.first;
//                               print("subiendo");
//                               NotificationsService.showBusyIndicator(context);

//                               final updatedUser =
//                                   await userFormProvider.uploadImage(
//                                 "/uploads/avataruser${user.id}",
//                                 file.bytes!,
//                               );
//                               print(updatedUser.img);

//                               Provider.of<UsersProvider>(context, listen: false)
//                                   .refreshUser(updatedUser);

//                               Navigator.of(context).pop();
//                             } else {
//                               // User canceled the picker
//                               ("no hay imagen");
//                             }
//                           },
//                         ),
//                       ),
//                     )
//                   ],
//                 )),
//             const SizedBox(height: 20),
//             Text(
//               user.username,
//               style: const TextStyle(fontWeight: FontWeight.bold),
//               textAlign: TextAlign.center,
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
