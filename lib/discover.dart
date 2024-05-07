import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:workout/opencatg.dart';

class Discoverpage extends StatefulWidget {
  const Discoverpage({super.key});

  @override
  State<Discoverpage> createState() => _DiscoverpageState();
}

class _DiscoverpageState extends State<Discoverpage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        controller: ScrollController(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 260,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Abs',
                        id: 1,
                        title: 'Spring',
                        image: 'assets/images/discovershape1.png',
                        colorname: Color.fromARGB(255, 255, 231, 250),
                        tagname: 'discovershape1',
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 240,
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 255, 231, 250),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                Transform.scale(
                                  scaleY: 1.1,
                                  child: Transform.translate(
                                    offset: const Offset(0, -8),
                                    child: Hero(
                                      tag: 'discovershape1',
                                      child: Image.asset(
                                        'assets/images/discover1.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    height: 140,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color.fromARGB(0, 0, 0, 0),
                                            Color.fromARGB(94, 0, 0, 0)
                                          ]),
                                    ),
                                    child: Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 70),
                                        child: const Text('SPRING',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'cbold',
                                                fontSize: 25,
                                                fontWeight: FontWeight.bold)),
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
                  GestureDetector(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Stretching',
                        id: 2,
                        title: 'Summar',
                        image: 'assets/images/discovershape2.png',
                        colorname: Color.fromARGB(255, 211, 255, 247),
                        tagname: 'discovershape2',
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 240,
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Stack(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                    color: const Color.fromARGB(
                                        255, 211, 255, 247),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                ),
                                // Align(
                                //     alignment: Alignment.bottomRight,
                                //     child: Image.asset('assets/images/category1.png')),
                                Transform.scale(
                                  scaleY: 1.1,
                                  child: Transform.translate(
                                    offset: const Offset(0, -8),
                                    child: Hero(
                                      tag: 'discovershape2',
                                      child: Image.asset(
                                        'assets/images/discover2.png',
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),

                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    width: double.infinity,
                                    height: 140,
                                    decoration: const BoxDecoration(
                                      gradient: LinearGradient(
                                          begin: Alignment.topCenter,
                                          end: Alignment.bottomCenter,
                                          colors: [
                                            Color.fromARGB(0, 0, 0, 0),
                                            Color.fromARGB(94, 0, 0, 0)
                                          ]),
                                    ),
                                    child: Center(
                                      child: Container(
                                        margin: const EdgeInsets.only(top: 70),
                                        child: const Text('SUMMER',
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontFamily: 'cbold',
                                                fontSize: 25)),
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
                  GestureDetector(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Arms',
                        id: 3,
                        title: 'Winter',
                        image: 'assets/images/discovershape3.png',
                        colorname: Color.fromARGB(255, 255, 231, 250),
                        tagname: 'discovershape3',
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: SizedBox(
                        width: 240,
                        height: 250,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(25),
                          child: Padding(
                            padding: const EdgeInsets.only(top: 30.0),
                            child: Stack(
                              children: [
                                Transform.scale(
                                  scaleY: 1.15,
                                  child: Transform.translate(
                                    offset: const Offset(0, -8),
                                    child: Hero(
                                      tag: 'discovershape3',
                                      child: Image.asset(
                                        'assets/images/discover3.png',
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
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Workout For You',
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'cbold',
                      fontSize: 18)),
            ),
            SizedBox(
              height: 200,
              child: ListView(
                scrollDirection: Axis.horizontal,
                physics: const BouncingScrollPhysics(),
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Arms',
                        id: 1,
                        title: 'Classic',
                        image: 'assets/images/workoutyou1.png',
                        colorname: Color.fromARGB(255, 223, 230, 254),
                        tagname: 'workoutyou1',
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        width: MediaQuery.of(context).size.width * 0.8 / 1,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 223, 230, 254),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 30, right: 30, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Hero(
                                  tag: 'workoutyou1',
                                  child:
                                      Image.asset('assets/images/yoga1.png')),
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
                                      'Classic 7 min',
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
                                      Text(' 22 Excercise'),
                                    ]),
                                    const Spacer(),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Abs',
                        id: 2,
                        title: 'Abs Of Steel',
                        image: 'assets/images/workoutyou2.png',
                        colorname: Color.fromARGB(255, 247, 214, 201),
                        tagname: 'workoutyou2',
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 170,
                        width: MediaQuery.of(context).size.width * 0.8 / 1,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(255, 247, 214, 201),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 30, right: 30, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Hero(
                                  tag: 'workoutyou2',
                                  child:
                                      Image.asset('assets/images/yoga2.png')),
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
                                      'Abs Of Steel',
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
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Butt',
                        id: 3,
                        title: 'Body Cardio',
                        image: 'assets/images/workoutyou3.png',
                        colorname: Color.fromARGB(254, 254, 239, 212),
                        tagname: 'workoutyou3',
                      ));
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 170,
                        width: MediaQuery.of(context).size.width * 0.8 / 1,
                        decoration: BoxDecoration(
                            color: const Color.fromARGB(254, 254, 239, 212),
                            borderRadius: BorderRadius.circular(20)),
                        child: Padding(
                          padding: const EdgeInsets.only(
                              top: 20.0, left: 30, right: 30, bottom: 20),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Hero(
                                  tag: 'workoutyou3',
                                  child:
                                      Image.asset('assets/images/yoga3.png')),
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
                                    const Expanded(
                                      child: Text(
                                        'Full body Cardio',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16),
                                      ),
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
                                      Text(' 24 Excercise'),
                                    ]),
                                    const Spacer(),
                                    const Spacer(),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Stretches',
                  style: TextStyle(
                      color: Colors.black,
                      fontFamily: 'csemibold',
                      fontSize: 18,
                      fontWeight: FontWeight.w500)),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 255, 239, 239),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  child: ListTile(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Abs',
                        id: 1,
                        title: 'Body Streching',
                        image: 'assets/images/stretch1.png',
                        colorname: Color.fromARGB(255, 255, 239, 239),
                        tagname: 'stretch1',
                      ));
                    },
                    title: const Text('Full body stretching',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'cbold',
                            fontWeight: FontWeight.bold)),
                    trailing: Hero(
                        tag: 'stretch1',
                        child: Image.asset('assets/images/stretch1.png')),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(254, 251, 239, 254),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  child: ListTile(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Arms',
                        id: 2,
                        title: 'Shoulder',
                        image: 'assets/images/stretch2.png',
                        colorname: Color.fromARGB(254, 251, 239, 254),
                        tagname: 'stretch2',
                      ));
                    },
                    title: const Text('Shoulder & neck tension releif',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'cbold',
                            fontWeight: FontWeight.bold)),
                    trailing: Hero(
                        tag: 'stretch2',
                        child: Image.asset('assets/images/stretch2.png')),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(253, 255, 239, 226),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  child: ListTile(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Stretching',
                        id: 3,
                        title: 'Morning stretches',
                        image: 'assets/images/stretch3.png',
                        colorname: Color.fromARGB(253, 255, 239, 226),
                        tagname: 'stretch3',
                      ));
                    },
                    title: const Text('Morning stretches',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'cbold',
                            fontWeight: FontWeight.bold)),
                    trailing: Hero(
                        tag: 'stretch3',
                        child: Image.asset('assets/images/stretch3.png')),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(253, 231, 244, 255),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  child: ListTile(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Arms',
                        id: 4,
                        title: 'Lower back pain',
                        image: 'assets/images/stretch4.png',
                        colorname: Color.fromARGB(253, 231, 244, 255),
                        tagname: 'stretch4',
                      ));
                    },
                    title: const Text('Lower back pain releif',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'cbold',
                            fontWeight: FontWeight.bold)),
                    trailing: Hero(
                        tag: 'stretch4',
                        child: Image.asset('assets/images/stretch4.png')),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 236, 240, 254),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  child: ListTile(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Thigh',
                        id: 5,
                        title: 'Bed Time stretches',
                        image: 'assets/images/stretch5.png',
                        colorname: Color.fromARGB(255, 236, 240, 254),
                        tagname: 'stretch5',
                      ));
                    },
                    title: const Text('Bed time stretches',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'cbold',
                            fontWeight: FontWeight.bold)),
                    trailing: Hero(
                        tag: 'stretch5',
                        child: Image.asset('assets/images/stretch5.png')),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 233, 255, 250),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  child: ListTile(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Arms',
                        id: 6,
                        title: 'Upper Body stretches',
                        image: 'assets/images/stretch6.png',
                        colorname: Color.fromARGB(255, 233, 255, 250),
                        tagname: 'stretch6',
                      ));
                    },
                    title: const Text('Upper body stretches',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'cbold',
                            fontWeight: FontWeight.bold)),
                    trailing: Hero(
                        tag: 'stretch6',
                        child: Image.asset('assets/images/stretch6.png')),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 224, 241, 254),
                    borderRadius: BorderRadius.circular(15)),
                child: Padding(
                  padding: const EdgeInsets.only(
                      top: 15, left: 10, right: 10, bottom: 15),
                  child: ListTile(
                    onTap: () {
                      Get.to(const Opencatg(
                        catgname: 'Butt',
                        id: 7,
                        title: 'Lower Body stretches',
                        image: 'assets/images/stretch7.png',
                        colorname: Color.fromARGB(255, 224, 241, 254),
                        tagname: 'stretch7',
                      ));
                    },
                    title: const Text('Lower body stretches',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: 'cbold',
                            fontWeight: FontWeight.bold)),
                    trailing: Hero(
                        tag: 'stretch7',
                        child: Image.asset('assets/images/stretch7.png')),
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
