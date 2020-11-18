import 'dart:convert';

import 'package:best_flutter_ui_templates/design_course/design_course_app_theme.dart';
import 'package:best_flutter_ui_templates/design_course/models/category.dart';
import 'package:best_flutter_ui_templates/main.dart';
import 'package:best_flutter_ui_templates/metiers/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'course_info_screen.dart';

class PopularCourseListView extends StatefulWidget {
  const PopularCourseListView({Key key, this.callBack,this.metier}) : super(key: key);

  final Function callBack;
  final String metier;
  @override
  _PopularCourseListViewState createState() => _PopularCourseListViewState();
}

class _PopularCourseListViewState extends State<PopularCourseListView>
    with TickerProviderStateMixin {
  AnimationController animationController;
  List<User> metiers = [];

  @override
  void initState() {
    animationController = AnimationController(
        duration: const Duration(milliseconds: 2000), vsync: this);
    http.get("http://10.0.2.2:3000/personnoc/hatem@gmail.com")
        .then((http.Response response){
      List<dynamic>carsFromServer = json.decode(response.body);
      for(int i=0; i<carsFromServer.length;i++){
        Map<String,dynamic> carJ  = carsFromServer[i]; //Chaque bloc JSON est une Voiture de type Map

        metiers.add(User(id :carJ['id'],firebaseid :carJ['firebaseid'],token: carJ['token'],email : carJ['email'],name: carJ['name'], username: carJ['username'],
            encrypted_password: carJ['encrypted_password'],salt: carJ['salt'],numtel: carJ['numtel'],adresse: carJ['adresse'], metier: carJ['metier'],
            ville: carJ['ville'],codepostale: carJ['codepostale'], prix: carJ['prix'], image: carJ['image'])); //Alimenter mon dataSource (cars)
      }
      print(">>>>>>> "+metiers.length.toString());
    });

    super.initState();
    setState((){});

  }

  Future<bool> getData() async {
    await Future<dynamic>.delayed(const Duration(milliseconds: 200));
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: FutureBuilder<bool>(
        future: getData(),
        builder: (BuildContext context, AsyncSnapshot<bool> snapshot) {
          if (!snapshot.hasData) {
            return const SizedBox();
          } else {
            return GridView(
              padding: const EdgeInsets.all(8),
              physics: const BouncingScrollPhysics(),
              scrollDirection: Axis.vertical,
              children: List<Widget>.generate(
                metiers.length,
                    (int index) {
                  final int count = metiers.length;
                  final Animation<double> animation =
                  Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(
                      parent: animationController,
                      curve: Interval((1 / count) * index, 1.0,
                          curve: Curves.fastOutSlowIn),
                    ),
                  );
                  animationController.forward();
                  return CategoryView(
                    callback: () {
                      widget.callBack();
                    },
                    category: metiers[index],
                    animation: animation,
                    animationController: animationController,

                  );

                },
              ),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 32.0,
                crossAxisSpacing: 32.0,
                childAspectRatio: 0.8,
              ),

            );

          }
        },
      ),
    );
  }
}


class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
        this.category,
        this.animationController,
        this.animation,
        this.callback})
      : super(key: key);

  final VoidCallback callback;
  final User category;

  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
                Navigator.push<dynamic>(
                  context,
                  MaterialPageRoute<dynamic>(
                    builder: (BuildContext context) => CourseInfoScreen(category : category ),
                  ),
                );
              },
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                // border: new Border.all(
                                //     color: DesignCourseAppTheme.notWhite),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: Text(
                                              category.username,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 16,
                                                right: 16,
                                                bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment
                                                  .spaceBetween,
                                              crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${category.metier} ',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .grey,
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${4.4}',
                                                        textAlign:
                                                        TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                          FontWeight.w200,
                                                          fontSize: 18,
                                                          letterSpacing: 0.27,
                                                          color:
                                                          DesignCourseAppTheme
                                                              .grey,
                                                        ),
                                                      ),

                                                      Icon(
                                                        Icons.star,
                                                        color:
                                                        DesignCourseAppTheme
                                                            .nearlyBlue,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),

                                                )

                                              ],

                                            ),

                                          ),

                                        ],

                                      ),

                                    ),

                                  ),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                        const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignCourseAppTheme.grey
                                      .withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                            const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1.28,
                                child: Image.network('http://10.0.2.2:3000/uploads/'+category.image)),
                          ),

                        ),
                      ),

                    ),

                  ],

                ),

              ),

            ),

          ),

        );

      },

    );
  }
}


/*
class CategoryView extends StatelessWidget {
  const CategoryView(
      {Key key,
      this.category,
      this.animationController,
      this.animation,
      this.callback})
      : super(key: key);

  final VoidCallback callback;
  final Category category;

  final AnimationController animationController;
  final Animation<dynamic> animation;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animationController,
      builder: (BuildContext context, Widget child) {
        return FadeTransition(
          opacity: animation,
          child: Transform(
            transform: Matrix4.translationValues(
                0.0, 50 * (1.0 - animation.value), 0.0),
            child: InkWell(
              splashColor: Colors.transparent,
              onTap: () {
                callback();
              },
              child: SizedBox(
                height: 280,
                child: Stack(
                  alignment: AlignmentDirectional.bottomCenter,
                  children: <Widget>[
                    Container(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            child: Container(
                              decoration: BoxDecoration(
                                color: HexColor('#F8FAFB'),
                                borderRadius: const BorderRadius.all(
                                    Radius.circular(16.0)),
                                // border: new Border.all(
                                //     color: DesignCourseAppTheme.notWhite),
                              ),
                              child: Column(
                                children: <Widget>[
                                  Expanded(
                                    child: Container(
                                      child: Column(
                                        children: <Widget>[
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 16, left: 16, right: 16),
                                            child: Text(
                                              category.title,
                                              textAlign: TextAlign.left,
                                              style: TextStyle(
                                                fontWeight: FontWeight.w600,
                                                fontSize: 16,
                                                letterSpacing: 0.27,
                                                color: DesignCourseAppTheme
                                                    .darkerText,
                                              ),
                                            ),
                                          ),
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8,
                                                left: 16,
                                                right: 16,
                                                bottom: 8),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: <Widget>[
                                                Text(
                                                  '${category.lessonCount} lesson',
                                                  textAlign: TextAlign.left,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w200,
                                                    fontSize: 12,
                                                    letterSpacing: 0.27,
                                                    color: DesignCourseAppTheme
                                                        .grey,
                                                  ),
                                                ),
                                                Container(
                                                  child: Row(
                                                    children: <Widget>[
                                                      Text(
                                                        '${category.rating}',
                                                        textAlign:
                                                            TextAlign.left,
                                                        style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.w200,
                                                          fontSize: 18,
                                                          letterSpacing: 0.27,
                                                          color:
                                                              DesignCourseAppTheme
                                                                  .grey,
                                                        ),
                                                      ),
                                                      Icon(
                                                        Icons.star,
                                                        color:
                                                            DesignCourseAppTheme
                                                                .nearlyBlue,
                                                        size: 20,
                                                      ),
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    width: 48,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 48,
                          ),
                        ],
                      ),
                    ),
                    Container(
                      child: Padding(
                        padding:
                            const EdgeInsets.only(top: 24, right: 16, left: 16),
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            boxShadow: <BoxShadow>[
                              BoxShadow(
                                  color: DesignCourseAppTheme.grey
                                      .withOpacity(0.2),
                                  offset: const Offset(0.0, 0.0),
                                  blurRadius: 6.0),
                            ],
                          ),
                          child: ClipRRect(
                            borderRadius:
                                const BorderRadius.all(Radius.circular(16.0)),
                            child: AspectRatio(
                                aspectRatio: 1.28,
                                child: Image.asset(category.imagePath)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}*/
