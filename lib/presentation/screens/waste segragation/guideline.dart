import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:waste_management/constants/costants.dart';
import 'package:waste_management/presentation/widgets/backbutton.dart';

class WasteSegragationGuideline extends StatelessWidget {
  const WasteSegragationGuideline({super.key});

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
          child: SingleChildScrollView(
            child: Column(
              children: [
                const Padding(
                  padding: EdgeInsets.all(8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      BackButtonCustomMade(),
                    ],
                  ),
                ),
                Lottie.asset("asset/lottie/animation_lnidfakg.json"),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Plastic Segragation Guideline.",
                      style: primaryfont(fontSize: 24),
                      textAlign: TextAlign.center,
                    ),
                    sizedBox30,
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Plastic waste is a pressing environmental concern, and effective segregation is vital for sustainable waste management. By understanding the various types of plastic and implementing proper segregation techniques, we can significantly reduce the environmental impact of plastic pollution.',
                        style: primaryfont(fontSize: 16),
                      ),
                    ),
                    sizedBox10,
                    Text(
                      'Types of Plastic Wastes',
                      style: primaryfont(fontSize: 20),
                    ),
                    sizedBox10,
                    Padding(
                      padding: const EdgeInsets.all(16),
                      child: Text(
                          'PETE or PET (Polyethylene Terephthalate): Used in water bottles and food packaging. Segregate PET by checking the label or looking for a "1" symbol.HDPE (High-Density Polyethylene): Commonly found in milk jugs, detergent bottles, and toys. Look for the "2" symbol for segregation.PVC (Polyvinyl Chloride): Often used in pipes, window frames, and some packaging. Check for the "3" symbol during segregation.LDPE (Low-Density Polyethylene): Found in plastic bags, shrink wraps, and squeezable bottles. Identify LDPE with the "4" symbol for proper segregation.PP (Polypropylene): Used in food containers, medicine bottles, and bottle caps. Look for the "5" symbol during segregation.PS (Polystyrene): Commonly found in foam cups, meat trays, and take-out containers. Segregate using the "6" symbol as a guide.Other Plastics: Includes various other types of plastic that do not fall into the above categories. Segregate them separately to enable proper processing.',
                          style: primaryfont()),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Adopting effective plastic waste segregation techniques is crucial for minimizing environmental pollution and promoting sustainable waste management practices. By understanding the types of plastic and implementing proper segregation methods, we can contribute to a cleaner and healthier environment for future generations.',
                        style: primaryfont(),
                      ),
                    )
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
