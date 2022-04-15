import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:noteapp/controller/google_auth.dart';
import 'package:noteapp/utils/color_constant.dart';
import 'package:noteapp/utils/math_utils.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        body: Container(
          decoration: BoxDecoration(
            color: ColorConstant.whiteA700,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Expanded(
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: SingleChildScrollView(
                    padding: EdgeInsets.only(
                      top: getVerticalSize(
                        125.00,
                      ),
                      bottom: getVerticalSize(
                        20.00,
                      ),
                    ),
                    child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(
                                40.00,
                              ),
                              right: getHorizontalSize(
                                40.00,
                              ),
                            ),
                            child: Text(
                              "Cloud note",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstant.black900,
                                fontSize: getFontSize(
                                  28,
                                ),
                                fontFamily: 'Red Hat Display',
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                          Container(
                            width: getHorizontalSize(
                              278.00,
                            ),
                            margin: EdgeInsets.only(
                              left: getHorizontalSize(
                                40.00,
                              ),
                              top: getVerticalSize(
                                30.00,
                              ),
                              right: getHorizontalSize(
                                40.00,
                              ),
                            ),
                            child: Text(
                              "Crea e gestisci le tue note collegandole al tuo account Google.",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: ColorConstant.black900,
                                fontSize: getFontSize(
                                  16,
                                ),
                                fontFamily: 'Red Hat Text',
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                              left: getHorizontalSize(
                                40.00,
                              ),
                              top: getVerticalSize(
                                48.00,
                              ),
                              right: getHorizontalSize(
                                40.00,
                              ),
                            ),
                            child: Container(
                              alignment: Alignment.center,
                              height: getVerticalSize(
                                48.00,
                              ),
                              width: getHorizontalSize(
                                278.00,
                              ),
                              decoration: BoxDecoration(
                                color: ColorConstant.orange700,
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(16.00,),
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: ColorConstant.orange50,
                                    spreadRadius: getHorizontalSize(2.00,),
                                    blurRadius: getHorizontalSize(2.00,),
                                    offset: Offset(0, 4,),
                                  ),
                                ],
                              ),
                              child: TextButton(
                                onPressed: () {
                                  signInWithGoogle(context);
                                },
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        ColorConstant.orange700) // and this
                                    ),
                                child: Text(
                                  "Continua con Google",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: ColorConstant.whiteA700,
                                    fontSize: getFontSize(
                                      14,
                                    ),
                                    fontFamily: 'Red Hat Text',
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ]),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
