import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final Color backgroundColor;
  final double radius;
  final Widget? prefixIcon;
  final Function(PointerDownEvent)? onTapOutside;
  const MyTextField({
    super.key,
    required this.controller,
    required this.hintText,
    required this.obscureText,
    required this.backgroundColor,
    required this.radius,
    required this.prefixIcon,
    this.onTapOutside,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      onTapOutside: onTapOutside ?? (event) => FocusScope.of(context).unfocus(),
      onTap: () {
        SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
            overlays: [SystemUiOverlay.bottom]);
      },
      controller: controller,
      obscureText: obscureText,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        prefixIconColor: Colors.grey,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backgroundColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: backgroundColor),
          borderRadius: BorderRadius.circular(radius),
        ),
        fillColor: backgroundColor,
        filled: true,
        hintText: hintText,
        hintStyle: const TextStyle(
          color: Colors.grey,
        ),
      ),
    );
  }
}

class MyButton extends StatelessWidget {
  final void Function()? onTap;
  final String text;
  final Color? buttonColor;
  final Color? textColor;
  const MyButton({
    super.key,
    required this.onTap,
    required this.text,
    this.buttonColor,
    this.textColor,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: buttonColor ?? Colors.black,
            borderRadius: BorderRadius.circular(
              10,
            )),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: textColor ?? Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingScreen extends StatelessWidget {
  const LoadingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(),
        backgroundColor: Colors.grey.shade300,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              AvatarGlow(
                duration: const Duration(milliseconds: 1500),
                glowColor: Colors.amber,
                endRadius: 80,
                child: Container(
                    height: 125,
                    width: 125,
                    alignment: Alignment.center,
                    decoration: const BoxDecoration(
                        image: DecorationImage(
                            image: AssetImage(
                                'assets/bee/bee_nobg_nooutline.png')))),
              ),
              const Text(
                "Bee yourself with Buzz",
                // "Create an Account",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ],
          ),
        ));
  }
}

void showAlertBox(context, message, color) {
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(message),
    duration: const Duration(seconds: 3),
    backgroundColor: color,
    action: SnackBarAction(
      label: "OK",
      onPressed: () {},
      textColor: Colors.white,
    ),
  ));
}
