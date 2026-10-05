import 'package:material_ui/material_ui.dart';

/// Scrollable, width-constrained page used by the secondary auth screens.
class AuthPage extends StatelessWidget {
  const AuthPage({super.key, required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(constraints: const BoxConstraints(maxWidth: 480), child: child),
          ),
        ),
      ),
    );
  }
}
