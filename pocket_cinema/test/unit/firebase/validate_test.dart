import 'package:flutter_test/flutter_test.dart';
import 'package:pocket_cinema/controller/validate.dart';
import 'package:pocket_cinema/controller/firestore_database.dart';
import 'package:mockito/mockito.dart';

class MockFirestoreDatabase extends Mock implements FirestoreDatabase {
  @override
  Future<bool> emailExists(String email) {
    return super.noSuchMethod(
      Invocation.method(#emailExists, [email]),
      returnValue: Future.value(false),
    );
  }
  @override
  Future<bool> usernameExists(String username) {
    return super.noSuchMethod(
      Invocation.method(#usernameExists, [username]),
      returnValue: Future.value(false),
    );
  }
}

void main() {
  group('Validate isEmail and listName', () {
    const email = 'john@gmail.com';
    test('valid list name', () {
      expect(Validate.listName(''), false);
      expect(Validate.listName('a'), false);
      expect(Validate.listName('ab'), true);

      const maxLengthName = 'abcdefghijklmnopqrst';
      expect(maxLengthName.length, 20);
      expect(Validate.listName(maxLengthName), true);
      expect(Validate.listName('abcdefghijklmnopqrstu'), false);
    });
    test('isEmail', () {
      expect(Validate.isEmail(email), true, reason: '$email is a valid email');
      expect(Validate.isEmail('john@gmail'), false, reason: 'john@gmail is not a valid email');
      expect(Validate.isEmail('invalid email'), false, reason: 'invalid email is not a valid email');
    });
  });
  group('Validate login and register', () {
    const validEmail = 'john@gmail.com';
    const invalidEmail = 'invalid email';
    const validUsername = 'username';
    const invalidUsername = 'invalid username';
    FirestoreDatabase mockFirestoreDatabase = MockFirestoreDatabase();

    setUp(() {
        mockFirestoreDatabase = MockFirestoreDatabase();
    });





    /*
    test('empty fields', () async {
      expect(() => Validate.login('', '', mockFirestoreDatabase), throwsException);
      expect(() => Validate.login('', 'password', mockFirestoreDatabase), throwsException);
      expect(() => Validate.login('username', '', mockFirestoreDatabase), throwsException);
    });
     */
    test('valid fields - exist in mock DB', () async {
      when(mockFirestoreDatabase.emailExists(validEmail)).thenAnswer((_) async => true);
      when(mockFirestoreDatabase.usernameExists(validUsername)).thenAnswer((_) async => true);
      expect(Validate.login(validEmail, 'password', mockFirestoreDatabase), completion(equals('')));
      expect(Validate.login(validUsername, 'password', mockFirestoreDatabase), completion(equals('')));
    });
    /*
    test('invalid fields - do not exist in mock DB', () async {
      when(mockFirestoreDatabase.emailExists(invalidEmail)).thenAnswer((_) async => false);
      when(mockFirestoreDatabase.usernameExists(invalidUsername)).thenAnswer((_) async => false);
      final a = await Validate.login(invalidEmail, 'password', mockFirestoreDatabase);
      expect(a, throwsA(isA<String>()));
      final b = await Validate.login(invalidUsername, 'password', mockFirestoreDatabase);
      expect(b, throwsA(isA<String>()));
    });
     */
  });
}
