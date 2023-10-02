import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/bloc/logout/logout_bloc.dart';
import 'package:waste_management/presentation/screens/authentication/login_signup_screen.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser!;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        width: size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff44ADA8), Color(0xffC3EFB7)],
                stops: [0.1, 0.9],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: Padding(
          padding: const EdgeInsets.only(top: 40, left: 40, right: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              IconButton(
                style: const ButtonStyle(
                    backgroundColor: MaterialStatePropertyAll(thirdColor)),
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(
                  Icons.arrow_back_outlined,
                  color: grey,
                ),
              ),
              sizedBox10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: primaryColor,
                    backgroundImage:
                        const AssetImage('asset/images/womenmain.png'),
                    child: Container(),
                  ),
                  sizedBoxW30,
                  Expanded(
                    child: Text(
                      user.displayName ?? "name",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                      style: primaryfont(color: white, fontSize: 26),
                    ),
                  )
                ],
              ),
              sizedBox10,
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xff44ADA8),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Mobile Number",
                        style: primaryfont(color: white, fontSize: 18),
                      ),
                      Text("989543778",
                          style: primaryfont(color: white, fontSize: 18))
                    ],
                  ),
                ),
              ),
              sizedBox10,
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xff547981),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Email",
                        style: primaryfont(color: white, fontSize: 18),
                      ),
                      Text(user.email ?? "no email",
                          style: primaryfont(color: white, fontSize: 18))
                    ],
                  ),
                ),
              ),
              sizedBox10,
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xff547981),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Address",
                        style: primaryfont(color: white, fontSize: 18),
                      ),
                      Text("789 Coconut Avenue \nKochi,Kerala \n682001",
                          style: primaryfont(color: white, fontSize: 18))
                    ],
                  ),
                ),
              ),
              sizedBox10,
              Container(
                decoration: const BoxDecoration(
                    color: Color(0xff547981),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Gender",
                        style: primaryfont(color: white, fontSize: 18),
                      ),
                      Text("Female",
                          style: primaryfont(color: white, fontSize: 18))
                    ],
                  ),
                ),
              ),
              sizedBox10,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    decoration: const BoxDecoration(
                        color: Color(0xff547981),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Date of Birth",
                            style: primaryfont(color: white, fontSize: 18),
                          ),
                          Text("1-4-1999",
                              style: primaryfont(color: white, fontSize: 18))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      context.read<LogoutBloc>().add(LogoutEvent());
                      Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) {
                          return const LoginSignup();
                        },
                      ));
                    },
                    child: Container(
                      height: 50,
                      width: 50,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(200),
                          color: const Color(0xff44ADA8)),
                      child: const Icon(
                        Icons.logout,
                        color: white,
                      ),
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
