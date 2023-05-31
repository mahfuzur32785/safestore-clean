import 'package:dartz/dartz.dart';
import 'package:safestore/core/data/datasources/remote_data_source.dart';
import 'package:safestore/core/error/exception.dart';
import 'package:safestore/core/error/failure.dart';
import 'package:safestore/modules/ad_details/model/details_response_model.dart';

abstract class AdDetailsRepository {
  Future<Either<Failure, DetailsResponseModel>> getAdDetails(String slug,String token);
  Future<Either<Failure, String>> postReport(Map<String, dynamic> body,String token);
}

class AdDetailsRepositoryImp extends AdDetailsRepository {
  final RemoteDataSource remoteDataSource;
  AdDetailsRepositoryImp({required this.remoteDataSource});

  @override
  Future<Either<Failure, DetailsResponseModel>> getAdDetails(String slug,String token) async {
    try {
      final result = await remoteDataSource.getAdDetails(slug,token);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
  @override
  Future<Either<Failure, String>> postReport(Map<String, dynamic> body,String token) async {
    try {
      final result = await remoteDataSource.postReport(body,token);
      return right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

}