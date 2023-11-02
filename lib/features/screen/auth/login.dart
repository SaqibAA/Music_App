import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import 'package:music_app/features/features.dart';
import 'package:music_app/global.dart';
import 'package:provider/provider.dart';

import '../../../core/core.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController phoneController = TextEditingController();
    TextEditingController otpController = TextEditingController();
    return Consumer<AuthProvider>(builder: (context, auth, child) {
      return WillPopScope(
        onWillPop: () async {
          if (auth.isOTP) {
            auth.setOptScreen(false);
          }else{
            SystemNavigator.pop();
          }
          return false;
        },
        child: Scaffold(
          appBar: AppBar(
            title: const Text("Login"),
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                auth.isOTP
                    ? TextFormField(
                        controller: otpController,
                        keyboardType: TextInputType.number,
                        maxLength: 6,
                        decoration: const InputDecoration(
                            counterText: '',
                            hintText: "Enter OTP",
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 10)),
                      )
                    : IntlPhoneField(
                        invalidNumberMessage: '',
                        controller: phoneController,
                        keyboardType: TextInputType.phone,
                        showCountryFlag: true,
                        flagsButtonPadding:
                            const EdgeInsets.only(left: 20, right: 10),
                        showDropdownIcon: false,
                        // disableLengthCheck: true,
                        initialValue: auth.countryCode,
                        onCountryChanged: (country) {
                          auth.setCountryCode("+${country.dialCode}");
                        },
                        validator: (p0) {
                          if (p0!.isValidNumber()) {
                            auth.setValidNumber(true);
                          } else {
                            auth.setValidNumber(false);
                          }

                          return "";
                        },
                        decoration: const InputDecoration(
                            counterText: "",
                            hintText: "Enter Number",
                            contentPadding: EdgeInsets.fromLTRB(20, 0, 0, 0)),
                      ),
                SizedBox(
                  height: height * 0.04,
                ),
                AppButton(
                    title: auth.isOTP ? "Verify OTP" : "Send OTP",
                    onPressed: () {
                      if (auth.isOTP) {
                      } else {
                        if (phoneController.text.isEmpty) {
                          Utils.snackBarError("Enter Mobile Number", context);
                        } else if (!auth.isValidNumber) {
                          Utils.snackBarError(
                              "Enter Mobile Number Correctly", context);
                        } else {
                          // verifyPhone(auth.countryCode + phoneController.text);
                          auth.setOptScreen(true);
                        }
                      }
                    }),
              ],
            ),
          ),
        ),
      );
    });
  }
}
