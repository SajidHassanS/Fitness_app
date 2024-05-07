// import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_progress_status/flutter_progress_status.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:get/get.dart';
import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout/glitchtext.dart';
import 'package:workout/splash.dart';
import 'package:workout/plansmodel/plansmodelclass.dart';
import 'bell.dart';
import 'firebase_options.dart';
import 'activity.dart';
import 'addplans.dart';
import 'discover.dart';
import 'editprofile.dart';
import 'hinfo.dart';
import 'intro.dart';
import 'opencatg.dart';
import 'setting.dart';
import 'veiwallcatg.dart';
import 'vplanslistpage.dart';
import 'weeklytraning.dart';

FlutterLocalNotificationsPlugin notificationsPlugin =
    FlutterLocalNotificationsPlugin();
void main() async {
  await Hive.initFlutter();
  await Hive.openBox('profile');
  await Hive.openBox('actibox');
  await Hive.openBox('activitybox');
  Hive.registerAdapter(PlansmodelclassAdapter());
  Hive.registerAdapter(ExercisesAdapter());
  await Hive.openBox<Plansmodelclass>('plansbox');
  Hive.registerAdapter(WeightchartDataAdapter());
  await Hive.openBox<WeightchartData>('chartbox');

  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // FirebaseFirestore.instance.enablePersistence();
///////// for local notifications setups

  AndroidInitializationSettings androidSettings =
      const AndroidInitializationSettings("@mipmap/bellicon");

  InitializationSettings initializationSettings = InitializationSettings(
    android: androidSettings,
  );

  // ignore: unused_local_variable
  bool? initialized = await notificationsPlugin.initialize(
    initializationSettings,
  );
  // log("Notifications: $initialized");

///////// for local notifications setups
  runApp(const Materialopen());
}

class Materialopen extends StatelessWidget {
  const Materialopen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Workout',
      theme: ThemeData(primarySwatch: Colors.deepOrange),
      debugShowCheckedModeBanner: false,
      initialRoute: '/SplashScreen',

      // defaultTransition: Transition.cupertino,
      // unknownRoute: GetPage(name: '/error', page: () => const Vpage404()),

      getPages: [
        GetPage(
          name: '/',
          page: () => const Homepage(),
        ),
        GetPage(
          name: '/SplashScreen',
          page: () => const SplashScreen(),
        ),
        GetPage(
          name: '/Home',
          page: () => const Home(),
        ),
        GetPage(
          name: '/editprofile',
          page: () => const Editprofile(),
        ),
        GetPage(
          name: '/bell',
          page: () => const Bell(),
        ),
        GetPage(
          name: '/hinfo',
          page: () => const Hinfo(),
        ),
        GetPage(
          name: '/OnBoardingPage',
          page: () => const OnBoardingPage(),
        ),
        GetPage(
          name: '/VallCatgpage',
          page: () => const VallCatgpage(),
        ),
      ],

      home: const Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  chekhivef() async {
    ///// check first open boxes
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

  /////////////////////////////////////
  int pagevindex = 0;

  var pagelist = const [
    Homepage(),
    Discoverpage(),
    Addplanspage(),
    Addplanspage(),
    Activitypage(),
    Settingpage(),
  ];

  _pageback() {
    setState(() {
      pagevindex = 0;
    });
  }

  @override
  void initState() {
    super.initState();
    chekhivef();
    // showNotification();
  }

  @override
  void dispose() async {
    await Hive.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var appbarlist = [
      AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              setState(() {
                pagevindex = 5;
              });
            },
            icon: const Icon(Icons.menu, color: Colors.black)),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: GestureDetector(
              onTap: () {
                Get.to(const Editprofile());
              },
              child: CircleAvatar(
                child: ValueListenableBuilder<Box>(
                    valueListenable: Hive.box('profile').listenable(),
                    builder: (BuildContext context, Box<dynamic> stngbox, _) {
                      dynamic userpImage = stngbox.get('userpImage');
                      File? imageFile;
                      if (userpImage is String) {
                        imageFile = File(userpImage);
                      } else if (userpImage is File) {
                        imageFile = userpImage;
                      }

                      return ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: SizedBox(
                          width: 36,
                          height: 45,
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
                      );
                    }),
              ),
            ),
          )
        ],
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(10),
          child: SizedBox(),
        ),
      ),
      AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
            onPressed: _pageback,
            icon: const Icon(
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text(
          'Discover Workout',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
            onPressed: _pageback,
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: const Text(
          'Custom Workout',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
            onPressed: _pageback,
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: const Text(
          'Custom Workout',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
            onPressed: _pageback,
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: const Text(
          'Activity',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
            onPressed: _pageback,
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: const Text(
          'Setting',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
    ];

    return WillPopScope(
      onWillPop: () async {
        bool quit = await showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0)),
              title: const Text('Are you sure you want to quit?'),
              actions: <Widget>[
                TextButton(
                  child: Text('No',
                      style:
                          TextStyle(color: Colors.deepOrange.withOpacity(0.5))),
                  onPressed: () {
                    Navigator.of(context).pop(false);
                  },
                ),
                TextButton(
                  child: const Text('Yes'),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
              ],
            );
          },
        );

        // If the user wants to quit, close the app
        if (quit == true) {
          return Future.value(true);
        } else {
          return Future.value(false);
        }
      },
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: appbarlist[pagevindex],
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            selectedItemColor: Colors.black,
            unselectedItemColor: Colors.black54,
            selectedFontSize: 0,
            unselectedFontSize: 0,
            currentIndex: pagevindex,
            elevation: 0,
            backgroundColor: Colors.white,
            items: const <BottomNavigationBarItem>[
              BottomNavigationBarItem(
                icon: Icon(Icons.home),
                activeIcon: Icon(Icons.home),
                tooltip: '',
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.compass_calibration_outlined),
                activeIcon: Icon(Icons.compass_calibration),
                tooltip: '',
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                activeIcon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                tooltip: 'add',
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                activeIcon: Icon(
                  Icons.add,
                  color: Colors.white,
                ),
                tooltip: 'add',
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.date_range),
                activeIcon: Icon(Icons.date_range),
                tooltip: 'activity',
                label: '',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.settings_outlined),
                activeIcon: Icon(Icons.settings_outlined),
                tooltip: 'setting',
                label: '',
              ),
            ],
            onTap: ((value) {
              setState(() {
                pagevindex = value;
              });
              // debugPrint('$value');
            }),
          ),
        ),
        floatingActionButton: CustomPaint(
          painter:
              _DomePainter(color: const Color.fromARGB(255, 250, 250, 250)),
          child: Padding(
            padding:
                const EdgeInsets.only(top: 4.0, left: 40, right: 40, bottom: 0),
            child: FloatingActionButton(
              mini: true,
              onPressed: () {
                setState(() {
                  pagevindex = 3;
                });
              },
              hoverColor: Colors.amberAccent,
              tooltip: 'why open mail page',
              child: const Icon(Icons.add),
            ),
          ),
        ),
        body: pagelist[pagevindex],
      ),
    );
  }
}

/////////////

class Homepage extends StatelessWidget {
  const Homepage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      controller: ScrollController(),
      physics: const BouncingScrollPhysics(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const SizedBox(
            height: 10,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Row(
              children: [
                Text(" ${Hive.box('profile').get('morningevening')}"),
                GlithEffect(
                  child: Text(" ${Hive.box('profile').get('usernamekey')}!",
                      style: const TextStyle(
                          color: Color.fromARGB(255, 80, 201, 231),
                          shadows: [
                            BoxShadow(
                              color: Color.fromARGB(255, 139, 33, 0),
                              offset: Offset(0.5, 0.5),
                              blurRadius: 1,
                            ),
                          ])),
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(
              'Let`s Shape YourSelf',
              style: TextStyle(
                  fontSize: 23,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              decoration: BoxDecoration(
                  color: const Color.fromARGB(255, 255, 239, 234),
                  borderRadius: BorderRadius.circular(15)),
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 12, top: 16.0, right: 10, bottom: 18),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Your Progress In This Week',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18),
                    ),
                    ProgressStatus(
                      fillColor: const Color.fromARGB(255, 255, 116, 51),
                      backgroundColor: Colors.white,
                      radius: 23,
                      strokeWidth: 3,
                      fillValue: Hive.box('profile')
                                  .get('vweeklyprogress')
                                  .toDouble() ==
                              null
                          ? 70
                          : Hive.box('profile')
                                  .get('vweeklyprogress')
                                  .toDouble() *
                              100 /
                              40,
                      centerTextStyle: const TextStyle(
                          color: Color.fromARGB(255, 255, 116, 51),
                          fontSize: 13),
                    ),
                  ],
                ),
              ),
            ),
          ),
          ListTile(
            title: const Hero(
              tag: 'workoutseeall',
              child: Text(
                'Workout',
                style: TextStyle(color: Colors.black, fontSize: 17),
              ),
            ),
            trailing: const Text('see all'),
            onTap: () {
              Get.to(
                  const Weekltraining(
                    id: 0,
                    title: 'For Begginer',
                    image: 'assets/images/workout1.png',
                    colorname: Color.fromARGB(255, 203, 231, 254),
                    // tagnamewk: 'workoutseeall',
                  ),
                  transition: Transition.fadeIn);
            },
          ),
          CarouselSlider(
            options: CarouselOptions(
              autoPlay: true,
              aspectRatio: 2.0,
              enlargeCenterPage: false,
            ),
            items: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                        const Weekltraining(
                          id: 1,
                          title: 'For Begginer',
                          image: 'assets/images/workout1.png',
                          colorname: Color.fromARGB(255, 203, 231, 254),
                          // tagnamewk: 'workout1weekly',
                        ),
                        transition: Transition.fade);
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            child: Container(
                              color: const Color.fromARGB(255, 203, 231, 254),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 17),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'For Beginner',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  const Spacer(),
                                  Row(children: const [
                                    Icon(Icons.timer_outlined, size: 14),
                                    Text(' 4 week'),
                                  ]),
                                  const Spacer(),
                                  Row(children: const [
                                    Icon(
                                      Icons.fitness_center_outlined,
                                      size: 14,
                                    ),
                                    Text(' 28 Excercise'),
                                  ]),
                                  const Spacer(),
                                  Row(children: const [
                                    Text('Let`s Start ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 14,
                                    ),
                                  ]),
                                  const Spacer(),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Transform.translate(
                                offset: const Offset(-2, 0),
                                child: Image.asset(
                                  'assets/images/image.png',
                                  fit: BoxFit.cover,
                                  scale: 1,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: GestureDetector(
                  onTap: () {
                    Get.to(
                        const Weekltraining(
                          id: 2,
                          title: 'For Intermediate',
                          image: 'assets/images/workout2.png',
                          colorname: Color.fromARGB(255, 254, 241, 202),
                          // tagnamewk: 'workout2weekly',
                        ),
                        transition: Transition.fade);
                  },
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(Radius.circular(20.0)),
                    child: Stack(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(20.0)),
                            child: Container(
                              color: const Color.fromARGB(255, 254, 241, 202),
                            ),
                          ),
                        ),
                        Row(
                          children: [
                            Container(
                              margin: const EdgeInsets.only(left: 10),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  const Spacer(),
                                  const Text(
                                    'For Intermediate',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17),
                                  ),
                                  const Spacer(),
                                  Row(children: const [
                                    Icon(Icons.timer_outlined, size: 14),
                                    Text(' 4 week'),
                                  ]),
                                  const Spacer(),
                                  Row(children: const [
                                    Icon(
                                      Icons.fitness_center_outlined,
                                      size: 14,
                                    ),
                                    Text(' 26 Excercise'),
                                  ]),
                                  const Spacer(),
                                  Row(children: const [
                                    Text('Let`s Start ',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 13)),
                                    Icon(
                                      Icons.arrow_forward_ios_outlined,
                                      size: 14,
                                    ),
                                  ]),
                                  const Spacer(),
                                  const Spacer(),
                                ],
                              ),
                            ),
                            Expanded(
                              child: Transform.scale(
                                scale: 1.17,
                                // offset: const Offset(-3, 0),
                                child: Image.asset('assets/images/images.png',
                                    fit: BoxFit.cover, scale: 1),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          ListTile(
            title: const Text(
              'Workout Categories',
              style: TextStyle(color: Colors.black, fontSize: 17),
            ),
            trailing: const Text('see all'),
            onTap: () {
              Get.toNamed('/VallCatgpage');
            },
          ),
          SizedBox(
            height: 200,
            child: ListView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              children: [
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 150,
                        height: 140,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(const Opencatg(
                              catgname: 'Stretching',
                              id: 1,
                              title: 'Warmup',
                              image: 'assets/images/categoryimage1.png',
                              colorname: Color.fromARGB(255, 212, 246, 228),
                              tagname: 'categoryimage1',
                            ));
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 212, 246, 228),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset(
                                          'assets/images/category1.png')),
                                  Transform.scale(
                                    scaleY: 1.1,
                                    child: Transform.translate(
                                      offset: const Offset(0, -6),
                                      child: Hero(
                                        tag: 'categoryimage1',
                                        child: Image.asset(
                                          'assets/images/categoryimage1.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Warmup',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 150,
                        height: 140,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                                const Opencatg(
                                  catgname: 'Abs',
                                  id: 2,
                                  title: 'ABS Workout',
                                  image: 'assets/images/categoryimage2.png',
                                  colorname: Color.fromARGB(255, 232, 229, 254),
                                  tagname: 'categoryimage2',
                                ),
                                transition: Transition.noTransition);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 232, 229, 254),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset(
                                          'assets/images/category2.png')),
                                  Transform.scale(
                                    scaleY: 1.1,
                                    child: Transform.translate(
                                      offset: const Offset(0, -6),
                                      child: Hero(
                                        tag: 'categoryimage2',
                                        child: Image.asset(
                                          'assets/images/categoryimage2.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'ABS Workout',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 150,
                        height: 140,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                                const Opencatg(
                                  catgname: 'Arms',
                                  id: 3,
                                  title: 'Arms & Shoulder',
                                  image: 'assets/images/categoryimage3.png',
                                  colorname: Color.fromARGB(255, 199, 221, 246),
                                  tagname: 'categoryimage3',
                                ),
                                transition: Transition.noTransition);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 199, 221, 246),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset(
                                          'assets/images/category3.png')),
                                  Transform.scale(
                                    scaleY: 1.1,
                                    child: Transform.translate(
                                      offset: const Offset(0, -6),
                                      child: Hero(
                                        tag: 'categoryimage3',
                                        child: Image.asset(
                                          'assets/images/categoryimage3.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Arms & Shoulder',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 150,
                        height: 140,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                                const Opencatg(
                                  catgname: 'Butt',
                                  id: 4,
                                  title: 'Butt Workout',
                                  image: 'assets/images/categoryimage4.png',
                                  colorname: Color.fromARGB(255, 243, 209, 246),
                                  tagname: 'categoryimage4',
                                ),
                                transition: Transition.noTransition);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 243, 209, 246),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset(
                                          'assets/images/category4.png')),
                                  Transform.scale(
                                    scaleY: 1.1,
                                    child: Transform.translate(
                                      offset: const Offset(0, -6),
                                      child: Builder(builder: (context) {
                                        return Hero(
                                          tag: 'categoryimage4',
                                          child: Image.asset(
                                            'assets/images/categoryimage4.png',
                                            fit: BoxFit.cover,
                                          ),
                                        );
                                      }),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Butt Workout',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 150,
                        height: 140,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                                const Opencatg(
                                  catgname: 'Thigh',
                                  id: 5,
                                  title: 'Leg Workout',
                                  image: 'assets/images/categoryimage5.png',
                                  colorname: Color.fromARGB(255, 213, 243, 255),
                                  tagname: 'categoryimage5',
                                ),
                                transition: Transition.noTransition);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 213, 243, 255),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset(
                                          'assets/images/category5.png')),
                                  Transform.translate(
                                    offset: const Offset(0, -6),
                                    child: Hero(
                                      tag: 'categoryimage5',
                                      child: Image.asset(
                                        'assets/images/categoryimage5.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Thigh',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 150,
                        height: 140,
                        child: GestureDetector(
                          onTap: () {
                            Get.to(
                                const Opencatg(
                                  catgname: 'Stretching',
                                  id: 6,
                                  title: 'Chest Back',
                                  image: 'assets/images/categoryimage6.png',
                                  colorname: Color.fromARGB(255, 255, 235, 219),
                                  tagname: 'categoryimage6',
                                ),
                                transition: Transition.noTransition);
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(25),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 20.0),
                              child: Stack(
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                        color: const Color.fromARGB(
                                            255, 255, 235, 219),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                  ),
                                  Align(
                                      alignment: Alignment.bottomRight,
                                      child: Image.asset(
                                          'assets/images/category6.png')),
                                  Transform.scale(
                                    scaleY: 1.1,
                                    child: Transform.translate(
                                      offset: const Offset(0, -6),
                                      child: Hero(
                                        tag: 'categoryimage6',
                                        child: Image.asset(
                                          'assets/images/categoryimage6.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Text(
                      'Stretching',
                      style: TextStyle(
                          color: Colors.black, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Text('My Plan',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 14)),
          ),
          SizedBox(
            height: 200,
            child: ListView(
              controller: ScrollController(),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.horizontal,
              children: [
                GestureDetector(
                  onTap: () {
                    Get.to(const Vplanslistpage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(17.0)),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(17.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        254, 254, 242, 208),
                                    borderRadius: BorderRadius.circular(17)),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Spacer(),
                                          const Text(
                                            'Custom Workout',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          const Spacer(),
                                          const Text(
                                              'Add custom plan by tapping',
                                              style: TextStyle(fontSize: 11)),
                                          const Text('to create a new plan',
                                              style: TextStyle(fontSize: 11)),
                                          const Spacer(),
                                          Row(children: const [
                                            Text('Let`s Strat ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 14,
                                            ),
                                          ]),
                                          const Spacer(),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(10, -4),
                                      child: Transform.scale(
                                        scale: 1.1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 30.0),
                                          child: Image.asset(
                                            'assets/images/plan.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(const Vplanslistpage());
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: ClipRRect(
                      borderRadius:
                          const BorderRadius.all(Radius.circular(17.0)),
                      child: Stack(
                        children: [
                          ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(17.0)),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 13.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        254, 254, 242, 208),
                                    borderRadius: BorderRadius.circular(17)),
                                child: Row(
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.only(left: 10),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          const SizedBox(
                                            height: 10,
                                          ),
                                          const Spacer(),
                                          const Text(
                                            'Custom Workout',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 17),
                                          ),
                                          const Spacer(),
                                          const Text(
                                              'Add custom plan by tapping',
                                              style: TextStyle(fontSize: 11)),
                                          const Text('to create a new plan',
                                              style: TextStyle(fontSize: 11)),
                                          const Spacer(),
                                          Row(children: const [
                                            Text('Let`s Strat ',
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 13)),
                                            Icon(
                                              Icons.arrow_forward_ios_outlined,
                                              size: 14,
                                            ),
                                          ]),
                                          const Spacer(),
                                          const Spacer(),
                                        ],
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: const Offset(25, -4),
                                      child: Transform.scale(
                                        scale: 1.1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              right: 50.0),
                                          child: Image.asset(
                                            'assets/images/plan.png',
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

///////////
class _DomePainter extends CustomPainter {
  final Color color;
  _DomePainter({
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint();
    paint.color = color;
    Path path = Path();
    path.moveTo(20, 0); // Move to (20,0) to start drawing the path
    path.lineTo(20, size.height); // Draw a line from (20,0) to (20,size.height)
    path.cubicTo(
      20,
      size.height,
      size.width - 20,
      size.height,
      size.width - 20,
      size.height,
    );
    path.cubicTo(
      size.width * 0.94,
      size.height,
      size.width * 0.83,
      size.height * 0.65,
      size.width * 0.72,
      size.height * 0.31,
    );
    path.cubicTo(
      size.width * 0.67,
      size.height * 0.12,
      size.width * 0.59,
      size.height * 0.01,
      size.width * 0.51,
      0,
    );
    path.cubicTo(
      size.width * 0.51,
      0,
      size.width * 0.51,
      0,
      size.width * 0.51,
      0,
    );
    path.cubicTo(
      size.width * 0.42,
      -0.01,
      size.width * 0.34,
      size.height * 0.11,
      size.width * 0.27,
      size.height * 0.31,
    );
    path.cubicTo(
      size.width * 0.17,
      size.height * 0.65,
      size.width * 0.06,
      size.height,
      20,
      size.height,
    );
    path.lineTo(20, 0); // Draw a line from (20,size.height) to (20,0)
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}

//////////
