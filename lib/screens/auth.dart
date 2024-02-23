import 'package:evaluacion_final_flutter/controllers/login_controller.dart';
import 'package:evaluacion_final_flutter/controllers/register_controller.dart';
import 'package:evaluacion_final_flutter/widgets/inputs_fields.dart';
import 'package:evaluacion_final_flutter/widgets/submit_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthScreen extends StatefulWidget {
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  RegisterController registerationController = Get.put(RegisterController());
  LoginController loginController = Get.put(LoginController());

  var isLogin = false.obs;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(36),
          child: Center(
            child: Obx(
              () => Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      child: const Text(
                        'Bienvenido',
                        style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MaterialButton(
                          color:
                              !isLogin.value ? Colors.pinkAccent : Colors.white,
                          onPressed: () {
                            isLogin.value = false;
                          },
                          child: const Text('Registrarse'),
                        ),
                        MaterialButton(
                          color:
                              isLogin.value ? Colors.pinkAccent : Colors.white,
                          onPressed: () {
                            isLogin.value = true;
                          },
                          child: const Text('Iniciar sesión'),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 80,
                    ),
                    isLogin.value ? loginWidget() : registerWidget()
                  ]),
            ),
          ),
        ),
      ),
    );
  }

  Widget registerWidget() {
    return Column(
      children: [
        InputTextFieldWidget(registerationController.nameController, 'Nombres'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.lastnameController, 'Apellidos'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.addressController, 'Dirección'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.phoneNumberController, 'Teléfono'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.birthdayController, 'Fecha de nacimiento'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(registerationController.emailController, 'Email'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(
            registerationController.passwordController, 'Contraseña'),
        const SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => registerationController.registerWithEmail(),
          title: 'Registrarse',
        )
      ],
    );
  }

  Widget loginWidget() {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.emailController, 'Email'),
        const SizedBox(
          height: 20,
        ),
        InputTextFieldWidget(loginController.passwordController, 'Contraseña'),
        const SizedBox(
          height: 20,
        ),
        SubmitButton(
          onPressed: () => loginController.loginWithEmail(),
          title: 'Ingresar',
        )
      ],
    );
  }
}
