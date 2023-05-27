import 'package:html/dom.dart' as dom;

typedef OnTap = void Function(
    String? url, Map<String, String> attributes, dom.Element? element);

class HtmlRenderProps {
  final OnTap? onLinkTap;

  HtmlRenderProps({this.onLinkTap});
}
