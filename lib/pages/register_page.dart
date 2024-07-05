// ignore_for_file: use_build_context_synchronously

import 'package:chatapp/components/items.dart';
import 'package:chatapp/hidden_drawer.dart';
import 'package:chatapp/pages/login_page.dart';
import 'package:chatapp/services/auth/auth_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class RegisterPage extends StatefulWidget {
  // final void Function()? onTap;

  const RegisterPage({
    super.key,
    // required this.onTap,
  });

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  // final TextEditingController password2Controller = TextEditingController();

  bool isLoading = false;

  void signUp() async {
    // if (passwordController.text != password2Controller.text) {
    //   ScaffoldMessenger.of(context).showSnackBar(
    //       const SnackBar(content: Text("Passwords doesn't match!")));
    // }

    if (emailController.text.isEmpty ||
        usernameController.text.isEmpty ||
        passwordController.text.isEmpty) {
      showAlertBox(context, "Please enter all details", Colors.red);
      return;
    }

    setState(() {
      isLoading = true;
    });

    // get auth service
    final authService = Provider.of<AuthService>(context, listen: false);

    try {
      await authService.signUpWithEmailAndPassword(
        emailController.text,
        passwordController.text,
        usernameController.text,
      );
    } catch (e) {
      setState(() {
        isLoading = false;
      });
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
    return isLoading
        ? const LoadingScreen()
        : Scaffold(
            backgroundColor: Colors.grey[300],
            body: SingleChildScrollView(
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    // mainAxisAlignment: MainAxisAlignment.center,
                    // crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 100),
                      // logo
                      Container(
                        height: 150,
                        width: 150,
                        alignment: Alignment.center,
                        decoration: const BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage(
                              'assets/bee/bee_nobg_nooutline.png',
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 25),
                      // welcome back message
                      const Text(
                        // "Bee yourself with Buzz",
                        "Create an Account",
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      // name
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

                      // username
                      MyTextField(
                        controller: usernameController,
                        hintText: "Username",
                        obscureText: false,
                        backgroundColor: Colors.grey.shade200,
                        radius: 4,
                        prefixIcon: const Icon(Icons.person),
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

                      const SizedBox(height: 35),
                      // signin button
                      MyButton(onTap: signUp, text: "Sign up"),
                      // register now
                      const SizedBox(height: 15),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Already a member?"),
                          const SizedBox(width: 6),
                          GestureDetector(
                            onTap: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (BuildContext context) =>
                                      const LoginPage(),
                                ),
                              );
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //     builder: (BuildContext context) =>
                              //         const LoadingScreen(),
                              //   ),
                              // );
                            },
                            child: const SizedBox(
                              height: 30,
                              child: Center(
                                child: Text(
                                  "  Login now    ",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
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
