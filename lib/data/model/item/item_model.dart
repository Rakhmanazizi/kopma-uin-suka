import 'package:equatable/equatable.dart';
import 'package:kopma/data/model/item/item_entity.dart';

class ItemModel extends Equatable {
  final String? id;
  final String name;
  final String image;
  final String category;
  final String description;
  final int quantity;
  final int price;
  final String? sellerId;
  final String? sellerName;
  final String? sellerEmail;
  final String? sellerAddress;
  final String? sellerImage;

  const ItemModel({
    this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.description,
    required this.quantity,
    required this.price,
    this.sellerId,
    this.sellerName,
    this.sellerEmail,
    this.sellerAddress,
    this.sellerImage,
  });

  // empty static item.
  static const empty = ItemModel(
      id: '',
      name: '',
      image: '',
      category: '',
      description: '',
      quantity: 0,
      price: 0,
      sellerId: '',
      sellerName: '',
      sellerEmail: '',
      sellerAddress: '',
      sellerImage: '');

//   modify item parameters
  ItemModel copyWith({
    String? id,
    String? name,
    String? image,
    String? category,
    String? description,
    int? quantity,
    int? price,
    String? sellerId,
    String? sellerName,
    String? sellerEmail,
    String? sellerAddress,
    String? sellerImage,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      category: category ?? this.category,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
      sellerId: sellerId ?? this.sellerId,
      sellerName: sellerName ?? this.sellerName,
      sellerEmail: sellerEmail ?? this.sellerEmail,
      sellerAddress: sellerAddress ?? this.sellerAddress,
      sellerImage: sellerImage ?? this.sellerImage,
    );
  }

  // convenience getter to determine whether the current user is empty
  bool get isEmpty => this == ItemModel.empty;

  // convenience getter to determine whether the current user is not empty
  bool get isNotEmpty => this != ItemModel.empty;

  ItemEntity toEntity(String id, String sellerId, String sellerName,
      String sellerEmail, String sellerAddress, String? sellerImage) {
    return ItemEntity(
      id: id,
      name: name,
      image: image,
      category: category,
      description: description,
      quantity: quantity,
      price: price,
      sellerId: sellerId,
      sellerName: sellerName,
      sellerEmail: sellerEmail,
      sellerAddress: sellerAddress,
      sellerImage: sellerImage,
    );
  }

  static ItemModel fromEntity(ItemEntity entity) {
    return ItemModel(
      id: entity.id as String,
      name: entity.name,
      image: entity.image,
      category: entity.category,
      description: entity.description,
      quantity: entity.quantity,
      price: entity.price,
      sellerId: entity.sellerId,
      sellerName: entity.sellerName,
      sellerEmail: entity.sellerEmail,
      sellerAddress: entity.sellerAddress,
      sellerImage: entity.sellerImage,
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props => [
        id,
        name,
        image,
        category,
        description,
        quantity,
        price,
        sellerId,
        sellerName,
        sellerEmail,
        sellerAddress,
        sellerImage
      ];
}
