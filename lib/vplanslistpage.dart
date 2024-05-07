import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:workout/vplansexc.dart';
import 'plansmodel/getpplansdata.dart';
import 'plansmodel/plansmodelclass.dart';

class Vplanslistpage extends StatefulWidget {
  const Vplanslistpage({super.key});

  @override
  State<Vplanslistpage> createState() => _VplanslistpageState();
}

class _VplanslistpageState extends State<Vplanslistpage> {
  TextEditingController wkcustomtitletext = TextEditingController();
  TextEditingController wkcostumdesctxt = TextEditingController();
  final box = Plansbox.data();

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
              Icons.arrow_back_ios_new,
              color: Colors.black,
            )),
        title: const Text(
          'Custom Plans',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        controller: ScrollController(),
        physics: const BouncingScrollPhysics(),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.9 / 1,
          child: box.isEmpty
              ? Center(
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.2 / 1,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.5 / 1,
                        child: Opacity(
                          opacity: 0.2,
                          child: Image.asset(
                            'assets/images/splash_icon.png',
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.05 / 1,
                      ),
                      const Text('You Have Not any Custom Plans'),
                    ],
                  ),
                )
              : ValueListenableBuilder(
                  valueListenable: box.listenable(),
                  builder: (BuildContext context, dynamic box, _) {
                    return ListView.builder(
                        itemCount: box.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data =
                              box.values.toList().cast<Plansmodelclass>();
                          var nooflist = index + 1;

                          return InkWell(
                            onTap: () {
                              Get.to(Startwkonebyoneforplans(vlistno: index));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          color:
                                              Colors.blueGrey.withOpacity(0.1),
                                          offset: const Offset(0, 0.2),
                                          blurRadius: 5,
                                          spreadRadius: 0),
                                    ]),
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 11, left: 8, right: 8, bottom: 11),
                                  child: Stack(
                                    children: [
                                      ListTile(
                                        leading: Transform.scale(
                                          scale: 1.2,
                                          child: Container(
                                            width: Get.size.width * 0.15 / 1,
                                            height: Get.size.height * 0.25 / 1,
                                            decoration: BoxDecoration(
                                                color: const Color.fromARGB(
                                                    255, 255, 239, 234),
                                                borderRadius:
                                                    BorderRadius.circular(15)),
                                            child: Center(
                                              child: Text(
                                                nooflist.toString(),
                                                overflow: TextOverflow.visible,
                                                style: const TextStyle(
                                                    color: Colors.deepOrange,
                                                    fontSize: 30,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                          ),
                                        ),
                                        title: Text(
                                          data[index].title.toString(),
                                          style: const TextStyle(
                                              fontSize: 16,
                                              color: Colors.black,
                                              fontFamily: 'csemibold'),
                                        ),
                                        subtitle: Row(
                                          children: [
                                            const Icon(
                                              Icons.fitness_center_outlined,
                                              size: 14,
                                            ),
                                            Text(
                                              ' ${data[index].desc.toString()}',
                                              maxLines: 1,
                                              style: const TextStyle(
                                                  color: Colors.black87,
                                                  fontFamily: 'csemibold'),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: PopupMenuButton(
                                              shape: BeveledRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  side: const BorderSide(
                                                    color: Color.fromARGB(
                                                        255, 255, 121, 64),
                                                    width: 1,
                                                  )),
                                              initialValue: 23,
                                              elevation: 40,
                                              splashRadius: 22,
                                              position: PopupMenuPosition.over,
                                              itemBuilder:
                                                  (BuildContext context) {
                                                return [
                                                  PopupMenuItem(
                                                    onTap: () {
                                                      data[index].delete();
                                                    },
                                                    value: 1,
                                                    child: const Text('Delete'),
                                                  ),
                                                ];
                                              }))
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
                        });
                  },
                ),
        ),
      ),
    );
  }
}
