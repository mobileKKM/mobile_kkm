import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';

/// The user's photo, or their initials until (or unless) it loads.
class UserAvatar extends ConsumerWidget {
  const UserAvatar({super.key, required this.user, this.size = 64, this.background, this.foreground, this.fontSize});

  final UserData? user;

  /// The circle's diameter.
  final double size;

  /// primaryContainer with primaryFixed on it unless given, as for an avatar
  /// that itself lies on the brand colour.
  final Color? background;
  final Color? foreground;

  /// Of the initials; a good third of [size] unless given.
  final double? fontSize;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final url = user?.photoUrl;
    final photo = url == null || url.isEmpty ? null : ref.watch(photoCacheProvider).image(url);
    final initials = [
      user?.firstName,
      user?.lastName,
    ].map((name) => name == null || name.isEmpty ? '' : name.characters.first.toUpperCase()).join();
    // The fixed role: primary would vanish on the brand colour.
    final foreground = this.foreground ?? scheme.primaryFixed;

    return ClipOval(
      child: SizedBox.square(
        dimension: size,
        child: Stack(
          fit: StackFit.expand,
          children: [
            ColoredBox(
              color: background ?? scheme.primaryContainer,
              child: Center(
                child: initials.isEmpty
                    ? Icon(Symbols.person_rounded, size: size / 2, color: foreground)
                    : Text(
                        initials,
                        maxLines: 1,
                        softWrap: false,
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: foreground,
                          fontSize: fontSize ?? (size * 0.36).roundToDouble(),
                          height: 1,
                        ),
                      ),
              ),
            ),
            if (photo != null)
              Image(
                image: photo,
                fit: BoxFit.cover,
                // Over the initials once it is there, so that nothing moves.
                frameBuilder: (context, child, frame, wasSynchronouslyLoaded) => wasSynchronouslyLoaded
                    ? child
                    : AnimatedOpacity(
                        opacity: frame == null ? 0 : 1,
                        duration: const Duration(milliseconds: 150),
                        child: child,
                      ),
                // Unreachable or undecodable: the initials underneath stay.
                errorBuilder: (context, error, stackTrace) => const SizedBox.shrink(),
              ),
          ],
        ),
      ),
    );
  }
}
