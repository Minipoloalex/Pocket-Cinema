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
    const email = 'john@gmail.com';
    const username = 'username';
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
      when(mockFirestoreDatabase.emailExists(email)).thenAnswer((_) async => true);
      when(mockFirestoreDatabase.usernameExists(username)).thenAnswer((_) async => true);
      expect(Validate.login(email, 'password', mockFirestoreDatabase), completion(equals('')));
      expect(Validate.login(username, 'password', mockFirestoreDatabase), completion(equals('')));
    });
    test('invalid login fields - do not exist in mock DB', () async {
      when(mockFirestoreDatabase.emailExists(email)).thenAnswer((_) async => false);
      when(mockFirestoreDatabase.usernameExists(username)).thenAnswer((_) async => false);
      expect(() => Validate.login(email, 'password', mockFirestoreDatabase), throwsA(isA<String>()));
      expect(() => Validate.login(username, 'password', mockFirestoreDatabase), throwsA(isA<String>()));
    });
    test('register fields - do not exist in mock DB', () async {
      when(mockFirestoreDatabase.emailExists(email)).thenAnswer((_) async => false);
      when(mockFirestoreDatabase.usernameExists(username)).thenAnswer((_) async => false);

      expect(Validate.register(username, email, password, password, mockFirestoreDatabase), completion(equals('')));

      expect(Validate.register(username, email, password, '', mockFirestoreDatabase), throwsA(isA<String>()));
      expect(Validate.register(username, email, '', '', mockFirestoreDatabase), throwsA(isA<String>()));
    });
    test('invalid register fields - empty', () async {
      when(mockFirestoreDatabase.emailExists(email)).thenAnswer((_) async => false);
      when(mockFirestoreDatabase.usernameExists(username)).thenAnswer((_) async => false);

      expect(() => Validate.register('', email, password, password, mockFirestoreDatabase), throwsA(isA<String>()));
      expect(() => Validate.register(username, '', password, password, mockFirestoreDatabase), throwsA(isA<String>()));
      expect(() => Validate.register(username, email, '', password, mockFirestoreDatabase), throwsA(isA<String>()));
      expect(() => Validate.register(username, email, password, '', mockFirestoreDatabase), throwsA(isA<String>()));
      expect(() => Validate.register(username, email, password, "not the same password", mockFirestoreDatabase), throwsA(isA<String>()));
      expect(() => Validate.register(username, email, '', '', mockFirestoreDatabase), throwsA(isA<String>()));
    });
    test('invalid register fields - username exist in mock DB', () async {
      when(mockFirestoreDatabase.emailExists(email)).thenAnswer((_) async => false);
      when(mockFirestoreDatabase.usernameExists(username)).thenAnswer((_) async => true);
      const smallPassword = 'small';
      expect(() => Validate.register(username, email, password, password, mockFirestoreDatabase), throwsA(isA<String>()));
      expect(() => Validate.register(username, email, smallPassword, smallPassword, mockFirestoreDatabase), throwsA(isA<String>()));
    });
    test('invalid register fields - email exists in mock DB', (){
      when(mockFirestoreDatabase.emailExists(email)).thenAnswer((_) async => true);
      when(mockFirestoreDatabase.usernameExists(username)).thenAnswer((_) async => false);
      expect(() => Validate.register(username, email, password, password, mockFirestoreDatabase), throwsA(isA<String>()));
    });
    test('invalid register fields - not an email', (){
      when(mockFirestoreDatabase.emailExists(email)).thenAnswer((_) async => false);
      when(mockFirestoreDatabase.usernameExists(username)).thenAnswer((_) async => false);
      expect(() => Validate.register(username, 'not an email', password, password, mockFirestoreDatabase), throwsA(isA<String>()));
    });
  });
}
