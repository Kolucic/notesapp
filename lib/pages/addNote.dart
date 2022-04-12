import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../utils/color_constant.dart';
import '../utils/math_utils.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  String title;
  String des;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

        floatingActionButton: FloatingActionButton.extended(
          onPressed: add,
          label: Text(
            "Salva nota",
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
          backgroundColor: ColorConstant.orange700,
        ),

        appBar: AppBar(
          title:TextFormField(
            decoration: InputDecoration.collapsed(
              hintText: "Titolo",
            ),
            style: TextStyle(
              fontSize: 24.0,
              overflow: TextOverflow.ellipsis,
              fontFamily: "Red Hat Display",
              fontWeight: FontWeight.w700,
              color: ColorConstant.black900,
            ),
            onChanged: (_val) {
              title = _val;
            },
          ),
          elevation: 0.0,
          backgroundColor: ColorConstant.whiteA700,
          leading:FloatingActionButton(
            elevation: 0.0,
            backgroundColor: ColorConstant.whiteA700,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: IconButton(
              icon: Image.asset("assets/images/arrow_back_black_24dp 2.png"),
              color: ColorConstant.black900,
            ),

          ),

        ),

        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Container(
              height: MediaQuery.of(context).size.height * 0.75,
              padding: const EdgeInsets.only(top: 12.0),
              child: TextFormField(
                decoration: InputDecoration.collapsed(
                  hintText: 'Scrivi...',
                ),
                style: TextStyle(
                  fontSize: 20.0,
                  fontFamily: "Red Hat Text",
                  color: Colors.grey,
                ),
                onChanged: (_val) {
                  des = _val;
                },
                maxLines: 20,
              ),
            ),
          ),
        ),
      ),
    );
  }

  void add() async {
    CollectionReference ref = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser?.uid)
        .collection('notes');

    var data = {
      'title': title,
      'description': des,
      'created': DateTime.now(),
    };

    ref.add(data);

    Navigator.pop(context);
  }
}
