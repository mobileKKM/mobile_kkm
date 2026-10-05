import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/features/account/providers/user_data_provider.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Placeholder for the signed-in area.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final user = ref.watch(userDataProvider).value?.userData;
    return Scaffold(
      appBar: AppBar(title: const Text('mobileKKM')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (user != null) ...[
                Text(
                  [user.firstName, user.lastName].nonNulls.join(' '),
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                if (user.email != null) Text(user.email!, textAlign: TextAlign.center),
                const SizedBox(height: 24),
              ],
              Text(l10n.homePlaceholder, textAlign: TextAlign.center, style: Theme.of(context).textTheme.bodyLarge),
              const SizedBox(height: 24),
              OutlinedButton(onPressed: () => ref.read(ekpClientProvider).auth.logout(), child: Text(l10n.logout)),
            ],
          ),
        ),
      ),
    );
  }
}
