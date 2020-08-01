import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'ftxQuery.dart';

class HistogramContractDisplayData {
  final String day;
  final num price;

  HistogramContractDisplayData(this.day, this.price);
}

class ftxHistogram extends StatelessWidget {
  final List<PrunedDataContract> dataContracts;
  ftxHistogram(this.dataContracts); //, {this.animate});

  @override
  Widget build(BuildContext context) {
    List<HistogramContractDisplayData> data =
        new List<HistogramContractDisplayData>();

    for (int i = 1; i < weekDays.length; i++) {
      List<PrunedDataContract> subsetContracts = dataContracts
          .where((contract) => (contract.contractDay == weekDays[i]))
          .toList();

      //num avgPrice = subsetContracts.map((contract) => contract.expiryPrice).reduce((a, b) => a + b) / subsetContracts.length;
      num avgPrice = 0;
      for (int idContract = 0;
          idContract < subsetContracts.length;
          idContract++) {
        avgPrice += subsetContracts[idContract].expiryPrice;
      }
      avgPrice = avgPrice / subsetContracts.length;

      data.add(new HistogramContractDisplayData(weekDays[i], avgPrice));
    }

    return new charts.BarChart(
      [
        new charts.Series<HistogramContractDisplayData, String>(
            id: "Average",
            data: data,
            domainFn: (HistogramContractDisplayData displayData, _) =>
                displayData.day,
            measureFn: (HistogramContractDisplayData displayData, _) =>
                displayData.price)
      ],
      animate: true,
    );
  }
}

class ScatterContractDisplayData {
  final int idContract;
  final num price;
  final num radius = 5.0;

  ScatterContractDisplayData(this.idContract, this.price);
}

class ftxScatter extends StatelessWidget {
  final List<PrunedDataContract> dataContracts;
  ftxScatter(this.dataContracts); //, {this.animate});

  @override
  Widget build(BuildContext context) {
    List<ScatterContractDisplayData> data =
        new List<ScatterContractDisplayData>();

    for (int idContract = 0; idContract < dataContracts.length; idContract++) {
      data.add(new ScatterContractDisplayData(
          idContract, dataContracts[idContract].expiryPrice));
    }

    List<charts.Series<ScatterContractDisplayData, int>> dataToDisplay =
        new List<charts.Series<ScatterContractDisplayData, int>>();
    dataToDisplay.add(
      new charts.Series<ScatterContractDisplayData, int>(
        id: "Price",
        data: data,
        domainFn: (ScatterContractDisplayData displayData, _) =>
            displayData.idContract,
        measureFn: (ScatterContractDisplayData displayData, _) =>
            displayData.price,
        radiusPxFn: (ScatterContractDisplayData displayData, _) =>
            displayData.radius,
      ),
    );

    return new charts.ScatterPlotChart(
      dataToDisplay,
      animate: true,
    );
  }
}
