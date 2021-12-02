import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';

class HtmlRenderProps {
  final void Function(String?, RenderContext, Map<String, String>, dynamic)?
      onLinkTap;

  HtmlRenderProps({this.onLinkTap});
}
