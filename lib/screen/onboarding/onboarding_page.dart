import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:front_fitness/component/dots_indicator.dart';
import 'package:front_fitness/component/progress_chart.dart';
import 'package:front_fitness/component/triangle_top_blue_header.dart';
import 'package:front_fitness/component/triangle_top_header.dart';
import 'package:front_fitness/model/graph_entry.dart';
import 'package:front_fitness/screen/onboarding/onboarding_animation.dart';
import 'package:lottie/lottie.dart';

class OnBoardingPage extends StatefulWidget {
  @override
  _OnBoardingPageState createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage>
    with TickerProviderStateMixin {
  AnimationController animationController;
  OnBoardingEnterAnimation onBoardingEnterAnimation;

  final _controller = new PageController();

  static const _kDuration = const Duration(milliseconds: 300);

  static const _kCurve = Curves.ease;


  List<Widget> _pages = <Widget>[
    _getPagerItem(),
    _getPagerItem(),
    _getPagerItem()
  ];

  @override
  void initState() {
    super.initState();
    animationController = new AnimationController(
        duration: const Duration(milliseconds: 1000), vsync: this)
      ..addListener(() {
        setState(() {});
      })
      ..addStatusListener((AnimationStatus status) {
        switch (status) {
          case AnimationStatus.forward:
            break;
          case AnimationStatus.reverse:
            break;
          case AnimationStatus.completed:
            break;
          case AnimationStatus.dismissed:
            Navigator.pushNamed(context, "/activity");
            break;
        }
      });

    onBoardingEnterAnimation = OnBoardingEnterAnimation(animationController);

    animationController.forward();
  }

  @override
  void dispose() {
    animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    TextTheme textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Color(0xFFfcfcfc),
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          _getTopBlueTriangle(size),
          _getTopTriangle(size),
          _getGraphLabel(size, textTheme),
          _setActivityData(
              textTheme,
              size.width * 0.1,
              size.height * 0.1,
              activityList[0],
              onBoardingEnterAnimation.dailyActivity1translation.value),
          _setActivityData(
              textTheme,
              size.width * 0.45,
              size.height * 0.1,
              activityList[1],
              onBoardingEnterAnimation.dailyActivity1translation.value),
          _setActivityData(
              textTheme,
              size.width * 0.1,
              size.height * 0.22,
              activityList[2],
              onBoardingEnterAnimation.dailyActivity1translation.value),
          _setActivityData(
              textTheme,
              size.width * 0.45,
              size.height * 0.22,
              activityList[3],
              onBoardingEnterAnimation.dailyActivity1translation.value),
          Positioned(
            right: size.width * 0.6,
            top: size.height * 0.4,
            child: Transform(
              transform: Matrix4.translationValues(
                  onBoardingEnterAnimation.fadeTranslation.value, 0, 0),
              child:AvatarGlow(
                 glowColor: Colors.white,
                endRadius: 90.0,
                duration: Duration(milliseconds: 2000),
                repeat: true,
                showTwoGlows: true,
                repeatPauseDuration: Duration(milliseconds: 100),
                child: Material(
                  elevation: 8.0,
                  shape: CircleBorder(),
                    child: CircleAvatar(
                      backgroundColor: Colors.grey[100],
                       child: Image.asset(
                      'assets/images/profile.png',
                        height: 80,
                      ),
                      radius: 40.0,
                      ),
                      ),
                  ),
              ),
            ),
          Positioned(
            right: size.width * 0.11,
            top: size.height * 0.10,
            child:Column(
                children: <Widget>[
                  Lottie.asset('assets/lottie/healthy.json',
                  height: 100.0,
                  ),
                  Text('Seeking',
                  style: textTheme.subhead.copyWith(fontSize: 18.0, color: Color(0xFF464965),)),
                  Text('Health',
                    style: textTheme.subhead.copyWith(fontSize: 26.0, color: Color(0xFFef476f),),),

                  ],
            ),
          ),
          _setActivityData(
              textTheme,
              size.width * 0.1,
              size.height * 0.34,
              activityList[4],
              onBoardingEnterAnimation.dailyActivity1translation.value),
          _createLineChart(size, textTheme),
          _createPagerIndicator(size),
          _getActivityPager(size, textTheme),
          _getFab(size),
        ],
      ),
    );
  }

  _getTopTriangle(Size size) => Positioned(
      left: 0,
      right: 0,
      bottom: size.height * 0.45,
      child: Transform(
        transform: Matrix4.translationValues(0,
            -onBoardingEnterAnimation.whiteCutBackgroundYtranslation.value, 0),
        child: TriangleTopHeader(
          child: Container(
            color: Colors.white,
            height: size.height,
          ),
        ),
      ));

  _getTopBlueTriangle(Size size) => Positioned(
      left: 0,
      right: 0,
      bottom: size.height * 0.3,
      child: Transform(
        transform: Matrix4.translationValues(
            onBoardingEnterAnimation.blueCutBackgroundYtranslation.value, 0, 0),
        child: TriangleTopBlueHeader(
          child: Container(
            color: Colors.white,
            height: size.height,
          ),
        ),
      ));

  _getFab(Size size) => Positioned(
        right: size.width * 0.16,
        top: size.height * 0.27,
        child: Transform(
          transform: Matrix4.translationValues(
              onBoardingEnterAnimation.fadeTranslation.value, 0, 0),
          child: GestureDetector(
            onTap: () {
                animationController.reverse();
                Scaffold.of(context).showSnackBar(
                    new SnackBar(content: new Text('Button Clicked')));
              },
            child: AvatarGlow(
            glowColor: Colors.white,
            endRadius: 80.0,
            duration: Duration(milliseconds: 2000),
            repeat: true,
            showTwoGlows: true,
            repeatPauseDuration: Duration(milliseconds: 100),
            child: Material(
              elevation: 8.0,
              shape: CircleBorder(),
              child: CircleAvatar(
                backgroundColor: Colors.grey[100],
                child: Icon(
                    Icons.arrow_forward,
                    color: Color(0xffEF476F)
                ),
                radius: 40.0,
              ),
            ),
            ),
          ),
          ),
      );

  static _getPagerItem() => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Text(
            "ultima atividade",
            style: TextStyle(
                fontSize: 16.0,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w600),
          ),
          SizedBox(
            height: 4,
          ),
          Text(
            "corrida 2 horas atrás",
            style: TextStyle(
                fontSize: 14.0,
                fontStyle: FontStyle.normal,
                color: Colors.white,
                fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.access_time,
                color: Colors.white,
                size: 12,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "47 min",
                style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
              SizedBox(
                width: 8,
              ),
              Icon(
                Icons.flag,
                color: Colors.white,
                size: 12,
              ),
              SizedBox(
                width: 4,
              ),
              Text(
                "3 km",
                style: TextStyle(
                    fontSize: 12.0,
                    fontStyle: FontStyle.normal,
                    color: Colors.white,
                    fontWeight: FontWeight.w300),
              ),
            ],
          )
        ],
      );

  _getActivityPager(Size size, TextTheme textTheme) => Positioned(
      left: size.width * 0.6,
      right: 0,
      top: size.height * 0.4,
      bottom: size.height * 0.4,
      child: Transform(
        transform: Matrix4.translationValues(
            onBoardingEnterAnimation.pagerXtranslation.value, 0, 0),
        child: PageView.builder(
          physics: new AlwaysScrollableScrollPhysics(),
          controller: _controller,
          scrollDirection: Axis.vertical,
          itemBuilder: (BuildContext context, int index) {
            return _pages[index % _pages.length];
          },
        ),
      ));

  _getGraphLabel(Size size, TextTheme textTheme) => Positioned(
      left: size.width * 0.1,
      right: 0,
      top: size.height * 0.56,
      child: Transform(
        transform: Matrix4.translationValues(
            -onBoardingEnterAnimation.graphLabelXtranslation.value, 0, 0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Text(
              "\nGabriel \nAlmeida\n\n\n",
              style: textTheme.subhead.copyWith(fontSize: 15.0,color: Color(0xff06d6a0)),
            ),
            SizedBox(
              width: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Card(
                shape: CircleBorder(),
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                      color: Color(0xFF464965),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(
                "Semanal",
                style: textTheme.subhead.copyWith(fontSize: 12.0, color: Color(0xFF464965),),
              ),
            ),
            SizedBox(
              width: 12,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Card(
                shape: CircleBorder(),
                child: Container(
                  height: 8,
                  width: 8,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Color(0xffef476f),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: Text(
                "Média",
                style: textTheme.subhead.copyWith(fontSize: 12.0, color: Color(0xffef476f)),
              ),
            )
          ],
        ),
      ));

  _setActivityData(TextTheme textTheme, double width, double height,
          DailyActivityModel dailyActivityModel, double animatedValue) =>
      Positioned(
          left: width,
          top: height,
          child: Transform(
            transform: Matrix4.translationValues(0, -animatedValue, 0),
            child: Opacity(
                opacity: animatedValue,
                child: _textValueUnitContainer(textTheme, dailyActivityModel)),
          ));

  _createLineChart(Size size, TextTheme textTheme) => Positioned(
      top: size.height * 0.7,
      left: 0,
      right: 0,
      bottom: 0,
      child: Transform(
          transform: Matrix4.translationValues(
              0, onBoardingEnterAnimation.graphYtranslation.value, 0),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: ProgressChart(entriesList),
          )));

  _createPagerIndicator(Size size) => new Positioned(
        left: size.width * 0.45,
        top: size.height * 0.4,
        bottom: size.height * 0.4,
        child: Transform(
          transform: Matrix4.translationValues(
              onBoardingEnterAnimation.pagerXtranslation.value, 0, 0),
          child: new Center(
            child: new DotsIndicator(
              controller: _controller,
              itemCount: _pages.length,
              onPageSelected: (int page) {
                _controller.animateToPage(
                  page,
                  duration: _kDuration,
                  curve: _kCurve,
                );
              },
            ),
          ),
        ),
      );
}

Widget _textValueUnitContainer(
    TextTheme textTheme, DailyActivityModel dailyActivityModel) {
  return Column(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: <Widget>[
      dailyActivityModel.valueUnitList != null
          ? Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: dailyActivityModel.valueUnitList.map((value) {
                return Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    Text(
                      "${value.value}",
                      style: textTheme.title
                          .copyWith(color: Colors.white),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 2.0),
                      child: Text(
                        "${value.unit}",
                        style:
                            textTheme.caption.copyWith(color: Colors.white),
                      ),
                    ),
                    SizedBox(
                      width: 4,
                    )
                  ],
                );
              }).toList())
          : Offstage(),
      Text(
        dailyActivityModel.label,
        style: textTheme.caption.copyWith(color: Colors.white),
      )
    ],
  );
}

class UnitValueModel {
  UnitValueModel({
    @required this.value,
    @required this.unit,
  });

  final String value;
  final String unit;
}

class DailyActivityModel {
  DailyActivityModel({
    @required this.label,
    @required this.valueUnitList,
  });

  final String label;
  final List<UnitValueModel> valueUnitList;
}

final List<DailyActivityModel> activityList = [
  DailyActivityModel(label: "Descanso", valueUnitList: [
    UnitValueModel(value: "6", unit: "h"),
    UnitValueModel(value: "29", unit: "m")
  ]),
  DailyActivityModel(
      label: "Frequência",
      valueUnitList: [UnitValueModel(value: "89", unit: "bpm")]),
  DailyActivityModel(
      label: "Passos", valueUnitList: [UnitValueModel(value: "1238", unit: "ps")]),
  DailyActivityModel(
      label: "Temperatura",
      valueUnitList: [UnitValueModel(value: "93.8°", unit: "C")]),
  DailyActivityModel(
      label: "Calorias",
      valueUnitList: [UnitValueModel(value: "234", unit: "cal")])
];


final List<GraphEntry> entriesList = [
  GraphEntry(DateTime.now(), 23, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 1)), 25, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 2)), 43, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 3)), 12, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 4)), 33, ""),
  GraphEntry(DateTime.now().subtract(Duration(days: 5)), 22, ""),
];