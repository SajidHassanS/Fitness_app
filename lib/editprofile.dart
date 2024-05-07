import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'dart:io';
// import 'package:path_provider/path_provider.dart';

import 'package:image_picker/image_picker.dart';

class Editprofile extends StatefulWidget {
  const Editprofile({super.key});

  @override
  State<Editprofile> createState() => _EditprofileState();
}

class _EditprofileState extends State<Editprofile> {
  TextEditingController usernametextcont = TextEditingController();
  TextEditingController useremailtextcont = TextEditingController();
  TextEditingController userpasstextcont = TextEditingController();
  late String whereusername;

  Future<void> fetchprofilef() async {
    QuerySnapshot chkuseridfirst = await FirebaseFirestore.instance
        .collection('users')
        .where('name', isEqualTo: whereusername)
        .get();

    // if (chkuseridfirst.size == 1) {
    // Get the document ID
    String thisdocId = chkuseridfirst.docs[0].id;

    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('users')
          .doc(thisdocId) // here is id of user
          .get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        String? name = data?['name'];
        String? gmail = data?['email'];
        String? pass = data?['pass'];

        usernametextcont.text = name ?? 'unknown';
        useremailtextcont.text = gmail ?? 'unknown';
        userpasstextcont.text = pass ?? 'unknown';
      }
    } catch (e) {
      debugPrint('Error fetching name: $e');
    }
    // }
  }

  FlutterTts flutterTts = FlutterTts();
  void ttsfuncfornameupdate(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.9);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void ttsfuncfornamerequired(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.9);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1);
    await flutterTts.speak('$text All Fields are required');
  }

  late String? imagpath;

///// for hive box
  late Box<dynamic> prfilebox;
///// for hive box
  @override
  void initState() {
    prfilebox = Hive.box<dynamic>('profile');
    whereusername = prfilebox.get('usernamekey') ?? 'hasan ameer';
    imagpath = prfilebox.get('userpImage');
    fetchprofilef();
    super.initState();
  }

// File: '/data/user/0/com.example.workout/cache/5c63e884-96cd-4af7-9138-6da8f54fed20/IMG-20230226-WA0121.jpg'
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: const Text('Edit Profile',
            style: TextStyle(color: Colors.black, fontFamily: 'sbold')),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: ListView(children: [
        Padding(
          padding: const EdgeInsets.all(14.0),
          child: Column(
            children: [
              const SizedBox(height: 15),
              SizedBox(
                height: 110,
                width: 100,
                child: Stack(
                  children: [
                    GestureDetector(
                      onTap: () async {
                        // Choose an image from gallery
                        var image = await ImagePicker()
                            .pickImage(source: ImageSource.gallery);
                        if (image != null) {
                          // Update the Hive box with the new image path
                          setState(() {
                            imagpath = image.path;
                            prfilebox.put('userpImage', imagpath);
                          });
                        }
                      },
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: SizedBox(
                          width: 110,
                          height: 100,
                          child: imagpath != null
                              ? Image.file(
                                  File(imagpath!),
                                  fit: BoxFit.fitWidth,
                                  width: double.infinity,
                                )
                              : Image.asset(
                                  'assets/images/profile.png',
                                  fit: BoxFit.fitWidth,
                                  width: double.infinity,
                                ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.bottomRight,
                      child: CircleAvatar(
                        backgroundColor: Colors.white,
                        child: Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Icon(
                            Icons.mode_edit_outline_outlined,
                            color: Colors.black,
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
              const SizedBox(height: 17),
              TextField(
                controller: usernametextcont,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_3_outlined),
                  hintText: 'Name',
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.05, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 0.05),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.05,
                          color: Colors.deepOrange.withOpacity(0.8)),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: useremailtextcont,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: 'Email',
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.05, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 0.05),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.05,
                          color: Colors.deepOrange.withOpacity(0.8)),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: userpasstextcont,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.password_sharp),
                  hintText: 'Password',
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.05, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(30)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(30),
                    borderSide: const BorderSide(width: 0.05),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.05,
                          color: Colors.deepOrange.withOpacity(0.8)),
                      borderRadius: BorderRadius.circular(30)),
                ),
              ),
              SizedBox(height: Get.size.height * 1.1 / 4),
              GestureDetector(
                onTap: () async {
                  final connectivityResult =
                      await (Connectivity().checkConnectivity());
                  if (connectivityResult == ConnectivityResult.mobile ||
                      connectivityResult == ConnectivityResult.wifi) {
                    if (usernametextcont.text.length < 2 ||
                        useremailtextcont.text.length < 2 ||
                        userpasstextcont.text.length < 2) {
                      Get.snackbar(
                          icon: const Icon(Icons.cancel),
                          shouldIconPulse: true,
                          'Requird',
                          'Fill All Feilds');
                      ttsfuncfornamerequired(usernametextcont.text);
                    } else {
                      prfilebox.put('usernamekey', usernametextcont.text);
                      prfilebox.put('useremailkey', useremailtextcont.text);

                      ttsfuncfornameupdate(
                          '${usernametextcont.text} Your Profile Is Updated');

                      QuerySnapshot chkuseridfirst = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .where('name', isEqualTo: whereusername)
                          .get();

                      if (chkuseridfirst.size == 1) {
                        // Get the document ID
                        String thisdocId = chkuseridfirst.docs[0].id;

                        FirebaseFirestore.instance
                            .collection('users')
                            .doc(thisdocId) // here is id of user
                            .update({
                          'name': usernametextcont.text,
                          'email': useremailtextcont.text,
                          'pass': userpasstextcont.text,
                        }).then((value) {
                          Get.snackbar(
                              icon: const Icon(
                                Icons.check,
                                color: Colors.green,
                                shadows: [
                                  BoxShadow(
                                      color: Colors.black,
                                      offset: Offset(1, 1),
                                      blurRadius: 2)
                                ],
                              ),
                              shouldIconPulse: true,
                              snackPosition: SnackPosition.TOP,
                              'Your Profile is Updated',
                              'Thank You');
                        });
                      }
                    }
                    setState(() {});
                  } else {
                    ttsfuncfornameupdate('Please Check Interneet Connetion');

                    Get.snackbar(
                        icon: const Icon(
                          Icons.wifi_off_rounded,
                          color: Colors.red,
                          shadows: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 2)
                          ],
                        ),
                        shouldIconPulse: true,
                        snackPosition: SnackPosition.TOP,
                        'Plz Check Interneet Connetion',
                        '');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('save',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'cbold')),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
