import 'package:dartz/dartz.dart';
import 'package:trader_app/core/errors/failures.dart';

abstract class ShipmentDetailsRepo {
  Future<Either<Failure, String>> cancelShipment({required String shipmentId});
}
