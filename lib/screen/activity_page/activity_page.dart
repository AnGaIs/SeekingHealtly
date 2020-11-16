import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:front_fitness/screen/activity_page/activity_page_animation.dart';
import 'package:lottie/lottie.dart';

class ActivityPage extends StatefulWidget {
  @override
  _ActivityPageState createState() => _ActivityPageState();
}

class _ActivityPageState extends State<ActivityPage>
    with TickerProviderStateMixin {
  AnimationController animationController;
  ActivityEnterAnimation activityEnterAnimation;

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
            Navigator.pushNamed(context, "/onboarding");
            break;
        }
      });

    activityEnterAnimation = ActivityEnterAnimation(animationController);

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
      backgroundColor: Color(0xFFEF476F),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            _getLabelText(textTheme),
            Expanded(
              child: _getActivityList(size, textTheme),
            ),
          ],
        ),
      ),
      floatingActionButton: _getFab(),
    );
  }

  _getActivityList(Size size, TextTheme textTheme) => Transform(
      transform: Matrix4.translationValues(
          -activityEnterAnimation.listXtranslation.value, 0, 0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: <Widget>[
            _getListItem(textTheme, 'Academia', FontAwesomeIcons.dumbbell),
            _getListItem(textTheme, 'Artes Marciais', FontAwesomeIcons.fistRaised),
            _getListItem(textTheme, 'Basquete', FontAwesomeIcons.baseballBall),
            _getListItem(textTheme, 'Caminhada', FontAwesomeIcons.walking),
            _getListItem(textTheme, 'Ciclismo', FontAwesomeIcons.biking),
            _getListItem(textTheme, 'Corrida', FontAwesomeIcons.running),
            _getListItem(textTheme, 'Futebol', FontAwesomeIcons.futbol),
            _getListItem(textTheme, 'Golf', FontAwesomeIcons.golfBall),
            _getListItem(textTheme, 'Natação', FontAwesomeIcons.swimmer),
            _getListItem(textTheme, 'Quadribol', FontAwesomeIcons.quidditch),
            _getListItem(textTheme, 'Patinação', FontAwesomeIcons.skating),
            _getListItem(textTheme, 'Rugby', FontAwesomeIcons.footballBall),
            _getListItem(textTheme, 'Snowboarding', FontAwesomeIcons.snowboarding),
            _getListItem(textTheme, 'Tênis', FontAwesomeIcons.tableTennis),
            _getListItem(textTheme, 'Vôlei', FontAwesomeIcons.volleyballBall),

          ],
        ),
      ));

  _getListItem(TextTheme textTheme, String label, IconData iconData) => Padding(
        padding: EdgeInsets.all(8),
        child: Row(
          children: <Widget>[
            Icon(
              iconData,
              color: Colors.white,
            ),
            SizedBox(
              width: 16,
            ),
            Text(
              label,
              style: textTheme.subhead.copyWith(color: Colors.white),
            )
          ],
        ),
      );

  _getFab() => Transform(
        transform: Matrix4.translationValues(
            activityEnterAnimation.listXtranslation.value, 0, 0),
        child: FloatingActionButton(
          backgroundColor: Colors.white,
          child: Icon(
            Icons.arrow_back,
            color: Color(0xFFEF476F)
          ),
          onPressed: () {
            animationController.reverse();
            Scaffold.of(context).showSnackBar(
                new SnackBar(content: new Text('Button Clicked')));
          },
        ),
      );

  _getLabelText(TextTheme textTheme) => Padding(
        padding: EdgeInsets.only(top: 24, left: 24),
        child: Transform(
          transform: Matrix4.translationValues(
              -activityEnterAnimation.labelXtranslation.value, 0, 0),
          child: Text(
            "Selecione a atividade",
            style: textTheme.caption.copyWith(color: Colors.white),
            textAlign: TextAlign.left,
          ),
        ),
      );
}
