import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class Hinfo extends StatefulWidget {
  const Hinfo({super.key});

  @override
  State<Hinfo> createState() => _HinfoState();
}

class _HinfoState extends State<Hinfo> {
  TextEditingController heighttextcont = TextEditingController();
  TextEditingController weighttextcont = TextEditingController();

  String? selectedgender = 'Male';
  dynamic userheight = 120;
  dynamic userweight = 40;
  late DateTime? newDate = DateTime(2023, 01, 01);
///// for hive box
  late Box<dynamic> prfilebox;
///// for hive box

  @override
  void initState() {
    calhiveboxdataf();
    super.initState();
  }

  calhiveboxdataf() {
    prfilebox = Hive.box<dynamic>('profile');
    selectedgender = prfilebox.get('genderbox');
    newDate = prfilebox.get('dateofborthbox') as DateTime?;
    userheight = prfilebox.get('hieghtbox');
    userweight = prfilebox.get('userweightbox');
  }

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
          'Health Info',
          style: TextStyle(color: Colors.black),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
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
                child: ListTile(
                  onTap: () {
                    Get.defaultDialog(
                      title: 'Select Gender',
                      titleStyle: const TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 17),
                      content: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 8.0, bottom: 2),
                            child: Card(
                              color: Colors.white,
                              child: ListTile(
                                leading: Radio(
                                  value: 'Male',
                                  groupValue: selectedgender ?? 'Female',
                                  onChanged: (value) {
                                    setState(() {
                                      selectedgender = value!;
                                      prfilebox.put('genderbox', value);
                                      Get.back();
                                    });
                                  },
                                ),
                                title: const Text("Male"),
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(top: 2.0, bottom: 5),
                            child: Card(
                              color: Colors.white,
                              child: ListTile(
                                leading: Radio(
                                  value: 'Female',
                                  groupValue: selectedgender ?? 'Female',
                                  onChanged: (value) {
                                    setState(() {
                                      selectedgender = value!;
                                      prfilebox.put('genderbox', value);
                                      Get.back();
                                    });
                                  },
                                ),
                                title: const Text("Female"),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                  title: const Text(
                    'Gender',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: SizedBox(
                    width: 75,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Center(
                          child: Text(selectedgender ?? 'Female',
                              style: const TextStyle(
                                color: Colors.deepOrange,
                                fontSize: 14,
                                fontFamily: 'cbold',
                              )),
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
                  onTap: () async {
                    final DateTime? newDateg = await showDatePicker(
                      context: context,
                      initialDate: DateTime(2020, 11, 17),
                      firstDate: DateTime(1980, 1),
                      lastDate: DateTime(2023, 1),
                      helpText: 'Select date',
                    );
                    setState(() {
                      newDate = newDateg!;
                      prfilebox.put('dateofborthbox', newDate);
                    });
                  },
                  title: const Text(
                    'Date Of Birth',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: SizedBox(
                    width: 90,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${newDate?.year ?? 2000}-${newDate?.month ?? 08}-${newDate?.day ?? 18}',
                          style: const TextStyle(color: Colors.deepOrange),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Color.fromARGB(221, 63, 62, 62),
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
                    heightSheet();
                  },
                  title: const Text(
                    'Height',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: SizedBox(
                    width: 80,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${userheight ?? 5} Cm',
                          style: const TextStyle(color: Colors.deepOrange),
                        ),
                        const Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.black87,
                          size: 17,
                        ),
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
                    weightsheet();
                  },
                  title: const Text(
                    'Weight',
                    style: TextStyle(fontFamily: 'clight'),
                  ),
                  trailing: SizedBox(
                    width: 67,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          '${userweight ?? 40} kg',
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
          ],
        ),
      ),
    );
  }

  Future<dynamic> weightsheet() {
    return Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      SizedBox(
        height: Get.size.height * 1.2 / 4,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ListTile(
              title: const Text(
                'Select Weight',
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, left: 15, right: 15, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: Get.size.width * 3.2 / 4,
                    child: TextField(
                      controller: weighttextcont,
                      decoration: InputDecoration(
                        hintText: 'Weight',
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.05, color: Colors.blueGrey),
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
                  const Text('KG',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: 'cbold',
                      )),
                ],
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
                            top: 15.0, left: 30, right: 30, bottom: 15),
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
                      prfilebox.put('userweightbox', weighttextcont.text);
                      setState(() {
                        userweight = int.parse(weighttextcont.text);
                      });
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
                          top: 15.0, left: 30, right: 30, bottom: 15),
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
            )
          ],
        ),
      ),
    );
  }

  Future<dynamic> heightSheet() {
    return Get.bottomSheet(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(25.0),
          topRight: Radius.circular(25.0),
        ),
      ),
      backgroundColor: Colors.white,
      SizedBox(
        height: Get.size.height * 1.2 / 4,
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            ListTile(
              title: const Text(
                'Select Height',
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
            Padding(
              padding: const EdgeInsets.only(
                  top: 2.0, left: 15, right: 15, bottom: 6),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: Get.size.width * 3.2 / 4,
                    child: TextField(
                      controller: heighttextcont,
                      decoration: InputDecoration(
                        hintText: 'Height',
                        disabledBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                width: 0.05, color: Colors.blueGrey),
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
                  const Text('CM',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 15,
                        fontFamily: 'cbold',
                      )),
                ],
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
                            top: 15.0, left: 30, right: 30, bottom: 15),
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
                      prfilebox.put('hieghtbox', heighttextcont.text);
                      setState(() {
                        userheight = int.parse(heighttextcont.text);
                      });
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
                          top: 15.0, left: 30, right: 30, bottom: 15),
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
            )
          ],
        ),
      ),
    );
  }
}

////////////
Future<dynamic> weightsheet() {
  return Get.bottomSheet(
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(25.0),
        topRight: Radius.circular(25.0),
      ),
    ),
    backgroundColor: Colors.white,
    SizedBox(
      height: Get.size.height * 1.2 / 4,
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          ListTile(
            title: const Text(
              'Select Weight',
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
          Padding(
            padding:
                const EdgeInsets.only(top: 2.0, left: 15, right: 15, bottom: 6),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                SizedBox(
                  width: Get.size.width * 3.2 / 4,
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Weight',
                      disabledBorder: OutlineInputBorder(
                          borderSide: const BorderSide(
                              width: 0.05, color: Colors.blueGrey),
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
                const Text('KG',
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 15,
                      fontFamily: 'cbold',
                    )),
              ],
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
                          top: 15.0, left: 30, right: 30, bottom: 15),
                      child: Text(
                        'Cancel',
                        style: TextStyle(
                            fontSize: 16,
                            fontFamily: 'cbold',
                            fontWeight: FontWeight.bold),
                      ),
                    )),
                OutlinedButton(
                  onPressed: () {},
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
                        top: 15.0, left: 30, right: 30, bottom: 15),
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
          )
        ],
      ),
    ),
  );
}
