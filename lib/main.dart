import 'package:candlestick_chart_local_json/api/chart_api.dart';
import 'package:candlestick_chart_local_json/models/chart_model.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late List<ChartModel> _chartData = [];
  late TrackballBehavior _trackballBehavior;

  @override
  void initState() {
    getData(context);
    _trackballBehavior = TrackballBehavior(
        enable: true, activationMode: ActivationMode.singleTap);
    super.initState();
  }

  void getData(BuildContext buildContext) async{
    _chartData = await ChartAPI.getChartDataLocally(buildContext);
  }

  @override
  Widget build(BuildContext context) {
    print(_chartData);
    return SafeArea(
      child: Scaffold(
        body: SfCartesianChart(
          title: ChartTitle(text: 'AAPL - 2016'),
          legend: Legend(isVisible: true),
          trackballBehavior: _trackballBehavior,
          series: <CandleSeries>[
            CandleSeries<ChartModel, DateTime>(
              dataSource: _chartData,
              name: 'AAPL',
              xValueMapper: (ChartModel chartModel, _) => chartModel.dateTime,
              lowValueMapper: (ChartModel chartModel, _) => chartModel.low,
              highValueMapper: (ChartModel chartModel, _) => chartModel.high,
              openValueMapper: (ChartModel chartModel, _) => chartModel.open,
              closeValueMapper: (ChartModel chartModel, _) => chartModel.close,
            )
          ],
          primaryXAxis: DateTimeAxis(
              dateFormat: DateFormat.MMM(),
              majorGridLines: MajorGridLines(width: 0)),
          primaryYAxis: NumericAxis(
            minimum: 70,
            maximum: 130,
            interval: 10,
            numberFormat: NumberFormat.simpleCurrency(decimalDigits: 0),
          ),
        ),
      ),
    );
  }
}
