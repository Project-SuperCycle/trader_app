import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/core/helpers/error_handler.dart';
import 'package:trader_app/core/services/api_endpoints.dart';
import 'package:trader_app/core/services/api_services.dart';
import 'package:trader_app/core/services/user_profile_services.dart';
import 'package:trader_app/features/sales_process/data/models/create_shipment_response.dart';
import 'package:trader_app/features/sales_process/data/repos/sales_process_repo.dart';

class SalesProcessRepoImp implements SalesProcessRepo {
  final ApiServices apiServices;

  SalesProcessRepoImp({required this.apiServices});

  @override
  Future<Either<Failure, CreateShipmentResponse>> createShipment({
    required FormData shipment,
  }) {
    return ErrorHandler.handleApiCall<CreateShipmentResponse>(
      apiCall: () async {
        final response = await apiServices.postFormData(
          endPoint: ApiEndpoints.createShipment,
          data: shipment,
        );

        if (response['message'] == null) {
          throw ServerFailure('Invalid response: Missing message', 422);
        }

        // Side effect after successful shipment creation
        await UserProfileService.fetchAndStoreUserProfile();

        return CreateShipmentResponse(
          message: response['message'],
          id: response['data']['_id'],
        );
      },
      errorContext: 'create shipment',
    );
  }
}
