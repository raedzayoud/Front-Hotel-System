import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/feature/authentication/data/model/user.dart';

abstract class AuthenticationRepo {
  Future<Either<Failure, void>> signIn(User user);
  Future<Either<Failure, String>> login(String email, String password);
  Future<Either<Failure, Map<String, dynamic>>> getUserDetails(String token);
  // Future<Either<Failure, void>> updateStatustoActive();
}
