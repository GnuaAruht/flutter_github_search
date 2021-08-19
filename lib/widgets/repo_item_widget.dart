import 'package:flutter/material.dart';
import 'package:flutter_github_search/models/repo_model.dart';

class RepoItemWidget extends StatelessWidget {
  final Repo repo;
  const RepoItemWidget({Key? key, required this.repo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        padding: const EdgeInsets.all(10.0),
        child: Row(
          children: [
            Container(
              width: 50.0,
              height: 50.0,
              decoration:
                  BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
            ),
            const SizedBox(
              width: 10.0,
            ),
            Expanded(
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  repo.fullName ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 20.0, fontWeight: FontWeight.w700),
                ),
                Text(
                  repo.description ?? '',
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
