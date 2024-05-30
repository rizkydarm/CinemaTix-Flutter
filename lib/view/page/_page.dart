

import 'package:cinematix/core/_core.dart';
import 'package:cinematix/data/_data.dart';
import 'package:cinematix/domain/_domain.dart';
import 'package:cinematix/view/bloc/_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';

part 'home_page.dart';

class InfiniteListView<T> extends StatefulWidget {
  
  final Widget Function(BuildContext, T, int) itemBuilder;
  final Widget Function(BuildContext, int) separatorBuilder;
  
  final Future<void> Function(int, PagingController<int, T>) onFetchPage;

  const InfiniteListView({super.key,
    required this.itemBuilder,
    required this.separatorBuilder,
    required this.onFetchPage,
  });

  @override
  State createState() => _InfiniteListViewState<T>();
}

class _InfiniteListViewState<T> extends State<InfiniteListView<T>> {
  

  final PagingController<int, T> _pagingController = PagingController(firstPageKey: 1);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      widget.onFetchPage(pageKey, _pagingController);
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) => 
    PagedListView<int, T>.separated(
      separatorBuilder: widget.separatorBuilder,
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: widget.itemBuilder,
        firstPageErrorIndicatorBuilder: (context) => SizedBox(
          height: 60,
          child: Center(child: Text(_pagingController.error.toString()))
        ),
      ),
    );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}