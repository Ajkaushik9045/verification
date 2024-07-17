// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:verification/components/Navigation/route_names.dart';
import 'package:verification/components/constant/colors.dart';
import 'package:verification/components/constant/string.dart';
import 'package:verification/components/widgets/custom_button.dart';

class LanguageSelector extends StatefulWidget {
  const LanguageSelector({super.key});

  @override
  State<LanguageSelector> createState() => _LanguageSelectorState();
}

class _LanguageSelectorState extends State<LanguageSelector> {
  // List of languages to select
  List<String> languages = [
    'English',
    'Spanish',
    'French',
    'German',
    'Chinese'
  ];

  // Default selected language
  String selectedLanguage = 'English';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(top: 100),
            child: Column(
              // mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.image_outlined, size: 50, color: Colors.black),
                SizedBox(height: 20),
                Text(
                  Apptext.selectLangauge,
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                SizedBox(height: 10),
                RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                        // style: DefaultTextStyle.of(context).style,
                        style: TextStyle(color: AppColors.secondaryTextColor),
                        children: const <TextSpan>[
                          TextSpan(text: 'You can change the language '),
                          TextSpan(
                            text: '\nat any time',
                          ),
                        ])),
                SizedBox(height: 20),
                Container(
                  width: 200,
                  padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                  decoration: BoxDecoration(
                    border: Border.all(color: AppColors.secondaryTextColor, width: 2),
                    borderRadius: BorderRadius.circular(
                        4), // Adjust the radius to get the square shape
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: selectedLanguage,
                      icon: Icon(Icons.arrow_downward),
                      iconSize: 24,
                      elevation: 16,
                      style: TextStyle(color: AppColors.primaryTextColor),
                      onChanged: (String? newValue) {
                        setState(() {
                          selectedLanguage = newValue!;
                        });
                      },
                      items: languages
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Mybutton(
                    onpressed: () {
                      Navigator.of(context)
                          .pushNamed(RouteNames.phoneNuberSelection);
                    },
                    text: Apptext.nextButton,
                    hieght: 60,
                    width: 200),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
