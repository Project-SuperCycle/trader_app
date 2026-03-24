import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/features/sales_process/data/models/create_shipment_response.dart';

abstract class SalesProcessRepo {
  Future<Either<Failure, CreateShipmentResponse>> createShipment({
    required FormData shipment,
  });
}
