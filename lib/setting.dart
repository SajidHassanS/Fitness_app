import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter_share_plus/flutter_share_plus.dart';
import 'package:get/get.dart';
import 'package:flutter/services.dart';
// import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'loginsignup.dart';

class Settingpage extends StatefulWidget {
  const Settingpage({super.key});

  @override
  State<Settingpage> createState() => _SettingpageState();
}

class _SettingpageState extends State<Settingpage> {
  // String _platformVersion = 'Unknown';
  static const _channel = MethodChannel("flutter_share_plus");

  // Future<void> initPlatformState() async {
  //   String platformVersion;
  //   try {
  //     platformVersion = await FlutterSharePlus.platformVersion;
  //   } on PlatformException {
  //     platformVersion = 'Failed to get platform version.';
  //   }
  //   if (!mounted) return;

  //   setState(() {
  //     _platformVersion = platformVersion;
  //   });
  // }

  /////////

  String? unitchangevalue = 'Metric';
  bool _value = false;

///////////////////

  Future<void> vsharelinkf(String message) async {
    await _channel
        .invokeMethod('share_text', <String, String>{'message': message});
  }

////////////// start for daily goal sheet

  TextEditingController dailygoaltextinpt = TextEditingController();
  TextEditingController feedbacktextc = TextEditingController();

  int? resttimebyf = 0;
  int? reminderbyf = 0;

  Future<void> getsharedlink() async {
    try {
      DocumentSnapshot snapshot = await FirebaseFirestore.instance
          .collection('settings')
          .doc('shareapp') // here is id of user
          .get();
      if (snapshot.exists) {
        Map<String, dynamic>? data = snapshot.data() as Map<String, dynamic>?;
        String? sharelink = data?['applink'];
        vsharelink = sharelink ?? 'maarkhoor5@gmail.com';
      }
    } catch (e) {
      debugPrint('Error fetching name: $e');
    }
  }

  var vsharelink = 'maarkhoor5@gmail.com';

  @override
  void initState() {
    getsharedlink();
    callstnghiveboxf();
    // initPlatformState();
    super.initState();
  }

///// for hive box
  late Box<dynamic> stngbox;
///// for hive box

  callstnghiveboxf() {
    stngbox = Hive.box<dynamic>('profile');
    resttimebyf = stngbox.get('restval') ?? 10;
    reminderbyf = stngbox.get('reminderval') ?? 0;
    unitchangevalue = stngbox.get('unitvaluebox') ?? 'Metric';
  }

/////////// end of call from rsttimedatapage

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(251, 250, 250, 250),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: ValueListenableBuilder<Box>(
                      valueListenable: Hive.box('profile').listenable(),
                      builder: (BuildContext context, Box<dynamic> stngbox, _) {
                        // File? userpImage = stngbox.get('userpImage') as File;
                        dynamic userpImage = stngbox.get('userpImage');
                        File? imageFile;
                        if (userpImage is String) {
                          // If the userpImage key contains a String, assume it is a file path
                          imageFile = File(userpImage);
                        } else if (userpImage is File) {
                          // If the userpImage key contains a File, use it directly
                          imageFile = userpImage;
                        }
                        final usernamekey = stngbox.get('usernamekey');
                        final useremailkey = stngbox.get('useremailkey');
                        return ListTile(
                          onTap: () {
                            Get.toNamed('/editprofile');
                          },
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(60),
                            child: SizedBox(
                              width: 56,
                              height: 65,
                              child: imageFile != null
                                  ? Image.file(
                                      imageFile,
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
                          title: Text(usernamekey),
                          subtitle: Text(useremailkey),
                          trailing:
                              const Icon(Icons.mode_edit_outline_outlined),
                        );
                      }),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(5.0),
              child: Text('Workout',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'csemibold',
                      fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    resttimeSheet();
                  },
                  title: const Text(
                    'Training Rest',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: SizedBox(
                    width: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${resttimebyf ?? 10} Sec',
                          style: const TextStyle(color: Colors.deepOrange),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black87,
                          size: 17,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    dailyGoalSheet();
                  },
                  title: const Text(
                    'Daily Goal',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: SizedBox(
                    width: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${stngbox.get('dailygoal') ?? 150} cal',
                          style: const TextStyle(color: Colors.deepOrange),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black87,
                          size: 17,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                    onTap: () {
                      soundsheet();
                    },
                    title: const Text(
                      'Sound Options',
                      style: TextStyle(fontFamily: 'clight'),
                    ),
                    trailing: const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.black87,
                      size: 17,
                    )),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('General',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'csemibold',
                      fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    remindersheet();
                  },
                  title: const Text(
                    'Set Workout Reminder',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: SizedBox(
                    width: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${reminderbyf ?? 1} Day',
                          style: const TextStyle(color: Colors.black),
                        ),
                        Transform.rotate(
                          angle: 1.5,
                          child: const Icon(
                            Icons.arrow_forward_ios,
                            color: Colors.black87,
                            size: 17,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    Get.toNamed('/hinfo');
                  },
                  title: const Text(
                    'Health Info',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black87,
                    size: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    Get.toNamed('/bell');
                  },
                  title: const Text(
                    'Notifications',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black87,
                    size: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    Get.bottomSheet(
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(25.0),
                          topRight: Radius.circular(25.0),
                        ),
                      ),
                      backgroundColor: const Color.fromARGB(251, 250, 250, 250),
                      SizedBox(
                        height: Get.size.height * 1.3 / 4,
                        child: Column(
                          children: [
                            ListTile(
                              title: const Text(
                                'Daily Goal',
                                style: TextStyle(
                                    color: Colors.black87,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    Get.back();
                                  },
                                  icon: const Icon(Icons.close,
                                      color: Colors.black)),
                            ),
                            const Spacer(),
                            Center(
                              child: Text(
                                  "Unit system: ${unitchangevalue ?? 'Metric'}",
                                  style: const TextStyle(
                                    color: Colors.black87,
                                    fontSize: 14,
                                    fontFamily: 'cbold',
                                  )),
                            ),
                            Wrap(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, bottom: 2),
                                  child: Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      leading: Radio(
                                        value: 'Metric',
                                        groupValue: unitchangevalue ?? 'Metric',
                                        onChanged: (value) {
                                          stngbox.put('unitvaluebox', value);

                                          setState(() {
                                            unitchangevalue = value!;
                                          });
                                          Get.back();
                                        },
                                      ),
                                      title: const Text("Metric"),
                                    ),
                                  ),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      top: 2.0, bottom: 5),
                                  child: Card(
                                    color: Colors.white,
                                    child: ListTile(
                                      leading: Radio(
                                        value: 'Imperial',
                                        groupValue: unitchangevalue ?? 'Metric',
                                        onChanged: (value) {
                                          stngbox.put('unitvaluebox', value);

                                          setState(() {
                                            unitchangevalue = value!;
                                          });
                                          Get.back();
                                        },
                                      ),
                                      title: const Text("Imperial"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  title: const Text(
                    'Change Unit System',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black87,
                    size: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  title: const Text(
                    'Keep Screen On',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: CupertinoSwitch(
                    activeColor: Colors.deepOrange,
                    value: _value,
                    onChanged: (value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Share',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'csemibold',
                      fontSize: 18)),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    vsharelinkf(vsharelink);
                  },
                  title: const Text(
                    'Share With Friends',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black87,
                    size: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    Get.defaultDialog(
                      title: "Workout Feedback",
                      content: Column(
                        children: [
                          const Text("How was your workout today?"),
                          SingleChildScrollView(
                            controller: ScrollController(),
                            child: SizedBox(
                              height: Get.size.height * 0.5 / 4,
                              child: TextFormField(
                                controller: feedbacktextc,
                                minLines: 2,
                                maxLines: null,
                                decoration: const InputDecoration(
                                    labelText: "Your feedback"),
                              ),
                            ),
                          ),
                        ],
                      ),
                      actions: [
                        ElevatedButton(
                            onPressed: () {
                              Get.back();
                            },
                            style: ButtonStyle(shape: MaterialStateProperty
                                .resolveWith<OutlinedBorder>(
                              (states) {
                                return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(15.0),
                                );
                              },
                            )),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  top: 7.0, left: 15, right: 15, bottom: 7),
                              child: Text(
                                'Cancel',
                                style: TextStyle(
                                    fontSize: 16,
                                    fontFamily: 'cbold',
                                    fontWeight: FontWeight.bold),
                              ),
                            )),
                        OutlinedButton(
                          onPressed: () {
                            if (feedbacktextc.text.length < 5) {
                              Get.snackbar(
                                  icon: const Icon(
                                    Icons.cancel,
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
                                  'Write Some Thing',
                                  'For Feedback');
                            } else {
                              FirebaseFirestore.instance
                                  .collection('feedbacks')
                                  .add({
                                'byname':
                                    stngbox.get('usernamekey') ?? 'Forget',
                                'msg': feedbacktextc.text,
                                'time': FieldValue.serverTimestamp(),
                              }).then((value) {
                                Get.snackbar(
                                    icon: const Icon(
                                      Icons.sms_rounded,
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
                                    'Your FeedBack Sends',
                                    'Thank You');
                                feedbacktextc.clear();
                              });
                              Get.back();
                            }
                          },
                          style: ButtonStyle(
                            shape: MaterialStateProperty.resolveWith<
                                OutlinedBorder>(
                              (states) {
                                return RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(14.0),
                                );
                              },
                            ),
                            side: MaterialStateProperty.resolveWith<BorderSide>(
                              (states) {
                                return const BorderSide(
                                    color: Colors.deepOrange);
                              },
                            ),
                          ),
                          child: const Padding(
                            padding: EdgeInsets.only(
                                top: 7.0, left: 15, right: 15, bottom: 7),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: 'csemibold',
                                  color: Colors.black,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      ],
                    );
                  },
                  title: const Text(
                    'Feedback',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black87,
                    size: 17,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10)),
                child: ListTile(
                  onTap: () {
                    // stngbox.delete('usernamekey');
                    stngbox.put('usernamekey', '0');
                    Navigator.of(context).push(
                      PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 2),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Login(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final tween = Tween<Offset>(
                              begin: const Offset(-1.0, 0.0), end: Offset.zero);
                          final curve = CurvedAnimation(
                              parent: animation, curve: Curves.bounceInOut);
                          return SlideTransition(
                            position: tween.animate(curve),
                            child: child,
                          );
                        },
                      ),
                    );
                    // Get.to(const Login());
                  },
                  title: const Text(
                    'Logout',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: const Icon(
                    Icons.arrow_forward_ios,
                    color: Colors.black87,
                    size: 17,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> dailyGoalSheet() {
    return Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      SizedBox(
        height: Get.size.height * 1.6 / 4,
        child: Column(
          children: [
            const SizedBox(
              height: 7,
            ),
            ListTile(
              title: const Text(
                'Daily Goal',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close, color: Colors.black)),
            ),
            const ListTile(
              title: Text(
                'Calories',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'clight'),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, left: 15, right: 15, bottom: 2),
              child: TextField(
                controller: dailygoaltextinpt,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.edit_outlined),
                  hintText: 'Calories',
                  disabledBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 0.05, color: Colors.blueGrey),
                      borderRadius: BorderRadius.circular(20)),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(width: 0.05),
                  ),
                  errorBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          width: 0.05,
                          color: Colors.deepOrange.withOpacity(0.8)),
                      borderRadius: BorderRadius.circular(20)),
                ),
              ),
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                      onPressed: () {
                        Get.back();
                      },
                      style: ButtonStyle(shape:
                          MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          );
                        },
                      )),
                      child: const Padding(
                        padding: EdgeInsets.only(
                            top: 12.0, left: 30, right: 30, bottom: 15),
                        child: Text(
                          'Cancel',
                          style: TextStyle(
                              fontSize: 16,
                              fontFamily: 'cbold',
                              fontWeight: FontWeight.bold),
                        ),
                      )),
                  OutlinedButton(
                    onPressed: () {
                      stngbox.put('dailygoal', dailygoaltextinpt.text);
                      setState(() {});
                      Get.back();
                    },
                    style: ButtonStyle(
                      shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                        (states) {
                          return RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          );
                        },
                      ),
                      side: MaterialStateProperty.resolveWith<BorderSide>(
                        (states) {
                          return const BorderSide(color: Colors.deepOrange);
                        },
                      ),
                    ),
                    child: const Padding(
                      padding: EdgeInsets.only(
                          top: 12.0, left: 30, right: 30, bottom: 15),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'csemibold',
                            color: Colors.black,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//////////////// remindersheet
  Future<dynamic> remindersheet() {
    return Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      SizedBox(
        height: Get.size.height * 2 / 4,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ListTile(
              title: const Text(
                'Select Reminder After',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close, color: Colors.black)),
            ),
            const Spacer(),
            Reminderclass(
              onDataSelected: (int data) {
                setState(() {
                  reminderbyf = data;
                });
              },
            ),
          ],
        ),
      ),
    );
  }

  Future<dynamic> resttimeSheet() {
    return Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      SizedBox(
        height: Get.size.height * 2 / 4,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ListTile(
              title: const Text(
                'Select Time',
                style: TextStyle(
                    color: Colors.black87,
                    fontSize: 20,
                    fontWeight: FontWeight.bold),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Get.back();
                  },
                  icon: const Icon(Icons.close, color: Colors.black)),
            ),
            const Spacer(),
            // const Resttimeclass(),
            Resttimeclass(
              onDataSelected: (int data) {
                setState(() {
                  resttimebyf = data;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

////// restime of class here
class Resttimeclass extends StatefulWidget {
  final ValueChanged<int> onDataSelected;

  const Resttimeclass({super.key, required this.onDataSelected});

  @override
  State<Resttimeclass> createState() => _ResttimeclassState();
}

class _ResttimeclassState extends State<Resttimeclass> {
  //////////////// here rest time values

  List<String> buttonTitles = [
    '10',
    '20',
    '30',
    '40',
    '50',
    '60',
  ];

  // int resttimebuttonv = 0;

  int? resttime;
  int? slctdrestbtnindex = 10;
  String? dailygolcalvalv;
///// for hive box
  late Box<dynamic> stngbox;
///// for hive box
  @override
  void initState() {
    stngbox = Hive.box<dynamic>('profile');
    slctdrestbtnindex = stngbox.get('slctdrestbtnindex') ?? 10;
    super.initState();
  }

//////////////// end here rest time values
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 14.0,
          runSpacing: 20,
          children: List.generate(
            buttonTitles.length,
            (index) => OutlinedButton(
              onPressed: () {
                setState(() {
                  slctdrestbtnindex = index;
                  stngbox.put('slctdrestbtnindex', index);
                  int setvalis = stngbox.get('slctdrestbtnindex') == 0
                      ? 10
                      : stngbox.get('slctdrestbtnindex') == 1
                          ? 20
                          : stngbox.get('slctdrestbtnindex') == 2
                              ? 30
                              : stngbox.get('slctdrestbtnindex') == 3
                                  ? 40
                                  : stngbox.get('slctdrestbtnindex') == 4
                                      ? 50
                                      : 60;

                  stngbox.put('restval', setvalis);
                  widget.onDataSelected(setvalis);
                });
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    );
                  },
                ),
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const BorderSide(color: Colors.blue);
                    }
                    return BorderSide(
                        color: stngbox.get('slctdrestbtnindex') != null &&
                                stngbox.get('slctdrestbtnindex') == index
                            ? Colors.deepOrange
                            : Colors.grey);
                  },
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 5, right: 5, bottom: 25),
                child: Column(
                  children: [
                    Text(
                      buttonTitles[index],
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const Text(
                      'Seconds',
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'csemibold'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('save',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'cbold')),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

///////////////// end of rest time sheet
////// reminderclass of class here
class Reminderclass extends StatefulWidget {
  final ValueChanged<int> onDataSelected;

  const Reminderclass({super.key, required this.onDataSelected});

  @override
  State<Reminderclass> createState() => _ReminderclassState();
}

class _ReminderclassState extends State<Reminderclass> {
  //////////////// here rest time values

  List<String> buttonTitles = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
  ];

  // int resttimebuttonv = 0;

  int? resttime;
  int? slctdremibtnindex = 10;
  String? dailygolcalvalv;
///// for hive box
  late Box<dynamic> stngbox;
///// for hive box

  @override
  void initState() {
    stngbox = Hive.box<dynamic>('profile');

    slctdremibtnindex = stngbox.get('slctdremibtnindex');
    super.initState();
  }

//////////////// end here rest time values
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Wrap(
          spacing: 14.0,
          runSpacing: 20,
          children: List.generate(
            buttonTitles.length,
            (index) => OutlinedButton(
              onPressed: () {
                setState(() {
                  slctdremibtnindex = index;
                  stngbox.put('slctdremibtnindex', index);
                  int setvalis = stngbox.get('slctdremibtnindex') == 0
                      ? 1
                      : stngbox.get('slctdremibtnindex') == 1
                          ? 2
                          : stngbox.get('slctdremibtnindex') == 2
                              ? 3
                              : stngbox.get('slctdremibtnindex') == 3
                                  ? 4
                                  : stngbox.get('slctdremibtnindex') == 4
                                      ? 5
                                      : 6;

                  stngbox.put('reminderval', setvalis);
                  widget.onDataSelected(setvalis);
                });
              },
              style: ButtonStyle(
                shape: MaterialStateProperty.resolveWith<OutlinedBorder>(
                  (states) {
                    return RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20.0),
                    );
                  },
                ),
                side: MaterialStateProperty.resolveWith<BorderSide>(
                  (states) {
                    if (states.contains(MaterialState.pressed)) {
                      return const BorderSide(color: Colors.blue);
                    }
                    return BorderSide(
                        color: stngbox.get('slctdremibtnindex') != null &&
                                stngbox.get('slctdremibtnindex') == index
                            ? Colors.deepOrange
                            : Colors.grey);
                  },
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 25.0, left: 15, right: 15, bottom: 25),
                child: Column(
                  children: [
                    Text(
                      buttonTitles[index],
                      style: const TextStyle(color: Colors.black, fontSize: 20),
                    ),
                    const Text(
                      ' Day ',
                      style: TextStyle(
                          color: Colors.black, fontFamily: 'csemibold'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('save',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'cbold')),
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
///////////////// end of reminderclass sheet

////////////////////////////////////////
Future<dynamic> soundsheet() {
  return Get.bottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
    ),
    backgroundColor: const Color.fromARGB(251, 250, 250, 250),
    SizedBox(
      height: Get.size.height * 2.3 / 4,
      child: const Soundsheet2(),
    ),
  );
}

class Soundsheet2 extends StatefulWidget {
  const Soundsheet2({super.key});

  @override
  State<Soundsheet2> createState() => _Soundsheet2State();
}

class _Soundsheet2State extends State<Soundsheet2> {
  FlutterTts flutterTts = FlutterTts();
  void texttospeech(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.9);
    await flutterTts.setSpeechRate(0.2);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void texttospeechstng(double no, bool onoroff) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(1);
    await flutterTts.setSpeechRate(no);
  }

  void texttospeechstop() async {
    await flutterTts.stop();
  }

  bool? ttsonoff = false;
  bool? soundonoffval = true;
  double ttsspeed = 0.5;
///// for hive box
  late Box<dynamic> stngbox;
///// for hive box

  @override
  void initState() {
    stngbox = Hive.box<dynamic>('profile');

    ttsonoff = stngbox.get('ttsonoff');
    soundonoffval = stngbox.get('soundonoff');
    super.initState();
  }

//////////////// end here rest time values

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 15,
        ),
        ListTile(
          title: const Text(
            'Sound',
            style: TextStyle(
                color: Colors.black87,
                fontSize: 20,
                fontWeight: FontWeight.bold),
          ),
          trailing: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(Icons.close, color: Colors.black)),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Card(
            child: Column(
              children: [
                ListTile(
                  leading: const Icon(Icons.volume_down_outlined),
                  title: const Text(
                    'TTS Voice',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: CupertinoSwitch(
                    activeColor: Colors.deepOrange,
                    value: ttsonoff ?? false,
                    onChanged: (value) {
                      setState(() {
                        ttsonoff = !(ttsonoff ?? false);
                      });
                    },
                  ),
                ),
                OrangeSlider(
                  value: stngbox.get('ttsspeed') ?? 1,
                  onChanged: (v) {
                    setState(() {
                      ttsspeed = v;
                    });
                  },
                )
              ],
            ),
          ),
        ),
        const Spacer(),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ListTile(
                leading: const Icon(Icons.volume_down_outlined),
                title: const Text(
                  'Sound',
                  style: TextStyle(fontFamily: 'clight'),
                ),
                trailing: CupertinoSwitch(
                  activeColor: Colors.deepOrange,
                  value: soundonoffval ?? true,
                  onChanged: (value) {
                    setState(() {
                      soundonoffval = !(soundonoffval ?? true);
                    });
                  },
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
        GestureDetector(
          onTap: () {
            soundonoffval ?? true
                ? texttospeech('Speach Settings Updated')
                : texttospeechstop();
            texttospeechstng(ttsspeed, (soundonoffval ?? true));

            stngbox.put('ttsonoff', ttsonoff);
            stngbox.put('ttsspeed', ttsspeed);
            stngbox.put('soundonoff', soundonoffval);
            setState(() {});
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.deepOrange,
                  borderRadius: BorderRadius.circular(15)),
              child: const Center(
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Text('save',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 22,
                          fontFamily: 'cbold')),
                ),
              ),
            ),
          ),
        ),
        const Spacer(),
      ],
    );
  }
}

class OrangeSlider extends StatefulWidget {
  final double value;
  final ValueChanged<double> onChanged;

  const OrangeSlider({super.key, required this.value, required this.onChanged});

  @override
  State<OrangeSlider> createState() => _OrangeSliderState();
}

class _OrangeSliderState extends State<OrangeSlider> {
  late double _value;

  @override
  void initState() {
    super.initState();
    _value = widget.value;
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderTheme.of(context).copyWith(
        activeTrackColor: Colors.deepOrange,
        thumbColor: Colors.deepOrange,
        overlayColor: Colors.deepOrange.withAlpha(32),
        thumbShape: const _CustomThumbShape(
          radius: 5,
          boxSize: 22,
          boxRadius: 8,
          color: Colors.deepOrange,
          boxCircularRadius: 5,
        ),
      ),
      child: Slider(
        value: _value,
        min: 0,
        max: 2,
        onChanged: (value) {
          setState(() {
            _value = value;
          });
          widget.onChanged(value);
        },
      ),
    );
  }
}

class _CustomThumbShape extends SliderComponentShape {
  final double radius;
  final double boxSize;
  final double boxRadius;
  final double boxCircularRadius;
  final Color color;

  const _CustomThumbShape({
    required this.radius,
    required this.boxSize,
    required this.boxRadius,
    required this.boxCircularRadius,
    required this.color,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(radius);
  }

  @override
  void paint(PaintingContext context, Offset center,
      {required Animation<double> activationAnimation,
      required Animation<double> enableAnimation,
      required bool isDiscrete,
      required TextPainter labelPainter,
      required RenderBox parentBox,
      required SliderThemeData sliderTheme,
      required TextDirection textDirection,
      required double value,
      required double textScaleFactor,
      required Size sizeWithOverflow}) {
    final canvas = context.canvas;

    // Draw the thumb
    final thumbPath = Path()
      ..addOval(Rect.fromCircle(center: center, radius: radius));
    canvas.drawPath(thumbPath, Paint()..color = color);

    // Draw the box on the center of the thumb
    final boxOffset = center.translate(-boxSize / 2, -boxSize / 2);
    final boxRect = Rect.fromLTWH(boxOffset.dx, boxOffset.dy, boxSize, boxSize);
    final boxRRect = RRect.fromRectAndCorners(
      boxRect,
      topRight: Radius.circular(boxCircularRadius),
      topLeft: Radius.circular(boxCircularRadius),
      bottomRight: Radius.circular(boxCircularRadius),
      bottomLeft: Radius.circular(boxCircularRadius),
    );
    canvas.drawRRect(boxRRect, Paint()..color = Colors.deepOrange);
  }
}

////////////////////////////////////////
