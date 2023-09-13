import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/authentication/widgets/textformfield.dart';
import 'package:waste_management/presentation/home/homepage.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('asset/images/login-signin.jpg'),
            fit: BoxFit.cover,
          ),
        ),
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
                "Welcome \nBack !",
                style: primaryfont(color: thirdColor, fontSize: 20),
              ),
              SizedBox(height: size.height * 0.2,),
              Column(
                children: [
                  TextFormFieldCustomMade(
                    hintText: "Email",
                    prefixIcon: Icons.email,
                  ),
                  sizedBox10,
                  TextFormFieldCustomMade(
                      prefixIcon: Icons.password_rounded, hintText: "Password"),
                      sizedBox10,
                  SizedBox(
                      height: MediaQuery.of(context).size.height * .06,
                      width: MediaQuery.of(context).size.width * .6,
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.of(context).push(MaterialPageRoute(
                            builder: (context) {
                              return HomePage();
                            },
                          ));
                        },
                        style: ButtonStyle(
                            backgroundColor:
                                MaterialStatePropertyAll(primaryColor)),
                        child: Text(
                          "Login",
                          style: primaryfont(color: white, fontSize: 24),
                        ),
                      )),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
