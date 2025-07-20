import 'dart:convert';
import 'dart:ffi';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:hotel/core/class/applink.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/core/utils/function/checkinternet.dart';
import 'package:hotel/feature/authentication/data/model/user.dart';
import 'package:hotel/feature/authentication/data/repos/authentication_repo.dart';

class AuthenticationRepoImpl implements AuthenticationRepo {
  final Dio dio = Dio(BaseOptions(
    headers: {
      'Accept': 'application/json', // Ensure Laravel returns JSON
      'Content-Type': 'application/json',
    },
  ));

  @override
  Future<Either<Failure, void>> signIn(User user) async {
    if (await checkInternet()) {
      //print(user.toJson());
      var response;
      try {
        response = await dio.post(
          Applink.apiSignup,
          data: user.toJson(),
        );
        return Right(null);
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

  @override
  Future<Either<Failure, String>> login(String email, String password) async {
    if (await checkInternet()) {
      // print(user.toJson());
      var response;
      try {
        response = await dio.get(
          Applink.apiLogin,
          data: {"email": email, "password": password},
        );
        String token = response.data['token'];
        if (token != null) {
          return Right(token);
        } else {
          return Left(ServeurFailure(errorsMessage: "Invalid token received"));
        }
      } catch (e) {
        if (e is DioException) {
          return Left(ServeurFailure.fromDioError(e));
        }
        final errorMessage = response?.data["message"] ?? "Unknown error";
        if (errorMessage != null)
          return Left(ServeurFailure(errorsMessage: errorMessage));
        else
          return Left(ServeurFailure(errorsMessage: e.toString()));
      }
    } else {
      return Left(ServeurFailure(errorsMessage: "No Internet Connection"));
    }
  }

  @override
  Future<Either<Failure, Map<String, dynamic>>> getUserDetails(
      String token) async {
    if (await checkInternet()) {
      var response;
      try {
        response = await dio.get(
         "",
          options: Options(
            headers: {
              "Authorization": "Bearer $token",
            },
          ),
        );

        final data = response.data['data'];
        if (data != null) {
          return Right(data);
        } else {
          return Left(
              ServeurFailure(errorsMessage: "Invalid user data received"));
        }
      } catch (e) {
        if (e is DioException) {
          return Left(ServeurFailure.fromDioError(e));
        }
        final errorMessage = response?.data["message"] ?? "Unknown error";
        return Left(ServeurFailure(errorsMessage: errorMessage));
      }
    } else {
      return Left(ServeurFailure(errorsMessage: "No Internet Connection"));
    }
  }
}
