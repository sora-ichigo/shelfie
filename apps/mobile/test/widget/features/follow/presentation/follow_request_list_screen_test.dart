import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/follow/application/follow_request_list_notifier.dart';
import 'package:shelfie/features/follow/domain/follow_request_model.dart';
import 'package:shelfie/features/follow/domain/follow_request_status.dart';
import 'package:shelfie/features/follow/domain/user_summary.dart';
import 'package:shelfie/features/follow/presentation/follow_request_list_screen.dart';

import '../../../../helpers/test_helpers.dart';

FollowRequestModel _createRequest({
  required int id,
  required String senderName,
  required String senderHandle,
}) {
  return FollowRequestModel(
    id: id,
    sender: UserSummary(
      id: id * 10,
      name: senderName,
      avatarUrl: null,
      handle: senderHandle,
    ),
    receiver: const UserSummary(
      id: 1,
      name: 'Me',
      avatarUrl: null,
      handle: 'me',
    ),
    status: FollowRequestStatus.pending,
    createdAt: DateTime(2026),
  );
}

class FakeFollowRequestListNotifier extends FollowRequestListNotifier {
  AsyncValue<List<FollowRequestModel>> _state = const AsyncLoading();
  bool loadInitialCalled = false;
  int? lastApprovedId;
  int? lastRejectedId;

  void setState(AsyncValue<List<FollowRequestModel>> value) {
    _state = value;
    state = value;
  }

  @override
  AsyncValue<List<FollowRequestModel>> build() {
    return _state;
  }

  @override
  Future<void> loadInitial() async {
    loadInitialCalled = true;
  }

  @override
  Future<void> loadMore() async {}

  @override
  Future<void> approve(int requestId) async {
    lastApprovedId = requestId;
  }

  @override
  Future<void> reject(int requestId) async {
    lastRejectedId = requestId;
  }
}

void main() {
  setUpAll(registerTestFallbackValues);

  late FakeFollowRequestListNotifier fakeNotifier;

  setUp(() {
    fakeNotifier = FakeFollowRequestListNotifier();
  });

  Widget buildSubject() {
    return ProviderScope(
      overrides: [
        followRequestListNotifierProvider
            .overrideWith(() => fakeNotifier),
      ],
      child: MaterialApp(
        theme: AppTheme.theme,
        home: const FollowRequestListScreen(),
      ),
    );
  }

  group('FollowRequestListScreen', () {
    testWidgets('AppBar にタイトルが表示される', (tester) async {
      fakeNotifier = FakeFollowRequestListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.text('フォローリクエスト'), findsOneWidget);
    });

    testWidgets('ローディング中にインジケータが表示される', (tester) async {
      fakeNotifier = FakeFollowRequestListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('リクエスト一覧にユーザー情報が表示される', (tester) async {
      fakeNotifier = FakeFollowRequestListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      fakeNotifier.setState(AsyncData([
        _createRequest(id: 1, senderName: 'Alice', senderHandle: 'alice'),
        _createRequest(id: 2, senderName: 'Bob', senderHandle: 'bob'),
      ]));
      await tester.pump();

      expect(find.text('Alice'), findsOneWidget);
      expect(find.text('@alice'), findsOneWidget);
      expect(find.text('Bob'), findsOneWidget);
      expect(find.text('@bob'), findsOneWidget);
    });

    testWidgets('各リクエストに承認ボタンと拒否ボタンが表示される', (tester) async {
      fakeNotifier = FakeFollowRequestListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      fakeNotifier.setState(AsyncData([
        _createRequest(id: 1, senderName: 'Alice', senderHandle: 'alice'),
      ]));
      await tester.pump();

      expect(find.text('承認'), findsOneWidget);
      expect(find.text('拒否'), findsOneWidget);
    });

    testWidgets('承認ボタンタップで approve が呼ばれる', (tester) async {
      fakeNotifier = FakeFollowRequestListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      fakeNotifier.setState(AsyncData([
        _createRequest(id: 42, senderName: 'Alice', senderHandle: 'alice'),
      ]));
      await tester.pump();

      await tester.tap(find.text('承認'));
      await tester.pump();

      expect(fakeNotifier.lastApprovedId, 42);
    });

    testWidgets('拒否ボタンタップで reject が呼ばれる', (tester) async {
      fakeNotifier = FakeFollowRequestListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      fakeNotifier.setState(AsyncData([
        _createRequest(id: 42, senderName: 'Alice', senderHandle: 'alice'),
      ]));
      await tester.pump();

      await tester.tap(find.text('拒否'));
      await tester.pump();

      expect(fakeNotifier.lastRejectedId, 42);
    });

    testWidgets('エラー時にエラーメッセージが表示される', (tester) async {
      fakeNotifier = FakeFollowRequestListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      fakeNotifier.setState(AsyncError('エラー', StackTrace.current));
      await tester.pump();

      expect(find.text('エラーが発生しました'), findsOneWidget);
    });

    testWidgets('空リストの場合に空状態メッセージが表示される', (tester) async {
      fakeNotifier = FakeFollowRequestListNotifier();
      await tester.pumpWidget(buildSubject());
      await tester.pump();

      fakeNotifier.setState(const AsyncData([]));
      await tester.pump();

      expect(find.text('フォローリクエストはありません'), findsOneWidget);
    });
  });
}
