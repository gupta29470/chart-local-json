class ChartModel {
  final dynamic dateTime;
  final dynamic open;
  final dynamic close;
  final dynamic low;
  final dynamic high;

  ChartModel({
    required this.dateTime,
    required this.open,
    required this.close,
    required this.low,
    required this.high,
  });

  static  ChartModel fromJSON(data) {
    return ChartModel(
      dateTime: DateTime.parse(data["dateTime"]),
      open: data["open"],
      close: data["close"],
      low: data["low"],
      high: data["high"],
    );
  }
}
