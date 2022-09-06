class QrCodeModel {
  String type;
  String url;
  DateTime? time;

  QrCodeModel({
    required this.type,
    required this.url,
    required this.time,
  });

  factory QrCodeModel.fromJson(Map<String, dynamic> jsonData) {
    return QrCodeModel(
      type: jsonData['type'],
      url: jsonData['url'],
      time: jsonData['time'] == null ? null : DateTime.parse(jsonData["time"]),
    );
  }

  static Map<String, dynamic> toMap(QrCodeModel qr) => {
        'type': qr.type,
        'url': qr.url,
        // ignore: prefer_null_aware_operators
        'time': qr.time == null ? null : qr.time!.toIso8601String(),
      };
}
