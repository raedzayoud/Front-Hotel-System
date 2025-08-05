import 'package:dartz/dartz.dart';
import 'package:hotel/core/class/applink.dart';
import 'package:hotel/core/error/failure.dart';
import 'package:hotel/core/utils/function/checkinternet.dart';
import 'package:hotel/feature/home/data/repos/home_repo.dart';
import 'package:dio/dio.dart';
import 'package:hotel/feature/wallet/data/repos/wallet_repo.dart';
import 'package:hotel/main.dart';

class WalletReposImpl implements WalletRepo {
  final Dio dio = Dio(BaseOptions(
    headers: {
      'Accept': 'application/json', // Ensure Laravel returns JSON
      'Content-Type': 'application/json',
    },
  ));

  @override
  Future<Either<Failure, int>> addSolde(int solde) async {
    if (await checkInternet()) {
      var response;
      try {
        response = await dio.post(
          Applink.addSolde,
          data: {'solde': solde},
          options: Options(
            headers: {
              "Authorization": "Bearer ${sharedPreferences.getString("token")}",
            },
          ),
        );
        final newSolde = response.data['solde'];
        return Right(newSolde);
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
