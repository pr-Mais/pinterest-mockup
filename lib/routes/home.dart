import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pinterest_mokeup/presentation/custom_icons_icons.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  int _selectedIndex = 0;
  Color _redColor = Color(0xffbd081c);
  Color _darkGrey = Color(0xff747474);
  String searchKey = "";
  List<Widget> _widgetOptions;
  FocusNode _focusNode = new FocusNode();
  TabController _tabController;
  ScrollController _hideButtonController = new ScrollController();
  AnimationController _animationController;
  Animation _animation;
  var _isVisible = true;
  var _position;
  static GlobalKey _scaffoldKey = new GlobalKey();

  @override
  initState() {
    super.initState();
    _widgetOptions = [
      _imagesList(),
      Text("Index 3: Followers"),
      Text(
        'Index 2: Notifications',
      ),
      Text(
        'Index 3: Saved',
      ),
    ];
    _tabController = new TabController(length: 3, vsync: this, initialIndex: 0);
    _animationController = AnimationController(
      vsync: this, // the SingleTickerProviderStateMixin
      duration: Duration(milliseconds: 250),
    );
    _animation = Tween(begin: 0.0, end: 1.0).animate(_animationController);
    _hideButtonController.addListener(() {
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.reverse) {
        setState(() {
          _isVisible = false;
        });
      }
      if (_hideButtonController.position.userScrollDirection ==
          ScrollDirection.forward) {
        setState(() {
          _isVisible = true;
        });
      }
    });
  }

  void _imageModalBottomSheet(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {},
              child: new Container(
                  height: 360,
                  color: Colors.white,
                  child: Column(children: [
                    Stack(children: [
                      Container(
                        padding: EdgeInsets.only(top: 4),
                        width: double.infinity,
                        height: 45.0,
                        child: Center(
                            child: Text(
                          "Options",
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                              color: Colors.black),
                        ) // Your desired title
                            ),
                      ),
                      Positioned(
                          left: 2.0,
                          top: 2.0,
                          child: IconButton(
                              icon: IconTheme(
                                  data: IconThemeData(
                                    color: Colors.grey[600],
                                  ),
                                  child:
                                      Icon(Icons.close)), // Your desired icon
                              onPressed: () {
                                Navigator.of(context).pop();
                              }))
                    ]),
                    Divider(),
                    Container(
                      child: InkWell(
                        onTap: () {
                          print("tapped");
                        },
                        child: Row(
                          children: <Widget>[
                            IconTheme(
                                data: IconThemeData(
                                  color: Colors.black87,
                                ),
                                child: Icon(Icons.save_alt)),
                            Container(
                              child: Text(
                                "Save",
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 20,
                                    color: Colors.black),
                              ),
                              padding: EdgeInsets.only(left: 10),
                            ),
                          ],
                        ),
                      ),
                      padding: EdgeInsets.only(left: 16, top: 14, bottom: 10),
                    ),
                    Container(
                      child: Row(
                        children: <Widget>[
                          IconTheme(
                              data: IconThemeData(
                                color: Colors.black87,
                              ),
                              child: Icon(Icons.send)),
                          Container(
                            child: Text(
                              "Send",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                  color: Colors.black),
                            ),
                            padding: EdgeInsets.only(left: 10),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.only(left: 16, top: 14, bottom: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconTheme(
                                  data: IconThemeData(
                                    color: Colors.black87,
                                  ),
                                  child: Icon(Icons.close)),
                              Container(
                                child: Text(
                                  "Hide",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                padding: EdgeInsets.only(left: 10),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "See fewer Pins like this",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                padding: EdgeInsets.only(left: 34, top: 4),
                              ),
                            ],
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(left: 16, top: 14, bottom: 10),
                    ),
                    Container(
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              IconTheme(
                                  data: IconThemeData(
                                    color: Colors.black87,
                                  ),
                                  child: Icon(Icons.report)),
                              Container(
                                child: Text(
                                  "Report",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20,
                                      color: Colors.black),
                                ),
                                padding: EdgeInsets.only(left: 10),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Container(
                                child: Text(
                                  "This goes against community guidlines",
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black87),
                                ),
                                padding: EdgeInsets.only(left: 34, top: 4),
                              ),
                            ],
                          )
                        ],
                      ),
                      padding: EdgeInsets.only(left: 16, top: 14, bottom: 10),
                    )
                  ])));
        });
  }

  Widget _imagesList() {
    return StaggeredGridView.count(
      controller: _hideButtonController,
      crossAxisCount: 4,
      staggeredTiles:
          images.map<StaggeredTile>((_) => StaggeredTile.fit(2)).toList(),
      children: images.map<Widget>((item) {
        //Do you need to go somewhere when you tap on this card, wrap using InkWell and add your route
        return Column(
          children: <Widget>[
            Material(
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                splashColor: Colors.transparent,
                child: GestureDetector(
                  child: Container(
                    child: Column(
                      children: <Widget>[
                        Card(
                          elevation: 0.0,
                          semanticContainer: true,
                          clipBehavior: Clip.antiAliasWithSaveLayer,
                          shape: const RoundedRectangleBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(6),
                            ),
                          ),
                          child: Image.asset(item),
                        ),
                        Padding(
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20)),
                            child: InkWell(
                              highlightColor: Colors.transparent,
                              splashColor: Colors.transparent,
                              onTap: () {
                                _imageModalBottomSheet(
                                    _scaffoldKey.currentContext);
                              },
                              child: IconTheme(
                                  data: IconThemeData(size: 18),
                                  child: Icon(Icons.more_horiz)),
                            ),
                            width: 24,
                            height: 24,
                          ),
                          padding: EdgeInsets.only(right: 6),
                        )
                      ],
                      crossAxisAlignment: CrossAxisAlignment.end,
                    ),
                  ),
                  onLongPressStart: (detail) {
                    RenderBox box = context.findRenderObject();
                    Offset local = box.globalToLocal(detail.globalPosition);
                    setState(() {
                      _position = local;
                    });

                    showMenu(
                      context: context,
                      position: RelativeRect.fromLTRB(
                          _position.dx.roundToDouble(),
                          _position.dy.roundToDouble(),
                          _position.dx.roundToDouble(),
                          _position.dy.roundToDouble()),
                      items: PopupMenu.choices.map((Widget choice) {
                        return PopupMenuItem<Widget>(child: choice);
                      }).toList(),
                    );
                  },
                ),
                onTap: () {
                  print("Tapped");
                },
              ),
            )
          ],
        );
      }).toList(),
      mainAxisSpacing: 10,
      crossAxisSpacing: 8,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  static List images = [
    "assets/images/image2.png",
    "assets/images/image1.jpg",
    "assets/images/image3.jpg",
    "assets/images/image4.jpg",
    "assets/images/image5.png",
    "assets/images/image6.jpg",
    "assets/images/image7.jpg",
  ];

  Widget tabBar() {
    return TabBar(
      tabs: <Widget>[
        Tab(
          child: Text(
            "Top",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
        Tab(
          child: Text(
            "Yours",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        ),
        Tab(
          child: Text(
            "People",
            style:
                TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),
          ),
        )
      ],
      controller: _tabController,
      indicatorColor: Colors.black87,
    );
  }

  Widget search() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Container(
            child: DecoratedTabBar(
          tabBar: tabBar(),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Colors.grey[100],
                width: 2.0,
              ),
            ),
          ),
        ))
      ],
    );
  }

  Widget feed() {
    return Container(
      child: _widgetOptions.elementAt(_selectedIndex),
      padding: EdgeInsetsDirectional.only(start: 9, end: 9, top: 6),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _scaffoldKey,
        appBar: CupertinoNavigationBar(
            trailing: _focusNode.hasFocus
                ? AnimatedCrossFade(
                    sizeCurve: Curves.ease,
                    firstChild: Container(
                        child: InkWell(
                      child: Container(
                        padding: EdgeInsets.only(left: 10, top: 10),
                        child: Text(
                          "Cancel",
                          style: TextStyle(
                              color: Colors.grey,
                              fontSize: 15,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      onTap: () {
                        setState(() {
                          _focusNode.unfocus();
                        });
                      },
                    )),
                    secondChild: Container(),
                    crossFadeState: CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 200),
                    alignment: Alignment.centerLeft,
                  )
                : AnimatedCrossFade(
                    sizeCurve: Curves.ease,
                    firstCurve: Curves.easeInOut,
                    firstChild: Container(
                      padding: EdgeInsets.only(left: 10, top: 10),
                      child: IconTheme(
                          data:
                              IconThemeData(color: Color(0xff8c8b8c), size: 24),
                          child: Icon(CustomIcons.chat)),
                    ),
                    secondChild: Container(),
                    crossFadeState: CrossFadeState.showFirst,
                    duration: Duration(milliseconds: 200),
                    alignment: Alignment.centerLeft,
                  ),
            automaticallyImplyLeading: false,
            backgroundColor: Colors.white,
            border: Border(bottom: BorderSide(color: Colors.white)),
            middle: Container(
              padding: EdgeInsetsDirectional.only(
                top: 10,
              ),
              height: 50,
              child: CupertinoTextField(
                cursorColor: Color(0xffbd081c),
                padding: _focusNode.hasFocus
                    ? EdgeInsets.only(left: 14)
                    : EdgeInsets.only(left: 5),
                focusNode: _focusNode,
                onChanged: (input) {
                  setState(() {
                    searchKey = input;
                    print(searchKey);
                  });
                },
                onTap: () {
                  setState(() {});
                },
                placeholderStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Color(0xff8c8b8c),
                    fontSize: 16),
                style: TextStyle(
                    color: Colors.black87, fontWeight: FontWeight.bold),
                placeholder: _focusNode.hasFocus ? "" : "Search",
                prefix: AnimatedCrossFade(
                  firstChild: Container(
                    child: IconTheme(
                        data: IconThemeData(color: Color(0xff8c8b8c), size: 14),
                        child: Icon(CustomIcons.magnifying_glass)),
                    padding: EdgeInsets.only(left: 14, right: 2, bottom: 3),
                  ),
                  secondChild: Container(),
                  crossFadeState: _focusNode.hasFocus
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 260),
                  alignment: Alignment.centerRight,
                ),
                suffix: AnimatedCrossFade(
                  sizeCurve: Curves.ease,
                  firstChild: Container(
                    child: IconTheme(
                        data: IconThemeData(color: Color(0xff8c8b8c), size: 22),
                        child: Icon(CustomIcons.photo_camera)),
                    padding:
                        EdgeInsets.only(left: 10, right: 10, top: 5, bottom: 5),
                  ),
                  secondChild: Container(),
                  crossFadeState: _focusNode.hasFocus
                      ? CrossFadeState.showSecond
                      : CrossFadeState.showFirst,
                  duration: Duration(milliseconds: 200),
                  alignment: Alignment.centerRight,
                ),
                decoration: BoxDecoration(
                  color: Color(0xffeeeeee),
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            )),
        bottomNavigationBar: AnimatedContainer(
            padding: EdgeInsets.only(top: 2),
            color: Colors.white,
            constraints:
                BoxConstraints(maxWidth: MediaQuery.of(context).size.width),
            duration: Duration(milliseconds: 250),
            height: _isVisible
                ? Theme.of(context).platform == TargetPlatform.iOS ? 68 : 55
                : 0.0,
            child: SingleChildScrollView(
              child: CupertinoTabBar(
                currentIndex: _selectedIndex,
                onTap: _onItemTapped,
                activeColor: _selectedIndex == 0 ? _redColor : _darkGrey,
                inactiveColor: Colors.grey,
                backgroundColor: Colors.white,
                border: Border(top: BorderSide(color: Colors.white)),
                items: <BottomNavigationBarItem>[
                  BottomNavigationBarItem(
                    icon: Icon(CustomIcons.pinterest),
                    title: Text('Home'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.people),
                    title: Text('Following'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.notifications),
                    title: Text('Notifications'),
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.account_circle),
                    title: Text('Saved'),
                  ),
                ],
              ),
            )),
        body: _focusNode.hasFocus
            ? AnimatedSwitcher(
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                duration: Duration(milliseconds: 300),
                child: search(),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(child: child, opacity: animation);
                },
              )
            : AnimatedSwitcher(
                switchInCurve: Curves.easeInOut,
                switchOutCurve: Curves.easeInOut,
                duration: Duration(milliseconds: 300),
                child: Container(
                  child: feed(),
                ),
                transitionBuilder: (Widget child, Animation<double> animation) {
                  return FadeTransition(child: child, opacity: animation);
                },
              ));
  }
}

class DecoratedTabBar extends StatelessWidget implements PreferredSizeWidget {
  DecoratedTabBar({@required this.tabBar, @required this.decoration});

  final TabBar tabBar;
  final BoxDecoration decoration;

  @override
  Size get preferredSize => tabBar.preferredSize;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(child: Container(decoration: decoration)),
        tabBar,
      ],
    );
  }
}

class PopupMenu {
  static Widget settings = Container(
      child: Icon(Icons.notifications),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ));
  static Widget logout = Container(
      child: Icon(Icons.account_circle),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
      ));

  static List<Widget> choices = <Widget>[settings, logout];
}
