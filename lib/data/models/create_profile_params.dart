class CreateProfileParams {
  final String name;
  final String address;
  final String city;
  final String state;
  final String postCode;
  final String country;
  final String phone;
  final String fax;
  final String shipName;
  final String shipAdd;
  final String shipCity;
  final String shipState;
  final String shipPostcode;
  final String shipCountry;
  final String shipPhone;

  CreateProfileParams({
    required this.name,
    required this.address,
    required this.city,
    required this.state,
    required this.postCode,
    required this.country,
    required this.phone,
    required this.fax,
    required this.shipName,
    required this.shipAdd,
    required this.shipCity,
    required this.shipState,
    required this.shipPostcode,
    required this.shipCountry,
    required this.shipPhone,
  });

  Map<String, dynamic> toJson() => {
        "cus_name": name,
        "cus_add": address,
        "cus_city": city,
        "cus_state": state,
        "cus_postcode": postCode,
        "cus_country": country,
        "cus_phone": phone,
        "cus_fax": fax,
        "ship_name": shipName,
        "ship_add": shipAdd,
        "ship_city": shipCity,
        "ship_state": shipState,
        "ship_postcode": shipPostcode,
        "ship_country": shipCountry,
        "ship_phone": shipPhone,
      };
}
