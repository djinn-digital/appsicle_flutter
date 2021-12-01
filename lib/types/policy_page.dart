class PolicyPageSectionModel {
  final String title;
  final String content;
  final String description;
  final List<PolicyPageSectionModel> items;

  PolicyPageSectionModel({
    required this.title,
    required this.content,
    required this.items,
    required this.description,
  });

  PolicyPageSectionModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        description = json['description'] ?? '',
        content = json['content'] ?? '',
        items = json['items'] != null
            ? PolicyPageSectionModel.listFromJson(json['items'])
            : [];

  static List<PolicyPageSectionModel> listFromJson(List<dynamic> json) {
    return json.isEmpty
        ? []
        : json.map((value) => PolicyPageSectionModel.fromJson(value)).toList();
  }
}
