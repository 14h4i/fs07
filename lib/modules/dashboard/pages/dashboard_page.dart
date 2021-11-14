import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fs07/blocs/app_state_bloc.dart';
import 'package:fs07/modules/posts/blocs/list_posts_bloc.dart';
import 'package:fs07/modules/posts/models/post.dart';
import 'package:fs07/modules/posts/widgets/post_item.dart';

class DashboardPage extends StatefulWidget {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  _DashboardPageState createState() => _DashboardPageState();
}

class _DashboardPageState extends State<DashboardPage> {
  ListPostsBloc? get bloc => BlocProvider.of<ListPostsBloc>(context);
  AppBloc? get appStateBloc => BlocProvider.of<AppBloc>(context);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List posts page'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.logout),
        onPressed: () {
          appStateBloc!.changeAppState(AppStatus.unAuthorized);
        },
      ),
      body: StreamBuilder<List<Post>?>(
          stream: bloc!.postsStream,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final posts = snapshot.data;
              return ListView.builder(
                itemBuilder: (_, int index) {
                  final item = posts![index];
                  return PostItem(
                    height: 200,
                    url: item.images?.first.url ?? '',
                    description: item.description!,
                  );
                },
                itemCount: posts?.length ?? 0,
              );
            }
            if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          }),
    );
  }
}
