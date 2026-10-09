import 'package:material_ui/material_ui.dart';

class BrandHeader extends StatelessWidget {
  const BrandHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(4, 0, 4, 8),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child: Image.asset('assets/images/app_logo.png', width: 52, height: 52, excludeFromSemantics: true),
          ),
          const SizedBox(width: 14),
          // Scales down instead of overflowing at large text sizes.
          Flexible(
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: AlignmentDirectional.centerStart,
              child: Text(
                'mobileKKM',
                style: Theme.of(context).textTheme.headlineMedium
                    ?.copyWith(fontSize: 26, height: 32 / 26, fontWeight: FontWeight.w700),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
