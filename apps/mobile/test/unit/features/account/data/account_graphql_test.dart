import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/account/data/__generated__/get_my_profile.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/get_my_profile.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/update_profile.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/update_profile.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/update_profile.var.gql.dart';
import 'package:shelfie/features/account/data/__generated__/request_email_change.data.gql.dart';
import 'package:shelfie/features/account/data/__generated__/request_email_change.req.gql.dart';
import 'package:shelfie/features/account/data/__generated__/request_email_change.var.gql.dart';

void main() {
  group('Account GraphQL Operations', () {
    group('GetMyProfile query', () {
      test('GGetMyProfileReq should be generated', () {
        final request = GGetMyProfileReq();
        expect(request, isA<GGetMyProfileReq>());
      });

      test('GGetMyProfileData should have me field', () {
        expect(GGetMyProfileData, isNotNull);
      });
    });

    group('UpdateProfile mutation', () {
      test('GUpdateProfileReq should be generated with name input', () {
        final request = GUpdateProfileReq(
          (b) => b..vars.input.name = 'Test Name',
        );
        expect(request, isA<GUpdateProfileReq>());
        expect(request.vars.input.name, equals('Test Name'));
      });

      test('GUpdateProfileVars should have input field', () {
        final vars = GUpdateProfileVars(
          (b) => b..input.name = 'Test Name',
        );
        expect(vars.input.name, equals('Test Name'));
      });

      test('GUpdateProfileData should be generated', () {
        expect(GUpdateProfileData, isNotNull);
      });
    });

    group('RequestEmailChange mutation', () {
      test('GRequestEmailChangeReq should be generated with newEmail input', () {
        final request = GRequestEmailChangeReq(
          (b) => b..vars.input.newEmail = 'new@example.com',
        );
        expect(request, isA<GRequestEmailChangeReq>());
        expect(request.vars.input.newEmail, equals('new@example.com'));
      });

      test('GRequestEmailChangeVars should have input field', () {
        final vars = GRequestEmailChangeVars(
          (b) => b..input.newEmail = 'new@example.com',
        );
        expect(vars.input.newEmail, equals('new@example.com'));
      });

      test('GRequestEmailChangeData should be generated', () {
        expect(GRequestEmailChangeData, isNotNull);
      });
    });
  });
}
