class DataListModel {
  final String? id;
  final String? title;
  final String? textDetails;

  DataListModel({
    this.id,
    this.title,
    this.textDetails,
  });

  factory DataListModel.fromJson(Map<String, dynamic> json, {String? id}) {
    return DataListModel(
      id: id,
      title: json['title'],
      textDetails: json['textDetails'],
    );
  }

  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['textDetails'] = textDetails;

    return data;
  }
}
