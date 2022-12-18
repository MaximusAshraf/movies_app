enum RequestStatus{
  /// request crashed - request time out or mobile exception
  exception,
  /// 1xx - in process or continue checking
  loading,
  /// 2xx
  success,
  /// 3xx
  redirection,
  /// 404
  noItemFound,
  /// 4xx
  clientError,
  /// 5xx
  serverError
}