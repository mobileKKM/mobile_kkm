import 'package:flutter/material.dart';
import 'package:mobile_kkm/features/auth/constants/information_obligation.dart';
import 'package:mobile_kkm/l10n/app_localizations.dart';

/// The data-protection notice, collapsed to its first lines until expanded.
class DataNotice extends StatefulWidget {
  const DataNotice({super.key});

  @override
  State<DataNotice> createState() => _DataNoticeState();
}

class _DataNoticeState extends State<DataNotice> {
  bool _expanded = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final theme = Theme.of(context);
    final style = theme.textTheme.bodySmall?.copyWith(color: theme.colorScheme.onSurfaceVariant);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.dataNoticeTitle, style: theme.textTheme.titleSmall),
        const SizedBox(height: 8),
        AnimatedSize(
          duration: const Duration(milliseconds: 200),
          alignment: Alignment.topCenter,
          child: _expanded
              ? Text(informationObligation, style: style)
              : ShaderMask(
                  blendMode: BlendMode.dstIn,
                  shaderCallback: (bounds) => const LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [Colors.black, Colors.transparent],
                  ).createShader(bounds),
                  child: Text(informationObligation, style: style, maxLines: 3, overflow: TextOverflow.clip),
                ),
        ),
        TextButton(
          style: TextButton.styleFrom(padding: EdgeInsets.zero),
          onPressed: () => setState(() => _expanded = !_expanded),
          child: Text(_expanded ? l10n.showLess : l10n.showMore),
        ),
      ],
    );
  }
}
