import 'dart:convert';

import 'package:flutter/cupertino.dart';

import '../models/chart_model.dart';

class ChartAPI {
  static Future<List<ChartModel>> getChartDataLocally(
      BuildContext buildContext) async {
    final assetBundle = DefaultAssetBundle.of(buildContext);
    final data =
        await assetBundle.loadString("assets/jsonFiles/chartData.json");
    final body = await json.decode(data);
    final chartData = await body.map<ChartModel>(ChartModel.fromJSON).toList();
    return chartData;
  }
}
