
class NotificationModel {
  int? id;
  int? userId;
  String? name;
  String? username;
  int? relId;
  String? notificationType;
  String? content;
  String? title;
  String? isSeen;
  String? status;
  String? createdDate;

  NotificationModel(
      {this.id,
        this.userId,
        this.name,
        this.username,
        this.relId,
        this.notificationType,
        this.content,
        this.title,
        this.isSeen,
        this.status,
        this.createdDate});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    userId = json['user_id'];
    name = json['name'];
    username = json['username'];
    relId = json['rel_id'];
    notificationType = json['notification_type'];
    content = json['content'];
    title = json['title'];
    isSeen = json['is_seen'];
    status = json['status'];
    createdDate = json['created_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['user_id'] = userId;
    data['name'] = name;
    data['username'] = username;
    data['rel_id'] = relId;
    data['notification_type'] = notificationType;
    data['content'] = content;
    data['title'] = title;
    data['is_seen'] = isSeen;
    data['status'] = status;
    data['created_date'] = createdDate;
    return data;
  }
}


