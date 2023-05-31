import 'package:dartz/dartz.dart';
import 'package:safestore/core/data/datasources/remote_data_source.dart';
import 'package:safestore/core/error/failure.dart';
import 'package:safestore/modules/my_plans/model/plans_billing_model.dart';
import 'package:safestore/modules/price_planing/model/payment_gateways_response_model.dart';
import 'package:safestore/modules/home/model/pricing_model.dart';

import '../../../core/error/exception.dart';

abstract class PricingRepository {
  Future<Either<Failure,List<PlansBillingModel>>> getMyPlanBillingList(String token);
  Future<Either<Failure,PaymentGatewaysResponseModel>> paymentGateways(String token);
}

class PricingRepositoryImp extends PricingRepository {
  PricingRepositoryImp({required this.remoteDataSource});
  final RemoteDataSource remoteDataSource;

  @override
  Future<Either<Failure, List<PlansBillingModel>>> getMyPlanBillingList(String token) async {
    try {
      final result = await remoteDataSource.getMyPlanBillingList(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }

  @override
  Future<Either<Failure, PaymentGatewaysResponseModel>> paymentGateways(String token) async {
    try {
      final result = await remoteDataSource.paymentGateways(token);
      return Right(result);
    } on ServerException catch (e) {
      return Left(ServerFailure(e.message, e.statusCode));
    }
  }
}