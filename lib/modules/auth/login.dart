import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:learning_2_10c/kernel/text_field_password.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _pass = TextEditingController();
  bool _isObscure = true;
  late FirebaseMessaging _messaging;

  @override
  void initState() {
    super.initState();
    _initializeFirebaseMessaging();
  }

  void _initializeFirebaseMessaging() async {
    _messaging = FirebaseMessaging.instance;

    // Solicitar permisos de notificación
    NotificationSettings settings = await _messaging.requestPermission(
      alert: true,
      badge: true,
      sound: true,
    );

    print('Permisos de notificación: ${settings.authorizationStatus}');

    // Obtener el token de Firebase Messaging
    String? token = await _messaging.getToken();
    print('FCM Token: $token');

    // Manejar mensajes en primer plano
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Mensaje recibido: ${message.notification?.title}');
    });

    // Manejar notificaciones abiertas
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Notificación abierta: ${message.notification?.title}');
    });
  }

  void _login() async {
    if (!_formKey.currentState!.validate()) return;

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _email.text.trim(),
        password: _pass.text,
      );
      print("${_email.text}, ${_pass.text}");

      // Navegar a la pantalla principal después del inicio de sesión
      Navigator.pushReplacementNamed(context, '/home');
    } on FirebaseAuthException catch (e) {
      String errorMessage = 'Ocurrió un error.';
      if (e.code == 'user-not-found') {
        errorMessage = 'No se encontró un usuario con ese correo.';
      } else if (e.code == 'wrong-password') {
        errorMessage = 'Contraseña incorrecta.';
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(errorMessage)),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Center(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/icon_3d.png', width: 150, height: 150),
                    const SizedBox(height: 32),
                    TextFormField(
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(),
                        isDense: true,
                        hintText: "tu@correo.com",
                        label: Text("Correo electrónico"),
                        prefixIcon: Icon(Icons.email_outlined),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      controller: _email,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, ingresa un correo electrónico.';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 32.0),
                    TextFieldPassword(controller: _pass),
                    const SizedBox(height: 32.0),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _login,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.black,
                          foregroundColor: Colors.white,
                        ),
                        child: const Text("Iniciar sesión"),
                      ),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pushNamed(context, '/register'),
                      child: const Text(
                        "Registrarse",
                        style: TextStyle(
                          color: Colors.blue,
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.blue,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
