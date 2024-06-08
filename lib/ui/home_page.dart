//import 'dart:js_interop';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_ui_firestore/firebase_ui_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopma/bloc/item_bloc/item_bloc.dart';
import 'package:kopma/bloc/user_bloc/user_bloc.dart';
import 'package:kopma/ui/post_item_page.dart';

import '../data/model/item/item_model.dart';
import 'detail_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<StatefulWidget> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<ItemBloc>().add(const GetListItems(query: ""));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add Item',
        onPressed: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) {
            return const PostItemPage();
          }));
        },
        child: const Icon(Icons.add),
      ),
      body: BlocListener<ItemBloc, ItemState>(
        listener: (context, state) {
          if (state is UploadItemSuccess) {
            context.read<ItemBloc>().add(const GetListItems(query: ""));
          }
        },
        child: BlocBuilder<ItemBloc, ItemState>(builder: (context, state) {
          if (state is GetListItemSuccess) {
            return FirestoreListView<ItemModel>(
              query: state.listItem,
              pageSize: 10,
              emptyBuilder: (context) => const Text('No data'),
              errorBuilder: (context, error, stackTrace) =>
                  Text(error.toString()),
              loadingBuilder: (context) => const CircularProgressIndicator(),
              itemBuilder: (context, doc) {
                return ItemWidget(item: doc.data());
              },
            );
          } else {
            return const Text('Error coy');
          }
        }),
      ),
    );
  }
}

class ItemWidget extends StatelessWidget {
  final ItemModel item;

  const ItemWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (item.id != null) {
          if (item.id!.isNotEmpty) {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return DetailItemPage(
                idItem: item.id!,
              );
            }));
          }
        }
      },
      child: Card(
        margin: const EdgeInsets.all(8),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              CachedNetworkImage(
                imageUrl: item.image,
              ),
              const Padding(padding: EdgeInsets.all(4)),
              Text(
                item.name,
                style: const TextStyle(
                    fontSize: 20.0, fontWeight: FontWeight.w600),
              ),
              Text(
                "Rp. ${item.price}",
                style: const TextStyle(
                    fontSize: 16.0, fontWeight: FontWeight.w500),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
