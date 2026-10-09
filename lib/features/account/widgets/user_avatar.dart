import 'package:ekp_api/ekp_api.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';

/// The user's photo, or their initials until (or unless) it loads.
class UserAvatar extends ConsumerWidget {
  const UserAvatar({super.key, required this.user, this.size = 64});

  final UserData? user;

  /// The circle's diameter.
  final double size;

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

    return CircleAvatar(
      radius: size / 2,
      backgroundColor: scheme.primaryContainer,
      // The fixed role: primary would vanish on the brand colour.
      foregroundColor: scheme.primaryFixed,
      foregroundImage: photo,
      // Unreachable or undecodable: the initials underneath stay visible.
      onForegroundImageError: photo == null ? null : (_, _) {},
      child: initials.isEmpty
          ? Icon(Symbols.person_rounded, size: size / 2)
          : Text(
              initials,
              style: theme.textTheme.titleLarge?.copyWith(
                color: scheme.primaryFixed,
                fontSize: (size * 0.36).roundToDouble(),
                height: 1,
              ),
            ),
    );
  }
}
