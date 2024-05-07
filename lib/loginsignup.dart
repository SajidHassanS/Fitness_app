import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_cupertino_picker/custom_cupertino_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout/plansmodel/plansmodelclass.dart';
import 'package:workout/terms.dart';
import 'main.dart';

class Login extends StatefulWidget {
  const Login({Key? key}) : super(key: key);

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  // @override
  // void initState() {
  //   super.initState();
  //   // caluitopbottomnva();
  // }

  // caluitopbottomnva() {
  //   SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark.copyWith(
  //       statusBarColor: const Color.fromARGB(206, 241, 239, 238),
  //       statusBarIconBrightness: Brightness.dark,
  //       systemNavigationBarColor: Colors.white,
  //       systemNavigationBarIconBrightness: Brightness.dark));
  // }

  @override
  void initState() {
    hiveboxcheck();
    super.initState();
  }

  hiveboxcheck() async {
    if (!Hive.isBoxOpen('profile')) {
      await Hive.openBox('profile');
    }
    if (!Hive.isBoxOpen('actibox')) {
      await Hive.openBox('actibox');
    }
    if (!Hive.isBoxOpen('activitybox')) {
      await Hive.openBox('activitybox');
    }
    if (!Hive.isBoxOpen('plansbox')) {
      await Hive.openBox<Plansmodelclass>('plansbox');
    }
    if (!Hive.isBoxOpen('chartbox')) {
      await Hive.openBox<WeightchartData>('chartbox');
    }
    //// check adapter
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PlansmodelclassAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(WeightchartDataAdapter());
    }
  }

  TextEditingController loginnamecont = TextEditingController();
  TextEditingController loginpasscont = TextEditingController();

  FlutterTts flutterTts = FlutterTts();
  void ttsforsignup(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.9);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.white,
              statusBarIconBrightness: Brightness.dark,
              systemNavigationBarColor: Color.fromARGB(255, 255, 255, 255),
              systemNavigationBarIconBrightness: Brightness.dark),
          leading: const Text(' '),
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        body: Padding(
          padding: const EdgeInsets.all(14.0),
          child: ListView(
            children: [
              const ListTile(
                  contentPadding: EdgeInsets.all(0),
                  title: Text(
                    'Login',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontFamily: 'clight',
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'Welcome back to our account!',
                    style: TextStyle(color: Colors.black, fontFamily: 'clight'),
                  )),
              const SizedBox(height: 17),
              TextField(
                controller: loginnamecont,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.person_3_outlined),
                  hintText: 'Name',
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
              const SizedBox(height: 16),
              TextField(
                controller: loginpasscont,
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.email_outlined),
                  hintText: 'Password',
                  helperStyle: const TextStyle(fontSize: 10),
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
              const SizedBox(height: 16),
              ListTile(
                contentPadding: const EdgeInsets.all(0),
                trailing: Padding(
                  padding: const EdgeInsets.only(left: 8.0),
                  child: TextButton(
                      onPressed: () {
                        Get.to(const Forgotpasw());
                      },
                      child: const Text(
                        'Forgot Password?',
                        style: TextStyle(
                            color: Colors.black, fontFamily: 'clight'),
                      )),
                ),
              ),
              GestureDetector(
                onTap: () async {
                  QuerySnapshot chkuseridfirst = await FirebaseFirestore
                      .instance
                      .collection('users')
                      .where('name', isEqualTo: loginnamecont.text.toString())
                      .where('pass', isEqualTo: loginpasscont.text.toString())
                      .get();
                  if (loginnamecont.text.length <= 1 ||
                      loginpasscont.text.length <= 1) {
                    Get.snackbar(
                        icon: const Icon(
                          Icons.warning_amber_rounded,
                          color: Colors.deepOrangeAccent,
                          shadows: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 2)
                          ],
                        ),
                        shouldIconPulse: true,
                        snackPosition: SnackPosition.TOP,
                        'Required',
                        'All Fields');
                    ttsforsignup('Required All Fields With Correct Details');
                  } else if (chkuseridfirst.size >= 1) {
                    // ignore: use_build_context_synchronously
                    FocusScope.of(context).unfocus();
                    Get.snackbar(
                        icon: const Icon(
                          Icons.check_circle_sharp,
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
                        loginnamecont.text.toString(),
                        'You Successfully Login');

                    try {
                      final stngbox = Hive.box<dynamic>('profile');
                      QuerySnapshot chkuseridfirst = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .where('name',
                              isEqualTo: loginnamecont.text.toString())
                          .get();

                      String thisdocId = chkuseridfirst.docs[0].id;
                      DocumentSnapshot snapshot =
                          await FirebaseFirestore.instance
                              .collection('users')
                              .doc(thisdocId) // here is id of user
                              .get();
                      if (snapshot.exists) {
                        Map<String, dynamic>? data =
                            snapshot.data() as Map<String, dynamic>?;

                        String? gmail =
                            data?['email'] ?? 'update from settings';
                        await stngbox.put('useremailkey', gmail.toString());
                      }
                      await stngbox.put(
                          'usernamekey', loginnamecont.text.toString());
                    } catch (e) {
                      debugPrint('${e.toString()}///////////////////////');
                    }
                    loginnamecont.clear();
                    // zoom up bouncing animation
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushReplacement(
                      PageRouteBuilder(
                        transitionDuration: const Duration(seconds: 2),
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            const Home(),
                        transitionsBuilder:
                            (context, animation, secondaryAnimation, child) {
                          final tween = Tween<double>(begin: 0.0, end: 1.0);
                          final curve = CurvedAnimation(
                            parent: animation,
                            curve: Curves.bounceInOut,
                          );
                          return ScaleTransition(
                            scale: tween.animate(curve),
                            child: child,
                          );
                        },
                      ),
                    );

                    // zoom up only animation
                    // Navigator.of(context).pushReplacement(
                    //   PageRouteBuilder(
                    //     transitionDuration: const Duration(seconds: 2),
                    //     pageBuilder: (context, animation, secondaryAnimation) =>
                    //         const Home(),
                    //     transitionsBuilder:
                    //         (context, animation, secondaryAnimation, child) {
                    //       const begin = 0.5;
                    //       const end = 1.0;
                    //       final tween = Tween(begin: begin, end: end);
                    //       final curvedAnimation = CurvedAnimation(
                    //           parent: animation, curve: Curves.easeInOut);

                    //       return ScaleTransition(
                    //         scale: tween.animate(curvedAnimation),
                    //         child: child,
                    //       );
                    //     },
                    //   ),
                    // );
                  } else {
                    ttsforsignup(
                        ' ${loginnamecont.text.toString()}. Please Enter Correct Details');
                    Get.snackbar(
                        icon: const Icon(
                          Icons.warning_rounded,
                          color: Colors.deepOrangeAccent,
                          shadows: [
                            BoxShadow(
                                color: Colors.black,
                                offset: Offset(1, 1),
                                blurRadius: 2)
                          ],
                        ),
                        shouldIconPulse: true,
                        snackPosition: SnackPosition.TOP,
                        loginnamecont.text.toString(),
                        'Please Enter Correct Details');
                  }
                },
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.deepOrange,
                      borderRadius: BorderRadius.circular(20)),
                  child: const Center(
                    child: Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text('Login',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontFamily: 'cbold')),
                    ),
                  ),
                ),
              ),
              SizedBox(height: MediaQuery.of(context).size.height * 1.3 / 4),
              Center(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('Don`t have an account?'),
                    TextButton(
                        onPressed: () {
                          Get.to(const Selectgenderreg());
                        },
                        child: const Text(
                          'Sign Up',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'cbold',
                              fontWeight: FontWeight.bold,
                              fontSize: 17),
                        ))
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Forgotpasw extends StatefulWidget {
  const Forgotpasw({Key? key}) : super(key: key);

  @override
  State<Forgotpasw> createState() => _ForgotpaswState();
}

class _ForgotpaswState extends State<Forgotpasw> {
  TextEditingController getnametextcont = TextEditingController();
  TextEditingController getsecpasstextcont = TextEditingController();
  TextEditingController setnewpasstextcont = TextEditingController();
  FlutterTts flutterTts = FlutterTts();
  void ttsforsignup(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.9);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Forgot Password',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontFamily: 'clight',
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'we need your registration secret key for reset password',
                  style: TextStyle(color: Colors.black, fontFamily: 'clight'),
                )),
            const SizedBox(height: 16),
            TextField(
              controller: getnametextcont,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline_rounded),
                hintText: 'Name',
                helperStyle: const TextStyle(fontSize: 10),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0.05, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(23)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: const BorderSide(width: 0.05),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.05, color: Colors.deepOrange.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(23)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: getsecpasstextcont,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password_outlined),
                hintText: 'Secret Key',
                helperStyle: const TextStyle(fontSize: 10),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0.05, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(23)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: const BorderSide(width: 0.05),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.05, color: Colors.deepOrange.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(23)),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () async {
                QuerySnapshot chkuseridfirst = await FirebaseFirestore.instance
                    .collection('users')
                    .where('name', isEqualTo: getnametextcont.text.toString())
                    .where('pass',
                        isEqualTo: getsecpasstextcont.text.toString())
                    .get();
                if (getsecpasstextcont.text.length <= 1) {
                  Get.snackbar(
                      icon: const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.deepOrangeAccent,
                        shadows: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ],
                      ),
                      shouldIconPulse: true,
                      snackPosition: SnackPosition.TOP,
                      'Required Correct',
                      'Secret Password');
                  ttsforsignup('Please Required Correct Secret Password');
                } else if (chkuseridfirst.size == 1) {
                  Get.snackbar(
                      icon: const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.deepOrangeAccent,
                        shadows: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ],
                      ),
                      shouldIconPulse: true,
                      snackPosition: SnackPosition.TOP,
                      'Now',
                      'Set New Password');
                  QuerySnapshot chkuseridsec = await FirebaseFirestore.instance
                      .collection('users')
                      .where('name', isEqualTo: getnametextcont.text.toString())
                      .get();
                  ///// its means 0 is where id meeet on 0 index  if equal
                  String thisdocId = chkuseridsec.docs[0].id;

                  if (chkuseridsec.size == 1) {
                    Get.defaultDialog(
                        title: 'New Password',
                        content: TextField(
                          controller: setnewpasstextcont,
                          decoration: InputDecoration(
                            prefixIcon: const Icon(Icons.password_outlined),
                            hintText: 'Secret Key',
                            helperStyle: const TextStyle(fontSize: 10),
                            disabledBorder: OutlineInputBorder(
                                borderSide: const BorderSide(
                                    width: 0.05, color: Colors.blueGrey),
                                borderRadius: BorderRadius.circular(23)),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(23),
                              borderSide: const BorderSide(width: 0.05),
                            ),
                            errorBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                    width: 0.05,
                                    color: Colors.deepOrange.withOpacity(0.8)),
                                borderRadius: BorderRadius.circular(23)),
                          ),
                        ),
                        actions: [
                          OutlinedButton(
                              onPressed: () {
                                Get.back();
                              },
                              child: const Text('Cancel')),
                          const SizedBox(
                            width: 30,
                          ),
                          ElevatedButton(
                              onPressed: () async {
                                await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(thisdocId) // here is id of user
                                    .update({
                                  'pass': setnewpasstextcont.text,
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
                                      'Password Reset',
                                      setnewpasstextcont.text.toString());
                                  ttsforsignup(
                                      '${setnewpasstextcont.text.toString()}. is New Password');
                                  Get.back();
                                  setnewpasstextcont.clear();
                                });
                              },
                              child: const Text('Set')),
                        ]);
                  }
                } else {
                  Get.snackbar(
                      icon: const Icon(
                        Icons.warning_amber_rounded,
                        color: Colors.deepOrangeAccent,
                        shadows: [
                          BoxShadow(
                              color: Colors.black,
                              offset: Offset(1, 1),
                              blurRadius: 2)
                        ],
                      ),
                      shouldIconPulse: true,
                      snackPosition: SnackPosition.TOP,
                      'Account Suspended',
                      'if try 7 times at simultaneously');
                  getsecpasstextcont.clear();
                  ttsforsignup('Please Enter Correct Secret Password');
                }
              },
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(20)),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(12.0),
                    child: Text('Submit',
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
    );
  }
}

/////////////////////////////////
///
///
///
///   For SignUp
///
///
///
///

class Selectgenderreg extends StatefulWidget {
  const Selectgenderreg({super.key});

  @override
  State<Selectgenderreg> createState() => _SelectgenderregState();
}

class _SelectgenderregState extends State<Selectgenderreg> {
  bool selectedgenderm = true;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          const Text('Select You Gender',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'cbold',
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 11,
          ),
          Center(
            child: SizedBox(
                width: Get.size.width * 1.8 / 4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  child: OutlinedButton(
                    onPressed: () async {
                      setState(() {
                        try {
                          final prfilebox = Hive.box<dynamic>('profile');
                          prfilebox.put('genderbox', 'Male');
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                        selectedgenderm = !selectedgenderm;
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
                            return const BorderSide(color: Colors.deepOrange);
                          }
                          return BorderSide(
                              color: selectedgenderm
                                  ? Colors.grey
                                  : Colors.transparent);
                        },
                      ),
                    ),
                    child: Transform.scale(
                      scale: 1.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Image.asset(
                          'assets/images/male.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: SizedBox(
                width: Get.size.width * 1.8 / 4,
                child: ClipRRect(
                  borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                  child: OutlinedButton(
                    onPressed: () {
                      setState(() {
                        try {
                          final prfilebox = Hive.box<dynamic>('profile');
                          prfilebox.put('genderbox', 'Female');
                        } catch (e) {
                          debugPrint(e.toString());
                        }
                        selectedgenderm = !selectedgenderm;
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
                            return const BorderSide(color: Colors.deepOrange);
                          }
                          return BorderSide(
                              color: selectedgenderm
                                  ? Colors.transparent
                                  : Colors.grey);
                        },
                      ),
                    ),
                    child: Transform.scale(
                      scale: 1.3,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Image.asset(
                          'assets/images/female.png',
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.to(const Oldareyoureg());
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
                    child: Text('Next',
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
      ),
    );
  }
}

////////////////////////
class Oldareyoureg extends StatefulWidget {
  const Oldareyoureg({super.key});

  @override
  State<Oldareyoureg> createState() => _OldareyouregState();
}

class _OldareyouregState extends State<Oldareyoureg> {
  late int _selectedAge;
  final int _minAge = 18;
  final int _maxAge = 100;

  @override
  void initState() {
    super.initState();
    _selectedAge = 18;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: Column(
        children: [
          const Text('How old are you?',
              style: TextStyle(
                  color: Colors.black,
                  fontSize: 25,
                  fontFamily: 'cbold',
                  fontWeight: FontWeight.bold)),
          const SizedBox(
            height: 80,
          ),
          Expanded(
            child: CustomCupertinoPicker(
              backgroundColor: Colors.transparent,
              looping: false,
              itemExtent: 100,
              highlighterBorder: const Border(
                top: BorderSide(
                  width: 1.0,
                  color: Colors.orange,
                ),
                bottom: BorderSide(
                  width: 1.0,
                  color: Colors.orange,
                ),
              ),
              highlighterBorderWidth: 60,
              scrollPhysics: const FixedExtentScrollPhysics(
                parent: BouncingScrollPhysics(),
              ),
              onSelectedItemChanged: (index) {
                setState(() {
                  _selectedAge = index + _minAge;
                });
              },
              children: List.generate(
                _maxAge - _minAge + 1,
                (index) {
                  final age = index + _minAge;
                  final isSelected = age == _selectedAge;
                  final textStyle = TextStyle(
                    fontSize: isSelected ? 60 : 40,
                    color: isSelected ? Colors.deepOrange : Colors.black,
                  );
                  return Center(
                    child: Text(
                      '$age',
                      style: textStyle,
                    ),
                  );
                },
              ),
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.to(const Howmanyexreg());
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
                    child: Text('Next',
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
      ),
    );
  }
}

////////////////////////
////////////////////////
class Howmanyexreg extends StatefulWidget {
  const Howmanyexreg({super.key});

  @override
  State<Howmanyexreg> createState() => _HowmanyexregState();
}

class _HowmanyexregState extends State<Howmanyexreg> {
  var howmanyexval = 0;
  List<String> buttonoldru = [
    '2',
    '2-3',
    'Over 4',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView(
          children: [
            const Center(
              child: Text('How Many Times you Excercise in a Week',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 24,
                      fontFamily: 'cbold',
                      fontWeight: FontWeight.bold)),
            ),
            const SizedBox(
              height: 20,
            ),
            Wrap(
              spacing: 14.0,
              runSpacing: 20,
              children: List.generate(
                buttonoldru.length,
                (index) => OutlinedButton(
                  onPressed: () {
                    setState(() {
                      howmanyexval = index;
                    });
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                      (states) {
                        return howmanyexval == index
                            ? const Color.fromARGB(255, 255, 239, 234)
                            : Colors.transparent;
                      },
                    ),
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
                          return const BorderSide(color: Colors.deepOrange);
                        }
                        return BorderSide(
                            color: howmanyexval == index
                                ? Colors.transparent
                                : Colors.grey);
                      },
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        top: 18.0, left: 5, right: 5, bottom: 18),
                    child: SizedBox(
                      width: double.infinity,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            buttonoldru[index] == '2'
                                ? 'Begginer'
                                : buttonoldru[index] == '2-3'
                                    ? 'Intermediate'
                                    : 'Advanced',
                            style: const TextStyle(
                                color: Colors.black, fontSize: 20),
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Text(
                            '${buttonoldru[index]} times a week',
                            style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 12,
                                fontFamily: 'clight'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 1.25 / 4,
            ),
            GestureDetector(
              onTap: () {
                Get.to(const Signup());
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
                      child: Text('Next',
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
        ),
      ),
    );
  }
}
////////////////////////

////////////////////////
class Signup extends StatefulWidget {
  const Signup({Key? key}) : super(key: key);

  @override
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override
  void initState() {
    hiveboxcheck();
    super.initState();
  }

  hiveboxcheck() async {
    if (!Hive.isBoxOpen('profile')) {
      await Hive.openBox('profile');
    }
    if (!Hive.isBoxOpen('actibox')) {
      await Hive.openBox('actibox');
    }
    if (!Hive.isBoxOpen('activitybox')) {
      await Hive.openBox('activitybox');
    }
    if (!Hive.isBoxOpen('plansbox')) {
      await Hive.openBox<Plansmodelclass>('plansbox');
    }
    if (!Hive.isBoxOpen('chartbox')) {
      await Hive.openBox<WeightchartData>('chartbox');
    }
    //// check adapter
    if (!Hive.isAdapterRegistered(0)) {
      Hive.registerAdapter(PlansmodelclassAdapter());
    }
    if (!Hive.isAdapterRegistered(2)) {
      Hive.registerAdapter(WeightchartDataAdapter());
    }
  }

  TextEditingController nametextcont = TextEditingController();
  TextEditingController passtextcont = TextEditingController();
  TextEditingController emailtextcont = TextEditingController();
  TextEditingController seckeytextcont = TextEditingController();

  FlutterTts flutterTts = FlutterTts();
  void ttsforsignup(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.9);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  // @override
  // void initState() {
  //   chekhivef();
  //   super.initState();
  // }

  bool agreeval = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(14.0),
        child: ListView(
          children: [
            const ListTile(
                contentPadding: EdgeInsets.all(0),
                title: Text(
                  'Sign Up',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 23,
                      fontFamily: 'clight',
                      fontWeight: FontWeight.bold),
                ),
                subtitle: Text(
                  'Create Account',
                  style: TextStyle(color: Colors.black, fontFamily: 'clight'),
                )),
            const SizedBox(height: 16),
            TextField(
              controller: nametextcont,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.person_outline_outlined),
                hintText: 'Full Name',
                helperStyle: const TextStyle(fontSize: 10),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0.05, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(23)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: const BorderSide(width: 0.05),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.05, color: Colors.deepOrange.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(23)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: emailtextcont,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.email_outlined),
                hintText: 'Email',
                helperStyle: const TextStyle(fontSize: 10),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0.05, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(23)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: const BorderSide(width: 0.05),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.05, color: Colors.deepOrange.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(23)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: passtextcont,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password_outlined),
                hintText: 'Password',
                helperStyle: const TextStyle(fontSize: 10),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0.05, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(23)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: const BorderSide(width: 0.05),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.05, color: Colors.deepOrange.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(23)),
              ),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: seckeytextcont,
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.password_outlined),
                hintText: 'Secret Key',
                helperStyle: const TextStyle(fontSize: 10),
                disabledBorder: OutlineInputBorder(
                    borderSide:
                        const BorderSide(width: 0.05, color: Colors.blueGrey),
                    borderRadius: BorderRadius.circular(23)),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(23),
                  borderSide: const BorderSide(width: 0.05),
                ),
                errorBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        width: 0.05, color: Colors.deepOrange.withOpacity(0.8)),
                    borderRadius: BorderRadius.circular(23)),
              ),
            ),
            const SizedBox(height: 16),
            ListTile(
              leading: Checkbox(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5),
                ),
                side: const BorderSide(
                  color: Colors.deepOrange,
                  width: 0.58,
                ),
                splashRadius: 30,
                value: agreeval,
                onChanged: (v) {
                  setState(() {
                    agreeval = !agreeval;
                  });
                },
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                visualDensity: VisualDensity.compact,
                checkColor: Colors.white,
              ),
              title: Container(
                margin: const EdgeInsets.only(right: 10.0),
                child: Row(
                  children: [
                    const Text(
                      'i agree with',
                      style: TextStyle(
                        fontSize: 12,
                        fontFamily: 'clight',
                      ),
                    ),
                    TextButton(
                        onPressed: () {
                          Get.to(const Termsandcondition());
                        },
                        child: const Text(
                          'Terms & Privacy',
                          style: TextStyle(
                            color: Colors.deepOrangeAccent,
                            fontSize: 12,
                            fontFamily: 'clight',
                          ),
                        ))
                  ],
                ),
              ),
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: agreeval
                  ? () async {
                      QuerySnapshot chkuseridfirst = await FirebaseFirestore
                          .instance
                          .collection('users')
                          .where('name',
                              isEqualTo: nametextcont.text.toString())
                          .get();
                      if (nametextcont.text.length <= 1 ||
                          emailtextcont.text.length <= 1 ||
                          passtextcont.text.length <= 1 ||
                          seckeytextcont.text.length <= 1) {
                        Get.snackbar(
                            icon: const Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.deepOrangeAccent,
                              shadows: [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 2)
                              ],
                            ),
                            shouldIconPulse: true,
                            snackPosition: SnackPosition.TOP,
                            'Required',
                            'All Fields');
                        ttsforsignup(
                            'Required All Fields With Correct Details');
                      } else if (chkuseridfirst.size == 1) {
                        Get.snackbar(
                            icon: const Icon(
                              Icons.warning_amber_rounded,
                              color: Colors.deepOrangeAccent,
                              shadows: [
                                BoxShadow(
                                    color: Colors.black,
                                    offset: Offset(1, 1),
                                    blurRadius: 2)
                              ],
                            ),
                            shouldIconPulse: true,
                            snackPosition: SnackPosition.TOP,
                            'Already Registerd',
                            'This Name Or Check Internet Conection');
                        ttsforsignup(
                            '${nametextcont.text.toString()}. This Name Already Registerd Or Check Internet Connection');
                      } else {
                        await FirebaseFirestore.instance
                            .collection('users')
                            .doc() // here is id of user
                            .set({
                          'name': nametextcont.text,
                          'pass': passtextcont.text,
                          'email': emailtextcont.text,
                          'secpass': seckeytextcont.text,
                          'time': FieldValue.serverTimestamp(),
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
                              'Account Created',
                              nametextcont.text.toString());
                          try {
                            final stngbox = Hive.box<dynamic>('profile');
                            stngbox.put(
                                'usernamekey', nametextcont.text.toString());
                            stngbox.put(
                                'useremailkey', emailtextcont.text.toString());
                          } catch (e) {
                            debugPrint(
                                '${e.toString()}///////////////////////');
                          }
                          nametextcont.clear();
                          passtextcont.clear();
                          emailtextcont.clear();
                          seckeytextcont.clear();
                        }).catchError((error) =>
                                // ignore: invalid_return_type_for_catch_error
                                debugPrint("Failed to add document: $error"));

                        ttsforsignup(
                            '${nametextcont.text.toString()} Check Login');

                        Timer(const Duration(seconds: 3), () {
                          Navigator.of(context).pushReplacement(
                            PageRouteBuilder(
                              transitionDuration: const Duration(seconds: 2),
                              pageBuilder:
                                  (context, animation, secondaryAnimation) =>
                                      const Home(),
                              transitionsBuilder: (context, animation,
                                  secondaryAnimation, child) {
                                final tween =
                                    Tween<double>(begin: 0.0, end: 1.0);
                                final curve = CurvedAnimation(
                                  parent: animation,
                                  curve: Curves.bounceInOut,
                                );
                                return ScaleTransition(
                                  scale: tween.animate(curve),
                                  child: child,
                                );
                              },
                            ),
                          );
                        });
                      }
                    }
                  : null,
              child: agreeval
                  ? Container(
                      decoration: BoxDecoration(
                          color: Colors.deepOrange,
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'cbold')),
                        ),
                      ),
                    )
                  : Container(
                      decoration: BoxDecoration(
                          color: const Color.fromARGB(139, 255, 86, 34),
                          borderRadius: BorderRadius.circular(20)),
                      child: const Center(
                        child: Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text('Sign Up',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 25,
                                  fontFamily: 'cbold')),
                        ),
                      ),
                    ),
            ),
            SizedBox(height: MediaQuery.of(context).size.height * 0.4 / 4),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                      onPressed: () {
                        Get.to(const Login());
                      },
                      child: const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'cbold',
                            fontWeight: FontWeight.bold,
                            fontSize: 17),
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
