import 'status.dart';

class ApiResponse<T>{
  String? message;
  Status? status;
  T? data;

  ApiResponse(this.data, this.message, this.status);

  ApiResponse.loading(): status = Status.loading;
  ApiResponse.failed(): status = Status.failed;
  ApiResponse.completed(this.data): status = Status.completed;
  
}