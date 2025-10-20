class PointOfSale {
  int? id;
  String date;
  String business;
  String owner;
  String address;
  String city;
  String state;
  String zipCode;
  String phone;
  int plateQuantity;
  String serialNumbers;
  double price;
  String? notes;
  String? visits;

  PointOfSale({
    this.id,
    required this.date,
    required this.business,
    required this.owner,
    required this.address,
    required this.city,
    required this.state,
    required this.zipCode,
    required this.phone,
    required this.plateQuantity,
    required this.serialNumbers,
    required this.price,
    this.notes,
    this.visits,
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'date': date,
      'business': business,
      'owner': owner,
      'address': address,
      'city': city,
      'state': state,
      'zipCode': zipCode,
      'phone': phone,
      'plateQuantity': plateQuantity,
      'serialNumbers': serialNumbers,
      'price': price,
      'notes': notes,
      'visits': visits,
    };
  }

  factory PointOfSale.fromMap(Map<String, dynamic> map) {
    return PointOfSale(
      id: map['id'],
      date: map['date'],
      business: map['business'],
      owner: map['owner'],
      address: map['address'],
      city: map['city'],
      state: map['state'],
      zipCode: map['zipCode'],
      phone: map['phone'],
      plateQuantity: map['plateQuantity'],
      serialNumbers: map['serialNumbers'],
      price: map['price']?.toDouble() ?? 0.0,
      notes: map['notes'] ?? '',
      visits: map['visits'],
    );
  }
}
