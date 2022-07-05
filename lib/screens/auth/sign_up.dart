import 'dart:ffi';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/services.dart';
import 'package:sehetak2/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sehetak2/screens/bottom_bar.dart';
import 'package:sehetak2/services/global_method.dart';
import 'package:wave/config.dart';
import 'package:wave/wave.dart';

import '../../components/applocal.dart';

class SignUpScreen extends StatefulWidget {
  static const routeName = '/SignUpScreen';
  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _emailFocusNode = FocusNode();
  final FocusNode _phoneNumberFocusNode = FocusNode();
  final FocusNode _priceFocusNode = FocusNode();
  final FocusNode _describtionFocusNode = FocusNode();
  final FocusNode _titleFocusNode = FocusNode();
  bool _obscureText = true;
  String _emailAddress = '';
  String _password = '';
  String _fullName = '';
  String url;
  int _phoneNumber;
  String speciality = "Dermatology";
  File _pickedImage;
  final _formKey = GlobalKey<FormState>();
  final FirebaseAuth _auth = FirebaseAuth.instance;
  GlobalMethods _globalMethods = GlobalMethods();
  bool _isLoading = false;
  bool _isDoctor = false;
  var _specialities = [
    "Dermatology",
    "Dentistry",
    "Neurology",
    "Orthopedics",
    "Ophthalmology",
  ];

  double _price;
  String _describtion;
  String _token;
  var fbm = FirebaseMessaging.instance;
  String _title;
  @override
  void initState() {
    fbm.getToken().then((value) {
      print("token = "+value);
      _token = value;
    });
    super.initState();
  }
  @override
  void dispose() {
    _passwordFocusNode.dispose();
    _emailFocusNode.dispose();
    _phoneNumberFocusNode.dispose();
    _priceFocusNode.dispose();
    _describtionFocusNode.dispose();
    _titleFocusNode.dispose();
    super.dispose();
  }

  void _submitForm() async {
    final isValid = _formKey.currentState.validate();
    FocusScope.of(context).unfocus();
    var date = DateTime.now().toString();
    var dateparse = DateTime.parse(date);
    var formattedDate = "${dateparse.day}-${dateparse.month}-${dateparse.year}";
    String sr = speciality == "Orthopedics"
        ? "Sr.${speciality.substring(0, speciality.length - 2)}st"
        : speciality == "Dentistry"
            ? "Sr.dentist"
            : "Sr.${speciality.substring(0, speciality.length - 1)}ist";
    print(sr);
    if (isValid) {
      _formKey.currentState.save();
      try {
        if (_pickedImage == null) {
          _globalMethods.authErrorhandler('Please pick an image', context);
        } else {
          setState(() {
            _isLoading = true;
          });
          final ref = FirebaseStorage.instance
              .ref()
              .child('usersImages')
              .child(_fullName + '.jpg');
          await ref.putFile(_pickedImage);
          url = await ref.getDownloadURL();
          await _auth.createUserWithEmailAndPassword(
              email: _emailAddress.toLowerCase().trim(),
              password: _password.trim());
          final User user = _auth.currentUser;
          final _uid = user.uid;
          user.updateProfile(photoURL: url, displayName: _fullName);
          user.reload();
          FirebaseFirestore.instance.collection('users').doc(_uid).set({
            'id': _uid,
            'name': _fullName,
            'email': _emailAddress,
            'phoneNumber': _phoneNumber,
            'imageUrl': url,
            'joinedAt': formattedDate,
            'createdAt': Timestamp.now(),
            'doctor': _isDoctor.toString(),
            'token' : _token
          }).then((value) async {
            _isDoctor ? await FirebaseFirestore.instance
                .collection('doctors')
                .doc(_uid)
                .set({
              'description': _describtion,
              'image': url,
              'name': _fullName,
              'price': _price.toString(),
              'rating': 4.0,
              'specialty': speciality,
              'sr': sr,
              'title': _title,
              'token' : _token
            }): null;
          });
          Navigator.canPop(context) ? Navigator.pop(context) : null;
        }
      } catch (error) {
        _globalMethods.authErrorhandler(error.message, context);
        print('error occured ${error.message}');
      } finally {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _pickImageCamera() async {
    final picker = ImagePicker();
    final pickedImage =
        await picker.getImage(source: ImageSource.camera, imageQuality: 100);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _pickImageGallery() async {
    final picker = ImagePicker();
    final pickedImage = await picker.getImage(source: ImageSource.gallery);
    final pickedImageFile = File(pickedImage.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    Navigator.pop(context);
  }

  void _remove() {
    setState(() {
      _pickedImage = null;
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * 0.95,
              child: RotatedBox(
                quarterTurns: 2,
                child: WaveWidget(
                  config: CustomConfig(
                    gradients: [
                      [
                        ColorsConsts.gradiendFStart,
                        ColorsConsts.gradiendLStart
                      ],
                      [ColorsConsts.gradiendFEnd, ColorsConsts.gradiendLEnd],
                    ],
                    durations: [19440, 10800],
                    heightPercentages: [0.10, 0.15],
                    blur: MaskFilter.blur(BlurStyle.solid, 10),
                    gradientBegin: Alignment.bottomLeft,
                    gradientEnd: Alignment.topRight,
                  ),
                  waveAmplitude: 0,
                  size: Size(
                    double.infinity,
                    double.infinity,
                  ),
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 30,
                ),
                Stack(
                  children: [
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 30, horizontal: 30),
                      child: CircleAvatar(
                        radius: 71,
                        backgroundColor: Colors.white,
                        child: CircleAvatar(
                          radius: 65,
                          backgroundColor: ColorsConsts.gradiendFEnd,
                          backgroundImage: _pickedImage == null
                              ? null
                              : FileImage(_pickedImage),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 120,
                        left: 110,
                        child: RawMaterialButton(
                          elevation: 10,
                          fillColor: ColorsConsts.gradiendLEnd,
                          child: Icon(Icons.add_a_photo),
                          padding: EdgeInsets.all(15.0),
                          shape: CircleBorder(),
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text(
                                      'Choose option',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          color: ColorsConsts.gradiendLStart),
                                    ),
                                    content: SingleChildScrollView(
                                      child: ListBody(
                                        children: [
                                          InkWell(
                                            onTap: _pickImageCamera,
                                            splashColor: Colors.purpleAccent,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.camera,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                                Text(
                                                  'Camera',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorsConsts.title),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: _pickImageGallery,
                                            splashColor: Colors.purpleAccent,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.image,
                                                    color: Colors.purpleAccent,
                                                  ),
                                                ),
                                                Text(
                                                  'Gallery',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color:
                                                          ColorsConsts.title),
                                                )
                                              ],
                                            ),
                                          ),
                                          InkWell(
                                            onTap: _remove,
                                            splashColor: Colors.purpleAccent,
                                            child: Row(
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: Icon(
                                                    Icons.remove_circle,
                                                    color: Colors.red,
                                                  ),
                                                ),
                                                Text(
                                                  'Remove',
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: Colors.red),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                });
                          },
                        ))
                  ],
                ),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      Center(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Checkbox(
                              onChanged: (value) {
                                _isDoctor = value;
                                setState(() {});
                              },
                              value: _isDoctor,
                            ),
                            SizedBox(
                              width: 5.0,
                            ),
                            Text("${getLang(context, "Register As a Doctor")}"),
                          ],
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('name'),
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'name cannot be null';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_emailFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.person),
                              labelText: "${getLang(context, "Full name")}",
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _fullName = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('email'),
                          focusNode: _emailFocusNode,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'Please enter a valid email address';
                            }
                            return null;
                          },
                          textInputAction: TextInputAction.next,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_passwordFocusNode),
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.email),
                              labelText: "${getLang(context, "Email Address")}",
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _emailAddress = value;
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('Password'),
                          validator: (value) {
                            if (value.isEmpty || value.length < 7) {
                              return 'Please enter a valid Password';
                            }
                            return null;
                          },
                          keyboardType: TextInputType.emailAddress,
                          focusNode: _passwordFocusNode,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.lock),
                              suffixIcon: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _obscureText = !_obscureText;
                                  });
                                },
                                child: Icon(_obscureText
                                    ? Icons.visibility
                                    : Icons.visibility_off),
                              ),
                              labelText: "${getLang(context, "Password")}",
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _password = value;
                          },
                          obscureText: _obscureText,
                          onEditingComplete: () => FocusScope.of(context)
                              .requestFocus(_phoneNumberFocusNode),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: TextFormField(
                          key: ValueKey('phone number'),
                          focusNode: _phoneNumberFocusNode,
                          validator: (value) {
                            if (value.isEmpty) {
                              return 'Please enter a valid phone number';
                            }
                            return null;
                          },
                          inputFormatters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                          textInputAction: TextInputAction.next,
                          onEditingComplete: _isDoctor
                              ? () => FocusScope.of(context)
                                  .requestFocus(_priceFocusNode)
                              : _submitForm,
                          keyboardType: TextInputType.phone,
                          decoration: InputDecoration(
                              border: const UnderlineInputBorder(),
                              filled: true,
                              prefixIcon: Icon(Icons.phone_android),
                              labelText: "${getLang(context, "Phone number")}",
                              fillColor: Theme.of(context).backgroundColor),
                          onSaved: (value) {
                            _phoneNumber = int.parse(value);
                          },
                        ),
                      ),
                      ConditionalBuilder(
                        condition: _isDoctor,
                        builder: (context) => Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                key: ValueKey('price'),
                                focusNode: _priceFocusNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'cannot be null';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_describtionFocusNode),
                                keyboardType: TextInputType.number,
                                decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    filled: true,
                                    prefixIcon:
                                        Icon(Icons.attach_money_rounded),
                                    labelText:
                                        "${getLang(context, "Online Consultation Price")}",
                                    fillColor:
                                        Theme.of(context).backgroundColor),
                                onSaved: (value) {
                                  _price = double.parse(value);
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                key: ValueKey('Describtion'),
                                focusNode: _describtionFocusNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'cannot be null';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                onEditingComplete: () => FocusScope.of(context)
                                    .requestFocus(_titleFocusNode),
                                keyboardType: TextInputType.multiline,
                                decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    filled: true,
                                    prefixIcon: Icon(Icons.description),
                                    labelText:
                                        "${getLang(context, "Short Describtion About yourself")}",
                                    fillColor:
                                        Theme.of(context).backgroundColor),
                                onSaved: (value) {
                                  _describtion = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: TextFormField(
                                key: ValueKey('Title'),
                                focusNode: _titleFocusNode,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'cannot be null';
                                  }
                                  return null;
                                },
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.text,
                                decoration: InputDecoration(
                                    border: const UnderlineInputBorder(),
                                    filled: true,
                                    prefixIcon: Icon(Icons.title),
                                    labelText:
                                        "${getLang(context, "Consultation title")}",
                                    fillColor:
                                        Theme.of(context).backgroundColor),
                                onSaved: (value) {
                                  _title = value;
                                },
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: FormField<String>(
                                key: ValueKey('Speciality'),
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'cannot be null';
                                  }
                                  return null;
                                },
                                builder: (FormFieldState<String> state) {
                                  return InputDecorator(
                                    isEmpty: false,
                                    decoration: InputDecoration(
                                        border: const UnderlineInputBorder(),
                                        filled: true,
                                        prefixIcon:
                                            Icon(Icons.psychology_rounded),
                                        labelText:
                                            "${getLang(context, "Speciality")}",
                                        fillColor:
                                            Theme.of(context).backgroundColor),
                                    child: DropdownButtonHideUnderline(
                                      child: DropdownButton<String>(
                                        value: speciality,
                                        onChanged: (String newValue) {
                                          setState(() {
                                            speciality = newValue;
                                            state.didChange(newValue);
                                          });
                                        },
                                        items:
                                            _specialities.map((String value) {
                                          return DropdownMenuItem<String>(
                                            value: value,
                                            child: Text(value),
                                          );
                                        }).toList(),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            )
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          SizedBox(width: 10),
                          _isLoading
                              ? const CircularProgressIndicator()
                              : Expanded(
                                  child: ElevatedButton(
                                      style: ButtonStyle(
                                          shape: MaterialStateProperty.all<
                                              RoundedRectangleBorder>(
                                        RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          side: BorderSide(
                                              color:
                                                  ColorsConsts.backgroundColor),
                                        ),
                                      )),
                                      onPressed: _submitForm,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "${getLang(context, "Sign up")}",
                                            style: TextStyle(
                                                fontWeight: FontWeight.w500,
                                                fontSize: 17),
                                          ),
                                          SizedBox(
                                            width: 5,
                                          ),
                                          Icon(
                                            Feather.user,
                                            size: 18,
                                          )
                                        ],
                                      )),
                                ),
                          SizedBox(width: 10),
                        ],
                      ),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ),
                              Text(
                                "${getLang(context, "Or Sign Up with")}",
                                style: TextStyle(color: Colors.black),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Divider(
                                    color: Colors.white,
                                    thickness: 2,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              OutlineButton(
                                onPressed: _submitForm,
                                shape: StadiumBorder(),
                                highlightedBorderColor: Colors.red.shade200,
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xFFFB6073)),
                                child: Text(
                                  'Google +',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                              OutlineButton(
                                onPressed: () {
                                  Navigator.pushNamed(
                                      context, BottomBarScreen.routeName);
                                },
                                shape: StadiumBorder(),
                                highlightedBorderColor:
                                    Colors.deepPurple.shade200,
                                borderSide: BorderSide(
                                    width: 2, color: Color(0xFFA0ABFF)),
                                child: Text(
                                  "${getLang(context, "Guest Login")}",
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
