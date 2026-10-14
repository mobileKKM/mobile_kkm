import 'dart:async';
import 'dart:math' as math;

import 'package:ekp_api/ekp_api.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_area.dart';
import 'package:mobile_kkm/core/widgets/code_screen/code_state.dart';
import 'package:mobile_kkm/core/widgets/code_screen/enlarged_code.dart';
import 'package:mobile_kkm/features/account/widgets/user_avatar.dart';

/// The screen someone else looks at: whose code it is (photo, name and
/// customer number, to compare with an identity document), what it is for
/// ([details]) and the code itself in its ring.
///
/// The header in the brand colour reaches down to the middle of the photo.
/// Its bar stays; everything under it is one scrolling body, which only
/// scrolls once the code is at its smallest: the photo keeps its size, the
/// code gives way first.
class CodeScreen extends StatelessWidget {
  const CodeScreen({
    super.key,
    required this.title,
    required this.user,
    required this.customerCode,
    required this.customerCodeLabel,
    required this.state,
    required this.codeLabel,
    required this.onRetry,
    this.details,
  });

  /// The photo with its ring, on every phone; [widePhotoSize] from
  /// [wideWidth] on.
  static const photoSize = 128.0;
  static const widePhotoSize = 152.0;
  static const wideWidth = 600.0;

  final String title;
  final UserData? user;
  final String? customerCode;
  final String customerCodeLabel;

  /// What the code area shows. The enlarged code listens to the same.
  final ValueListenable<CodeState> state;

  /// What a screen reader calls the code, given the time it has left.
  final String Function(String time) codeLabel;
  final VoidCallback onRetry;

  /// Between the customer number and the code, e.g. the ticket's facts.
  final Widget? details;

  String get _name => [user?.firstName, user?.lastName].whereType<String>().join(' ');

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final top = MediaQuery.viewPaddingOf(context).top;
    final photo = MediaQuery.sizeOf(context).width >= wideWidth ? widePhotoSize : photoSize;
    final name = _name;
    // A long name gets smaller letters, never an ellipsis.
    final long = name.characters.length > 24;
    final customerCode = this.customerCode;
    final details = this.details;

    final person = Stack(
      children: [
        // The header's lower part: it scrolls away with the photo.
        Positioned(
          top: 0,
          left: 0,
          right: 0,
          height: 8 + photo / 2,
          child: ColoredBox(color: scheme.primaryContainer),
        ),
        Container(
          // Centred across the screen, with or without details under it.
          width: double.infinity,
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: Column(
            children: [
              Container(
                key: const Key('code-photo'),
                width: photo,
                height: photo,
                padding: const EdgeInsets.all(4),
                decoration: BoxDecoration(color: scheme.surface, shape: BoxShape.circle),
                child: UserAvatar(
                  user: user,
                  size: photo - 8,
                  background: scheme.surfaceContainerHighest,
                  foreground: scheme.onSurfaceVariant,
                  fontSize: 44,
                ),
              ),
              if (name.isNotEmpty) ...[
                const SizedBox(height: 8),
                Text(
                  name,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontSize: long ? 20 : 24,
                    height: long ? 26 / 20 : 32 / 24,
                  ),
                ),
              ],
              if (customerCode != null) ...[
                const SizedBox(height: 4),
                Text(
                  customerCodeLabel,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelMedium?.copyWith(letterSpacing: 0.4, color: scheme.onSurfaceVariant),
                ),
                const SizedBox(height: 2),
                Text(
                  customerCode,
                  textAlign: TextAlign.center,
                  style: theme.textTheme.labelLarge?.copyWith(
                    fontSize: 16,
                    height: 22 / 16,
                    letterSpacing: 0.5,
                    fontFeatures: const [FontFeature.tabularFigures()],
                  ),
                ),
              ],
              if (details != null) ...[const SizedBox(height: 12), details],
            ],
          ),
        ),
      ],
    );

    return Scaffold(
      body: Column(
        children: [
          // The brand colour in both themes, so what lies on it does not
          // follow the theme either.
          AnnotatedRegion<SystemUiOverlayStyle>(
            value: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
              statusBarBrightness: Brightness.dark,
            ),
            child: ColoredBox(
              color: scheme.primaryContainer,
              child: Padding(
                padding: EdgeInsets.only(top: top),
                child: SizedBox(
                  height: 64,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4),
                    child: Row(
                      children: [
                        IconButton(
                          tooltip: MaterialLocalizations.of(context).closeButtonTooltip,
                          color: _onHeader,
                          icon: const Icon(Symbols.close_rounded),
                          onPressed: () => unawaited(Navigator.of(context).maybePop()),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Semantics(
                            header: true,
                            child: Text(
                              title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.titleLarge?.copyWith(color: _onHeader),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            child: SafeArea(
              top: false,
              child: LayoutBuilder(
                builder: (context, constraints) => SingleChildScrollView(
                  child: _FillRest(
                    viewport: constraints.maxHeight,
                    minRest: CodeArea.minHeight,
                    children: [
                      person,
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: ValueListenableBuilder(
                          valueListenable: state,
                          builder: (context, value, _) => CodeArea(
                            state: value,
                            label: codeLabel,
                            onRetry: onRetry,
                            onEnlarge: () => unawaited(
                              showEnlargedCode(context, state: state, name: name, customerCode: customerCode),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

const _onHeader = Color(0xFFFFFFFF);

/// Two children, one under the other: the first as tall as it is, the
/// second filling what is left of [viewport], but never less than
/// [minRest]. Inside a scroll view, so that the whole only scrolls once the
/// second is at its least.
///
/// A render object of its own because the second child lays itself out by
/// the room it gets, and so cannot be asked how tall it would like to be.
class _FillRest extends MultiChildRenderObjectWidget {
  const _FillRest({required this.viewport, required this.minRest, required super.children});

  final double viewport;
  final double minRest;

  @override
  RenderObject createRenderObject(BuildContext context) => _RenderFillRest(viewport, minRest);

  @override
  void updateRenderObject(BuildContext context, _RenderFillRest renderObject) {
    renderObject
      ..viewport = viewport
      ..minRest = minRest;
  }
}

class _FillRestParentData extends ContainerBoxParentData<RenderBox> {}

class _RenderFillRest extends RenderBox
    with
        ContainerRenderObjectMixin<RenderBox, _FillRestParentData>,
        RenderBoxContainerDefaultsMixin<RenderBox, _FillRestParentData> {
  _RenderFillRest(this._viewport, this._minRest);

  double _viewport;
  set viewport(double value) {
    if (value != _viewport) {
      _viewport = value;
      markNeedsLayout();
    }
  }

  double _minRest;
  set minRest(double value) {
    if (value != _minRest) {
      _minRest = value;
      markNeedsLayout();
    }
  }

  @override
  void setupParentData(RenderBox child) {
    if (child.parentData is! _FillRestParentData) {
      child.parentData = _FillRestParentData();
    }
  }

  @override
  void performLayout() {
    final width = constraints.maxWidth;
    final first = firstChild!;
    final rest = childAfter(first)!;
    first.layout(BoxConstraints.tightFor(width: width), parentUsesSize: true);
    final restHeight = math.max(_minRest, _viewport - first.size.height);
    rest.layout(BoxConstraints.tight(Size(width, restHeight)));
    (rest.parentData! as _FillRestParentData).offset = Offset(0, first.size.height);
    size = Size(width, first.size.height + restHeight);
  }

  @override
  void paint(PaintingContext context, Offset offset) => defaultPaint(context, offset);

  @override
  bool hitTestChildren(BoxHitTestResult result, {required Offset position}) =>
      defaultHitTestChildren(result, position: position);
}
