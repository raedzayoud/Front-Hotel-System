import 'package:dartz/dartz.dart';
import 'package:hotel/core/class/applink.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/core/utils/function/checkinternet.dart';
import 'package:hotel/feature/home/data/repos/home_repo.dart';
import 'package:dio/dio.dart';
import 'package:hotel/main.dart';

class HomeReposImpl implements HomeRepo {
  final Dio dio = Dio(BaseOptions(
    headers: {
      'Accept': 'application/json', // Ensure Laravel returns JSON
      'Content-Type': 'application/json',
    },
  ));
  @override
  Future<Either<Failure, void>> SearchHotel() {
    // TODO: implement SearchHotel
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, List>> getAllHotel() async {
    if (await checkInternet()) {
      //print(user.toJson());
      var response;
      try {
        response = await dio.get(
          Applink.apiGetAllHotel,
          options: Options(
            headers: {
              "Authorization": "Bearer ${sharedPreferences.getString("token")}",
            },
          ),
        );
        List hotels = response.data['hotel'];
        return Right(hotels);
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
