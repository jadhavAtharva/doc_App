import 'package:docapp/mainPage.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'constants.dart';
import 'package:path/path.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'components/rounded_button.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

Future<dynamic> loadImage(BuildContext context, String image ) async{
    var url = await FirebaseStorage.instance.ref().child(image).getDownloadURL();
    return url;
  }



class UpdatePage extends StatefulWidget {
  static const String id = 'update_page';
  @override
  _UpdatePageState createState() => _UpdatePageState();
}

class _UpdatePageState extends State<UpdatePage> {
  final _auth = FirebaseAuth.instance;
  var _image;
  var fullName = '';
  String id;

  Future<String> getFilename() async {
    var name = _auth.currentUser();
    FirebaseUser newUser = await name;
    var fullName = newUser.email.toString();
    return fullName;
  }

  void cutName() async{
    fullName = await getFilename();
  }

  @override
  void initState() {
    super.initState();
    getFilename();
    cutName();
  }

  getID () async{
    Firestore.instance.collection('user').where('username',isEqualTo: fullName).snapshots();
  }

   updateDocument(id, num) async {
      Firestore.instance.collection('user').document(id).updateData({'phone_no' : num});
   }

  updateData(selectedDoc, newValues) {
    Firestore.instance.collection('user').document(selectedDoc).updateData(newValues).catchError((e) {
      print(e);
    });
  }

  @override
  Widget build(BuildContext context) {

    var newNumber;
    final updateTextController = TextEditingController();
    Future getImage() async {
      var image = await ImagePicker.pickImage(source: ImageSource.gallery);

      setState(() {
        _image = image;
        print('Image Path $_image');
      });
    }

    Future uploadPic(BuildContext context) async {
      StorageReference reference =
      FirebaseStorage.instance.ref().child("$fullName.jpg");
      StorageUploadTask uploadTask = reference.putFile(_image);
      StorageTaskSnapshot taskSnapshot = await uploadTask.onComplete;

      setState(() {
        print('Profile Pic uploaded');
        //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Pic Uploaded'),));
      });
    }
    return MaterialApp(
      home: Container(
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/back5.jpg"), fit: BoxFit.cover)),
        child: Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            elevation: 0,
            backgroundColor: Colors.transparent,
            title: Text(
              'Update Details',
            style: TextStyle(
              fontFamily: 'Pacifico',
              fontSize: 30.0,
            ),
            ),
            centerTitle: true,
            leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.pop(context);
                }),
          ),
          resizeToAvoidBottomPadding: true,
          body: StreamBuilder<QuerySnapshot>(
            stream: Firestore.instance.collection('user').snapshots(),
            builder: (context, snapshot) {
              return SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.only(top: 250.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0, bottom: 10.0),
                        child: Text(
                          'Update Contact Number:\n(Press the edit button to save changes)',
                          style: TextStyle(
                            color: Hexcolor('#224D4D'),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: TextField(
                          controller: updateTextController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          onChanged: (value) {
                            newNumber = value;
                          },
                          decoration: kTextFieldDecoration.copyWith(
                            hintText: 'Phone Number',
                            fillColor: Hexcolor('#E4EFEF'),
                            suffixIcon: IconButton(
                              icon: Icon(Icons.edit),
                              focusColor: Hexcolor('#224D4D'),
                              onPressed: () {
                                updateTextController.clear();
                                for(int i = 0; i < snapshot.data.documents.length; i++) {
                                 if(snapshot.data.documents[i].data['username'] == fullName){
                                     id = snapshot.data.documents[i].documentID;
                                 }
                                }
                                try{
                                  updateDocument(id , newNumber);
                                  createAlertDialogue(context, 'Updated!!', 'Phone Number successfully updated.');
                                } catch(e) {
                                  print(e);
                                }
                              },
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Hexcolor("#224D4D")),
                              borderRadius: BorderRadius.all(Radius.circular(32.0)),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 22.0, bottom: 10.0),
                        child: Text(
                          'Update Profile Pic:',
                          style: TextStyle(
                            color: Hexcolor('#224D4D'),
                            fontSize: 20.0,
                          ),
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Center(
                            child: CircleAvatar(
                              backgroundColor: Hexcolor('#224D4D'),
                              radius: 100.0,
                              child: ClipOval(
                                child: SizedBox(
                                  width: 180.0,
                                  height: 180.0,
                                  child: (_image != null) ? Image.file(
                                    _image,
                                    fit: BoxFit.fill,
                                  )
                                      : Container(
                                    height: 70.0,
                                    width: 70.0,
                                    color: Hexcolor('#E4EFEF'),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(top: 60.0),
                            child: IconButton(
                              icon: Icon(
                                FontAwesomeIcons.camera,
                                size: 30.0,
                              ),
                              onPressed: () {
                                getImage();
                              },
                            ),
                          ),
                        ],
                      ),
                      Center(
                        child: Padding(
                          padding: const EdgeInsets.only(top: 30.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              RoundedButton(
                                color: Hexcolor('#224D4D'),
                                title: 'Back',
                                onPressed: () {
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => MainPage()));
                                },
                                minWidth: 100.0,
                                textColor: Hexcolor('#E4EFEF'),
                              ),
                              SizedBox(
                                width: 20.0,
                              ),
                              RoundedButton(
                                color: Hexcolor('#224D4D'),
                                title: 'Submit',
                                onPressed: () {
                                  try{
                                    uploadPic(context);
                                    createAlertDialogue(context, 'Uploaded!!', 'Profile Pic Uploaded Successfully!!');
                                  } catch(e) {
                                    print(e);
                                  }

                                },
                                minWidth: 100.0,
                                textColor: Hexcolor('#E4EFEF'),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
  createAlertDialogue (BuildContext context, String title, String message) {
    return showDialog(context: context, builder: (context){
      return AlertDialog(
        title: Text(
          title,
          style: TextStyle(
            fontFamily: 'Source Sans pro',
            color: Hexcolor('#224D4D'),
            fontSize: 20.0,
          ),
        ),
        content: Text(
          message,
          style: TextStyle(
            fontFamily: 'Source Sans pro',
          ),
        ),
        actions: <Widget>[
          MaterialButton(
              color: Hexcolor('#224D4D'),
              elevation: 5.0,
              child: Text(
                'OK',
                style: TextStyle(
                  color: Hexcolor('#E4EFEF'),
                ),
              ),
              onPressed: () {
                Navigator.pop(context);
              }
          ),
        ],
      );
    });
  }

}
