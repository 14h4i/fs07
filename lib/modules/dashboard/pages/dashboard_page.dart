import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fs07/blocs/app/app_bloc.dart';
import 'package:fs07/modules/posts/blocs/list_posts_bloc.dart';
import 'package:fs07/modules/posts/widgets/post_item.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ListPostsBloc? get _postsBloc => BlocProvider.of<ListPostsBloc>(context);
  AppBloc? get appStateBloc => BlocProvider.of<AppBloc>(context);

  @override
  void initState() {
    super.initState();
    _postsBloc!.add('getPosts');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List posts page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () {
          appStateBloc!.add(ChangeAppState(status: AppStatus.unAuthorized));
        },
      ),
      body: BlocBuilder<ListPostsBloc, ListPostsState>(
        bloc: _postsBloc,
        builder: (context, state) {
          final posts = state.posts;
          if (posts != null) {
            return ListView.builder(
              itemBuilder: (_, int index) {
                final item = posts[index];
                return PostItem(
                  height: 200,
                  url: item.images?.first.url ?? '',
                  description: item.description!,
                );
              },
              itemCount: posts.length,
            );
          }
          final error = state.error;
          if (error != null) {
            return Center(
              child: Text(error.toString()),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}
