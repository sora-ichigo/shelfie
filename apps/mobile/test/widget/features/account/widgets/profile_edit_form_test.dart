import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/core/theme/app_theme.dart';
import 'package:shelfie/features/account/presentation/widgets/profile_edit_form.dart';

Widget buildForm({
  TextEditingController? nameController,
  TextEditingController? emailController,
  TextEditingController? handleController,
  TextEditingController? bioController,
  TextEditingController? instagramHandleController,
  ValueChanged<String>? onNameChanged,
  ValueChanged<String>? onHandleChanged,
  ValueChanged<String>? onBioChanged,
  ValueChanged<String>? onInstagramHandleChanged,
  String? nameError,
}) {
  return MaterialApp(
    theme: AppTheme.dark(),
    home: Scaffold(
      body: SingleChildScrollView(
        child: ProfileEditForm(
        nameController: nameController ?? TextEditingController(text: 'Test User'),
        emailController: emailController ?? TextEditingController(text: 'test@example.com'),
        handleController: handleController ?? TextEditingController(),
        bioController: bioController ?? TextEditingController(),
        instagramHandleController: instagramHandleController ?? TextEditingController(),
        onNameChanged: onNameChanged ?? (_) {},
        onHandleChanged: onHandleChanged ?? (_) {},
        onBioChanged: onBioChanged ?? (_) {},
        onInstagramHandleChanged: onInstagramHandleChanged ?? (_) {},
        nameError: nameError,
      ),
      ),
    ),
  );
}

void main() {
  group('ProfileEditForm', () {
    testWidgets('氏名入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(buildForm());
      expect(find.text('氏名'), findsOneWidget);
    });

    testWidgets('氏名の初期値が表示される', (tester) async {
      await tester.pumpWidget(buildForm());
      expect(find.text('Test User'), findsOneWidget);
    });

    testWidgets('メールアドレス入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(buildForm());
      expect(find.text('メールアドレス'), findsOneWidget);
    });

    testWidgets('メールアドレスの初期値が表示される', (tester) async {
      await tester.pumpWidget(buildForm());
      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('メールアドレス変更不可の注意書きが表示される', (tester) async {
      await tester.pumpWidget(buildForm());
      expect(find.text('アカウントのメールアドレスは変更できません'), findsOneWidget);
    });

    testWidgets('メールアドレスフィールドは編集不可', (tester) async {
      await tester.pumpWidget(buildForm());
      final emailField = tester.widget<TextField>(find.byType(TextField).last);
      expect(emailField.enabled, isFalse);
    });

    testWidgets('氏名のバリデーションエラーが表示される', (tester) async {
      await tester.pumpWidget(
        buildForm(
          nameController: TextEditingController(text: ''),
          nameError: '氏名を入力してください',
        ),
      );
      expect(find.text('氏名を入力してください'), findsOneWidget);
    });

    testWidgets('氏名入力時にコールバックが呼ばれる', (tester) async {
      String? changedValue;
      await tester.pumpWidget(
        buildForm(onNameChanged: (value) => changedValue = value),
      );
      await tester.enterText(find.byType(TextField).first, 'New Name');
      expect(changedValue, equals('New Name'));
    });

    testWidgets('ハンドル入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(buildForm());
      expect(find.text('ハンドル'), findsOneWidget);
    });

    testWidgets('自己紹介入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(buildForm());
      expect(find.text('自己紹介'), findsOneWidget);
    });

    testWidgets('Instagram入力フィールドが表示される', (tester) async {
      await tester.pumpWidget(buildForm());
      expect(find.text('Instagram'), findsOneWidget);
    });
  });
}
