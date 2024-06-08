import 'dart:developer';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kopma/data/item_repository.dart';
import 'package:kopma/data/model/item/item_model.dart';

part 'item_event.dart';

part 'item_state.dart';

class ItemBloc extends Bloc<ItemEvent, ItemState> {
  final ItemRepository itemRepository;

  ItemBloc({required this.itemRepository}) : super(const ItemState.loading()) {
    on<PostItem>((event, emit) async {
      try {
        await itemRepository.postItem(event.item);
        emit(UploadItemSuccess(event.item));
      } catch (e) {
        log(e.toString());
        emit(const ItemState.failure());
      }
    });

    on<UploadImage>((event, emit) async {
      try {
        String imageUrl =
            await itemRepository.uploadImage(event.file, event.fileName);
        log(imageUrl);
        emit(ItemState.successUploadImage(imageUrl));
      } catch (e) {
        log(e.toString());
        emit(const ItemState.failure());
      }
    });

    on<GetListItems>((event, emit) {
      try {
        Query<ItemModel> listItem = itemRepository.getListItem(event.query);
        emit(GetListItemSuccess(listItem));
      } catch (e) {
        log(e.toString());
        emit(const ItemState.failure());
      }
    });
  }
}
