import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/infrastucture/authentication/validator.dart';
import 'package:waste_management/presentation/bloc/gender/gender_bloc.dart';
import 'package:waste_management/presentation/screens/authentication/login_signup_screen.dart';
import 'package:waste_management/presentation/widgets/textformfield.dart';

class DetailScreen extends StatefulWidget {
  const DetailScreen({super.key});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  DateTime _dateTime = DateTime.now();
  String? bithdate;
  final _formkey = GlobalKey<FormState>();

  TextEditingController dateOfBirthController = TextEditingController();

  final usernameController = TextEditingController();
  final phoneNumberController = TextEditingController();

  final addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          return Form(
            key: _formkey,
            child: SingleChildScrollView(
              child: Container(
                height: size.height,
                width: size.width,
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
                        "Provide \nDetails !",
                        style: primaryfont(color: thirdColor, fontSize: 20),
                      ),
                      SizedBox(
                        height: size.height * 0.04,
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
                          TextFormFieldCustomMade(
                            password: false,
                            controller: phoneNumberController,
                            prefixIcon: Icons.phone,
                            hintText: "Phone Number",
                            customValidator: validatePhoneNumber,
                          ),
                          SizedBox(
                            height: 150,
                            child: TextFormField(
                              controller: addressController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Address cant be empty";
                                } else {
                                  return null;
                                }
                              },
                              maxLines: 5,
                              style: primaryfont(
                                color: white,
                              ),
                              decoration: InputDecoration(
                                  hintText: "Address",
                                  hintStyle: primaryfont(
                                    fontWeight: FontWeight.w500,
                                    color: white,
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20)),
                                  focusedBorder: OutlineInputBorder(
                                      borderSide: BorderSide.none,
                                      borderRadius: BorderRadius.circular(20)),
                                  filled: true,
                                  fillColor: Colors.black.withOpacity(0.2),
                                  prefixIcon: const Icon(
                                    Icons.home,
                                    color: white,
                                  ),
                                  prefixIconConstraints: const BoxConstraints(
                                    minWidth: 70,
                                  ),
                                  contentPadding: const EdgeInsets.only(
                                      top: 30, right: 30)),
                            ),
                          ),
                          sizedBox30,
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  style: primaryfont(color: white),
                                  controller: dateOfBirthController,
                                  onTap: () {
                                    _showDatePicker(context);
                                  },
                                  decoration: InputDecoration(
                                      hintText: "Date of Birth",
                                      hintStyle: primaryfont(
                                        fontWeight: FontWeight.w500,
                                        color: white,
                                      ),
                                      enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius:
                                              BorderRadius.circular(100)),
                                      filled: true,
                                      fillColor: Colors.black.withOpacity(0.3),
                                      prefixIcon: const Icon(
                                        Icons.date_range,
                                        color: white,
                                      ),
                                      prefixIconConstraints:
                                          const BoxConstraints(
                                        minWidth: 70,
                                      ),
                                      contentPadding: const EdgeInsets.only()),
                                ),
                              ),
                            ],
                          ),
                          sizedBox30,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Select your gender",
                                style: primaryfont(
                                    color: white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.w500),
                              ),
                            ],
                          ),
                          sizedBox10,
                          Column(
                            children: [
                              BlocBuilder<GenderBloc, GenderState>(
                                builder: (context, state) {
                                  return Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      state.gender == "Male"
                                                          ? forthColor
                                                          : grey)),
                                          onPressed: () {
                                            context
                                                .read<GenderBloc>()
                                                .add(Male());
                                          },
                                          child: Text(
                                            "Male",
                                            style: primaryfont(color: white),
                                          )),
                                      sizedBoxW10,
                                      ElevatedButton(
                                          style: ButtonStyle(
                                              backgroundColor:
                                                  MaterialStatePropertyAll(
                                                      state.gender == "Female"
                                                          ? forthColor
                                                          : grey)),
                                          onPressed: () {
                                            context
                                                .read<GenderBloc>()
                                                .add(Female());
                                          },
                                          child: Text(
                                            "Female",
                                            style: primaryfont(color: white),
                                          ))
                                    ],
                                  );
                                },
                              )
                            ],
                          ),
                          sizedBox10,
                          BlocBuilder<GenderBloc, GenderState>(
                            builder: (context, state) {
                              return SizedBox(
                                  height:
                                      MediaQuery.of(context).size.height * .06,
                                  width: MediaQuery.of(context).size.width * .6,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      handleSignup(context, state.gender);
                                    },
                                    style: const ButtonStyle(
                                        backgroundColor:
                                            MaterialStatePropertyAll(
                                                primaryColor)),
                                    child: Text(
                                      "Proceed",
                                      style: primaryfont(
                                          color: white, fontSize: 24),
                                    ),
                                  ));
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  void handleSignup(BuildContext context, String gender) async {
    if (_formkey.currentState!.validate()) {
      if (gender == "") {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please select your gender.')),
        );
        return;
      }
      print("2");

      print("3");
      final details = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      print('4');
      final user = {
        'userId': details.id,
        'dateTime': DateTime.now(),
        'phonenumber': phoneNumberController.text.trim(),
        'userName': usernameController.text.trim(),
        'address': addressController.text,
        'birthdate': dateOfBirthController.text,
        'gender': gender
      };
      await details.update(user);
      print("5");
      Navigator.of(context).pushReplacement(MaterialPageRoute(
        builder: (context) {
          return const LoginSignup();
        },
      ));
    }
  }

  _showDatePicker(BuildContext context) {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1900),
            lastDate: DateTime(2024))
        .then((value) {
      setState(() {
        _dateTime = value!;
        bithdate = _dateTime.day.toString() +
            " - " +
            _dateTime.month.toString() +
            " - " +
            _dateTime.year.toString();
        dateOfBirthController.text = bithdate ?? "hello";
      });
    });
  }
}
