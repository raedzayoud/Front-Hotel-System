import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/feature/authentication/data/model/user.dart';
import 'package:dio/dio.dart';

abstract class RoomRepo {
  Future<Either<Failure, List>> getAllRooms(String idHotel);
}
