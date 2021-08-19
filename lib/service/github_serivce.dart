import 'package:flutter_github_search/api/github_api.dart';
import 'package:flutter_github_search/models/search_result.dart';
import 'package:flutter_github_search/service/base_service.dart';
import 'package:flutter_github_search/service/data_state.dart';
import 'package:dio/dio.dart';

class GithubService with DataStateConvertable {
  final GithubApi _nextApi;
  GithubService(this._nextApi);

  Future<DataState<SearchResult>> searchRepos(String query) async {
    try {
      final _response = await _nextApi.searchRepo(query);
      return convertToDataState(_response);
    } on DioError catch (e) {
      print('search failed : $e');
      return DataFailed(e);
    }
  }
}
