import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:noteapp/pages/addNote.dart';
import 'package:noteapp/pages/login.dart';
import 'package:noteapp/pages/viewNote.dart';

import '../utils/color_constant.dart';
import '../utils/math_utils.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key key, User user})
      : _user = user,
        super(key: key);
  final User _user;

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CollectionReference ref = FirebaseFirestore.instance
      .collection('users')
      .doc(FirebaseAuth.instance.currentUser?.uid)
      .collection('notes');

  List<Color> myColors = [
    Colors.orange[100],
    Colors.red[100],
    Colors.yellow[100],
    Colors.brown[100],
  ];

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,

        floatingActionButton: FloatingActionButton.extended(
          onPressed: () {
            Navigator.of(context)
                .push(
              MaterialPageRoute(
                builder: (context) => AddNote(),
              ),
            )
                .then((value) {
              print("Calling a set state");
              setState(() {});
            });
          },
          label: Text(
            "Aggiungi una nota",
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

        //
        appBar: AppBar(
          title: Text(
            'Le mie note',
            style: TextStyle(
              fontSize: 24.0,
              overflow: TextOverflow.ellipsis,
              fontFamily: "Red Hat Display",
              fontWeight: FontWeight.w700,
              color: ColorConstant.black900,
            ),
          ),
          elevation: 0.0,
          backgroundColor: ColorConstant.whiteA700,
          leading: Padding(
            padding: EdgeInsets.only(right: 2.0),
            child: FloatingActionButton(
              backgroundColor: ColorConstant.orange700,
              onPressed: () {
                showAlertDialog(context);
              },
              child: CircleAvatar(
                backgroundImage: (CachedNetworkImageProvider(
                  widget._user.photoURL,
                )),
              ),
            ),
          ),
        ),

        //
        body: FutureBuilder<QuerySnapshot>(
          future: ref.get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data.docs.length == 0) {
                return Center(
                  child: Text(
                    "Non hai note !",
                    style: TextStyle(
                      color: Colors.white70,
                    ),
                  ),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data?.docs.length,
                itemBuilder: (context, index) {
                  Random random = new Random();
                  Color bg = myColors[random.nextInt(4)];
                  Map data = snapshot.data.docs[index].data();
                  DateTime mydateTime = data['created'].toDate();
                  String formattedTime =
                      DateFormat.yMMMd().add_jm().format(mydateTime);
                  return InkWell(
                    onTap: () {
                      Navigator.of(context)
                          .push(
                        MaterialPageRoute(
                          builder: (context) => ViewNote(
                            data,
                            formattedTime,
                            snapshot.data.docs[index].reference,
                          ),
                        ),
                      )
                          .then((value) {
                        setState(() {});
                      });
                    },
                    child: Card(
                      color: bg,
                      child: Padding(
                        padding: EdgeInsets.only(
                            left: getHorizontalSize(20.00),
                            top: getVerticalSize(17.00),
                            right: getHorizontalSize(20.00)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(
                                  getHorizontalSize(
                                    16.00,
                                  ),
                                ),
                              ),
                              child: Text(
                                "${data['title']}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 16.0,
                                  fontFamily: "Red Hat Display",
                                  fontWeight: FontWeight.w600,
                                  color: ColorConstant.black900,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  child: Text(
                                    "${data['description']}",
                                    style: TextStyle(
                                      fontSize: 12.0,
                                      fontFamily: "Red Hat Text",
                                      color: ColorConstant.black900,
                                      fontWeight: FontWeight.w400,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              alignment: Alignment.centerRight,
                              child: Text(
                                formattedTime,
                                style: TextStyle(
                                  fontSize: 12.0,
                                  fontFamily: "Red Hat Text",
                                  color: ColorConstant.black900,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              );
            } else {
              return Center(
                child: Text("Loading..."),
              );
            }
          },
        ),
      ),
    );
  }

  showAlertDialog(BuildContext context) {
    // set up the button
    Widget okButton = FlatButton(
      child: Text("OK"),
      onPressed: () {
        _signOut();
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => LoginPage(),
          ),
        );
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Sicuro di voler uscire?"),
      content: Text("Ritornerai alla pagina principale."),
      actions: [
        okButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

  Future<void> _signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}
