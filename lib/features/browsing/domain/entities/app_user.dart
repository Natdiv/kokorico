import 'package:equatable/equatable.dart';
import 'package:kokorico/core/helpers/enum.dart';

/// The User entity.
class AppUser extends Equatable {
  /// The user's unique identifier.
  final String uid;
  final String name;
  final String firstName;
  final String email;
  final String phoneNumber;
  final String? imageUrl;
  final String? bio;
  final String? address;
  final String? referenceAddress;
  final UserRole role;
  final bool isVerified;
  final List<String> favorites;
  final List<String> cart;

  const AppUser({
    required this.uid,
    required this.name,
    required this.firstName,
    required this.email,
    required this.phoneNumber,
    this.imageUrl,
    this.bio,
    this.address,
    this.referenceAddress,
    this.role = UserRole.USER,
    this.isVerified = false,
    this.favorites = const [],
    this.cart = const [],
  });

  @override
  List<Object?> get props => [
        uid,
        name,
        firstName,
        email,
        phoneNumber,
        imageUrl,
        bio,
        address,
        referenceAddress,
        role,
        isVerified,
        favorites,
        cart,
      ];
}
