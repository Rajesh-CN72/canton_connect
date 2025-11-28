// D:\FlutterProjects\Home_Cook\canton_connect\lib\data\models\address_model.dart

class Address {
  final String? id;
  final String fullName;
  final String phoneNumber;
  final String streetAddress;
  final String city;
  final String state;
  final String postalCode;
  final String country;
  final bool isDefault;

  const Address({
    this.id,
    required this.fullName,
    required this.phoneNumber,
    required this.streetAddress,
    required this.city,
    required this.state,
    required this.postalCode,
    required this.country,
    this.isDefault = false,
  });

  // Convert to JSON for sending to API
  Map<String, dynamic> toJson() => {
        if (id != null) 'id': id,
        'fullName': fullName,
        'phoneNumber': phoneNumber,
        'streetAddress': streetAddress,
        'city': city,
        'state': state,
        'postalCode': postalCode,
        'country': country,
        'isDefault': isDefault,
      };

  // Create from JSON received from API
  factory Address.fromJson(Map<String, dynamic> json) => Address(
        id: json['id'],
        fullName: json['fullName'],
        phoneNumber: json['phoneNumber'],
        streetAddress: json['streetAddress'],
        city: json['city'],
        state: json['state'],
        postalCode: json['postalCode'],
        country: json['country'],
        isDefault: json['isDefault'] ?? false,
      );

  // Copy with method for updates
  Address copyWith({
    String? id,
    String? fullName,
    String? phoneNumber,
    String? streetAddress,
    String? city,
    String? state,
    String? postalCode,
    String? country,
    bool? isDefault,
  }) =>
      Address(
        id: id ?? this.id,
        fullName: fullName ?? this.fullName,
        phoneNumber: phoneNumber ?? this.phoneNumber,
        streetAddress: streetAddress ?? this.streetAddress,
        city: city ?? this.city,
        state: state ?? this.state,
        postalCode: postalCode ?? this.postalCode,
        country: country ?? this.country,
        isDefault: isDefault ?? this.isDefault,
      );
}
