import 'package:flutter/material.dart';
import 'package:flutter_github_search/api/github_api.dart';
import 'package:flutter_github_search/bloc/search_bloc/search_bloc.dart';
import 'package:flutter_github_search/models/repo_model.dart';
import 'package:flutter_github_search/service/github_serivce.dart';
import 'package:flutter_github_search/widgets/repo_item_widget.dart';
import 'package:flutter_github_search/widgets/search_widget.dart';
import 'package:dio/dio.dart';

class SearchScreen extends StatefulWidget {
  final String searchText;
  const SearchScreen({Key? key, required this.searchText}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final SearchBloc _bloc = SearchBloc(service: GithubService(GithubApi(Dio())));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchWidget(
          initText: widget.searchText,
          onTextChanged: (text) {
            _bloc.onTextChanged(text);
          },
        ),
      ),
      body: StreamBuilder<SearchState>(
        stream: _bloc.searchStream,
        builder: (context, snapshot) {
          return AnimatedSwitcher(
            duration: Duration(milliseconds: 300),
            child: _buildForChild(snapshot.data),
          );
        },
      ),
    );
  }

  Widget _buildForChild(SearchState? state) {
    print('Search state : $state');
    if (state != null) {
      if (state is SearchLoadingState) {
        return _buildForLoading();
      } else if (state is SearchFailedState) {
        return _buildForSearchFailed();
      } else if (state is SearchSuccessState) {
        return state.repos.isEmpty
            ? _buildForNoRepo()
            : _buildForSearchSuccess(state.repos);
      }
    }
    return _buildForStart();
  }

  Widget _buildForLoading() {
    return Center(
      child: CircularProgressIndicator(),
    );
  }

  Widget _buildForStart() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.search,
            size: 80.0,
            color: Colors.black54,
          ),
          Text('Search Github Repos')
        ],
      ),
    );
  }

  Widget _buildForNoRepo() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.info_outline_rounded,
            size: 80.0,
            color: Colors.black54,
          ),
          Text(
            'No repo found',
          )
        ],
      ),
    );
  }

  Widget _buildForSearchFailed() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.error_outline,
            size: 80.0,
            color: Colors.black54,
          ),
          Text(
            'Search failed',
          )
        ],
      ),
    );
  }

  Widget _buildForSearchSuccess(List<Repo> repos) {
    return ListView.builder(
        itemCount: repos.length,
        itemBuilder: (context, index) {
          return RepoItemWidget(
            repo: repos[index],
          );
        });
  }

  @override
  void dispose() {
    _bloc.dispose();
    super.dispose();
  }
}
