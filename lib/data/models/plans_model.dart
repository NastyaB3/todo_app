import 'package:flutter/material.dart';

class PlansModel {
  String? id; // уникальный идентификатор элемента
  String? text;
  Importance? importance;
  DateTime? deadline; // int64, может отсутствовать, тогда нет
  bool? done;
  Color? color; // может отсутствовать
  DateTime? createdAt;
  DateTime? changedAt;
  String? lastUpdatedBy;

  PlansModel({
    this.id,
    this.text,
    this.importance,
    this.deadline,
    this.done,
    this.color,
    this.createdAt,
    this.changedAt,
    this.lastUpdatedBy,
  });

  PlansModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    text = json['text'];
    importance = json['importance'] != null
        ? Importance.fromJson(json['importance'])
        : null;
    deadline = json['deadline'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['deadline']).toLocal()
        : null;
    done = json['done'];
    color = json['color'];
    createdAt = json['created_at'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['created_at']).toLocal()
        : null;
    changedAt = json['changed_at'] != null
        ? DateTime.fromMillisecondsSinceEpoch(json['changed_at']).toLocal()
        : null;
    lastUpdatedBy = json['last_updated_by'];
  }
}

class Importance {
  String? low;
  String? basic;
  String? important;

  Importance({this.low, this.basic, this.important});

  Importance.fromJson(Map<String, dynamic> json) {
    low = json['low'];
    basic = json['basic'];
    important = json['important'];
  }
}
