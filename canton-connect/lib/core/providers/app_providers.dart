import 'package:provider/provider.dart';
import 'package:canton_connect/core/providers/language_provider.dart';

class AppProviders {
  static List<ChangeNotifierProvider> get providers => [
        ChangeNotifierProvider(create: (_) => LanguageProvider()),
      ];
}
