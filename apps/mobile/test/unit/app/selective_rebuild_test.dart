import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'selective_rebuild_test.g.dart';

/// Task 9.2: 状態変更による UI 再描画の最適化
///
/// このテストファイルは select 使用パターンを確立し、
/// 不要な再描画を防ぐためのベストプラクティスを示す。

/// テスト用のユーザー状態
class UserState {
  const UserState({
    required this.id,
    required this.name,
    required this.email,
    required this.avatarUrl,
  });

  final String id;
  final String name;
  final String email;
  final String avatarUrl;

  UserState copyWith({
    String? id,
    String? name,
    String? email,
    String? avatarUrl,
  }) {
    return UserState(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      avatarUrl: avatarUrl ?? this.avatarUrl,
    );
  }
}

/// テスト用のユーザー状態プロバイダ
@riverpod
class UserNotifier extends _$UserNotifier {
  @override
  UserState build() {
    return const UserState(
      id: '1',
      name: 'Test User',
      email: 'test@example.com',
      avatarUrl: 'https://example.com/avatar.png',
    );
  }

  void updateName(String name) {
    state = state.copyWith(name: name);
  }

  void updateEmail(String email) {
    state = state.copyWith(email: email);
  }

  void updateAvatar(String avatarUrl) {
    state = state.copyWith(avatarUrl: avatarUrl);
  }
}

void main() {
  group('Task 9.2: select 使用パターン', () {
    test('select を使用すると特定のフィールドのみを監視できること', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      var nameWatchCount = 0;

      // select を使用して name フィールドのみを監視
      container.listen(
        userNotifierProvider.select((state) => state.name),
        (previous, next) {
          nameWatchCount++;
        },
      );

      // name を更新 -> コールバックが呼ばれる
      container.read(userNotifierProvider.notifier).updateName('New Name');
      expect(nameWatchCount, equals(1));

      // email を更新 -> name は変わらないのでコールバックは呼ばれない
      container
          .read(userNotifierProvider.notifier)
          .updateEmail('new@example.com');
      expect(nameWatchCount, equals(1));

      // avatar を更新 -> name は変わらないのでコールバックは呼ばれない
      container.read(userNotifierProvider.notifier).updateAvatar(
            'https://example.com/new-avatar.png',
          );
      expect(nameWatchCount, equals(1));
    });

    test('select を使用しないと全ての変更でリビルドが発生すること', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      var watchCount = 0;

      // select を使用せずに全体を監視
      container.listen(
        userNotifierProvider,
        (previous, next) {
          watchCount++;
        },
      );

      // name を更新 -> コールバックが呼ばれる
      container.read(userNotifierProvider.notifier).updateName('New Name');
      expect(watchCount, equals(1));

      // email を更新 -> コールバックが呼ばれる
      container
          .read(userNotifierProvider.notifier)
          .updateEmail('new@example.com');
      expect(watchCount, equals(2));

      // avatar を更新 -> コールバックが呼ばれる
      container.read(userNotifierProvider.notifier).updateAvatar(
            'https://example.com/new-avatar.png',
          );
      expect(watchCount, equals(3));
    });

    test('複数フィールドの select で複合条件を監視できること', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      var watchCount = 0;

      // name と email の組み合わせを監視
      container.listen(
        userNotifierProvider.select((state) => (state.name, state.email)),
        (previous, next) {
          watchCount++;
        },
      );

      // name を更新 -> コールバックが呼ばれる
      container.read(userNotifierProvider.notifier).updateName('New Name');
      expect(watchCount, equals(1));

      // email を更新 -> コールバックが呼ばれる
      container
          .read(userNotifierProvider.notifier)
          .updateEmail('new@example.com');
      expect(watchCount, equals(2));

      // avatar を更新 -> name も email も変わらないのでコールバックは呼ばれない
      container.read(userNotifierProvider.notifier).updateAvatar(
            'https://example.com/new-avatar.png',
          );
      expect(watchCount, equals(2));
    });
  });

  group('Provider 依存関係の分離', () {
    test('独立した Provider は互いに影響を与えないこと', () {
      final counterAProvider = StateProvider<int>((ref) => 0);
      final counterBProvider = StateProvider<int>((ref) => 0);

      final container = ProviderContainer();
      addTearDown(container.dispose);

      var aWatchCount = 0;
      var bWatchCount = 0;

      container.listen(counterAProvider, (_, __) => aWatchCount++);
      container.listen(counterBProvider, (_, __) => bWatchCount++);

      // counterA を更新
      container.read(counterAProvider.notifier).state = 1;
      expect(aWatchCount, equals(1));
      expect(bWatchCount, equals(0));

      // counterB を更新
      container.read(counterBProvider.notifier).state = 1;
      expect(aWatchCount, equals(1));
      expect(bWatchCount, equals(1));
    });

    test('依存関係のある Provider は親の変更で更新されること', () {
      final baseProvider = StateProvider<int>((ref) => 1);
      final derivedProvider = Provider<int>((ref) {
        final base = ref.watch(baseProvider);
        return base * 2;
      });

      final container = ProviderContainer();
      addTearDown(container.dispose);

      // 初期値を確認
      expect(container.read(derivedProvider), equals(2));

      // base を更新
      container.read(baseProvider.notifier).state = 5;

      // derived も更新される
      expect(container.read(derivedProvider), equals(10));
    });
  });

  group('Consumer ウィジェットパターン', () {
    test('Consumer は ref.watch を使用して選択的リビルドを実現できること', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      // Consumer ウィジェットでの使用パターンをシミュレート
      //
      // Widget build(BuildContext context, WidgetRef ref) {
      //   // Bad: 全体を監視（不要なリビルドが発生）
      //   final user = ref.watch(userNotifierProvider);
      //
      //   // Good: 必要なフィールドのみを監視
      //   final name = ref.watch(userNotifierProvider.select((s) => s.name));
      //   final email = ref.watch(userNotifierProvider.select((s) => s.email));
      //
      //   return Text('$name ($email)');
      // }

      var nameWatchCount = 0;

      container.listen(
        userNotifierProvider.select((state) => state.name),
        (_, __) => nameWatchCount++,
      );

      // 表示に使用する name のみ更新された場合
      container.read(userNotifierProvider.notifier).updateName('Updated');
      expect(nameWatchCount, equals(1));

      // 表示に使用しない avatar が更新された場合
      container.read(userNotifierProvider.notifier).updateAvatar('new-url');
      expect(nameWatchCount, equals(1)); // リビルドなし
    });
  });
}
