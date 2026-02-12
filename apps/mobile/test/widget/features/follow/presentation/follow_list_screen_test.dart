import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/follow/application/follow_list_notifier.dart';
import 'package:shelfie/features/follow/domain/follow_list_type.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';
import 'package:shelfie/features/follow/presentation/follow_list_screen.dart';

import '../../../../helpers/test_helpers.dart';

class FakeFollowListNotifier extends FollowListNotifier {
  AsyncValue<List<UserSummary>> _state = const AsyncLoading();
  bool loadInitialCalled = false;

  void setState(AsyncValue<List<UserSummary>> value) {
    _state = value;
    state = value;
  }

  @override
  AsyncValue<List<UserSummary>> build(int userId, FollowListType listType) {
    return _state;
  }

  @override
  Future<void> loadInitial() async {
    loadInitialCalled = true;
  }

  @override
  Future<void> loadMore() async {}
}

void main() {
  setUpAll(registerTestFallbackValues);

  late FakeFollowListNotifier fakeNotifier;

  setUp(() {
    fakeNotifier = FakeFollowListNotifier();
  });

  Widget buildSubject({
    int userId = 1,
    FollowListType listType = FollowListType.following,
  }) {
    return ProviderScope(
      overrides: [
        followListNotifierProvider(userId, listType)
            .overrideWith(() => fakeNotifier),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: FollowListScreen(userId: userId, listType: listType),
      ),
    );
  }

  group('FollowListScreen', () {
    testWidgets('フォロー中タイプのタイトルが表示される', (tester) async {
      fakeNotifier = FakeFollowListNotifier();
      await tester.pumpWidget(
        buildSubject(listType: FollowListType.following),
      );
      await tester.pump();

      expect(find.text('フォロー中'), findsOneWidget);
    });

    testWidgets('フォロワータイプのタイトルが表示される', (tester) async {
      fakeNotifier = FakeFollowListNotifier();
      await tester.pumpWidget(
        buildSubject(listType: FollowListType.followers),
      );
      await tester.pump();

      expect(find.text('フォロワー'), findsOneWidget);
    });

    testWidgets('ローディング中にインジケータが表示される', (tester) async {
      fakeNotifier = FakeFollowListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('ユーザー一覧が表示される', (tester) async {
      fakeNotifier = FakeFollowListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      fakeNotifier.setState(const AsyncData([
        UserSummary(id: 1, name: 'Alice', avatarUrl: null, handle: 'alice'),
        UserSummary(id: 2, name: 'Bob', avatarUrl: null, handle: 'bob'),
      ]));
      await tester.pump();

      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('@alice'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
      expect(find.text('@bob'), findsOneWidget);
    });

    testWidgets('エラー時にエラーメッセージとリトライが表示される', (tester) async {
      fakeNotifier = FakeFollowListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      fakeNotifier.setState(AsyncError('エラー', StackTrace.current));
      await tester.pump();

      expect(find.text('エラーが発生しました'), findsOneWidget);
      expect(find.text('再読み込み'), findsOneWidget);
    });

    testWidgets('空リストの場合に空状態メッセージが表示される', (tester) async {
      fakeNotifier = FakeFollowListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      fakeNotifier.setState(const AsyncData([]));
      await tester.pump();

      expect(find.textContaining('ユーザーはいません'), findsOneWidget);
    });
  });
}
