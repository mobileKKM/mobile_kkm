import 'package:material_ui/material_ui.dart';

/// A grey bar in the place of content that is still loading.
class SkeletonBox extends StatelessWidget {
  const SkeletonBox({super.key, this.width, required this.height, this.radius});

  final double? width;
  final double height;

  /// Half the height unless given.
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(radius ?? height / 2),
      ),
    );
  }
}
