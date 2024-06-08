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

  const ItemModel({
    this.id,
    required this.name,
    required this.image,
    required this.category,
    required this.description,
    required this.quantity,
    required this.price,
  });

  // empty static item.
  static const empty = ItemModel(
      id: '',
      name: '',
      image: '',
      category: '',
      description: '',
      quantity: 0,
      price: 0);

//   modify item parameters
  ItemModel copyWith({
    String? id,
    String? name,
    String? image,
    String? category,
    String? description,
    int? quantity,
    int? price,
  }) {
    return ItemModel(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      category: category ?? this.category,
      description: description ?? this.description,
      quantity: quantity ?? this.quantity,
      price: price ?? this.price,
    );
  }

  bool get isEmpty => this == ItemModel.empty;

  bool get isNotEmpty => this != ItemModel.empty;

  ItemEntity toEntity(String id) {
    return ItemEntity(
      id: id,
      name: name,
      image: image,
      category: category,
      description: description,
      quantity: quantity,
      price: price,
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
    );
  }

  @override
  // TODO: implement props
  List<Object?> get props =>
      [id, name, image, category, description, quantity, price];
}
