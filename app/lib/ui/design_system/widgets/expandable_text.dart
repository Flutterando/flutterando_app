import 'package:flutter/material.dart';

import '../constants/spaces.dart';
import '../theme/theme.dart';

class ExpandableTextFixed3Lines extends StatefulWidget {
  final String text;

  const ExpandableTextFixed3Lines(this.text, {Key? key}) : super(key: key);

  @override
  _ExpandableTextFixed3LinesState createState() =>
      _ExpandableTextFixed3LinesState();
}

class _ExpandableTextFixed3LinesState extends State<ExpandableTextFixed3Lines> {
  bool _isExpanded = false;
  bool _isOverflowing = false;

  static const int _lineLimit = 3;

  @override
  void initState() {
    super.initState();
    _isExpanded = false;
  }

  void _toggleExpanded() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        final textPainter = TextPainter(
          text: TextSpan(text: widget.text),
          maxLines: _lineLimit,
          textDirection: TextDirection.ltr,
        );

        textPainter.layout(maxWidth: constraints.maxWidth);
        _isOverflowing = textPainter.didExceedMaxLines;

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.text,
              style: context.theme.textStyles.bodyM14Bold.copyWith(
                fontWeight: FontWeight.w400,
              ),
              maxLines: _isExpanded ? null : _lineLimit,
              overflow:
                  _isExpanded ? TextOverflow.visible : TextOverflow.ellipsis,
            ),
            if (_isOverflowing) ...[
              const SizedBox(height: 10),
              GestureDetector(
                onTap: _toggleExpanded,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: Spaces.l,
                    vertical: (Spaces.m + 1) / 2,
                  ),
                  child: Text(_isExpanded ? 'Ver menos' : 'Ver mais'),
                  decoration: BoxDecoration(
                    border: Border.fromBorderSide(
                      BorderSide(
                        width: Spaces.xxs,
                        color: context.theme.colors.greyTwo,
                      ),
                    ),
                    borderRadius: BorderRadius.circular(Spaces.xl),
                  ),
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
