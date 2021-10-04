import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:stockdaddy/screens/sd_home_screen.dart';
import 'package:sizer/sizer.dart';

class SDIntroScreen extends StatefulWidget {
  static String id = 'intro_screen';
  const SDIntroScreen({Key? key}) : super(key: key);

  @override
  State<SDIntroScreen> createState() => _SDIntroScreenState();
}

class _SDIntroScreenState extends State<SDIntroScreen> {
  var introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (_) => const SDHomeScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 18.0);

    const pageDecoration = PageDecoration(
      titleTextStyle: TextStyle(fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 0.0, 16.0, 16.0),
      pageColor: Colors.white,
      imagePadding: EdgeInsets.zero,
    );

    return SafeArea(
      child: IntroductionScreen(
        key: introKey,
        globalBackgroundColor: Colors.white,
        pages: [
          PageViewModel(
            title: "About Us",
            body:
                "StockDaddy is an E-learning application that helps you to learn and develop your skills in the stock market. StockDaddy is a subsidiary of rapidly growing stock market educational platform EasemyTrade Pvt. Ltd.",
            image: const _IntroImage(
              url: 'https://stockdaddy.in/images/banner/certificate.svg',
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Vision",
            body:
                "Our Vision is to educate more people about the Stock market and make them capable to create their own vision in the competitive market.",
            image: const _IntroImage(
              url: 'https://stockdaddy.in/images/banner/mission-vision.svg',
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "What We Offer!",
            body:
                " The app offers various features like market, Daily EDIC(Educatinal Demo Intraday Calls), Different courses related to stock market, trade, Screen/vix, and informative videos that give you a better knowledge about stock market.",
            image: const _IntroImage(
              url: 'https://stockdaddy.in/images/banner/certificate.svg',
            ),
            decoration: pageDecoration,
          ),
          PageViewModel(
            title: "Mission",
            body:
                "Our Mission is to burst the myth on the stock market from the Indian society. We strive to offer our customers a complete affordable package with the best services.",
            image: const _IntroImage(
              url: 'https://stockdaddy.in/images/banner/mission-vision.svg',
            ),
            decoration: pageDecoration,
          ),
        ],
        onDone: () => _onIntroEnd(context),
        onSkip: () => _onIntroEnd(context),
        showSkipButton: true,
        skipFlex: 0,
        nextFlex: 0,
        skip: const Text('Skip'),
        next: const Icon(Icons.arrow_forward),
        done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600)),
        curve: Curves.fastLinearToSlowEaseIn,
        controlsMargin: const EdgeInsets.all(16),
        controlsPadding: kIsWeb
            ? const EdgeInsets.all(12.0)
            : const EdgeInsets.fromLTRB(8.0, 4.0, 8.0, 4.0),
        dotsDecorator: const DotsDecorator(
          size: Size(10.0, 10.0),
          color: Color(0xFFBDBDBD),
          activeSize: Size(22.0, 10.0),
          activeShape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(25.0)),
          ),
        ),
        dotsContainerDecorator: const ShapeDecoration(
          color: Colors.black87,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(8.0)),
          ),
        ),
      ),
    );
  }
}

class _IntroImage extends StatelessWidget {
  const _IntroImage({
    Key? key,
    required this.url,
  }) : super(key: key);

  final String url;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.network(
      url,
      height: 30.h,
      width: 50.w,
    );
  }
}
