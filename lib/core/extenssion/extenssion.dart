import 'package:flutter/cupertino.dart';

import '../../l10n/app_localizations.dart';

extension ContextExtenssion on BuildContext {
  AppLocalizations? get local => AppLocalizations.of(this);
}
