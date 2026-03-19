import 'package:flutter/widgets.dart';

class AppFocusTraversal extends StatelessWidget {
  const AppFocusTraversal.form({required this.child, super.key})
    : debugLabel = 'form';

  const AppFocusTraversal.dialog({required this.child, super.key})
    : debugLabel = 'dialog';

  const AppFocusTraversal.sheet({required this.child, super.key})
    : debugLabel = 'sheet';

  const AppFocusTraversal.largeScreen({required this.child, super.key})
    : debugLabel = 'large-screen';

  final Widget child;
  final String debugLabel;

  @override
  Widget build(BuildContext context) {
    return FocusTraversalGroup(
      policy: OrderedTraversalPolicy(),
      child: child,
    );
  }
}
