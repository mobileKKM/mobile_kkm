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

/// Lets the shapes of what is still loading breathe, and tells a screen
/// reader once what they stand for. Still where animations are switched off.
class SkeletonPulse extends StatefulWidget {
  const SkeletonPulse({super.key, required this.label, required this.child});

  /// Read out in place of the shapes.
  final String label;
  final Widget child;

  @override
  State<SkeletonPulse> createState() => _SkeletonPulseState();
}

class _SkeletonPulseState extends State<SkeletonPulse> with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(vsync: this, duration: const Duration(seconds: 1));
  late final Animation<double> _opacity = Tween<double>(
    begin: 1,
    end: 0.6,
  ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (MediaQuery.disableAnimationsOf(context)) {
      _controller
        ..stop()
        ..value = 0;
    } else if (!_controller.isAnimating) {
      _controller.repeat(reverse: true);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: widget.label,
      child: ExcludeSemantics(
        child: FadeTransition(opacity: _opacity, child: widget.child),
      ),
    );
  }
}
