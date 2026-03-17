import 'package:fleetfill/core/localization/localization.dart';
import 'package:fleetfill/shared/widgets/widgets.dart';
import 'package:flutter/material.dart';

class RoleSelectionScreen extends StatelessWidget {
  const RoleSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.roleSelectionTitle,
      description: s.roleSelectionDescription,
      showSummary: false,
    );
  }
}

class LanguageSelectionScreen extends StatelessWidget {
  const LanguageSelectionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.languageSelectionTitle,
      description: s.languageSelectionDescription,
      showSummary: false,
    );
  }
}

class ProfileSetupScreen extends StatelessWidget {
  const ProfileSetupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.profileSetupTitle,
      description: s.profileSetupDescription,
      showSummary: false,
    );
  }
}

class PhoneCompletionScreen extends StatelessWidget {
  const PhoneCompletionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final s = S.of(context);

    return AppPlaceholderScreen(
      title: s.phoneCompletionTitle,
      description: s.phoneCompletionDescription,
      showSummary: false,
    );
  }
}
