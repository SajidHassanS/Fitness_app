import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'modellist.dart';

class Durationscountclas extends GetxController {
  final prfilebox = Hive.box<dynamic>('profile');

  final _count = 0.obs;

  int get count => _count.value;

  @override
  void onInit() {
    super.onInit();
    _count.value = prfilebox.get('durationbox') ?? 20;
  }

  void increment() {
    if (_count.value >= 60) {
      _count.value = 60;
    } else {
      _count.value += 5;
      prfilebox.put('durationbox', _count.value);
    }
  }

  void decrement() {
    if (_count.value > 10) {
      _count.value -= 5;
      prfilebox.put('durationbox', _count.value);
    } else {
      _count.value = 10;
    }
  }
}

class Vgifvideo extends StatefulWidget {
  final String catgname;
  final int getindex;
  const Vgifvideo({required this.catgname, super.key, required this.getindex});

  @override
  State<Vgifvideo> createState() => _VgifvideoState();
}

class _VgifvideoState extends State<Vgifvideo> {
  final Durationscountclas callDurationnos = Get.put(Durationscountclas());
  Durationscountclas findDurationnos = Get.find<Durationscountclas>();

  final prfilebox = Hive.box<dynamic>('profile');

  Future<List<Exercise>> _loadExercises() async {
    await Future.delayed(const Duration(seconds: 0));
    ExerciseCategory cardioCategory =
        categories.firstWhere((category) => category.name == widget.catgname);
    return cardioCategory.exercises;
  }

  FlutterTts flutterTts = FlutterTts();
  void callttswhenvideoloaded(String text) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setVolume(0.9);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setPitch(1);
    await flutterTts.speak(text);
  }

  int indexplus = 0;
  /////// yt videos
  // final videourl = '';
  late YoutubePlayerController _controller;
  /////// yt videos
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 0));
    indexplus = widget.getindex;
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.black45,
            statusBarIconBrightness: Brightness.dark,
          ),
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Icon(
                Icons.arrow_back_ios,
                color: Colors.black45,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  Get.back();
                },
                icon: const Icon(
                  Icons.minimize_outlined,
                  color: Colors.transparent,
                ))
          ],
          backgroundColor: Colors.black45,
          elevation: 0,
        ),
        body: Stack(
          children: [
            Container(
              color: Colors.black45,
              width: Get.size.width,
              height: Get.size.height,
              child: null,
            ),
            Container(
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              height: MediaQuery.of(context).size.height * 0.92,
              width: MediaQuery.of(context).size.width * 1,
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
                      return Column(
                        children: [
                          const SizedBox(
                            height: 12,
                          ),
                          Flexible(
                            child: DefaultTabController(
                              length: 2,
                              initialIndex: 0,
                              animationDuration:
                                  const Duration(milliseconds: 1000),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const TabBar(
                                      unselectedLabelColor: Colors.black,
                                      labelColor: Colors.black,
                                      indicatorSize: TabBarIndicatorSize.label,
                                      tabs: [
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Tab(
                                            text: 'Animation',
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 8.0),
                                          child: Tab(
                                            text: 'Video',
                                          ),
                                        ),
                                      ]),
                                  SizedBox(
                                    height: Get.size.height * 1.2 / 4,
                                    child: TabBarView(
                                      children: [
                                        FutureBuilder(
                                            future: _loadExercises(),
                                            builder: (BuildContext context,
                                                AsyncSnapshot<List<Exercise>>
                                                    snapshot) {
                                              if (snapshot.connectionState ==
                                                  ConnectionState.waiting) {
                                                Future.delayed(
                                                    const Duration(seconds: 1));
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (snapshot.hasError) {
                                                return const Center(
                                                    child:
                                                        CircularProgressIndicator());
                                              } else if (!snapshot.hasData ||
                                                  snapshot.data!.isEmpty) {
                                                return const Center(
                                                    child: Text(
                                                        'No exercises found'));
                                              } else {
                                                return Image.asset(
                                                  snapshot.data![indexplus]
                                                      .imageUrl,
                                                  fit: BoxFit.cover,
                                                );
                                              }
                                            }),
                                        Center(
                                          child: YoutubePlayer(
                                            controller: _controller =
                                                YoutubePlayerController(
                                              initialVideoId:
                                                  YoutubePlayer.convertUrlToId(
                                                          snapshot
                                                              .data![indexplus]
                                                              .videoUrl
                                                              .toString())
                                                      .toString(),
                                              flags: const YoutubePlayerFlags(
                                                autoPlay: false,
                                                mute: false,
                                                hideThumbnail: true,
                                                showLiveFullscreenButton: false,
                                              ),
                                            ),
                                            showVideoProgressIndicator: true,
                                            onReady: () {
                                              callttswhenvideoloaded(
                                                  'Video is Loaded');

                                              Get.snackbar(
                                                  icon: const Icon(
                                                    Icons
                                                        .slow_motion_video_rounded,
                                                    color: Colors.deepOrange,
                                                    shadows: [
                                                      BoxShadow(
                                                          color: Colors.black,
                                                          offset: Offset(1, 1),
                                                          blurRadius: 2)
                                                    ],
                                                  ),
                                                  shouldIconPulse: true,
                                                  snackPosition:
                                                      SnackPosition.TOP,
                                                  snapshot
                                                      .data![indexplus].title
                                                      .toString(),
                                                  'Video Is Loaded Can Veiw');
                                            },
                                            bottomActions: [
                                              FullScreenButton(
                                                color: Colors.transparent,
                                              ),
                                              ProgressBar(
                                                isExpanded: true,
                                                colors: const ProgressBarColors(
                                                    playedColor:
                                                        Colors.deepOrange,
                                                    handleColor:
                                                        Colors.orangeAccent),
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  ListTile(
                                    title: Text(
                                      snapshot.data![indexplus].title,
                                      style: const TextStyle(
                                          color: Colors.black87,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  ListTile(
                                      title: const Text(
                                        'Duration',
                                        style: TextStyle(
                                            fontWeight: FontWeight.normal,
                                            fontFamily: 'cbold'),
                                      ),
                                      trailing: SizedBox(
                                        width:
                                            MediaQuery.of(context).size.width *
                                                1.5 /
                                                4,
                                        child: Center(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4 /
                                                      4,
                                                  height: 25,
                                                  child: OutlinedButton(
                                                      onPressed: callDurationnos
                                                          .decrement,
                                                      style: ButtonStyle(
                                                        shape: MaterialStateProperty
                                                            .resolveWith<
                                                                OutlinedBorder>(
                                                          (states) {
                                                            return RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7.0),
                                                            );
                                                          },
                                                        ),
                                                        side:
                                                            MaterialStateProperty
                                                                .resolveWith<
                                                                    BorderSide>(
                                                          (states) {
                                                            if (states.contains(
                                                                MaterialState
                                                                    .pressed)) {
                                                              return const BorderSide(
                                                                  color: Colors
                                                                      .deepOrange);
                                                            }
                                                            return BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2));
                                                          },
                                                        ),
                                                      ),
                                                      child:
                                                          Transform.translate(
                                                        offset: const Offset(
                                                            -10, -8),
                                                        child: const Icon(Icons
                                                            .minimize_outlined),
                                                      ))),
                                              Obx(() => Text(
                                                    '${findDurationnos.count}',
                                                    style: const TextStyle(
                                                        fontFamily: 'cbold',
                                                        fontWeight:
                                                            FontWeight.bold,
                                                        fontSize: 17),
                                                  )),
                                              SizedBox(
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.4 /
                                                      4,
                                                  height: 25,
                                                  child: OutlinedButton(
                                                      onPressed: callDurationnos
                                                          .increment,
                                                      style: ButtonStyle(
                                                        shape: MaterialStateProperty
                                                            .resolveWith<
                                                                OutlinedBorder>(
                                                          (states) {
                                                            return RoundedRectangleBorder(
                                                              borderRadius:
                                                                  BorderRadius
                                                                      .circular(
                                                                          7.0),
                                                            );
                                                          },
                                                        ),
                                                        side:
                                                            MaterialStateProperty
                                                                .resolveWith<
                                                                    BorderSide>(
                                                          (states) {
                                                            if (states.contains(
                                                                MaterialState
                                                                    .pressed)) {
                                                              return const BorderSide(
                                                                  color: Colors
                                                                      .deepOrange);
                                                            }
                                                            return BorderSide(
                                                                color: Colors
                                                                    .grey
                                                                    .withOpacity(
                                                                        0.2));
                                                          },
                                                        ),
                                                      ),
                                                      child:
                                                          Transform.translate(
                                                        offset: const Offset(
                                                            -10, 0),
                                                        child: const Icon(
                                                            Icons.add),
                                                      ))),
                                            ],
                                          ),
                                        ),
                                      )),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: SingleChildScrollView(
                                      controller: ScrollController(),
                                      child: Text(
                                        snapshot.data![indexplus].subtitle,
                                        style: const TextStyle(
                                            color: Colors.black54),
                                      ),
                                    ),
                                  ),
                                  const Spacer(),
                                  ListTile(
                                    title: SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.4 /
                                          1,
                                      child: Center(
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4 /
                                                    4,
                                                height: 25,
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      if (indexplus <= 0) {
                                                      } else {
                                                        setState(() {
                                                          indexplus =
                                                              indexplus - 1;
                                                          // Durationnos
                                                          //     .mindurrationval();
                                                        });
                                                      }
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (states) {
                                                          return Colors
                                                              .deepOrangeAccent
                                                              .withOpacity(0.2);
                                                        },
                                                      ),
                                                      shape: MaterialStateProperty
                                                          .resolveWith<
                                                              OutlinedBorder>(
                                                        (states) {
                                                          return RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.0),
                                                          );
                                                        },
                                                      ),
                                                      side:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  BorderSide>(
                                                        (states) {
                                                          if (states.contains(
                                                              MaterialState
                                                                  .pressed)) {
                                                            return const BorderSide(
                                                                color: Colors
                                                                    .deepOrange);
                                                          }
                                                          return BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3));
                                                        },
                                                      ),
                                                    ),
                                                    child: Transform.translate(
                                                      offset:
                                                          const Offset(-10, 0),
                                                      child: const Icon(
                                                          Icons.arrow_back),
                                                    ))),
                                            Text(
                                              ' ${indexplus + 1} / ${snapshot.data!.length.toString()} ',
                                              style: const TextStyle(
                                                  fontFamily: 'cbold',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 17),
                                            ),
                                            SizedBox(
                                                width: MediaQuery.of(context)
                                                        .size
                                                        .width *
                                                    0.4 /
                                                    4,
                                                height: 25,
                                                child: OutlinedButton(
                                                    onPressed: () {
                                                      setState(() {
                                                        indexplus ==
                                                                snapshot.data!
                                                                        .length -
                                                                    1
                                                            ? null
                                                            : indexplus =
                                                                indexplus + 1;
                                                      });
                                                    },
                                                    style: ButtonStyle(
                                                      backgroundColor:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  Color>(
                                                        (states) {
                                                          return Colors
                                                              .deepOrangeAccent
                                                              .withOpacity(0.2);
                                                        },
                                                      ),
                                                      shape: MaterialStateProperty
                                                          .resolveWith<
                                                              OutlinedBorder>(
                                                        (states) {
                                                          return RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        7.0),
                                                          );
                                                        },
                                                      ),
                                                      side:
                                                          MaterialStateProperty
                                                              .resolveWith<
                                                                  BorderSide>(
                                                        (states) {
                                                          if (states.contains(
                                                              MaterialState
                                                                  .pressed)) {
                                                            return const BorderSide(
                                                                color: Colors
                                                                    .deepOrange);
                                                          }
                                                          return BorderSide(
                                                              color: Colors.grey
                                                                  .withOpacity(
                                                                      0.3));
                                                        },
                                                      ),
                                                    ),
                                                    child: Transform.translate(
                                                      offset:
                                                          const Offset(-10, 0),
                                                      child: const Icon(
                                                          Icons.arrow_forward),
                                                    ))),
                                          ],
                                        ),
                                      ),
                                    ),
                                    trailing: SizedBox(
                                        width: Get.size.width * 0.4 / 1,
                                        child: ElevatedButton(
                                            onPressed: () {
                                              Get.back();
                                            },
                                            style: ButtonStyle(
                                              shape: MaterialStateProperty
                                                  .resolveWith<OutlinedBorder>(
                                                (states) {
                                                  return RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20.0),
                                                  );
                                                },
                                              ),
                                            ),
                                            child: SizedBox(
                                                width: Get.size.width * 0.3 / 1,
                                                height:
                                                    Get.size.height * 0.05 / 1,
                                                child: const Center(
                                                    child: Text('Close'))))),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }
                  }), // add your content here
            ),
          ],
        ));
  }
}
