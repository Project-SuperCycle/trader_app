import 'package:dartz/dartz.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/features/environment/data/models/trader_eco_info_model.dart';
import 'package:trader_app/features/environment/data/models/environmental_redeem_model.dart';

abstract class EnvironmentRepo {
  Future<Either<Failure, TraderEcoInfoModel>> getTraderEcoInfo();

  Future<Either<Failure, List<EnvironmentalRedeemModel>>> getTraderEcoRequests({
    required int page,
  });

  Future<Either<Failure, String>> createTraderEcoRequest({
    required int quantity,
  });
}
