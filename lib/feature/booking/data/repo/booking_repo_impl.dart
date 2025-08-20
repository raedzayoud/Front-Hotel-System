import 'dart:convert';
import 'dart:ffi';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hotel/core/class/applink.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/core/utils/function/checkinternet.dart';
import 'package:hotel/feature/authentication/data/model/user.dart';
import 'package:hotel/feature/authentication/data/repos/authentication_repo.dart';
import 'package:hotel/feature/booking/data/repo/booking_repo.dart';
import 'package:hotel/main.dart';

class BookingRepoImpl implements BookingRepo {
  final Dio dio = Dio(BaseOptions(
    headers: {
      'Accept': 'application/json', // Ensure Laravel returns JSON
      'Content-Type': 'application/json',
    },
  ));

  @override
  Future<Either<Failure, List<dynamic>>> getIncomingPastRooms() async {
    if (await checkInternet()) {
      //print(user.toJson());
      var response;
      try {
        response = await dio.get(
          Applink.getIncomingPastRooms,
          options: Options(
            headers: {
              "Authorization": "Bearer ${sharedPreferences.getString("token")}",
            },
          ),
        );
        List<dynamic> list = response.data['data'];
        return Right(list);
      } catch (e) {
        if (e is DioException) {
          return Left(ServeurFailure.fromDioError(e));
        }
        return Left(ServeurFailure(errorsMessage: e.toString()));
      }
    } else {
      return Left(ServeurFailure(errorsMessage: "No Internet Connection"));
    }
  }
}
