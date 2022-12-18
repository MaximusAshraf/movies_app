
import 'package:movies_app/enums/request_status.dart';
/// model to handle data transfer between app layers
/// like controllers, providers and UI
/// [Type] model needed to be transfer
class AppResponse<Type>{

  /// use to handle different request cases
  RequestStatus? status;

  /// may be any thing depend on status like
  /// in case [RequestStatus.success] expect [Type] to be
  /// items list or what ever need to display in ui
  /// in case [RequestStatus.exception] expect [Type] to be
  /// error object or what ever need to display error message in ui
  Type? data;

  AppResponse({
    this.data,
    this.status,
  });
}