import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';

import '../../models/search_result.dart';
part 'github_api.g.dart';

@RestApi(baseUrl: 'https://api.github.com/')
abstract class GithubApi {
  factory GithubApi(Dio dio) = _GithubApi;

  @GET('/search/repositories')
  Future<HttpResponse<SearchResult>> searchRepo(@Query('q') String query);
}
