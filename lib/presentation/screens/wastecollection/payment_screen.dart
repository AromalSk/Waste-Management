// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/domain/repositories/weekly_collection.dart';
import 'package:waste_management/presentation/screens/wastecollection/pay_success_screen.dart';
import 'package:waste_management/presentation/widgets/backbutton.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class PaymentScreen extends StatefulWidget {
  String streetAddress;
  String title;
  int index;
  String latitude;
  String longitude;
  String amount;

  PaymentScreen(
      {Key? key,
      required this.streetAddress,
      required this.title,
      required this.index,
      required this.latitude,
      required this.longitude,
      required this.amount})
      : super(key: key);

  @override
  State<PaymentScreen> createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var _razorpay = Razorpay();

  @override
  void initState() {
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    super.initState();
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    // Do something when payment succeeds
    print("payment done");
    Navigator.of(context).push(MaterialPageRoute(
      builder: (context) {
        return const PaymentSuccessful();
      },
    ));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    // Do something when payment fails
    print('payment error');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    // Do something when an external wallet is selected
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
            gradient: LinearGradient(
                colors: [Color(0xff44ADA8), Color(0xffC3EFB7)],
                stops: [0.1, 0.9],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight)),
        child: SafeArea(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.only(left: 20),
                child: Row(
                  children: [
                    BackButtonCustomMade(),
                  ],
                ),
              ),
              sizedBox50,
              Padding(
                padding: const EdgeInsets.only(left: 40),
                child: Text(
                  "Confirm the details you have provided :",
                  style: primaryfont(color: white, fontSize: 20),
                ),
              ),
              sizedBox30,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff44ADA8),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: primaryfont(color: white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              sizedBox10,
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  decoration: const BoxDecoration(
                      color: Color(0xff44ADA8),
                      borderRadius: BorderRadius.all(Radius.circular(10))),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.streetAddress,
                          style: primaryfont(color: white, fontSize: 18),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              sizedBox10,
              SizedBox(
                  height: MediaQuery.of(context).size.height * .06,
                  width: MediaQuery.of(context).size.width * .6,
                  child: ElevatedButton(
                    onPressed: () {},
                    style: const ButtonStyle(
                        backgroundColor:
                            MaterialStatePropertyAll(primaryColor)),
                    child: Text(
                      "₹ 50.00",
                      style: primaryfont(color: white, fontSize: 24),
                    ),
                  )),
              sizedBox30,
              InkWell(
                onTap: () {
                  var options = {
                    'key': 'rzp_test_ESaJeRtOUFPAcN',
                    'amount': 5000,
                    'name': 'Waste Management',
                    'description': 'Demo',
                    'timeout': 300, // in seconds
                    'prefill': {
                      'contact': '9898989898',
                      'email': 'aromalskumar97148@gmail.com'
                    }
                  };
                  _razorpay.open(options);
                  setCollectionDetailsToFirebase(
                      widget.index,
                      widget.streetAddress,
                      widget.latitude,
                      widget.longitude,
                      widget.amount,
                      widget.title);
                },
                splashFactory: InkRipple.splashFactory,
                splashColor: Colors.blueAccent,
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50)),
                  child: Container(
                    height: 70,
                    width: 70,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        gradient: const LinearGradient(
                            colors: [Color(0xffB1E5B4), Color(0xff48AFA8)],
                            begin: Alignment.topCenter,
                            end: Alignment.bottomCenter)),
                    child: Center(
                      child: Text(
                        "Pay",
                        style: primaryfont(
                            fontSize: 24,
                            color: white,
                            fontWeight: FontWeight.w500),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _razorpay.clear();
    super.dispose();
  }
}
