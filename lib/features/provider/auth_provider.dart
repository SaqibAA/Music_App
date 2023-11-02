import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/architect.dart';

class AuthProvider extends ChangeNotifier {
  String countryCode = "+91";
  bool isOTP = false;
  bool isValidNumber = false;
  String verID = "";

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void setOptScreen(bool val) {
    isOTP = val;
    notifyListeners();
  }

  void setValidNumber(bool val) {
    isValidNumber = val;
    notifyListeners();
  }

  void setCountryCode(String code) {
    countryCode = code;
    notifyListeners();
  }

  Future<void> verifyMobileNumber(context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "$countryCode${phoneController.text}",
      timeout: const Duration(minutes: 1),
      verificationCompleted: (PhoneAuthCredential credential) async {
        otpController.text = credential.smsCode.toString();
      },
      verificationFailed: (FirebaseAuthException e) {
        if (e.code == 'invalid-phone-number') {
          Utils.snackBarError(
              "The Provided Phone Number is Not Valid.", context);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        Utils.snackBarSuccessfull("OTP Sent!", context);
        verID = verificationId;
        setOptScreen(true);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        Utils.snackBarError("Timeout!", context);
      },
    );
  }

  Future<void> verifyOTP(context) async {
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verID,
        smsCode: otpController.text,
      );
      auth.signInWithCredential(credential).then((result) {
        if (result.user != null) {
          // setValidNumber(false);
          // setOptScreen(false);
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => const DashBoard()),
              (route) => false);
        }
      }).catchError((e) {
        debugPrint(e);
        Utils.snackBarError("Incorrect OTP!, Try Again", context);
      });
    } catch (e) {
      debugPrint("rrrrrrr$e");
    }
  }
}
