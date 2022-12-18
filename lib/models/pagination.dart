class Pagination<T>{
  int? totalPages;
  int pageIndex;
  /// true if there is next page so load it
  bool next;
  List<T> list;

  Pagination({
    required this.list,
    this.totalPages,
    this.next = false,
    this.pageIndex = 0,
  });

  /// clear [Pagination] info
  reset(){
    totalPages = null;
    next = false;
    pageIndex = 0;
    list.clear();
  }

  /// when get new [Pagination] use to append it to current [Pagination]
  addFromPagination(Pagination<T> pagination){
    list.addAll(pagination.list);
    totalPages = pagination.totalPages;
    pageIndex = pagination.pageIndex;
    next = pagination.next;
  }
}