class QrCodeModel {
  String type;
  String url;
  DateTime time;

  QrCodeModel({
    required this.type,
    required this.url,
    required this.time,
  });

  factory QrCodeModel.fromJson(Map<String, dynamic> jsonData) {
    return QrCodeModel(
      type: jsonData['type'],
      url: jsonData['url'],
      time: jsonData['time'],
    );
  }

  static Map<String, dynamic> toMap(QrCodeModel music) => {
    'type': music.type,
    'url': music.url,
    'time': music.time,
  };
}
