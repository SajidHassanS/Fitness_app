import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive/hive.dart';
import 'loginsignup.dart';
import 'package:introduction_screen/introduction_screen.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  OnBoardingPageState createState() => OnBoardingPageState();
}

class OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    final checkprofilebox = Hive.box<dynamic>('profile');
    checkprofilebox.put('setintro', '1');
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const Login()),
    );
  }

  Widget _buildImage(String assetName) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      child: Image.asset(
        'assets/intro/$assetName',
        fit: BoxFit.cover,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 19.0);
    var btntitleby4 = 'Get Started';
    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(
        fontSize: 24.0,
        fontWeight: FontWeight.w700,
        letterSpacing: 1.5,
      ),
      imageFlex: 3,
      contentMargin: EdgeInsets.all(22),
      titlePadding: EdgeInsets.only(top: 0.0),
      bodyTextStyle: bodyStyle,
      bodyPadding: EdgeInsets.fromLTRB(0.0, 0.0, 0.0, 0.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
      fullScreen: false,
    );
    return Scaffold(
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark,
            systemNavigationBarColor: Colors.white,
            systemNavigationBarIconBrightness: Brightness.dark),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      extendBodyBehindAppBar: true,
      body: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        allowImplicitScrolling: true,
        autoScrollDuration: 3000,
        globalFooter: SizedBox(
          width: double.infinity,
          height: 130,
          child: Column(
            children: [
              GestureDetector(
                onTap: () {
                  final nextno = introKey.currentState!.getCurrentPageNumber();
                  introKey.currentState?.animateScroll(nextno + 1);
                  if (introKey.currentState?.getCurrentPageNumber() == 3) {
                    final checkprofilebox = Hive.box<dynamic>('profile');
                    checkprofilebox.put('setintro', '1');
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (_) => const Login()));
                  }
                },
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Container(
                    decoration: BoxDecoration(
                        color: Colors.deepOrange,
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Text(btntitleby4,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 22,
                                fontFamily: 'cbold')),
                      ),
                    ),
                  ),
                ),
              ),
              TextButton(
                  onPressed: () => _onIntroEnd(context),
                  child: const Text(
                    'Skip',
                    style: TextStyle(color: Colors.black),
                  ))
            ],
          ),
        ),
        bodyPadding: EdgeInsets.zero,
        pages: [
          PageViewModel(
            title: "Make Perfect Body By Doing Daily Workouts",
            body: "",
            image: _buildImage('intro_1.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Shot Strong Fitness Programme",
            body: "",
            image: _buildImage('intro_2.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Healthy Muscular Sportswoman Standing",
            body: "",
            image: _buildImage('intro_3.png'),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Workout Anywhere",
            body: "",
            image: _buildImage('intro_4.png'),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        isBottomSafeArea: true,
        showSkipButton: false,
        showNextButton: false,
        skipOrBackFlex: 0,
        nextFlex: 0,
        showBackButton: false,
        showDoneButton: false,
        back: const Icon(Icons.arrow_back),
        skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600)),
        next: const Icon(Icons.arrow_forward),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: DotsDecorator(
          size: const Size(10.0, 10.0),
          color: Colors.deepOrangeAccent.withOpacity(0.3),
          activeSize: const Size(22.0, 10.0),
          activeShape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
      ),
    );
  }
}
