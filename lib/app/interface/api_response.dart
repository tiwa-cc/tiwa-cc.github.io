import 'dart:io';

final class ApiResponse {
  final int status;
  final Object? response;
  final String? message;

  ApiResponse({required this.status, this.response, this.message});

  static get ok => ApiResponse(status: HttpStatus.ok);
  static get badRequest => ApiResponse(status: HttpStatus.badRequest);
  static get requestTimeout => ApiResponse(status: HttpStatus.requestTimeout);
}
