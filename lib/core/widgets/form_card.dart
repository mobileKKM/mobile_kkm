import 'package:material_ui/material_ui.dart';

/// One section of a form with several: a titled card around its fields.
class FormCard extends StatelessWidget {
  const FormCard({super.key, this.title, this.subtitle, required this.children});

  final String? title;
  final String? subtitle;
  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    // A Material, so that ink from what is inside is drawn on the card.
    return Material(
      color: scheme.surfaceContainerLow,
      borderRadius: BorderRadius.circular(28),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          spacing: 20,
          children: [
            if (title != null)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                spacing: 4,
                children: [
                  Semantics(
                    header: true,
                    child: Text(
                      title!,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontSize: 16,
                        height: 22 / 16,
                        color: scheme.primary,
                      ),
                    ),
                  ),
                  if (subtitle != null)
                    Text(
                      subtitle!,
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontSize: 13,
                        height: 18 / 13,
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                ],
              ),
            ...children,
          ],
        ),
      ),
    );
  }
}
