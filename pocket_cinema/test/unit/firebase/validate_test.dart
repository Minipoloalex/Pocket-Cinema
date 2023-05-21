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
    const password = 'password';
    FirestoreDatabase mockFirestoreDatabase = MockFirestoreDatabase();

    setUp(() {
        mockFirestoreDatabase = MockFirestoreDatabase();
    });

    test('login empty fields', () async {
      expect(() => Validate.login('', '', mockFirestoreDatabase), throwsA(isA<String>()));
      expect(() => Validate.login('', 'password', mockFirestoreDatabase), throwsA(isA<String>()));
      expect(() => Validate.login('username', '', mockFirestoreDatabase), throwsA(isA<String>()));
    });
    test('valid login fields - exist in mock DB', () async {
      when(mockFirestoreDatabase.emailExists(validEmail)).thenAnswer((_) async => true);
      when(mockFirestoreDatabase.usernameExists(validUsername)).thenAnswer((_) async => true);
      expect(Validate.login(validEmail, 'password', mockFirestoreDatabase), completion(equals('')));
      expect(Validate.login(validUsername, 'password', mockFirestoreDatabase), completion(equals('')));
    });
    test('register fields - do not exist in mock DB', () async {
      when(mockFirestoreDatabase.emailExists(validEmail)).thenAnswer((_) async => false);
      when(mockFirestoreDatabase.usernameExists(validUsername)).thenAnswer((_) async => false);

      expect(Validate.register(validUsername, validEmail, password, password, mockFirestoreDatabase), completion(equals('')));

      expect(Validate.register(validUsername, validEmail, password, '', mockFirestoreDatabase), throwsA(isA<String>()));
      expect(Validate.register(validUsername, validEmail, '', '', mockFirestoreDatabase), throwsA(isA<String>()));
    });
    test('invalid fields - do not exist in mock DB', () async {
      when(mockFirestoreDatabase.emailExists(invalidEmail)).thenAnswer((_) async => false);
      when(mockFirestoreDatabase.usernameExists(invalidUsername)).thenAnswer((_) async => false);

      expect(() => Validate.login(invalidUsername, 'password', mockFirestoreDatabase), throwsA(isA<String>()));
    });
  });
}
