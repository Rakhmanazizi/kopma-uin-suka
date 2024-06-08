import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:kopma/data/model/item/item_model.dart';
import 'package:kopma/data/model/transaction_model.dart';
import 'package:kopma/data/model/user/user_model.dart';

abstract class ItemRepository {
  Query<ItemModel> getListItem(String? query);

  Query<ItemModel> getDetailItem(String? query);

  Future<String> uploadImage(File file, String fileName);

  Future<bool> postItem(ItemModel item);

  Future<bool> deleteItem(String itemId);

  Future<TransactionModel> buyItem(ItemModel item, UserModel user);
}
