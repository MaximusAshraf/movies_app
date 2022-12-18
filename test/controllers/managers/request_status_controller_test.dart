import 'package:flutter_test/flutter_test.dart';
import 'package:movies_app/controllers/managers/request_status_controller.dart';
import 'package:movies_app/enums/request_status.dart';

void main() {
  group('RequestStatusController', () {
    test('getStatusMessage', (){

      expect(RequestStatusController.getStatusMessage(
          status: RequestStatus.success), "requestCompleteSuccessfully");
      expect(RequestStatusController.getStatusMessage(
          status: RequestStatus.success,successMessage: "message"), "message");
      expect(RequestStatusController.getStatusMessage(
          status: RequestStatus.exception), "Failed to complete request");
      expect(RequestStatusController.getStatusMessage(
          status: RequestStatus.clientError,failedMessage: "message"), "message");

    });
    test('convertStatusToEnum', (){
      expect(RequestStatusController.convertStatusToEnum(0), RequestStatus.exception);
      expect(RequestStatusController.convertStatusToEnum(200), RequestStatus.success);
      expect(RequestStatusController.convertStatusToEnum(400), RequestStatus.clientError);
      expect(RequestStatusController.convertStatusToEnum(500), RequestStatus.serverError);
    });
  });
}