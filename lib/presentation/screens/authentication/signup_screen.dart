import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/domain/entities/user.dart';
import 'package:waste_management/infrastucture/authentication/signup.dart';
import 'package:waste_management/infrastucture/authentication/validator.dart';
import 'package:waste_management/presentation/screens/authentication/details_screen.dart';
import 'package:waste_management/presentation/widgets/textformfield.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({super.key});

  final emailController = TextEditingController();

  final passwordController = TextEditingController();

  final confirmPasswordController = TextEditingController();

  bool submitted = false;

  final _formKey = GlobalKey<FormState>();

  String? validateConfirmPassword(String? value) {
    if (value == null || value.isEmpty) {
      return 'Confirm Password is required';
    }
    if (value != passwordController.text) {
      return 'Passwords do not match';
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formKey,
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('asset/images/login-signin.jpg'),
              fit: BoxFit.cover,
            ),
          ),
          child: ListView(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    IconButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(thirdColor)),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      icon: const Icon(
                        Icons.arrow_back_outlined,
                        color: grey,
                      ),
                    ),
                    sizedBox10,
                    Text(
                      "Create \nAccount .",
                      style: primaryfont(color: thirdColor, fontSize: 20),
                    ),
                    SizedBox(
                      height: size.height * 0.08,
                    ),
                    Column(
                      children: [
                        sizedBox10,
                        TextFormFieldCustomMade(
                          password: false,
                          controller: emailController,
                          hintText: "Email",
                          prefixIcon: Icons.email,
                          isEmailField: true,
                          customValidator: validateEmail,
                        ),
                        sizedBox10,
                        sizedBox10,
                        TextFormFieldCustomMade(
                          password: true,
                          controller: passwordController,
                          prefixIcon: Icons.password_rounded,
                          hintText: "Password",
                          customValidator: validatePassword,
                        ),
                        sizedBox10,
                        TextFormFieldCustomMade(
                          password: true,
                          controller: confirmPasswordController,
                          prefixIcon: Icons.password,
                          hintText: "Confirm Password",
                          customValidator: validateConfirmPassword,
                        ),
                        sizedBox10,
                        SizedBox(
                            height: size.height * .06,
                            width: size.width * .6,
                            child: ElevatedButton(
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  await signUp(emailController.text.trim(),
                                      passwordController.text.trim());

                                  final details = FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(FirebaseAuth
                                          .instance.currentUser!.uid);
                                  final user = UserDetails(
                                      email: emailController.text.trim());
                                  details.set(user.toMap());
                                  Navigator.of(context).push(MaterialPageRoute(
                                    builder: (context) {
                                      return DetailScreen(
                                        
                                      );
                                    },
                                  ));
                                }
                              },
                              style: const ButtonStyle(
                                  backgroundColor:
                                      MaterialStatePropertyAll(primaryColor)),
                              child: Text(
                                "Sign Up",
                                style: primaryfont(color: white, fontSize: 24),
                              ),
                            )),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// class DummySignup extends StatelessWidget {
//   const DummySignup({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return StreamBuilder(
//       stream: FirebaseAuth.instance.authStateChanges(),
//       builder: (context, snapshot) {
//         if (snapshot.hasData) {
//           return DetailScreen();
//         } else {
//           return SignUpScreen();
//         }
//       },
//     );
//   }
// }
