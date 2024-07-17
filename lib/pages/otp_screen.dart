import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:verification/components/Navigation/route_names.dart';
import 'package:verification/components/constant/colors.dart';
import 'package:verification/components/constant/string.dart';
import 'package:verification/components/widgets/custom_button.dart';
import 'package:sms_autofill/sms_autofill.dart';

class OtpScreen extends StatefulWidget {
  final String phoneNumber;
  final String verificationId;
  final TextEditingController pinController;

  const OtpScreen({
    super.key,
    required this.phoneNumber,
    required this.verificationId,
    required this.pinController,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final _smsAutoFill = SmsAutoFill();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FocusNode _pinFocusNode = FocusNode();
  bool _isLoading = false;
  String? _errorMessage;

  @override
  void initState() {
    super.initState();
    _pinFocusNode.requestFocus();
  }

  void _listenForCode() async {
    _smsAutoFill.listenForCode;
    _smsAutoFill.code.listen((String code) {
      // Automatically fill the OTP field with `code`
      widget.pinController.text = code;
      // Optionally verify the OTP automatically
      _verifyOTP();
    });
  }

  @override
  void dispose() {
    widget.pinController.dispose();
    _pinFocusNode.dispose();
    super.dispose();
  }

  void _verifyOTP() async {
    if (widget.pinController.text.length != 6) {
      setState(() {
        _errorMessage = 'Please enter a valid 6-digit OTP';
      });
      return;
    }

    setState(() {
      _isLoading = true;
      _errorMessage = null;
    });

    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: widget.verificationId,
        smsCode: widget.pinController.text,
      );

      await _auth.signInWithCredential(credential);

      Navigator.pushNamedAndRemoveUntil(
        context,
        RouteNames.profileSelection,
        ModalRoute.withName(RouteNames.phoneNuberSelection),
      );
    } on FirebaseAuthException catch (e) {
      setState(() {
        _errorMessage = e.message ?? 'An error occurred. Please try again.';
      });
    } catch (e) {
      setState(() {
        _errorMessage = 'An unexpected error occurred. Please try again.';
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
        fontSize: 20,
        color: AppColors.primaryTextColor,
        fontWeight: FontWeight.w600,
      ),
      decoration: BoxDecoration(
        color: Colors.blue[200],
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: Colors.blue.shade300),
      ),
    );

    final focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: Colors.blue.shade500),
      borderRadius: BorderRadius.circular(8),
    );

    final submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration?.copyWith(
        color: Colors.blue.shade100,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 100),
              Text(
                Apptext.verifyPhone,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryTextColor,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                "Code is Sent to ${widget.phoneNumber}",
                style: const TextStyle(color: AppColors.secondaryTextColor),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 20),
              Directionality(
                textDirection: TextDirection.ltr,
                child: Pinput(
                  length: 6,
                  controller: widget.pinController,
                  focusNode: _pinFocusNode,
                  defaultPinTheme: defaultPinTheme,
                  focusedPinTheme: focusedPinTheme,
                  submittedPinTheme: submittedPinTheme,
                  validator: (pin) {
                    return pin?.length == 6 ? null : 'Please enter a valid OTP';
                  },
                  pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                  showCursor: true,
                  onCompleted: (pin) {
                    _verifyOTP();
                  },
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
              const SizedBox(height: 20),
              Stack(
                alignment: Alignment.center,
                children: [
                  Mybutton(
                    onpressed: _isLoading
                        ? () {
                            Null;
                          }
                        : _verifyOTP,
                    text: Apptext.verfyContinue,
                    hieght: 60,
                    width: 300,
                  ),
                  if (_isLoading) const CircularProgressIndicator(),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
