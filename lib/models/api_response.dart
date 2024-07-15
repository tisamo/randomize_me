class ApiResponse<T> {
  String status;
  T data;

  ApiResponse(this.status, this.data);
}