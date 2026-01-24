import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_edit_form.dart';

void main() {
  group('ProfileEditForm', () {
    testWidgets('氏名入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditForm(
              nameController: TextEditingController(text: 'Test User'),
              emailController: TextEditingController(text: 'test@example.com'),
              onNameChanged: (_) {},
              onEmailChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('氏名'), findsOneWidget);
    });

    testWidgets('氏名の初期値が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditForm(
              nameController: TextEditingController(text: 'Test User'),
              emailController: TextEditingController(text: 'test@example.com'),
              onNameChanged: (_) {},
              onEmailChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('Test User'), findsOneWidget);
    });

    testWidgets('メールアドレス入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditForm(
              nameController: TextEditingController(text: 'Test User'),
              emailController: TextEditingController(text: 'test@example.com'),
              onNameChanged: (_) {},
              onEmailChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('メールアドレス'), findsOneWidget);
    });

    testWidgets('メールアドレスの初期値が表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditForm(
              nameController: TextEditingController(text: 'Test User'),
              emailController: TextEditingController(text: 'test@example.com'),
              onNameChanged: (_) {},
              onEmailChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('メールアドレス変更の注意書きが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditForm(
              nameController: TextEditingController(text: 'Test User'),
              emailController: TextEditingController(text: 'test@example.com'),
              onNameChanged: (_) {},
              onEmailChanged: (_) {},
            ),
          ),
        ),
      );

      expect(find.textContaining('確認メール'), findsOneWidget);
    });

    testWidgets('氏名のバリデーションエラーが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditForm(
              nameController: TextEditingController(text: ''),
              emailController: TextEditingController(text: 'test@example.com'),
              onNameChanged: (_) {},
              onEmailChanged: (_) {},
              nameError: '氏名を入力してください',
            ),
          ),
        ),
      );

      expect(find.text('氏名を入力してください'), findsOneWidget);
    });

    testWidgets('メールアドレスのバリデーションエラーが表示される', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditForm(
              nameController: TextEditingController(text: 'Test User'),
              emailController: TextEditingController(text: 'invalid'),
              onNameChanged: (_) {},
              onEmailChanged: (_) {},
              emailError: '有効なメールアドレスを入力してください',
            ),
          ),
        ),
      );

      expect(find.text('有効なメールアドレスを入力してください'), findsOneWidget);
    });

    testWidgets('氏名入力時にコールバックが呼ばれる', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditForm(
              nameController: TextEditingController(text: 'Test User'),
              emailController: TextEditingController(text: 'test@example.com'),
              onNameChanged: (value) => changedValue = value,
              onEmailChanged: (_) {},
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).first, 'New Name');
      expect(changedValue, equals('New Name'));
    });

    testWidgets('メールアドレス入力時にコールバックが呼ばれる', (tester) async {
      String? changedValue;

      await tester.pumpWidget(
        MaterialApp(
          theme: AppTheme.dark(),
          home: Scaffold(
            body: ProfileEditForm(
              nameController: TextEditingController(text: 'Test User'),
              emailController: TextEditingController(text: 'test@example.com'),
              onNameChanged: (_) {},
              onEmailChanged: (value) => changedValue = value,
            ),
          ),
        ),
      );

      await tester.enterText(find.byType(TextField).last, 'new@example.com');
      expect(changedValue, equals('new@example.com'));
    });
  });
}
