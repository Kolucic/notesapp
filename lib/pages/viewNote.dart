import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:noteapp/utils/color_constant.dart';

class ViewNote extends StatefulWidget {
  final Map data;
  final String time;
  final DocumentReference ref;

  ViewNote(this.data, this.time, this.ref);

  @override
  _ViewNoteState createState() => _ViewNoteState();
}

class _ViewNoteState extends State<ViewNote> {
  String title;
  String des;

  bool edit = false;

  GlobalKey<FormState> key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    title = widget.data['title'];
    des = widget.data['description'];
    return SafeArea(
      child: Scaffold(
        backgroundColor: ColorConstant.whiteA700,
        floatingActionButton: edit ?
        FloatingActionButton(
                onPressed: save,
                child: Icon(
                  Icons.save_rounded,
                  color: Colors.white,
                ),
                backgroundColor: ColorConstant.orange700,
              )
            : null,
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          backgroundColor: ColorConstant.whiteA700,
          elevation: 0,
          title: TextFormField(
            decoration: InputDecoration.collapsed(
              hintText: "Title",
            ),
            style: TextStyle(
              fontSize: 26.0,
              fontFamily: "Red Hat Display",
              fontWeight: FontWeight.bold,
              color: Colors.black,
            ),
            initialValue: widget.data['title'],
            enabled: edit,
            onChanged: (_val) {
              title = _val;
            },
            validator: (_val) {
              if (_val.isEmpty) {
                return "Can't be empty !";
              } else {
                return null;
              }
            },
          ),
          leading: FloatingActionButton(
            backgroundColor: ColorConstant.whiteA700,
            elevation: 0.0,
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: IconButton(
              icon: Image.asset("assets/images/arrow_back_black_24dp 2.png"),
            ),
          ),

          actions: <Widget>[
            if(edit == false)
              FloatingActionButton(
                backgroundColor: ColorConstant.whiteA700,
                elevation: 0.0,

                onPressed: () {
                  setState(() {
                    edit = !edit;
                  });
                },
                child: IconButton(
                  icon: Image.asset("assets/images/Vector.png"),
                ),
              ),

            FloatingActionButton(
              backgroundColor: ColorConstant.whiteA700,
              elevation: 0.0,
              onPressed: delete,
              child: IconButton(
                icon: Image.asset("assets/images/delete_black_24dp 3.png"),
              ),
            ),
          ],

        ),
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.all(12.0),
            child: Column(
              children: [
                Form(
                  key: key,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                        decoration: InputDecoration.collapsed(
                          hintText: "Note Description",
                        ),
                        style: TextStyle(
                          fontSize: 18.0,
                          fontFamily: "Red Hat Text",
                          color: Colors.black,
                        ),
                        initialValue: widget.data['description'],
                        enabled: edit,
                        onChanged: (_val) {
                          des = _val;
                        },
                        maxLines: 20,
                        validator: (_val) {
                          if (_val.isEmpty) {
                            return "Can't be empty !";
                          } else {
                            return null;
                          }
                        },
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void delete() async {
    await widget.ref.delete();
    Navigator.pop(context);
  }

  void save() async {
    if (key.currentState.validate()) {
      await widget.ref.update(
        {'title': title, 'description': des},
      );
      Navigator.of(context).pop();
    }
  }
}
