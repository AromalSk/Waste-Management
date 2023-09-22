import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/infrastucture/authentication/signup.dart';
import 'package:waste_management/infrastucture/authentication/validator.dart';
import 'package:waste_management/presentation/authentication/details_screen.dart';
import 'package:waste_management/presentation/authentication/widgets/textformfield.dart';
import 'package:waste_management/presentation/home/homepage.dart';

class SignUpScreen extends StatefulWidget {
  SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final usernameController = TextEditingController();

  final emailController = TextEditingController();

  final phoneNumberController = TextEditingController();

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

  handleSignUp() async {
    if (_formKey.currentState!.validate()) {
      // All form fields are valid, proceed with signup
      await signUp(emailController.text.trim(), passwordController.text.trim());
    }
    if (FirebaseAuth.instance.currentUser != null) {
      Navigator.of(context).push(MaterialPageRoute(
        builder: (context) {
          return DummySignup();
        },
      ));
    }
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
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  IconButton(
                    style: ButtonStyle(
                        backgroundColor: MaterialStatePropertyAll(thirdColor)),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    icon: Icon(
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
                      TextFormFieldCustomMade(
                        password: false,
                        controller: usernameController,
                        prefixIcon: Icons.person,
                        hintText: "Username",
                        customValidator: validateUsername,
                      ),
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
                      TextFormFieldCustomMade(
                        password: false,
                        controller: phoneNumberController,
                        prefixIcon: Icons.phone,
                        hintText: "Phone Number",
                        customValidator: validatePhoneNumber,
                      ),
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
                            onPressed: () {
                              handleSignUp();
                            },
                            style: ButtonStyle(
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
          ),
        ),
      ),
    );
  }
}

class DummySignup extends StatelessWidget {
  const DummySignup({super.key});

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DetailScreen();
        } else {
          return SignUpScreen();
        }
      },
    );
  }
}
