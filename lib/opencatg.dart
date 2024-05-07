// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';
import 'dart:math';
import 'package:confetti/confetti.dart';
import 'package:circular_seek_bar/circular_seek_bar.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';
import 'modellist.dart';
import 'setting.dart';
import 'vgifvideobyindex.dart';

class Opencatg extends StatefulWidget {
  final String catgname;
  final int id;
  final String title;
  final String image;

  final Color colorname;
  final String tagname;
  const Opencatg({
    Key? key,
    required this.catgname,
    required this.id,
    required this.title,
    required this.image,
    required this.colorname,
    required this.tagname,
  }) : super(key: key);

  @override
  State<Opencatg> createState() => _OpencatgState();
}

class _OpencatgState extends State<Opencatg> {
  final prfilebox = Hive.box<dynamic>('profile');

  int selectedButtonIndex1 = 0;
  int selectedButtonIndex2 = 1;
  int selectedButtonIndex3 = 2;
  int selectedButtonIndex4 = 3;

//// // for get categories list data only
  Future<List<Exercise>> _loadExercises() async {
    // simulate loading the exercises from a database or API
    // await Future.delayed(const Duration(seconds: 0)); // wait for 1 second
    ExerciseCategory cardioCategory =
        categories.firstWhere((category) => category.name == widget.catgname);
    return cardioCategory.exercises;
  }

  ExerciseCategory? vdurationcal;

  @override
  void initState() {
    super.initState();
    vdurationcal =
        categories.firstWhere((category) => category.name == widget.catgname);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: widget.colorname,
          statusBarIconBrightness: Brightness.dark,
        ),
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        backgroundColor: widget.colorname,
        elevation: 0,
      ),
      extendBodyBehindAppBar: false,
      bottomNavigationBar: Container(
        height: Get.size.height * 0.35 / 4,
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 0.0, left: 8, right: 8, bottom: 4),
          child: GestureDetector(
            onTap: () {
              Get.to(Startwkonebyone(catgname: widget.catgname, vindex2: 0));
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.deepOrange,
                    borderRadius: BorderRadius.circular(15)),
                child: const Center(
                  child: Padding(
                    padding: EdgeInsets.all(10.0),
                    child: Text('Start Workout',
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 22,
                            fontFamily: 'cbold')),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          children: [
            Container(
              decoration: BoxDecoration(
                  color: widget.colorname,
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(20),
                      bottomRight: Radius.circular(20))),
              height: Get.size.height * 1.2 / 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 0.0),
                child: Center(
                  child: Hero(
                    transitionOnUserGestures: true,
                    tag: widget.tagname,
                    child: Image.asset(
                      widget.image,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: Get.size.width * 1.5 / 4,
                    height: Get.size.height * 0.24 / 4,
                    decoration: BoxDecoration(
                        color: const Color.fromARGB(255, 211, 249, 244),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: Get.size.height * 0.16 / 4,
                            child: Image.asset('assets/images/clock1.png')),
                        Text(
                          vdurationcal!.duration.toString(),
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'clight'),
                        )
                      ],
                    ),
                  ),
                  Container(
                    width: Get.size.width * 1.5 / 4,
                    height: Get.size.height * 0.24 / 4,
                    decoration: BoxDecoration(
                        color: const Color.fromRGBO(250, 241, 219, 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        SizedBox(
                            height: Get.size.height * 0.16 / 4,
                            child: Image.asset('assets/images/calories.png')),
                        Text(
                          '${vdurationcal!.cal.toString()} Calories',
                          style: const TextStyle(
                              color: Colors.black,
                              fontSize: 13,
                              fontFamily: 'clight'),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
            ListTile(
              title: Text(
                widget.title,
                style: const TextStyle(
                    color: Colors.black,
                    fontFamily: 'cbold',
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
            ),
            SizedBox(
              height: Get.size.height * 0.7,
              child: FutureBuilder(
                future: _loadExercises(),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Exercise>> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No exercises found'));
                  } else {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      itemBuilder: (BuildContext context, int index) {
                        Exercise exercise = snapshot.data![index];

                        return GestureDetector(
                          behavior: HitTestBehavior.opaque,
                          excludeFromSemantics: true,
                          onTap: () {
                            Get.to(
                                Vgifvideo(
                                    catgname: widget.catgname, getindex: index),
                                transition: Transition.downToUp);
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(15.0),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(15),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ListTile(
                                  leading: Transform.scale(
                                    scale: 1.3,
                                    child: ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                          Radius.circular(7.0)),
                                      child: Container(
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(15)),
                                          height: Get.size.height * 0.4 / 4,
                                          width: Get.size.width * 0.4 / 4,
                                          child: Transform.scale(
                                              scale: 1.1,
                                              child: Image.asset(
                                                  exercise.thumbUrl))),
                                    ),
                                  ),
                                  title: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Text(exercise.title),
                                  ),
                                  subtitle: Padding(
                                    padding: const EdgeInsets.only(left: 15.0),
                                    child: Row(children: [
                                      const Icon(
                                        Icons.fitness_center_outlined,
                                        size: 14,
                                      ),
                                      Text(
                                          ' ${prfilebox.get('durationbox') ?? '14 '} Seconds'),
                                    ]),
                                  ),
                                  trailing: SizedBox(
                                      width: Get.size.width * 0.4 / 4,
                                      child: Image.asset(
                                          'assets/images/play.png')),
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CountdownController extends GetxController {
  final prfilebox = Hive.box<dynamic>('profile');

  Timer? _timer;
  final _countdownValue = 0.obs;
  final _isPaused = false.obs;

  int get countdownValue => _countdownValue.value;

  @override
  void onInit() {
    super.onInit();
    _countdownValue.value = prfilebox.get('durationbox') ?? 60;
  }

  void startTimer() {
    if (_timer != null) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      if (!_isPaused.value) {
        if (_countdownValue.value > 0) {
          _countdownValue.value--;
        } else {
          _timer!.cancel();
          onTimerEnd();
        }
      }
    });
  }

  void pauseTimer() {
    _isPaused.value = true;
  }

  void resumeTimer() {
    _isPaused.value = false;
  }

  void stopTimer() {
    if (_timer != null) {
      _timer!.cancel();
      _timer = null;
    }
    _countdownValue.value = prfilebox.get('durationbox') ?? 60;
  }

  void onTimerEnd() {
    // Define your actions here
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

class Startwkonebyone extends StatefulWidget {
  final String catgname;
  final int vindex2;
  const Startwkonebyone(
      {super.key, required this.catgname, required this.vindex2});
  @override
  State<Startwkonebyone> createState() => _StartwkonebyoneState();
}

class _StartwkonebyoneState extends State<Startwkonebyone> {
  final prfilebox = Hive.box<dynamic>('profile');

  Future<List<Exercise>> _loadExercises() async {
    await Future.delayed(const Duration(seconds: 0));
    ExerciseCategory cardioCategory =
        categories.firstWhere((category) => category.name == widget.catgname);
    return cardioCategory.exercises;
  }

  FlutterTts flutterTts = FlutterTts();
  void texttospeech(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.9);
    await flutterTts.setSpeechRate(prfilebox.get('ttsspeed') ?? 0.5);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  void ttsstop() async {
    await flutterTts.stop();
  }

  void ttspause() async {
    await flutterTts.pause();
  }

  bool play = true;
  int indexplus = 0;
  int totalexcersanplength = 0;
  dynamic appbartitlev = 'Workout';

  ///////// start of timer
  final CountdownController countdownControllercall =
      Get.put(CountdownController());
  CountdownController findsec = Get.find<CountdownController>();
  @override
  void initState() {
    super.initState();

    // checkremtimef();
    countdownControllercall.startTimer();
    prfilebox.get('soundonoff') ?? true ? calltsinitialf() : flutterTts.stop();
    setState(() {
      indexplus = widget.vindex2;
    });
  }

  //// // for get categories list data only
  Future<void> calltsinitialf() async {
    await Future.delayed(const Duration(seconds: 0));
    ExerciseCategory cardioCategory =
        categories.firstWhere((category) => category.name == widget.catgname);
    setState(() {
      appbartitlev = cardioCategory.exercises[indexplus].title;
    });
    String initialspeach =
        '${cardioCategory.exercises[indexplus].title} . for ${prfilebox.get('durationbox') ?? 25} Seconds. next to do. Is ${cardioCategory.exercises[indexplus].subtitle}';
    return texttospeech(initialspeach);
  }

  @override
  void dispose() {
    ttsstop();
    flutterTts.stop();
    countdownControllercall.stopTimer();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.back();
                flutterTts.stop();
              },
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            appbartitlev,
            style: const TextStyle(color: Colors.black),
          ),
          actions: [
            IconButton(
                onPressed: () {
                  soundsheet();
                },
                icon: const Icon(
                  Icons.volume_up_outlined,
                  color: Colors.black,
                )),
          ],
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        body: FutureBuilder(
            future: _loadExercises(),
            builder:
                (BuildContext context, AsyncSnapshot<List<Exercise>> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('No exercises found'));
              } else {
                totalexcersanplength = snapshot.data!.length - 1;

                return Column(
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    Image.asset(snapshot.data![indexplus].imageUrl.toString()),
                    const Spacer(),
                    Column(
                      children: [
                        Obx(() {
                          if (findsec._countdownValue.value == 0) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (indexplus == totalexcersanplength) {
                                Get.off(Trophypage(
                                    trophytotalexcer:
                                        snapshot.data!.length - 1));
                              } else {
                                Get.off(Skipwp(
                                    catgname3: widget.catgname,
                                    vindex3: indexplus + 1,
                                    excercisetittle: snapshot
                                        .data![indexplus].title
                                        .toString(),
                                    exceriseimage: snapshot
                                        .data![indexplus].thumbUrl
                                        .toString()));
                              }
                            });
                            return Container();
                          } else {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              countdownControllercall.startTimer();
                            });
                            return Text(
                              '${findsec._countdownValue}',
                              style: const TextStyle(
                                  color: Colors.black,
                                  fontFamily: 'cbold',
                                  fontSize: 55,
                                  fontWeight: FontWeight.bold),
                            );
                          }
                        }),
                        const Text(
                          'Seconds',
                          style: TextStyle(
                            color: Colors.black54,
                            fontFamily: 'clight',
                          ),
                        )
                      ],
                    ),
                    const Spacer(),
                    SizedBox(
                      width: double.infinity,
                      height: Get.size.height * 0.15 / 1,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Stack(
                          children: [
                            Center(
                              child: Container(
                                width: double.infinity,
                                height: Get.size.height * 0.15 / 1,
                                decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 239, 234),
                                    borderRadius: BorderRadius.circular(20)),
                                child: Padding(
                                    padding: const EdgeInsets.only(
                                        top: 30.0,
                                        left: 18,
                                        right: 18,
                                        bottom: 10),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        IconButton(
                                            onPressed: () {
                                              if (indexplus == 0) {
                                                null;
                                              } else {
                                                // _stopTimer();
                                                countdownControllercall
                                                    .stopTimer();
                                                ttsstop();
                                                setState(() {
                                                  countdownControllercall
                                                      .startTimer();
                                                  prfilebox.get('soundonoff') ??
                                                          true
                                                      ? texttospeech(
                                                          '${snapshot.data![indexplus - 1].title} . for ${prfilebox.get('durationbox') ?? 10} Seconds. next to do. ${snapshot.data![indexplus - 1].subtitle}')
                                                      : flutterTts.stop();

                                                  appbartitlev = snapshot
                                                      .data![indexplus - 1]
                                                      .title;
                                                  indexplus = indexplus - 1;
                                                });
                                                // checkremtimef();
                                              }
                                            },
                                            icon: Icon(Icons.arrow_back_ios,
                                                size: 25,
                                                color: indexplus == 0
                                                    ? Colors.grey
                                                    : Colors.black)),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.add,
                                              size: 1,
                                              color: Colors.transparent,
                                            )),
                                        IconButton(
                                            onPressed: () {},
                                            icon: const Icon(
                                              Icons.add,
                                              size: 1,
                                              color: Colors.transparent,
                                            )),
                                        IconButton(
                                            onPressed: () {
                                              // _stopTimer();
                                              if (indexplus ==
                                                  snapshot.data!.length - 1) {
                                                Get.off(Trophypage(
                                                    trophytotalexcer:
                                                        snapshot.data!.length -
                                                            1));
                                                countdownControllercall
                                                    .stopTimer();
                                                ttsstop();
                                              } else {
                                                countdownControllercall
                                                    .stopTimer();
                                                ttsstop();
                                                setState(() {
                                                  countdownControllercall
                                                      .startTimer();
                                                  prfilebox.get('soundonoff') ??
                                                          true
                                                      ? texttospeech(
                                                          '${snapshot.data![indexplus + 1].title} . for ${prfilebox.get('durationbox') ?? 10} Seconds. next to do. ${snapshot.data![indexplus + 1].subtitle}')
                                                      : flutterTts.stop();

                                                  appbartitlev = snapshot
                                                      .data![indexplus + 1]
                                                      .title;
                                                  indexplus = indexplus + 1;
                                                });
                                                // checkremtimef();
                                              }
                                            },
                                            icon: Icon(Icons.arrow_forward_ios,
                                                size: 25,
                                                color: indexplus ==
                                                        snapshot.data!.length -
                                                            1
                                                    ? Colors.grey
                                                    : Colors.black)),
                                      ],
                                    )),
                              ),
                            ),
                            Positioned(
                              left: Get.size.width * 0.27 / 1,
                              child: Transform.translate(
                                offset: const Offset(0, -30),
                                child: Transform.rotate(
                                  angle: 3.14,
                                  child: Center(
                                    child: CustomPaint(
                                      painter: _DomePainter(
                                          color: const Color.fromARGB(
                                              255, 250, 250, 250)),
                                      child: play
                                          ? Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  left: 50,
                                                  right: 50,
                                                  bottom: 2),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    prfilebox.get(
                                                                'soundonoff') ??
                                                            true
                                                        ? ttspause()
                                                        : flutterTts.stop();
                                                    play = !play;

                                                    countdownControllercall
                                                        .pauseTimer();
                                                  });
                                                },
                                                child: Container(
                                                  width:
                                                      Get.size.width * 0.6 / 4,
                                                  decoration: BoxDecoration(
                                                      color: Colors.deepOrange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60)),
                                                  child: Image.asset(
                                                      'assets/images/pause.png'),
                                                ),
                                              ),
                                            )
                                          : Padding(
                                              padding: const EdgeInsets.only(
                                                  top: 10.0,
                                                  left: 50,
                                                  right: 50,
                                                  bottom: 2),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    play = !play;
                                                    prfilebox.get(
                                                                'soundonoff') ??
                                                            true
                                                        ? texttospeech(
                                                            '${snapshot.data![indexplus].title} . for ${prfilebox.get('durationbox') ?? 10} Seconds. next to do. ${snapshot.data![indexplus].subtitle}')
                                                        : flutterTts.stop();

                                                    countdownControllercall
                                                        .resumeTimer();
                                                  });
                                                  // checkremtimef();
                                                },
                                                child: Container(
                                                  width:
                                                      Get.size.width * 0.6 / 4,
                                                  decoration: BoxDecoration(
                                                      color: Colors.deepOrange,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              60)),
                                                  child: Image.asset(
                                                      'assets/images/play.png'),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              }
            }));
  }
}

///////////
//////////////
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

///////////////////////////////////////////////////////
// start for Skip Page
class Skiptimecont extends GetxController {
  final prfilebox = Hive.box<dynamic>('profile');

  Timer? _timer;
  final _countdownValue = 10.obs;
  // final _isPaused = false.obs;

  int get countdownValue => _countdownValue.value;

  @override
  void onInit() {
    super.onInit();
    _countdownValue.value = prfilebox.get('restval') ?? 10;
  }

  void startTimer() {
    if (_timer != null) {
      return;
    }
    _timer = Timer.periodic(const Duration(seconds: 1), (_) {
      // if (!_isPaused.value) {
      if (_countdownValue.value > 0) {
        _countdownValue.value--;
      } else {
        _timer!.cancel();
      }
      // }
    });
  }

  void stopTimer() {
    _timer!.cancel();
    _timer = null;

    _countdownValue.value = prfilebox.get('restval') ?? 10;
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}

class Skipwp extends StatefulWidget {
  final String catgname3;
  final int vindex3;
  final String excercisetittle;
  final String exceriseimage;
  const Skipwp(
      {super.key,
      required this.catgname3,
      required this.vindex3,
      required this.excercisetittle,
      required this.exceriseimage});

  @override
  State<Skipwp> createState() => _SkipwpState();
}

class _SkipwpState extends State<Skipwp> {
  final Skiptimecont skiptimecontcall = Get.put(Skiptimecont());
  Skiptimecont skiptimecontfind = Get.find<Skiptimecont>();
  final prfilebox = Hive.box<dynamic>('profile');

  Future<List<Exercise>> _loadExercises() async {
    await Future.delayed(const Duration(seconds: 0));
    ExerciseCategory cardioCategory =
        categories.firstWhere((category) => category.name == widget.catgname3);
    return cardioCategory.exercises;
  }

  Timer? _timercall2;
  Future<void> chkskiptimef() async {
    int sec;

    if (prfilebox.get('restval') == null) {
      sec = 25;
    } else {
      sec = prfilebox.get('restval') ?? 25;
    }
    _timercall2 = Timer.periodic(Duration(seconds: sec), (timer) {
      skiptimecontcall.stopTimer();
      afterskipcallp();
    });
    // await Future.delayed(Duration(seconds: sec));
  }

  void storactivity() {
    final activityBox = Hive.box<dynamic>('actibox');

    // Get current date and time
    final now = DateTime.now();
    final formattedDate = DateFormat.yMd().format(now);
    final formatdatnow = DateFormat.yMd().add_jm().format(now);

    List<Map<String, dynamic>> newData2 = [
      {
        'excertitle': 'Punches',
        'excerimage': 'assets/wk/thumbs/54.gif',
        'date': formatdatnow,
        'durationstime': 20,
        'calburn': 10,
      },
      {
        'excertitle': 'Jumping Jacks',
        'excerimage': 'assets/wk/thumbs/33.gif',
        'date': formatdatnow,
        'durationstime': 15,
        'calburn': 5,
      }
    ];

    final existingData = activityBox.get('key') ?? newData2;

    ///// random
    int durationstime = Random().nextInt(20) + 1;
    int calburn = Random().nextInt(10) + 1;

    // Update the data with new button click
    final newData = {
      'excertitle': widget.excercisetittle,
      'excerimage': widget.exceriseimage,
      'date': formattedDate,
      'durationstime': durationstime,
      'calburn': calburn,
    };

    existingData.add(newData);

    // Store the updated data in the box
    activityBox.put('key', existingData);
  }

  @override
  void initState() {
    super.initState();
    skiptimecontcall.startTimer();
    storactivity();
    chkskiptimef();
  }

  void _stopTimer() {
    _timercall2?.cancel();
    _timercall2 = null;
    // _timercall2 = const Duration(seconds: 0) as Timer?;
  }

  @override
  void dispose() {
    super.dispose();
    // skiptimecontcall.stopTimer();
    _stopTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            )),
        title: const Text(
          'Rest',
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Stack(
              children: [
                Transform.rotate(
                  angle: 2,
                  child: Obx(
                    () => CircularSeekBar(
                      width: double.infinity,
                      height: 170,
                      progress: skiptimecontfind.countdownValue /
                          prfilebox.get('restval') *
                          100,
                      barWidth: 6,
                      startAngle: 45,
                      sweepAngle: 350,
                      strokeCap: StrokeCap.butt,
                      progressColor: Colors.deepOrange,
                      innerThumbRadius: 5,
                      innerThumbStrokeWidth: 3,
                      innerThumbColor: Colors.deepOrange,
                      outerThumbRadius: 5,
                      outerThumbStrokeWidth: 10,
                      outerThumbColor: Colors.deepOrange,
                      animation: false,
                    ),
                  ),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(40),
                      child: Transform.translate(
                        offset: const Offset(0, 15),
                        child: Obx(
                          () => Text(
                            '${skiptimecontfind.countdownValue}',
                            style: const TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 55),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 25),
          Center(
            child: Text(
              '${prfilebox.get('restval') ?? 25} Seconds',
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18),
            ),
          ),
          const SizedBox(height: 20),
          FutureBuilder(
              future: _loadExercises(),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Exercise>> snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                  return const Center(child: Text('No exercises found'));
                } else {
                  return InkWell(
                    onTap: afterskipcallp,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: LinearProgressIndicator(
                            value: widget.vindex3 / snapshot.data!.length,
                            color: Colors.deepOrange,
                            backgroundColor:
                                Colors.deepOrangeAccent.withOpacity(0.2),
                          ),
                        ),
                        const SizedBox(height: 40),
                        const ListTile(
                          title: Text(
                            'Coming Up',
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'cbold'),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              top: 0, left: 15.0, right: 15.0, bottom: 0),
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                leading: Transform.scale(
                                  scale: 1.3,
                                  child: ClipRRect(
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(7.0)),
                                    child: Container(
                                        decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        height: Get.size.height * 0.4 / 4,
                                        width: Get.size.width * 0.4 / 4,
                                        child: Transform.scale(
                                            scale: 2.1,
                                            child: Image.asset(snapshot
                                                .data![widget.vindex3].imageUrl
                                                .toString()))),
                                  ),
                                ),
                                title: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(snapshot
                                      .data![widget.vindex3].title
                                      .toString()),
                                ),
                                subtitle: Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Row(children: [
                                    const Icon(
                                      Icons.fitness_center_outlined,
                                      size: 14,
                                    ),
                                    Text(
                                        ' ${prfilebox.get('durationbox') ?? 20}'),
                                  ]),
                                ),
                                trailing: SizedBox(
                                    width: Get.size.width * 0.4 / 4,
                                    child:
                                        Image.asset('assets/images/play.png')),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                }
              }),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: OutlinedButton(
              onPressed: afterskipcallp,
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
                padding:
                    EdgeInsets.only(top: 12.0, left: 30, right: 30, bottom: 15),
                child: SizedBox(
                  width: double.infinity,
                  child: Center(
                    child: Text(
                      'Skip',
                      style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'csemibold',
                          color: Colors.black,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(
            height: 15,
          ),
        ],
      ),
    );
  }

  void afterskipcallp() {
    _stopTimer();
    Get.off(Startwkonebyone(
      catgname: widget.catgname3,
      vindex2: widget.vindex3,
    ));
  }
}

// end for Skip Page

class Trophypage extends StatefulWidget {
  final int trophytotalexcer;
  const Trophypage({super.key, required this.trophytotalexcer});

  @override
  State<Trophypage> createState() => _TrophypageState();
}

class _TrophypageState extends State<Trophypage> {
  var confetticont = ConfettiController();
  final prfilebox = Hive.box<dynamic>('profile');

  int vsec = 80;
  @override
  void initState() {
    super.initState();
    double vsec1 = widget.trophytotalexcer * prfilebox.get('durationbox') / 60;
    vsec = vsec1.toInt();
    confetticont.play();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.fitness_center_outlined),
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: Color.fromARGB(255, 255, 239, 234),
          statusBarIconBrightness: Brightness.dark,
        ),
        backgroundColor: const Color.fromARGB(255, 255, 239, 234),
        elevation: 0,
      ),
      body: Column(
        children: [
          ConfettiWidget(
            confettiController: confetticont,
            shouldLoop: true,
            numberOfParticles: 40,
            blastDirectionality: BlastDirectionality.explosive,
            child: Container(
              decoration: const BoxDecoration(
                  color: Color.fromARGB(255, 255, 239, 234),
                  borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(27),
                      bottomRight: Radius.circular(27))),
              height: Get.size.height * 1.5 / 4,
              child: Padding(
                padding: const EdgeInsets.only(top: 80.0),
                child: Center(
                  child: Image.asset('assets/images/trophy.png'),
                ),
              ),
            ),
          ),
          const Spacer(),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Center(
                child:
                    Text('Congratulation you have Compeleted Workout Series')),
          ),
          const Spacer(),
          Stack(
            children: [
              Center(child: Image.asset('assets/images/textbg.png')),
              Align(
                alignment: Alignment.center,
                child: Transform.translate(
                  offset: const Offset(0, 15),
                  child: const Center(
                      child: Text(
                    'Six Pack',
                    style: TextStyle(
                        color: Colors.deepOrange,
                        fontWeight: FontWeight.bold,
                        fontSize: 25,
                        fontFamily: 'cbold'),
                  )),
                ),
              ),
            ],
          ),
          const Spacer(),
          Padding(
            padding: const EdgeInsets.all(14.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 203, 231, 254),
                      borderRadius: BorderRadius.circular(20)),
                  width: Get.size.width * 0.26 / 1,
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: Get.size.width * 0.10 / 1,
                            child: Image.asset('assets/images/dumbell_1.png')),
                        const SizedBox(height: 4),
                        Text(
                          '${widget.trophytotalexcer} Excercise',
                          style: const TextStyle(
                              fontFamily: 'clight',
                              color: Colors.black,
                              fontSize: 11),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 211, 249, 244),
                      borderRadius: BorderRadius.circular(20)),
                  width: Get.size.width * 0.26 / 1,
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: Get.size.width * 0.10 / 1,
                            child: Image.asset('assets/images/clock1.png')),
                        const SizedBox(height: 4),
                        Text(
                          '00:$vsec:${Random().nextInt(50)}',
                          style: const TextStyle(
                              fontFamily: 'clight',
                              color: Colors.black,
                              fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 253, 244, 218),
                      borderRadius: BorderRadius.circular(20)),
                  width: Get.size.width * 0.26 / 1,
                  child: Padding(
                    padding: const EdgeInsets.all(11.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                            width: Get.size.width * 0.07 / 1,
                            child: Image.asset('assets/images/calories.png')),
                        const SizedBox(height: 4),
                        Text(
                          '${Random().nextInt(100)}',
                          style: const TextStyle(
                              fontFamily: 'clight',
                              color: Colors.black,
                              fontSize: 14),
                        ),
                        const SizedBox(height: 4),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              Get.offAndToNamed('/');
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
                    child: Text('Continue',
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

/////////  end congratulation page
