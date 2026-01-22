import 'package:flutter_test/flutter_test.dart';
import 'package:shelfie/features/book_search/domain/isbn_extractor.dart';

void main() {
  group('ISBNExtractor', () {
    group('extractISBN', () {
      test('extracts valid ISBN-13 from EAN-13 barcode', () {
        const barcode = '9784873115658';
        final result = ISBNExtractor.extractISBN(barcode);
        expect(result, '9784873115658');
      });

      test('extracts valid ISBN-10 from barcode', () {
        const barcode = '4873115655';
        final result = ISBNExtractor.extractISBN(barcode);
        expect(result, '4873115655');
      });

      test('returns null for non-ISBN barcode', () {
        const barcode = '1234567890123';
        final result = ISBNExtractor.extractISBN(barcode);
        expect(result, isNull);
      });

      test('returns null for empty string', () {
        const barcode = '';
        final result = ISBNExtractor.extractISBN(barcode);
        expect(result, isNull);
      });

      test('returns null for barcode with invalid length', () {
        const barcode = '12345';
        final result = ISBNExtractor.extractISBN(barcode);
        expect(result, isNull);
      });
    });

    group('isValidISBN13', () {
      test('returns true for valid ISBN-13 starting with 978', () {
        expect(ISBNExtractor.isValidISBN13('9784873115658'), isTrue);
      });

      test('returns true for valid ISBN-13 starting with 979', () {
        expect(ISBNExtractor.isValidISBN13('9791234567890'), isTrue);
      });

      test('returns false for ISBN-13 not starting with 978 or 979', () {
        expect(ISBNExtractor.isValidISBN13('1234567890123'), isFalse);
      });

      test('returns false for wrong length', () {
        expect(ISBNExtractor.isValidISBN13('978487311565'), isFalse);
      });
    });

    group('isValidISBN10', () {
      test('returns true for valid ISBN-10', () {
        expect(ISBNExtractor.isValidISBN10('4873115655'), isTrue);
      });

      test('returns true for ISBN-10 with X check digit', () {
        expect(ISBNExtractor.isValidISBN10('487311565X'), isTrue);
      });

      test('returns false for wrong length', () {
        expect(ISBNExtractor.isValidISBN10('48731156'), isFalse);
      });

      test('returns false for non-numeric characters', () {
        expect(ISBNExtractor.isValidISBN10('487311565A'), isFalse);
      });
    });

    group('formatISBN', () {
      test('formats ISBN-13 correctly', () {
        final formatted = ISBNExtractor.formatISBN('9784873115658');
        expect(formatted, '978-4-87311-565-8');
      });

      test('formats ISBN-10 correctly', () {
        final formatted = ISBNExtractor.formatISBN('4873115655');
        expect(formatted, '4-87311-565-5');
      });

      test('returns original if already formatted', () {
        final formatted = ISBNExtractor.formatISBN('978-4-87311-565-8');
        expect(formatted, '978-4-87311-565-8');
      });
    });
  });
}
