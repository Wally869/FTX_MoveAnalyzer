import 'package:flutter/material.dart';

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
  Future<MoveResult> moveContractdata;

  @override
  void initState() {
    super.initState();
    expiredFuturesData = fetchExpiredContractsData();
    moveContractdata = fetchMoveData();
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
                  moveData: moveContractdata,
                  refreshFunction: callRefresh,
                ),
                Container(
                  // SEPERATOR
                  margin: EdgeInsets.all(30),
                  decoration: BoxDecoration(
                    border: Border.all(color: TWColors.blue[700], width: 2.0),
                  ),
                ),
                Container(
                  /*
                    child: Container(
                      child: SimpleBarChart.withSampleData(),
                    ),
                    */
                  child: FutureBuilder<ExpiredFutures>(
                    future: expiredFuturesData,
                    builder: (BuildContext context,
                        AsyncSnapshot<ExpiredFutures> snapshot) {
                      if (snapshot.hasData) {
                        //return SimpleBarChart.withSampleData();
                        return ContainerDisplay(
                          expiredFuturesData: snapshot.data,
                        );
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
                    },
                  ),
                ),
              ],
            )),
      ),
    );
  }
}

class ContainerHeaderDataDisplay extends StatelessWidget {
  final String title;
  final String value;

  ContainerHeaderDataDisplay(this.title, this.value);

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        Text(
          title,
          style: TextStyle(
            color: TWColors.blue[500],
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          value + "\$",
          style: TextStyle(
            color: TWColors.blue[700],
            fontWeight: FontWeight.bold,
            fontSize: 24.0,
          ),
        ),
      ],
    );
  }
}

class ContainerHeader extends StatelessWidget {
  Future<MoveResult> moveData;
  final refreshFunction;

  ContainerHeader({this.moveData, this.refreshFunction});

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
              Expanded(
                child: FutureBuilder<MoveResult>(
                  future: moveData,
                  builder: (BuildContext context,
                      AsyncSnapshot<MoveResult> snapshot) {
                    if (snapshot.hasData) {
                      //return SimpleBarChart.withSampleData();
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ContainerHeaderDataDisplay(
                            snapshot.data.name,
                            snapshot.data.last.toString(),
                          ),
                          ContainerHeaderDataDisplay(
                            "BTC-PERP",
                            snapshot.data.index.toString().split(".")[0],
                          ),
                        ],
                      );
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
                            child: Text('Fetching Data...'),
                          )
                        ],
                      );
                    }
                  },
                ),
              ),
              RaisedButton(
                onPressed: () => refreshFunction(),
                child: Text(
                  "Refresh",
                  style: TextStyle(
                    color: TWColors.blue[700],
                    fontWeight: FontWeight.bold,
                  ),
                ),
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
                  FutureBuilder<MoveResult>(
                    future: moveData,
                    builder: (BuildContext context,
                        AsyncSnapshot<MoveResult> snapshot) {
                      if (snapshot.hasData) {
                        //return SimpleBarChart.withSampleData();
                        return Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            ContainerHeaderDataDisplay(
                              snapshot.data.name,
                              snapshot.data.last.toString(),
                            ),
                            ContainerHeaderDataDisplay(
                              "BTC-PERP",
                              snapshot.data.index.toString().split(".")[0],
                            ),
                          ],
                        );
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
                              child: Text('Fetching Data...'),
                            )
                          ],
                        );
                      }
                    },
                  ),
                  Container(
                    height: 10,
                  ),
                  RaisedButton(
                    onPressed: () => refreshFunction(),
                    child: Text(
                      "Refresh",
                      style: TextStyle(
                        color: TWColors.blue[700],
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
  }
}

enum TypeChart { averageDollar, averagePercent, confidenceIntervals }

class ContainerDisplay extends StatefulWidget {
  final ExpiredFutures expiredFuturesData;

  ContainerDisplay({Key key, @required this.expiredFuturesData})
      : super(key: key);

  @override
  _ContainerDisplayState createState() =>
      _ContainerDisplayState(expiredFuturesData);
}

class _ContainerDisplayState extends State<ContainerDisplay> {
  final ExpiredFutures expiredFuturesData;

  _ContainerDisplayState(this.expiredFuturesData);

  TypeChart typeChart;
  List<PrunedDataContract> prunedData;
  @override
  void initState() {
    super.initState();
    typeChart = TypeChart.averageDollar;
    prunedData = convertExpiredToPruned(expiredFuturesData);
  }

  void changeTypeChart(TypeChart newTypeChart) {
    if (newTypeChart != typeChart) {
      typeChart = newTypeChart;
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    //double fontSize = (MediaQuery.of(context).size.width > 1000) ? 36 : 20;
    Widget displayChart = (typeChart == TypeChart.averageDollar)
        ? ftxHistogram(prunedData, false)
        : (typeChart == TypeChart.averagePercent)
            ? ftxHistogram(prunedData, true)
            : ftxScatter(prunedData);

    TextStyle selectedButtonStyle =
        TextStyle(color: Colors.white, fontWeight: FontWeight.bold);
    TextStyle unselectedButtonStyle =
        TextStyle(color: TWColors.blue[700], fontWeight: FontWeight.bold);

    return (MediaQuery.of(context).size.width > 550)
        ? Expanded(
            child: Container(
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 50,
                        width: 150,
                        child: RaisedButton(
                          onPressed: () => changeTypeChart(
                            TypeChart.averageDollar,
                          ),
                          child: Text(
                            "Avg. \$",
                            style: (typeChart == TypeChart.averageDollar)
                                ? selectedButtonStyle
                                : unselectedButtonStyle,
                          ),
                          color: (typeChart == TypeChart.averageDollar)
                              ? TWColors.blue[700]
                              : Colors.grey[300],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: RaisedButton(
                          onPressed: () => changeTypeChart(
                            TypeChart.averagePercent,
                          ),
                          child: Text(
                            "Avg. %",
                            style: (typeChart == TypeChart.averagePercent)
                                ? selectedButtonStyle
                                : unselectedButtonStyle,
                          ),
                          color: (typeChart == TypeChart.averagePercent)
                              ? TWColors.blue[700]
                              : Colors.grey[300],
                        ),
                      ),
                      Container(
                        height: 50,
                        width: 150,
                        child: RaisedButton(
                          onPressed: () => changeTypeChart(
                            TypeChart.confidenceIntervals,
                          ),
                          child: Text(
                            "Conf. Interv.",
                            style: (typeChart == TypeChart.confidenceIntervals)
                                ? selectedButtonStyle
                                : unselectedButtonStyle,
                          ),
                          color: (typeChart == TypeChart.confidenceIntervals)
                              ? TWColors.blue[700]
                              : Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  Container(
                    width: 50,
                  ),
                  Expanded(
                    child: displayChart,
                  ),
                ],
              ),
            ),
          )
        : Expanded(
            child: Container(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        width: 70,
                        child: RaisedButton(
                          onPressed: () => changeTypeChart(
                            TypeChart.averageDollar,
                          ),
                          child: Text(
                            "Avg. \$",
                            style: (typeChart == TypeChart.averageDollar)
                                ? selectedButtonStyle
                                : unselectedButtonStyle,
                          ),
                          color: (typeChart == TypeChart.averageDollar)
                              ? TWColors.blue[700]
                              : Colors.grey[300],
                        ),
                      ),
                      Container(
                        width: 70,
                        child: RaisedButton(
                          onPressed: () => changeTypeChart(
                            TypeChart.averagePercent,
                          ),
                          child: Text(
                            "Avg. %",
                            style: (typeChart == TypeChart.averagePercent)
                                ? selectedButtonStyle
                                : unselectedButtonStyle,
                          ),
                          color: (typeChart == TypeChart.averagePercent)
                              ? TWColors.blue[700]
                              : Colors.grey[300],
                        ),
                      ),
                      Container(
                        width: 70,
                        child: RaisedButton(
                          onPressed: () => changeTypeChart(
                            TypeChart.confidenceIntervals,
                          ),
                          child: Text(
                            "Conf. Interv.",
                            style: (typeChart == TypeChart.confidenceIntervals)
                                ? selectedButtonStyle
                                : unselectedButtonStyle,
                          ),
                          color: (typeChart == TypeChart.confidenceIntervals)
                              ? TWColors.blue[700]
                              : Colors.grey[300],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    child: displayChart,
                  ),
                ],
              ),
            ),
          );
  }
}
