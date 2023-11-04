import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:music_app/architect.dart';

class AuthProvider extends ChangeNotifier {
  String countryCode = "+91";
  bool isDialog = false;
  bool isOTP = false;
  bool isValidNumber = false;
  String verID = "";

  TextEditingController phoneController = TextEditingController();
  TextEditingController otpController = TextEditingController();

  void setDialog(bool val) {
    isDialog = val;
    notifyListeners();
  }

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
    setDialog(true);
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: "$countryCode${phoneController.text}",
      timeout: const Duration(minutes: 1),
      verificationCompleted: (PhoneAuthCredential credential) async {
        otpController.text = credential.smsCode.toString();
      },
      verificationFailed: (FirebaseAuthException e) {
        setDialog(false);
        if (e.code == 'invalid-phone-number') {
          Utils.snackBarError(
              "The Provided Phone Number is Not Valid.", context);
        }
      },
      codeSent: (String verificationId, int? resendToken) {
        setDialog(false);
        Utils.snackBarSuccessfull("OTP Sent!", context);
        verID = verificationId;
        setOptScreen(true);
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setDialog(false);
        Utils.snackBarError("Timeout!", context);
      },
    );
  }

  Future<void> verifyOTP(BuildContext context) async {
    setDialog(true);
    try {
      FirebaseAuth auth = FirebaseAuth.instance;
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
        verificationId: verID,
        smsCode: otpController.text,
      );
      UserCredential result = await auth.signInWithCredential(credential);
      if (result.user != null) {
        setDialog(false);
        setOptScreen(false);
        setValidNumber(false);
        phoneController.text = '';
        otpController.text ='';
        verID = "";

        // ignore: use_build_context_synchronously
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (context) => const DashBoard()),
            (route) => false);
      }
    } on FirebaseAuthException catch (e) {
      debugPrint(e.toString());
      setDialog(false);
      Utils.snackBarError("Incorrect OTP! Try Again", context);
    } catch (e) {
      debugPrint("rrrrrrr$e");
    }
  }
}
