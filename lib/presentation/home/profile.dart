import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';


class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Container(
        // height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: primaryColor,
                    backgroundImage: AssetImage('asset/images/womenmain.png'),
                    child: Container(),
                  ),
                  Text(
                    "Angelina \nJolie",
                    style: primaryfont(color: white, fontSize: 26),
                  )
                ],
              ),
              sizedBox10,
              Container(
                decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
                      Text("angelinaJolie@gmail.com",
                          style: primaryfont(color: white, fontSize: 18))
                    ],
                  ),
                ),
              ),
              sizedBox10,
              Container(
                decoration: BoxDecoration(
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
                decoration: BoxDecoration(
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
              Container(
                decoration: BoxDecoration(
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
            ],
          ),
        ),
      ),
    );
  }
}
