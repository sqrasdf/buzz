// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/components/items.dart';
import 'package:chatapp/hidden_drawer.dart';
// import 'package:chatapp/pages/hello_page.dart';
import 'package:chatapp/pages/register_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatefulWidget {
  // final void Function()? onTap;

  const LoginPage({
    super.key,
    // required this.onTap,
  });

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool isLoading = false;

  void signIn() async {
    if (emailController.text.isEmpty || passwordController.text.isEmpty) {
      showAlertBox(context, "Please enter all details", Colors.red);
      return;
    }
    setState(() {
      isLoading = true;
    });

    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signInWithEmailAndPassword(
        emailController.text,
        passwordController.text,
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
      // emailController.clear();
      passwordController.clear();

      showAlertBox(context, e.toString(), Colors.red);
      return;
    }
    await Future.delayed(const Duration(milliseconds: 3100));
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (BuildContext context) => const HiddenDrawer(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: isLoading
          ? const LoadingScreen()
          : SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 120),
                      // logo
                      Container(
                          height: 150,
                          width: 150,
                          alignment: Alignment.center,
                          decoration: const BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/bee/bee_nobg_nooutline.png')))),
                      const SizedBox(height: 25),
                      // welcome back message
                      const Text(
                        // "Bee yourself with Buzz",
                        "Hi, Welcome Back!",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      const SizedBox(height: 35),
                      // email
                      MyTextField(
                        controller: emailController,
                        hintText: "Email",
                        obscureText: false,
                        backgroundColor: Colors.grey.shade200,
                        radius: 4,
                        prefixIcon: const Icon(Icons.mail),
                      ),
                      const SizedBox(height: 10),
                      // password
                      MyTextField(
                        controller: passwordController,
                        hintText: "Password",
                        obscureText: true,
                        backgroundColor: Colors.grey.shade200,
                        radius: 4,
                        prefixIcon: const Icon(Icons.lock),
                      ),
                      const SizedBox(height: 30),
                      // signin button
                      MyButton(onTap: signIn, text: "Sign in"),
                      // register now
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Not a member yet?"),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const RegisterPage(),
                                ),
                              );
                            },
                            child: const SizedBox(
                              height: 30,
                              child: Center(
                                child: Text(
                                  "  Register now    ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 10),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
