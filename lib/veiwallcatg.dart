import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import 'opencatg.dart';

class VallCatgpage extends StatefulWidget {
  const VallCatgpage({super.key});

  @override
  State<VallCatgpage> createState() => _VallCatgpageState();
}

class _VallCatgpageState extends State<VallCatgpage> {
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
            icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black)),
        title: const Text(
          'All Categories',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              scrollDirection: Axis.vertical,
              physics: const BouncingScrollPhysics(),
              children: [
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
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
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.5 /
                                        1,
                                    child: Image.asset(
                                        'assets/images/category1.png'),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Warmup',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Hero(
                                    tag: 'categoryimage1',
                                    child: Transform.scale(
                                      scaleY: 1.1,
                                      child: Transform.translate(
                                        offset: const Offset(0, -6),
                                        child: Image.asset(
                                          'assets/images/categoryimage1.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
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
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.5 /
                                        1,
                                    child: Image.asset(
                                        'assets/images/category2.png'),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'ABS Workout',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Hero(
                                    tag: 'categoryimage2',
                                    child: Transform.scale(
                                      scaleY: 1.1,
                                      child: Transform.translate(
                                        offset: const Offset(0, -6),
                                        child: Image.asset(
                                          'assets/images/categoryimage2.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
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
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.5 /
                                        1,
                                    child: Image.asset(
                                        'assets/images/category3.png'),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Arms & Shoulder',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Hero(
                                    tag: 'categoryimage3',
                                    child: Transform.scale(
                                      scaleY: 1.1,
                                      child: Transform.translate(
                                        offset: const Offset(0, -6),
                                        child: Image.asset(
                                          'assets/images/categoryimage3.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
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
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.5 /
                                        1,
                                    child: Image.asset(
                                        'assets/images/category4.png'),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Butt Workout',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Hero(
                                    tag: 'categoryimage4',
                                    child: Transform.scale(
                                      scaleY: 1.1,
                                      child: Transform.translate(
                                        offset: const Offset(0, -6),
                                        child: Image.asset(
                                          'assets/images/categoryimage4.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
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
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.5 /
                                        1,
                                    child: Image.asset(
                                        'assets/images/category5.png'),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Center(
                                    child: Text(
                                      'Thigh',
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  Hero(
                                    tag: 'categoryimage5',
                                    child: Transform.scale(
                                      scaleY: 1.1,
                                      child: Transform.translate(
                                        offset: const Offset(5, -6),
                                        child: Image.asset(
                                          'assets/images/categoryimage5.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: double.infinity,
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
                                    borderRadius: BorderRadius.circular(20)),
                              ),
                              Align(
                                  alignment: Alignment.bottomRight,
                                  child: SizedBox(
                                    width: MediaQuery.of(context).size.width *
                                        0.5 /
                                        1,
                                    child: Image.asset(
                                        'assets/images/category6.png'),
                                  )),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  const Text(
                                    'Stretching',
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  Hero(
                                    tag: 'categoryimage6',
                                    child: Transform.scale(
                                      scaleY: 1.1,
                                      child: Transform.translate(
                                        offset: const Offset(0, -6),
                                        child: Image.asset(
                                          'assets/images/categoryimage6.png',
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )
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
        ],
      ),
    );
  }
}
