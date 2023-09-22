import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/authentication/widgets/textformfield.dart';
import 'package:waste_management/presentation/home/homepage.dart';

class DetailScreen extends StatelessWidget {
   DetailScreen({super.key});

   final _formkey = GlobalKey<FormState>();
final dateOfBirthController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Form(
        key: _formkey,
        child: Container(
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
                  "Provide \nDetails !",
                  style: primaryfont(color: thirdColor, fontSize: 20),
                ),
                SizedBox(
                  height: size.height * 0.1,
                ),
                Column(
                  children: [
                    SizedBox(
                      height: 150,
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Address cant be empty";
                          }else{
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
                            prefixIcon: Icon(
                              Icons.home,
                              color: white,
                            ),
                            prefixIconConstraints: BoxConstraints(
                              minWidth: 70,
                            ),
                            contentPadding: EdgeInsets.only(top: 30,right: 30)),
                      ),
                    ),
                    sizedBox10,
                    GestureDetector(
                      onTap: () {},
                      child: TextFormFieldCustomMade(
                        password: false,
                        controller: dateOfBirthController,
                        hintText: "Date of Birth",
                        prefixIcon: Icons.calendar_month,
                        
                      ),
                    ),
                    sizedBox10,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          "Select your gender",
                          style: primaryfont(
                              color: grey,
                              fontSize: 18,
                              fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                    sizedBox10,
                    Column(
                      children: [
                        Row(
                          children: [
                            ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Male",
                                  style: primaryfont(color: grey),
                                )),
                            sizedBoxW10,
                            ElevatedButton(
                                onPressed: () {},
                                child: Text(
                                  "Female",
                                  style: primaryfont(color: grey),
                                ))
                          ],
                        )
                      ],
                    ),
                    sizedBox10,
                    SizedBox(
                        height: MediaQuery.of(context).size.height * .06,
                        width: MediaQuery.of(context).size.width * .6,
                        child: ElevatedButton(
                          onPressed: () {
                            if (_formkey.currentState!.validate()) {
                               Navigator.of(context).push(MaterialPageRoute(
                              builder: (context) {
                                return HomePage();
                              },
                            ));
                            }
                           
                          },
                          style: ButtonStyle(
                              backgroundColor:
                                  MaterialStatePropertyAll(primaryColor)),
                          child: Text(
                            "Proceed",
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
    );
  }
}
