class InboxModel {
  bool? success;
  InboxDataList? data;

  InboxModel({this.success, this.data});

  factory InboxModel.fromJson(Map<String, dynamic> json) => InboxModel(
      success: json['success'],
      data: json['data'] != null ? InboxDataList.fromJson(json['data']) : null);
}

class InboxDataList {
  List<DataList>? inboxData;
  InboxPagination? inboxPagination;

  InboxDataList({this.inboxData, this.inboxPagination});

  factory InboxDataList.fromJson(Map<String, dynamic> json) => InboxDataList(
        inboxData: json['data'] != null
            ? List<DataList>.from(json['data'].map((x) => DataList.fromJson(x)))
            : null,
        inboxPagination: json['pagination'] != null
            ? InboxPagination.fromJson(json['pagination'])
            : null,
      );
}

class DataList {
  int? id;
  String? title;
  String? message;
  String? image;
  String? date;

  DataList({this.id, this.title, this.message, this.image, this.date});

  factory DataList.fromJson(Map<String, dynamic> json) => DataList(
        id: json['id'],
        title: json['title'],
        message: json['message'],
        image: json['image'],
        date: json['date'],
      );
}

class InboxPagination {
  int? total;
  int? count;
  int? perPage;
  int? currentPage;
  int? totalPage;

  InboxPagination(
      {this.total, this.count, this.perPage, this.currentPage, this.totalPage});

  factory InboxPagination.fromJson(Map<String, dynamic> json) =>
      InboxPagination(
        total: json['total'],
        count: json['count'],
        perPage: json['perPage'],
        currentPage: json['currentPage'],
        totalPage: json['totalPage'],
      );
}
