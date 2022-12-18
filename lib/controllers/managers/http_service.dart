import 'package:http/http.dart' as http;
import 'package:movies_app/controllers/managers/request_status_controller.dart';
import '../../models/app_response.dart';

class HttpService {

  const HttpService._();

  static const HttpService instance = HttpService._();

  Future<AppResponse<String>> get(
      String url,
      {Map<String,String>? headers, http.Client? client}
    ) async{
    client ??= http.Client();
    http.Response response = await client.get(Uri.parse(url),headers: headers);
    return AppResponse<String>(
      data: response.body,
      status: RequestStatusController.convertStatusToEnum(response.statusCode),
    );

  }
}