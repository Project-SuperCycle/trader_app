import 'package:dartz/dartz.dart';
import 'package:trader_app/core/constants/storage_constants.dart';
import 'package:trader_app/core/errors/failures.dart';
import 'package:trader_app/core/helpers/error_handler.dart';
import 'package:trader_app/core/services/api_endpoints.dart';
import 'package:trader_app/core/services/api_services.dart';
import 'package:trader_app/core/services/storage_services.dart';
import 'package:trader_app/features/finances/data/models/external/single_finance_external_model.dart';
import 'package:trader_app/features/finances/data/models/finance_transaction_model.dart';
import 'package:trader_app/features/finances/data/models/internal/single_finance_internal_model.dart';
import 'package:trader_app/features/finances/data/models/methods/finance_method_model.dart';
import 'package:trader_app/features/finances/data/models/summary/finance_summary_model.dart';
import 'package:trader_app/features/finances/data/repos/finances_repo.dart';

class FinancesRepoImp implements FinancesRepo {
  final ApiServices apiServices;

  FinancesRepoImp({required this.apiServices});

  // COMMON METHODS
  @override
  Future<Either<Failure, FinanceMethodModel>> getFinanceMethods() {
    // TODO: implement getFinanceMethods
    return ErrorHandler.handleApiResponse<FinanceMethodModel>(
      apiCall: () => apiServices.get(endPoint: ApiEndpoints.getFinancesMethods),
      errorContext: 'get finances methods',
      responseParser: (response) {
        final data = response['data'];
        return FinanceMethodModel.fromJson(data);
      },
    );
  }

  @override
  Future<Either<Failure, FinanceSummaryModel>> getFinancesSummary({
    required String type,
  }) {
    // TODO: implement getFinancesSummary
    return ErrorHandler.handleApiResponse<FinanceSummaryModel>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getFinancesSummary,
        query: {"type": type},
      ),
      errorContext: 'get finances summary',
      responseParser: (response) {
        final data = response['data'];
        return FinanceSummaryModel.fromJson(data);
      },
    );
  }

  @override
  Future<Either<Failure, List<FinanceTransactionModel>>>
  getFinanceTransactions({required String status, required int page}) {
    // TODO: implement getExternalFinances
    return ErrorHandler.handleApiResponse<List<FinanceTransactionModel>>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getFinancesItems,
        query: {"status": status, "page": page},
      ),
      errorContext: 'get trader finance transactions',
      responseParser: (response) {
        final List data = response['data'];
        final int meta = response['meta']['totalPages'];
        StorageServices.storeData(
          StorageConstants.EXTERNAL_FINANCES_PAGES,
          meta,
        );
        return data.map((e) => FinanceTransactionModel.fromJson(e)).toList();
      },
    );
  }

  // EXTERNAL METHODS
  @override
  Future<Either<Failure, SingleFinanceExternalModel>>
  getExternalFinanceDetails({required String shipmentId}) {
    // TODO: implement getExternalFinanceDetails
    return ErrorHandler.handleApiResponse<SingleFinanceExternalModel>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getExternalFinanceDetails.replaceAll(
          '{shipmentId}',
          shipmentId,
        ),
        query: {"shipmentId": shipmentId},
      ),
      errorContext: 'get external finance details',
      responseParser: (response) {
        final data = response['data'];
        return SingleFinanceExternalModel.fromJson(data);
      },
    );
  }

  // MEAL METHODS
  @override
  Future<Either<Failure, SingleFinanceInternalModel>> getMealFinanceDetails({
    required String paymentId,
  }) {
    // TODO: implement getMealFinanceDetails
    return ErrorHandler.handleApiResponse<SingleFinanceInternalModel>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getMealFinanceDetails.replaceAll(
          '{paymentId}',
          paymentId,
        ),
        query: {"paymentId": paymentId},
      ),
      errorContext: 'get meal finance details',
      responseParser: (response) {
        final data = response['data'];
        return SingleFinanceInternalModel.fromJson(data);
      },
    );
  }

  // MONTHLY METHODS
  @override
  Future<Either<Failure, SingleFinanceInternalModel>> getMonthlyFinanceDetails({
    required String paymentId,
  }) {
    // TODO: implement getMonthlyFinanceDetails
    return ErrorHandler.handleApiResponse<SingleFinanceInternalModel>(
      apiCall: () => apiServices.get(
        endPoint: ApiEndpoints.getMonthlyFinanceDetails.replaceAll(
          '{paymentId}',
          paymentId,
        ),
        query: {"paymentId": paymentId},
      ),
      errorContext: 'get monthly finance details',
      responseParser: (response) {
        final data = response['data'];
        return SingleFinanceInternalModel.fromJson(data);
      },
    );
  }
}
