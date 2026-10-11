import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:material_ui/material_ui.dart';
import 'package:mobile_kkm/core/api/device_identity.dart';
import 'package:mobile_kkm/core/providers/ekp_providers.dart';
import 'package:mobile_kkm/core/providers/platform_providers.dart';
import 'package:mobile_kkm/core/widgets/icon_tile.dart';
import 'package:mobile_kkm/core/widgets/row_group.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// Switches for looking at how the server and the app behave. Hidden: opened
/// by tapping the version on Account.
class DebugScreen extends ConsumerStatefulWidget {
  const DebugScreen({super.key});

  @override
  ConsumerState<DebugScreen> createState() => _DebugScreenState();
}

class _DebugScreenState extends ConsumerState<DebugScreen> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _deviceId;
  late final TextEditingController _deviceName;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final device = ref.read(deviceIdentityProvider);
    _deviceId = TextEditingController(text: device.deviceId);
    _deviceName = TextEditingController(text: device.deviceName);
  }

  @override
  void dispose() {
    _deviceId.dispose();
    _deviceName.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    if (_saving || !_formKey.currentState!.validate()) {
      return;
    }
    setState(() => _saving = true);
    try {
      // With the real client this screen is gone right after: the app goes
      // through the splash again.
      await ref
          .read(deviceIdentityProvider.notifier)
          .change(deviceId: _deviceId.text.trim(), deviceName: _deviceName.text);
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final secure = ref.watch(screenSecurityEnabledProvider);
    void setSecure(bool enabled) => ref.read(screenSecurityEnabledProvider.notifier).set(enabled);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.debugTitle)),
      body: SafeArea(
        top: false,
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(16, 4, 16, 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              spacing: 16,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: Text(
                    l10n.debugIdentityHelp,
                    style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
                  ),
                ),
                TextFormField(
                  controller: _deviceId,
                  autocorrect: false,
                  enableSuggestions: false,
                  decoration: InputDecoration(
                    labelText: l10n.debugDeviceId,
                    suffixIcon: IconButton(
                      tooltip: l10n.debugGenerate,
                      icon: const Icon(Symbols.casino_rounded),
                      onPressed: () => _deviceId.text = generateDeviceId(),
                    ),
                  ),
                  validator: (value) => value?.trim().length == DeviceIdentityController.deviceIdLength
                      ? null
                      : l10n.debugDeviceIdInvalid(DeviceIdentityController.deviceIdLength),
                ),
                TextFormField(
                  controller: _deviceName,
                  autocorrect: false,
                  decoration: InputDecoration(labelText: l10n.debugDeviceName, helperText: l10n.debugDeviceNameHint),
                ),
                FilledButton(onPressed: _saving ? null : _save, child: Text(l10n.debugSave)),
                RowGroup(
                  children: [
                    GroupRow(
                      leading: const IconTile(Symbols.screenshot_rounded),
                      label: l10n.debugScreenSecurity,
                      subtitle: l10n.debugScreenSecurityHint,
                      showChevron: false,
                      trailing: Switch(value: secure, onChanged: setSecure),
                      onTap: () => setSecure(!secure),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
