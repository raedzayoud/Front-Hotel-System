import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/feature/authentication/data/model/user.dart';
import 'package:dio/dio.dart';

abstract class HomeRepo {
  Future<Either<Failure, List>> getAllHotel();
  Future<Either<Failure, void>> SearchHotel();
}
