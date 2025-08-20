import 'package:hotel/core/error/failure.dart';
import 'package:dartz/dartz.dart';

abstract class BookingRepo {
  Future<Either<Failure, List<Map<String, dynamic>>>> signIn(User user);
}
