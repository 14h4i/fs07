import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fs07/modules/posts/models/post.dart';
import 'package:fs07/modules/posts/services/list_posts_service.dart';
import 'package:rxdart/rxdart.dart';

class ListPostsBloc extends Bloc<String, ListPostsState> {
  ListPostsBloc() : super(ListPostsState()) {
    on<String>(
      (event, emit) async {
        switch (event) {
          case 'getPosts':
            try {
              final res = await ListPostsService().getPosts();
              if (res != null) {
                emit(ListPostsState(posts: res));
              }
            } catch (e) {
              debugPrint('$e');
              emit(ListPostsState(error: e));
            }
            break;
          default:
            // in a real app, a separate event type should be used
            await _search(event, emit);
        }
      },
      transformer: debounce(const Duration(milliseconds: 100)),
    );
  }

  Future<void> _search(String query, Emitter<ListPostsState> emit) async {
    if (query.isEmpty) {
      return;
    }
  }
}

EventTransformer<T> debounce<T>(Duration duration) {
  return (events, mapper) => events.debounceTime(duration).flatMap(mapper);
}

class ListPostsState {
  final Object? error;
  final List<Post>? posts;

  final List<String>? tagList;
  final String? tagQuery;

  ListPostsState({
    this.error,
    this.posts,
    this.tagList,
    this.tagQuery,
  });

  ListPostsState copyWith({
    Object? error,
    List<Post>? posts,
    List<String>? tagList,
    String? tagQuery,
  }) =>
      ListPostsState(
        error: error ?? this.error,
        posts: posts ?? this.posts,
        tagList: tagList ?? this.tagList,
        tagQuery: tagQuery ?? this.tagQuery,
      );
}
