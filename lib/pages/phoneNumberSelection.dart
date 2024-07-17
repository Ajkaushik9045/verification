import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:verification/components/Navigation/route_names.dart';
import 'package:verification/components/constant/colors.dart';
import 'package:verification/components/constant/string.dart';
import 'package:verification/components/widgets/custom_button.dart';

class PhoneNumberEntryPage extends StatefulWidget {
  const PhoneNumberEntryPage({super.key});

  static String verify = "";

  @override
  PhoneNumberEntryPageState createState() => PhoneNumberEntryPageState();
}

class PhoneNumberEntryPageState extends State<PhoneNumberEntryPage> {
  final _formKey = GlobalKey<FormState>();
  final _phoneNumberController = TextEditingController();
  final TextEditingController _pinController = TextEditingController();
  String? _errorMessage;
  String CountryCode = "+91";
  bool _isLoading = false;

  @override
  void dispose() {
    _phoneNumberController.dispose();
    _pinController.dispose();
    super.dispose();
  }

  void _submit() async {
    setState(() {
      _errorMessage = _validatePhoneNumber(_phoneNumberController.text);
      _isLoading = true;
    });

    if (_formKey.currentState!.validate()) {
      final phoneNumber = CountryCode + _phoneNumberController.text;
      await FirebaseAuth.instance.verifyPhoneNumber(
        phoneNumber: phoneNumber,
        verificationCompleted: (PhoneAuthCredential credential) {
          _pinController.text = credential.smsCode ?? "";
          setState(() {
            _isLoading = false;
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          setState(() {
            _errorMessage = e.message;
            _isLoading = false;
          });
        },
        codeSent: (String verificationId, int? resendToken) {
          PhoneNumberEntryPage.verify = verificationId;
          Navigator.pushNamed(
            context,
            RouteNames.otpVerification,
            arguments: {
              'phoneNumber': phoneNumber,
              'verificationId': verificationId,
              'pinController': _pinController,
            },
          );
          setState(() {
            _isLoading = false;
          });
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    } else {
      setState(() {
        _isLoading = false;
      });
    }
  }

  String? _validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return Apptext.numberIsRequired;
    } else if (!RegExp(r'^\+?[0-9]{10,13}$').hasMatch(value)) {
      return Apptext.enterValidNumber;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.close),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 100),
          child: Center(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    Apptext.enterMobileNumber,
                    style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: AppColors.primaryTextColor),
                  ),
                  const SizedBox(height: 10),
                  RichText(
                    textAlign: TextAlign.center,
                    text: const TextSpan(
                      style: TextStyle(color: AppColors.secondaryTextColor),
                      children: <TextSpan>[
                        TextSpan(text: "You'll receive a 6 digit code "),
                        TextSpan(
                          text: '\nto verify next',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    height: 60,
                    width: 300,
                    child: TextFormField(
                      controller: _phoneNumberController,
                      decoration: InputDecoration(
                        labelText: Apptext.mobileLable,
                        border: const OutlineInputBorder(),
                        prefixIcon: Container(
                          width: 80,
                          padding: const EdgeInsets.all(8),
                          child: const Row(
                            children: [
                              Image(
                                image: AssetImage('lib/assets/india.png'),
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                '+91',
                                style: TextStyle(
                                    fontSize: 16, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      keyboardType: TextInputType.phone,
                    ),
                  ),
                  if (_errorMessage != null)
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Text(
                        _errorMessage!,
                        style: const TextStyle(color: AppColors.error),
                      ),
                    ),
                  const SizedBox(height: 10),
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      Mybutton(
                        onpressed: _isLoading ? () {} : _submit,
                        text: Apptext.continueButton,
                        hieght: 60,
                        width: 300,
                      ),
                      if (_isLoading) const CircularProgressIndicator(),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
