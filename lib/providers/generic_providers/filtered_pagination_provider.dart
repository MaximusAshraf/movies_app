

import 'package:flutter/material.dart';
import 'package:movies_app/controllers/managers/http_service.dart';
import 'package:movies_app/enums/request_status.dart';
import 'package:movies_app/models/app_response.dart';
import 'package:movies_app/models/pagination.dart';

/// generic provider to paginate data using [Type] and [Filters]
/// [Type] type of data need to be paginate
/// [Filters] type of filters on data
class PaginationFilteredProvider<Type,Filters> extends ChangeNotifier{

  /// contain loaded data which will be display in ui and request status
  /// data may be [Pagination] if successful request or null in case of error
  final AppResponse<Pagination<Type>?> _response = AppResponse<Pagination<Type>?>();
  AppResponse<Pagination<Type>?> get response => _response;


  /// used to filter data when call [_api]
  Filters? filters;

  /// request data from some data source to be mapped by [_mapper]
  final  Future<AppResponse> Function({
    required int page,
    required Filters? filters,
    HttpService service
  }) _api;

  /// map data which get from [_api] to [Pagination]
  final Pagination<Type> Function(dynamic) _mapper;

  PaginationFilteredProvider(this._api,this._mapper);

  /// reset provider response to initial vales
  reset(){
    _response.status = null;
    _response.data?.reset();
  }

  @override
  dispose(){
    // reset to stop provider if removed from widget tree
    reset();
    super.dispose();
  }

  /// get new page from api and map new data to current [Pagination]
  Future<RequestStatus?> getData ({
    /// clear current [Pagination] if true
    bool reset = false,
  }) async  {

    if(_response.status == RequestStatus.loading) {
      return RequestStatus.loading;
    }

    _response.status = RequestStatus.loading;
    if(_response.data == null) {
      notifyListeners();
    }

    try {
      final apiResponse = await _api(
          page: reset ? 1 : (_response.data?.pageIndex ?? 0) + 1,
          filters: filters
      );

      // stop process if provider dispose
      if(_response.status == null) return null;

      if(_response.data == null){
        _response.status = apiResponse.status;
      }else{
        _response.status = RequestStatus.success;
      }

      switch(apiResponse.status){
        case RequestStatus.success:
          if(reset){_response.data?.reset();}
          if(_response.data == null){
            _response.data = _mapper(apiResponse.data);
          }else{
            _response.data?.addFromPagination(_mapper(apiResponse.data));
          }
          break;
        default:
          break;
      }
      notifyListeners();
      return apiResponse.status;
    } catch (e) {
      if(_response.data == null){
        _response.status = RequestStatus.exception;
      }
      notifyListeners();
      return RequestStatus.exception;
    }
  }
}