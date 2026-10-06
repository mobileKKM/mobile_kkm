import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:mobile_kkm/core/database/app_database.dart';

/// The on-device database, opened in `main()`.
final appDatabaseProvider = Provider<AppDatabase>((ref) => throw UnimplementedError('overridden in main()'));
