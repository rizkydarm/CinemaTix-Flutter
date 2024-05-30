

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
  final Future<void> Function(int, PagingController<int, T>) onFetchPage;
  final int pageSize;

  const InfiniteListView({super.key,
    required this.itemBuilder,
    required this.onFetchPage,
    this.pageSize = 20,
  });

  @override
  State createState() => _BeerListViewState<T>();
}

class _BeerListViewState<T> extends State<InfiniteListView<T>> {
  

  final PagingController<int, T> _pagingController = PagingController(firstPageKey: 0);

  @override
  void initState() {
    _pagingController.addPageRequestListener((pageKey) {
      widget.onFetchPage(pageKey, _pagingController);
    });
    super.initState();
  }
  
  @override
  Widget build(BuildContext context) => 
    PagedListView<int, T>(
      pagingController: _pagingController,
      builderDelegate: PagedChildBuilderDelegate<T>(
        itemBuilder: widget.itemBuilder
      ),
    );

  @override
  void dispose() {
    _pagingController.dispose();
    super.dispose();
  }
}