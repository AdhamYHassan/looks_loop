import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:looks_loop/core/theming/colors_manager.dart';

/// Localized "By continuing…" notice with underlined legal links.
/// The translation holds `{terms}` / `{privacy}` tokens, so each language
/// controls the word order.
class LoginTermsNotice extends StatelessWidget {
  const LoginTermsNotice({super.key});

  static final RegExp _token = RegExp(r'\{(terms|privacy)\}');

  List<InlineSpan> _buildSpans(TextStyle linkStyle) {
    final template = 'auth.terms_notice'.tr();
    final spans = <InlineSpan>[];
    var cursor = 0;

    for (final match in _token.allMatches(template)) {
      if (match.start > cursor) {
        spans.add(TextSpan(text: template.substring(cursor, match.start)));
      }
      spans.add(TextSpan(text: 'auth.${match.group(1)}'.tr(), style: linkStyle));
      cursor = match.end;
    }
    if (cursor < template.length) {
      spans.add(TextSpan(text: template.substring(cursor)));
    }
    return spans;
  }

  @override
  Widget build(BuildContext context) {
    final baseStyle = TextStyle(
      fontSize: 11.5.sp,
      height: 1.5,
      color: ColorManager.getTextMuted(context),
    );
    final linkStyle = baseStyle.copyWith(
      color: ColorManager.getText(context),
      fontWeight: FontWeight.w700,
      decoration: TextDecoration.underline,
    );

    return Text.rich(
      TextSpan(style: baseStyle, children: _buildSpans(linkStyle)),
      textAlign: TextAlign.center,
    );
  }
}
