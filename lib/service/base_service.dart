import 'dart:io';
import 'package:dio/dio.dart';
import 'package:retrofit/dio.dart';

import 'data_state.dart';

mixin DataStateConvertable {
  DataState<T> convertToDataState<T>(HttpResponse<T> _response) {
    if (_response.response.statusCode == HttpStatus.ok) {
      return DataSuccess(_response.data);
    }
    return DataFailed(
      DioError(
        error: _response.response.statusMessage,
        response: _response.response,
        type: DioErrorType.response,
        requestOptions: _response.response.requestOptions,
      ),
    );
  }
}
