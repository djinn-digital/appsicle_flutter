import 'package:appsicle_flutter/common.dart';
import 'package:appsicle_flutter/types/page.dart';
import 'package:appsicle_flutter/types/policy_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class PolicyComponent extends StatefulWidget {
  final String siteId;
  final String pageId;

  const PolicyComponent({Key? key, required this.siteId, required this.pageId})
      : super(key: key);

  @override
  _PolicyComponentState createState() => _PolicyComponentState();
}

class _PolicyComponentState extends State<PolicyComponent> {
  @override
  void initState() {
    super.initState();
  }

  Future<PageModel> _getPage() async {
    var data = await Network().getData(widget.siteId, widget.pageId);
    return PageModel.fromJson(data);
  }

  Widget renderSectionContent(PolicyPageSectionModel section, String index) {
    final int levels = index.split(".").length;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.only(left: 2),
          child: Text("$index. ${section.title}",
              style: Theme.of(context).textTheme.headline5!.copyWith(
                  fontSize:
                      getVariableForLevel(levels, [22.0, 20.0, 18.0, 16.0]))),
        ),
        Html(data: section.content),
        if (section.items.isNotEmpty)
          renderSectionContainer(section.items, parentIndex: index)
      ],
    );
  }

  Widget renderSectionContainer(List<PolicyPageSectionModel> sections,
      {String parentIndex = ''}) {
    final int levels = parentIndex.split(".").length;
    return Container(
        padding: EdgeInsets.only(
            left: (parentIndex == '')
                ? 0.0
                : getVariableForLevel(levels, [10.0, 10.0, 4])),
        child: Column(
            children: sections
                .map((PolicyPageSectionModel section) => renderSectionContent(
                      section,
                      getIndex(sections.indexOf(section), parentIndex),
                    ))
                .toList()));
  }

  String getIndex(int current, String parentInd) {
    if (parentInd == '') return (current + 1).toString();

    return "$parentInd.${(current + 1).toString()}";
  }

  dynamic getVariableForLevel(int level, List options) {
    if (options.length >= level - 1) return options[level - 1];
    return options[options.length];
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: FutureBuilder<PageModel>(
      future: _getPage(),
      builder: (BuildContext context, AsyncSnapshot<PageModel> snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const Text('Loading....');
          default:
            if (snapshot.hasError) {
              return Center(
                  child: Text('Failed to load page',
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline5));
            } else {
              final List<PolicyPageSectionModel> sections =
                  PolicyPageSectionModel.listFromJson(
                      snapshot.data!.pageTemplateConfig['sections']);

              final String? introHtml = snapshot.data?.content;

              return SingleChildScrollView(
                  child: Container(
                child: Column(children: [
                  if (introHtml != null)
                    Container(child: Html(data: introHtml)),
                  renderSectionContainer(sections, parentIndex: '')
                ]),
                padding: const EdgeInsets.all(5),
              ));
            }
        }
      },
    ));
  }
}
