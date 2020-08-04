import 'dart:html';

import 'package:charts_flutter/flutter.dart' as charts;
import 'package:flutter/material.dart';

import 'package:tailwind_colors/tailwind_colors.dart';

import 'ftxQuery.dart';

import 'package:charts_flutter/src/text_element.dart' as chartsTextElement;
import 'package:charts_flutter/src/text_style.dart' as chartsTextStyle;

class HistogramContractDisplayData {
  final String day;
  final num price;

  HistogramContractDisplayData(this.day, this.price);
}

String pointerValue = "";

class CustomCircleSymbolRenderer extends charts.CircleSymbolRenderer {
  @override
  void paint(charts.ChartCanvas canvas, Rectangle<num> bounds,
      {List<int> dashPattern,
      charts.Color fillColor,
      charts.FillPatternType fillPattern,
      charts.Color strokeColor,
      double strokeWidthPx}) {
    super.paint(canvas, bounds,
        dashPattern: dashPattern,
        fillColor: charts.Color.white,
        fillPattern: charts.FillPatternType.solid,
        strokeColor: charts.Color.black,
        strokeWidthPx: 1);

    // Draw a bubble

    final num bubbleHight = 40;
    final num bubbleWidth = 120;
    final num bubbleRadius = bubbleHight / 2.0;
    final num bubbleBoundLeft = bounds.left;
    final num bubbleBoundTop = bounds.top - bubbleHight;

    canvas.drawRRect(
      Rectangle(bubbleBoundLeft, bubbleBoundTop, bubbleWidth, bubbleHight),
      fill: charts.Color.black,
      stroke: charts.Color.black,
      radius: bubbleRadius,
      roundTopLeft: true,
      roundBottomLeft: true,
      roundBottomRight: true,
      roundTopRight: true,
    );

    // Add text inside the bubble

    final textStyle = chartsTextStyle.TextStyle();
    textStyle.color = charts.Color.white;
    textStyle.fontSize = 12;

    final chartsTextElement.TextElement textElement =
        chartsTextElement.TextElement(pointerValue, style: textStyle);

    final num textElementBoundsLeft = ((bounds.left +
            (bubbleWidth - textElement.measurement.horizontalSliceWidth) / 2))
        .round();
    final num textElementBoundsTop = (bounds.top - 30).round();

    canvas.drawText(textElement, textElementBoundsLeft, textElementBoundsTop);
  }
}

class ftxHistogram extends StatelessWidget {
  final List<PrunedDataContract> dataContracts;
  final bool bIsPercent;
  ftxHistogram(this.dataContracts, this.bIsPercent); //, {this.animate});

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
        if (bIsPercent) {
          avgPrice += subsetContracts[idContract].expiryPrice /
              subsetContracts[idContract].underlyingPrice *
              100;
        } else {
          avgPrice += subsetContracts[idContract].expiryPrice;
        }
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
              displayData.price,
          colorFn: (_, __) =>
              charts.ColorUtil.fromDartColor(TWColors.blue[700]),
        ),
      ],
      animate: true,
      behaviors: [
        charts.LinePointHighlighter(
            symbolRenderer: CustomCircleSymbolRenderer()),
      ],
      selectionModels: [
        charts.SelectionModelConfig(
          changedListener: (charts.SelectionModel model) {
            if (model.hasDatumSelection)
              pointerValue = model.selectedSeries[0]
                  .measureFn(model.selectedDatum[0].index)
                  .toStringAsFixed(2) + ((bIsPercent) ? "\%" : "\$");
          },
        ),
      ],
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

    for (int idContract = 2; idContract < dataContracts.length; idContract++) {
      num expiryPrice = dataContracts[idContract].expiryPrice /
          dataContracts[idContract - 1].underlyingPrice *
          100;

      if (expiryPrice < 25) {
        data.add(
          new ScatterContractDisplayData(
              idContract,
              dataContracts[idContract].expiryPrice /
                  dataContracts[idContract - 1].underlyingPrice *
                  100),
        );
      }
    }

    // sort the datacontracts
    List<ScatterContractDisplayData> sortedContracts = data;
    sortedContracts.sort((a, b) => a.price.compareTo(b.price));
    num median = 0;
    for (int i = 0; i < sortedContracts.length; i++) {
      if (i > sortedContracts.length / 2) {
        median = sortedContracts[i].price;
        break;
      }
    }

    List<ScatterContractDisplayData> medianPoints =
        new List<ScatterContractDisplayData>();
    medianPoints.add(
      new ScatterContractDisplayData(
        0,
        median,
      ),
    );
    medianPoints.add(
      new ScatterContractDisplayData(
        data.length - 1,
        median,
      ),
    );

    List<ScatterContractDisplayData> exclusionLine =
        new List<ScatterContractDisplayData>();
    exclusionLine.add(
      new ScatterContractDisplayData(
        0,
        median * 3,
      ),
    );
    exclusionLine.add(
      new ScatterContractDisplayData(
        data.length - 1,
        median * 3,
      ),
    );

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
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(TWColors.blue[700]),
      ),
    );

    dataToDisplay.add(
      new charts.Series<ScatterContractDisplayData, int>(
        id: "Median",
        data: medianPoints,
        domainFn: (ScatterContractDisplayData displayData, _) =>
            displayData.idContract,
        measureFn: (ScatterContractDisplayData displayData, _) =>
            displayData.price,
        colorFn: (_, __) =>
            charts.ColorUtil.fromDartColor(TWColors.purple[700]),
      )..setAttribute(charts.rendererIdKey, 'customLine'),
    );

    dataToDisplay.add(
      new charts.Series<ScatterContractDisplayData, int>(
        id: "Median",
        data: exclusionLine,
        domainFn: (ScatterContractDisplayData displayData, _) =>
            displayData.idContract,
        measureFn: (ScatterContractDisplayData displayData, _) =>
            displayData.price,
        colorFn: (_, __) => charts.ColorUtil.fromDartColor(TWColors.red[700]),
      )..setAttribute(charts.rendererIdKey, 'customLine'),
    );

    return new charts.ScatterPlotChart(
      dataToDisplay,
      animate: true,
      defaultRenderer: new charts.PointRendererConfig(),
      // Custom renderer configuration for the line series.
      customSeriesRenderers: [
        new charts.LineRendererConfig(
            // ID used to link series to this renderer.
            customRendererId: 'customLine',
            // Configure the regression line to be painted above the points.
            //
            // By default, series drawn by the point renderer are painted on
            // top of those drawn by a line renderer.
            layoutPaintOrder: charts.LayoutViewPaintOrder.point + 1)
      ],
    );
  }
}
