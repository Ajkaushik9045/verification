import 'package:flutter/material.dart';
import 'package:verification/components/constant/colors.dart';
import 'package:verification/components/constant/string.dart';
import 'package:verification/components/widgets/custom_button.dart';

class ProfileSelection extends StatefulWidget {
  const ProfileSelection({super.key});

  @override
  State<ProfileSelection> createState() => _ProfileSelectionState();
}

class _ProfileSelectionState extends State<ProfileSelection> {
  String? _selectedProfile;

  // Define the data for the radio buttons
  final List<Map<String, dynamic>> _profiles = [
    {
      'label': 'Shipper',
      'desc': 'I am a shipper',
      'icon': Icons.store,
      'value': 'shipper',
    },
    {
      'label': 'Transporter',
      'desc': 'I am a transporter',
      'icon': Icons.directions_car,
      'value': 'transporter',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 150),
            child: Center(
              child: Column(
                children: [
                  Text(
                    Apptext
                        .selectProfile, // Replace with Apptext.selectProfile if using constants
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 20),
                  ..._profiles.map(
                    (profile) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            _selectedProfile = profile['value'];
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.symmetric(
                              vertical: 10, horizontal: 20),
                          padding: const EdgeInsets.all(20),
                          // width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: AppColors.primaryColor,
                              width: 2,
                            ),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Transform.scale(
                                    scale: 1.5,
                                    child: Radio<String>(
                                      value: profile['value'],
                                      groupValue: _selectedProfile,
                                      onChanged: (value) {
                                        setState(() {
                                          _selectedProfile = value;
                                        });
                                      },
                                      activeColor: AppColors.primaryColor,
                                    ),
                                  ),
                                  const SizedBox(
                                      width:
                                          5), // Increase spacing between radio button and text
                                  Icon(
                                    profile['icon'],
                                    color: AppColors.primaryColor,
                                    size: 40, // Increase icon size
                                  ),
                                  const SizedBox(
                                      width:
                                          10), // Increase spacing between icon and text
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        profile['label'],
                                        style: const TextStyle(
                                          color: AppColors.primaryColor,
                                          fontSize: 18, // Increase text size
                                        ),
                                      ),
                                      const SizedBox(height: 2),
                                      Text(
                                        profile['desc'], // Display description text
                                        style: const TextStyle(
                                          color: AppColors.secondaryTextColor,
                                          fontSize: 14, // Adjust description text size
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 10),
                  Mybutton(
                      onpressed: () {},
                      text: Apptext.continueButton,
                      hieght: 60,
                      width: 320),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
