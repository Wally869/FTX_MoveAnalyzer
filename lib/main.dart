import 'package:flutter/material.dart';

import 'simple.dart';
import 'package:tailwind_colors/tailwind_colors.dart';

import 'ftxQueryClasses.dart';
import 'ftxQuery.dart';

import 'ftxCharts.dart';

const colorBackgroundMarketReplay = const Color(0xFF181632);
const colorForegroundMarketReplay = const Color(0xFF282644);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FTX - Move Contracts Analyzer',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'FTX - Move Contracts Analyzer'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Future<ExpiredFutures> expiredFuturesData;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    expiredFuturesData = fetchExpiredContractsData();
  }

  void callRefresh() {
    print("refresh called");
  }

  @override
  Widget build(BuildContext context) {
    num widthWindow = MediaQuery.of(context).size.width;
    num heightWindow = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: TWColors.blue[100],
      body: Center(
        child: Container(
            width: (widthWindow > 1000)
                ? (widthWindow > 1500) ? 1000 : widthWindow * 0.65
                : widthWindow,
            height: (heightWindow > 750) ? heightWindow * 0.7 : double.infinity,
            padding: EdgeInsets.all(50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(10)),
              boxShadow: [
                BoxShadow(
                  spreadRadius: -3,
                  blurRadius: 10,
                  offset: Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              children: [
                ContainerHeader(
                  refreshFunction: callRefresh,
                ),
                Container(
                  // SEPERATOR
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    border: Border.all(color: TWColors.blue[700], width: 2.0),
                  ),
                ),
                ContainerDisplay(
                  expiredFuturesData: expiredFuturesData,
                ),
              ],
            )),
      ),
    );
  }
}

class ContainerHeader extends StatelessWidget {
  final refreshFunction;

  ContainerHeader({this.refreshFunction});

  @override
  Widget build(BuildContext context) {
    double titleFontSize = (MediaQuery.of(context).size.width > 1000) ? 36 : 20;

    return (MediaQuery.of(context).size.width > 500)
        ? Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "FTX Move\nAnalyzer",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontFamily: 'JetBrainsMono',
                  fontSize: titleFontSize,
                  color: TWColors.blue[700],
                ),
              ),
              Text("Placeholder prices"),
              RaisedButton(
                onPressed: () => refreshFunction(),
                child: Text("Refresh"),
              ),
            ],
          )
        : Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  Text(
                    "FTX Move\nAnalyzer",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: 'JetBrainsMono',
                      fontSize: titleFontSize,
                      color: TWColors.blue[700],
                    ),
                  ),
                  Container(
                    height: 10,
                  ),
                  Text("Placeholder prices"),
                  Container(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () => refreshFunction(),
                    child: Text("Refresh"),
                  ),
                ],
              ),
            ],
          );
  }
}

class ContainerDisplay extends StatefulWidget {
  Future<ExpiredFutures> expiredFuturesData;

  ContainerDisplay({Key key, @required this.expiredFuturesData})
      : super(key: key);

  @override
  _ContainerDisplayState createState() => _ContainerDisplayState();
}

class _ContainerDisplayState extends State<ContainerDisplay> {
  @override
  Widget build(BuildContext context) {
    double fontSize = (MediaQuery.of(context).size.width > 1000) ? 36 : 20;

    return (MediaQuery.of(context).size.width > 550)
        ? Expanded(
            child: Container(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Container(
                        height: 25,
                        child: RaisedButton(
                          onPressed: null,
                          child: Text("Button0"),
                        ),
                      ),
                      Container(
                        height: 25,
                        child: RaisedButton(
                          onPressed: null,
                          child: Text("Button0"),
                        ),
                      ),
                      Container(
                        height: 25,
                        child: RaisedButton(
                          onPressed: null,
                          child: Text("Button0"),
                        ),
                      ),
                      Container(
                        height: 25,
                        child: RaisedButton(
                          onPressed: null,
                          child: Text("Button0"),
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                  ),
                  Expanded(
                      /*
                    child: Container(
                      child: SimpleBarChart.withSampleData(),
                    ),
                    */
                      child: FutureBuilder<ExpiredFutures>(
                          future: widget.expiredFuturesData,
                          builder: (BuildContext context,
                              AsyncSnapshot<ExpiredFutures> snapshot) {
                            if (snapshot.hasData) {
                              //return SimpleBarChart.withSampleData();
                              return ftxHistogram(snapshot.data);
                            } else if (snapshot.hasError) {
                              return Text('Error: ${snapshot.error}');
                            } else {
                              return Column(
                                children: [
                                  SizedBox(
                                    child: CircularProgressIndicator(),
                                    width: 60,
                                    height: 60,
                                  ),
                                  const Padding(
                                    padding: EdgeInsets.only(top: 16),
                                    child: Text('Awaiting result...'),
                                  )
                                ],
                              );
                            }
                          })),
                ],
              ),
            ),
          )
        : Expanded(
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        onPressed: null,
                        child: Text("Button0"),
                      ),
                      RaisedButton(
                        onPressed: null,
                        child: Text("Button1"),
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      RaisedButton(
                        onPressed: null,
                        child: Text("Button2"),
                      ),
                      RaisedButton(
                        onPressed: null,
                        child: Text("Button3"),
                      ),
                    ],
                  ),
                  Container(
                    height: 25,
                  ),
                  Expanded(
                    child: Container(
                      height: MediaQuery.of(context).size.height * 0.5,
                      child: SimpleBarChart.withSampleData(),
                    ),
                  ),
                ],
              ),
            ),
          );
  }
}
