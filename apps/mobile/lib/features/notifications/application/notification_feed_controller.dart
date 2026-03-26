import 'package:fleetfill/features/notifications/domain/domain.dart';
import 'package:fleetfill/features/notifications/infrastructure/infrastructure.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final myNotificationsProvider =
    AsyncNotifierProvider<NotificationFeedController, NotificationFeedState>(
      NotificationFeedController.new,
    );

class NotificationFeedState {
  const NotificationFeedState({
    required this.items,
    required this.hasMore,
    this.isLoadingMore = false,
  });

  final List<AppNotificationRecord> items;
  final bool hasMore;
  final bool isLoadingMore;

  NotificationFeedState copyWith({
    List<AppNotificationRecord>? items,
    bool? hasMore,
    bool? isLoadingMore,
  }) {
    return NotificationFeedState(
      items: items ?? this.items,
      hasMore: hasMore ?? this.hasMore,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
    );
  }
}

class NotificationFeedController extends AsyncNotifier<NotificationFeedState> {
  @override
  Future<NotificationFeedState> build() => _fetchPage();

  Future<void> refresh() async {
    final current = state.asData?.value;
    if (current == null) {
      state = const AsyncLoading();
      state = await AsyncValue.guard(_fetchPage);
      return;
    }

    try {
      state = AsyncData(await _fetchPage());
    } on Object catch (error, stackTrace) {
      state = AsyncData(current);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<void> loadMore() async {
    final current = state.asData?.value;
    if (current == null || current.isLoadingMore || !current.hasMore) {
      return;
    }

    state = AsyncData(current.copyWith(isLoadingMore: true));

    try {
      final page = await ref
          .read(notificationRepositoryProvider)
          .fetchMyNotificationsPage(offset: current.items.length);
      state = AsyncData(
        NotificationFeedState(
          items: [...current.items, ...page.items],
          hasMore: page.hasMore,
        ),
      );
    } on Object catch (error, stackTrace) {
      state = AsyncData(current);
      Error.throwWithStackTrace(error, stackTrace);
    }
  }

  Future<NotificationFeedState> _fetchPage({int offset = 0}) async {
    final page = await ref
        .read(notificationRepositoryProvider)
        .fetchMyNotificationsPage(offset: offset);
    return NotificationFeedState(items: page.items, hasMore: page.hasMore);
  }
}
