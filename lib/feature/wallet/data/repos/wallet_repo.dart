import 'package:dartz/dartz.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/feature/authentication/data/model/user.dart';
import 'package:dio/dio.dart';

abstract class WalletRepo {
  Future<Either<Failure, int>> addSolde(int solde);
}
