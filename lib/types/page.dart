class PageModel {
  final String title;
  final String content;
  final String template;
  final dynamic pageTemplateConfig;
  final String slug;
  final String description;

  PageModel({
    required this.title,
    required this.content,
    required this.template,
    required this.pageTemplateConfig,
    required this.slug,
    required this.description,
  });

  PageModel.fromJson(Map<String, dynamic> json)
      : title = json['title'] ?? '',
        description = json['description'] ?? '',
        template = json['template'] ?? '',
        pageTemplateConfig = json['page_template_config'] ?? {},
        slug = json['slug'] ?? '',
        content = json['content'] ?? '';
}
