import 'package:dartz/dartz.dart';
import 'package:safestore/modules/setting/model/faq_category_model.dart';
import '../../../../core/data/datasources/remote_data_source.dart';
import '../../../../core/error/exception.dart';
import '../../../../core/error/failure.dart';
import '../../model/about_us_model.dart';
import '../../model/contact_us_mesage_model.dart';
import '../../model/contact_us_mode.dart';
import '../../model/faq_model.dart';

abstract class SettingRepository {
  // Future<Either<Failure, String>> deletionRequest(String reason,String reasonInText,String token);
}

class SettingRepositoryImp extends SettingRepository {
  final RemoteDataSource remoteDataSource;
  SettingRepositoryImp({required this.remoteDataSource});


  // @override
  // Future<Either<Failure, String>> deletionRequest(String reason,String reasonInText,String token) async {
  //   try {
  //     final result = await remoteDataSource.accDeletionRequest(reason,reasonInText,token);
  //     return right(result);
  //   } on ServerException catch (e) {
  //     return Left(ServerFailure(e.message, e.statusCode));
  //   }
  // }

}
