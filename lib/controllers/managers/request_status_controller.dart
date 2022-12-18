import 'package:movies_app/enums/request_status.dart';

class RequestStatusController{
  static String getStatusMessage({
    required RequestStatus? status,
    String? failedMessage,
    String? successMessage,
  }){
    switch(status){
      case null:
        // only can happen in debug cases
        // still not call request but build widget
        return "Request need to be called";
      case RequestStatus.exception:
        // request crashed - request time out or mobile exception
        // may be cause by backend or frontend
        return "Failed to complete request";
      case RequestStatus.loading:
        // client's request in process
        return "Request in process";
      case RequestStatus.success:
        // client's request was successfully received
        return successMessage ?? "requestCompleteSuccessfully";
      case RequestStatus.noItemFound:
        // page not found - no items - no data
        return failedMessage ?? "No item found";
      case RequestStatus.clientError:
        // client's request have error
        return failedMessage ?? "Failed to complete request";
      case RequestStatus.serverError:
        // server have error
        return "Currently service not available";
      default:
        // no error match so return default error
        return "Failed to complete request";

    }
  }

  static RequestStatus convertStatusToEnum(int status){
    if(status >= 100 && status < 200){
      return RequestStatus.loading;
    } else if(status >= 200 && status < 300){
      return RequestStatus.success;
    } else if(status >= 300 && status < 400){
      return RequestStatus.redirection;
    } else if(status >= 400 && status < 500){
        if(status == 404) return RequestStatus.noItemFound;
      return RequestStatus.clientError;
    } else if(status >= 500){
      return RequestStatus.serverError;
    } else {
      return RequestStatus.exception;
    }
  }
}