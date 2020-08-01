import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';
import 'package:ftx_move_display/ftxQueryClasses.dart';

import 'ftxQuery.dart';



class ftxHistogram extends StatefulWidget {
  final ExpiredFutures expFutures;
  final bool animate;
  ftxHistogram(this.expFutures, {this.animate});

  @override
  _ftxHistogramState createState() => new _ftxHistogramState(expFutures: expFutures);
}

class _ftxHistogramState extends State<ftxHistogram> {
  final ExpiredFutures expFutures;
  final bool animate;
  _ftxHistogramState({@required this.expFutures, this.animate = true});


  //final List<PrunedDataContract> dataContracts;

  //final List<PrunedDataContract> dataContracts;
  //final ExpiredFutures expFutures;


  //ftxHistogram(this.expFutures, {this.animate});

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }



  @override
  Widget build(BuildContext context) {
    List<PrunedDataContract> dataContracts = convertExpiredToPruned(widget.expFutures);
    List<ScatterplotContractDisplayData> data = new List<ScatterplotContractDisplayData>();


    for (int i = 1; i < weekDays.length; i++) {
      List<PrunedDataContract> subsetContracts = dataContracts.where((contract) => (contract.contractDay == weekDays[i])).toList();

      //num avgPrice = subsetContracts.map((contract) => contract.expiryPrice).reduce((a, b) => a + b) / subsetContracts.length;
      num avgPrice = 0;
      for (int idContract = 0; idContract < subsetContracts.length; idContract++) {
        //print(subsetContracts[i].expiryPrice);
        avgPrice += subsetContracts[idContract].expiryPrice;

      }
      avgPrice = avgPrice / subsetContracts.length;

      data.add(
        new ScatterplotContractDisplayData(weekDays[i], avgPrice)
      );
    }


    return new charts.BarChart(
      [new charts.Series<ScatterplotContractDisplayData, String>(id: "Average", data: data, domainFn: (ScatterplotContractDisplayData displayData, _) => displayData.day, measureFn: (ScatterplotContractDisplayData displayData, _) => displayData.price)],
      animate: widget.animate,
    );
  }


  
}


class ScatterplotContractDisplayData {
  final String day;
  final num price;

  ScatterplotContractDisplayData(this.day, this.price);
}
