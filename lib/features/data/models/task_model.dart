class TaskModel {
  late String id;
  late String title;
  late String description;
  late String status;
  late String category;
  late int statusColor;
  late int iconColor;
  late String icon;
  late int statusContainerColor;
  String? dateTime;

  TaskModel({
    required this.id,
    required this.title,
    required this.description,
    required this.status,
    required this.category,
    required this.statusColor,
    required this.iconColor,
    required this.icon,
    required this.statusContainerColor,
    this.dateTime,
  });

  TaskModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    description = json['description'];
    status = json['status'] ?? 'Pending';
    category = json['category'] ?? 'General';
    statusColor = json['statusColor'] ?? 0xFF000000;
    iconColor = json['iconColor'] ?? 0xFF000000;
    icon = json['icon'] ?? 'icon_home';
    statusContainerColor = json['statusContainerColor'] ?? 0xFFFFFFFF;
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'status': status,
      'category': category,
      'statusColor': statusColor,
      'iconColor': iconColor,
      'icon': icon,
      'statusContainerColor': statusContainerColor,
      'dateTime': dateTime,
    };
  }

  TaskModel copyWith({
    String? id,
    String? title,
    String? description,
    String? status,
    String? category,
    int? statusColor,
    int? iconColor,
    String? icon,
    int? statusContainerColor,
    String? dateTime,
  }) {
    return TaskModel(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      status: status ?? this.status,
      category: category ?? this.category,
      statusColor: statusColor ?? this.statusColor,
      iconColor: iconColor ?? this.iconColor,
      icon: icon ?? this.icon,
      statusContainerColor: statusContainerColor ?? this.statusContainerColor,
      dateTime: dateTime ?? this.dateTime,
    );
  }
}