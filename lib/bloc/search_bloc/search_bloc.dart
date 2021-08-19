import 'package:rxdart/rxdart.dart';

import '../../service/data_state.dart';
import '../../service/github_serivce.dart';
import '../../models/repo_model.dart';
part 'search_state.dart';

class SearchBloc {
  final _textSubject = BehaviorSubject<String>();
  final GithubService service;

  SearchBloc({required this.service});

  Stream<SearchState> get searchStream {
    return _textSubject
        .distinct()
        .debounceTime(Duration(milliseconds: 300))
        .switchMap<SearchState>((text) => _search(text, service))
        .startWith(SearchInitState());
  }

  void onTextChanged(String text) {
    print('Text add : $text');
    _textSubject.add(text);
  }

  void dispose() {
    _textSubject.close();
  }

  static Stream<SearchState> _search(String text, GithubService service) =>
      text.isEmpty
          ? Stream.value(SearchInitState())
          : FromCallableStream(() => service.searchRepos(text))
              .map((result) => result is DataSuccess
                  ? SearchSuccessState(result.data?.repos ?? [])
                  : SearchFailedState(result.error?.message ?? 'Unknown error'))
              .startWith(SearchLoadingState())
              .onErrorReturn(SearchFailedState('Unknown error'));
}
