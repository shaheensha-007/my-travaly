class SearchHostelModel {
  SearchHostelModel({
    this.status,
    this.message,
    this.responseCode,
    this.data,
  });

  factory SearchHostelModel.fromJson(Map<String, dynamic> json) {
    return SearchHostelModel(
      status: json['status'] as bool?,
      message: json['message'] as String?,
      responseCode: json['responseCode'] as int?,
      data: json['data'] != null ? HostelSearchData.fromJson(json['data'] as Map<String, dynamic>) : null,
    );
  }

  final bool? status;
  final String? message;
  final int? responseCode;
  final HostelSearchData? data;

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'responseCode': responseCode,
      if (data != null) 'data': data?.toJson(),
    };
  }
}

class HostelSearchData {
  HostelSearchData({
    this.arrayOfHotelList,
    this.arrayOfExcludedHotels,
    this.arrayOfExcludedSearchType,
  });

  factory HostelSearchData.fromJson(Map<String, dynamic> json) {
    return HostelSearchData(
      arrayOfHotelList: (json['arrayOfHotelList'] as List<dynamic>?)
          ?.map((v) => ArrayOfHotelList.fromJson(v as Map<String, dynamic>))
          .toList(),
      arrayOfExcludedHotels: (json['arrayOfExcludedHotels'] as List<dynamic>?)?.cast<String>(),
      arrayOfExcludedSearchType: (json['arrayOfExcludedSearchType'] as List<dynamic>?)?.cast<String>(),
    );
  }

  final List<ArrayOfHotelList>? arrayOfHotelList;
  final List<String>? arrayOfExcludedHotels;
  final List<String>? arrayOfExcludedSearchType;

  Map<String, dynamic> toJson() {
    return {
      if (arrayOfHotelList != null)
        'arrayOfHotelList': arrayOfHotelList?.map((v) => v.toJson()).toList(),
      'arrayOfExcludedHotels': arrayOfExcludedHotels,
      'arrayOfExcludedSearchType': arrayOfExcludedSearchType,
    };
  }
}

class ArrayOfHotelList {
  ArrayOfHotelList({
    this.propertyCode,
    this.propertyName,
    this.propertyImage,
    this.propertytype,
    this.propertyStar,
    this.propertyPoliciesAndAmmenities,
    this.propertyAddress,
    this.propertyUrl,
    this.roomName,
    this.numberOfAdults,
    this.markedPrice,
    this.propertyMaxPrice,
    this.propertyMinPrice,
    this.availableDeals,
    this.subscriptionStatus,
    this.propertyView,
    this.isFavorite,
    this.simplPriceList,
    this.googleReview,
  });

  factory ArrayOfHotelList.fromJson(Map<String, dynamic> json) {
    return ArrayOfHotelList(
      propertyCode: json['propertyCode'] as String?,
      propertyName: json['propertyName'] as String?,
      propertyImage: json['propertyImage'] != null
          ? PropertyImage.fromJson(json['propertyImage'] as Map<String, dynamic>)
          : null,
      propertytype: json['propertytype'] as String?,
      propertyStar: json['propertyStar'] as int?,
      propertyPoliciesAndAmmenities: json['propertyPoliciesAndAmmenities'] != null
          ? PropertyPoliciesAndAmenities.fromJson(json['propertyPoliciesAndAmmenities'] as Map<String, dynamic>)
          : null,
      propertyAddress: json['propertyAddress'] != null
          ? PropertyAddress.fromJson(json['propertyAddress'] as Map<String, dynamic>)
          : null,
      propertyUrl: json['propertyUrl'] as String?,
      roomName: json['roomName'] as String?,
      numberOfAdults: json['numberOfAdults'] as int?,
      markedPrice: json['markedPrice'] != null
          ? MarkedPrice.fromJson(json['markedPrice'] as Map<String, dynamic>)
          : null,
      propertyMaxPrice: json['propertyMaxPrice'] != null
          ? PropertyMaxPrice.fromJson(json['propertyMaxPrice'] as Map<String, dynamic>)
          : null,
      propertyMinPrice: json['propertyMinPrice'] != null
          ? PropertyMinPrice.fromJson(json['propertyMinPrice'] as Map<String, dynamic>)
          : null,
      availableDeals: (json['availableDeals'] as List<dynamic>?)
          ?.map((v) => AvailableDeals.fromJson(v as Map<String, dynamic>))
          .toList(),
      subscriptionStatus: json['subscriptionStatus'] != null
          ? SubscriptionStatus.fromJson(json['subscriptionStatus'] as Map<String, dynamic>)
          : null,
      propertyView: json['propertyView'] as int?,
      isFavorite: json['isFavorite'] as bool?,
      simplPriceList: json['simplPriceList'] != null
          ? SimplPriceList.fromJson(json['simplPriceList'] as Map<String, dynamic>)
          : null,
      googleReview: json['googleReview'] != null
          ? GoogleReview.fromJson(json['googleReview'] as Map<String, dynamic>)
          : null,
    );
  }

  final String? propertyCode;
  final String? propertyName;
  final PropertyImage? propertyImage;
  final String? propertytype;
  final int? propertyStar;
  final PropertyPoliciesAndAmenities? propertyPoliciesAndAmmenities;
  final PropertyAddress? propertyAddress;
  final String? propertyUrl;
  final String? roomName;
  final int? numberOfAdults;
  final MarkedPrice? markedPrice;
  final PropertyMaxPrice? propertyMaxPrice;
  final PropertyMinPrice? propertyMinPrice;
  final List<AvailableDeals>? availableDeals;
  final SubscriptionStatus? subscriptionStatus;
  final int? propertyView;
  final bool? isFavorite;
  final SimplPriceList? simplPriceList;
  final GoogleReview? googleReview;

  Map<String, dynamic> toJson() {
    return {
      'propertyCode': propertyCode,
      'propertyName': propertyName,
      if (propertyImage != null) 'propertyImage': propertyImage?.toJson(),
      'propertytype': propertytype,
      'propertyStar': propertyStar,
      if (propertyPoliciesAndAmmenities != null)
        'propertyPoliciesAndAmmenities': propertyPoliciesAndAmmenities?.toJson(),
      if (propertyAddress != null) 'propertyAddress': propertyAddress?.toJson(),
      'propertyUrl': propertyUrl,
      'roomName': roomName,
      'numberOfAdults': numberOfAdults,
      if (markedPrice != null) 'markedPrice': markedPrice?.toJson(),
      if (propertyMaxPrice != null) 'propertyMaxPrice': propertyMaxPrice?.toJson(),
      if (propertyMinPrice != null) 'propertyMinPrice': propertyMinPrice?.toJson(),
      if (availableDeals != null)
        'availableDeals': availableDeals?.map((v) => v.toJson()).toList(),
      if (subscriptionStatus != null) 'subscriptionStatus': subscriptionStatus?.toJson(),
      'propertyView': propertyView,
      'isFavorite': isFavorite,
      if (simplPriceList != null) 'simplPriceList': simplPriceList?.toJson(),
      if (googleReview != null) 'googleReview': googleReview?.toJson(),
    };
  }
}

// --- Google Review ---
class GoogleReview {
  GoogleReview({this.reviewPresent, this.data});

  factory GoogleReview.fromJson(Map<String, dynamic> json) {
    return GoogleReview(
      reviewPresent: json['reviewPresent'] as bool?,
      data: json['data'] != null
          ? GoogleReviewData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  final bool? reviewPresent;
  final GoogleReviewData? data;

  Map<String, dynamic> toJson() {
    return {
      'reviewPresent': reviewPresent,
      if (data != null) 'data': data?.toJson(),
    };
  }
}

class GoogleReviewData {
  GoogleReviewData({this.overallRating, this.totalUserRating, this.withoutDecimal});

  factory GoogleReviewData.fromJson(Map<String, dynamic> json) {
    return GoogleReviewData(
      overallRating: (json['overallRating'] as num?)?.toDouble(),
      totalUserRating: json['totalUserRating'] as int?,
      withoutDecimal: json['withoutDecimal'] as int?,
    );
  }

  final double? overallRating;
  final int? totalUserRating;
  final int? withoutDecimal;

  Map<String, dynamic> toJson() {
    return {
      'overallRating': overallRating,
      'totalUserRating': totalUserRating,
      'withoutDecimal': withoutDecimal,
    };
  }
}

// --- Simpl Price ---
class SimplPriceList {
  SimplPriceList({this.simplPrice, this.originalPrice});

  factory SimplPriceList.fromJson(Map<String, dynamic> json) {
    return SimplPriceList(
      simplPrice: json['simplPrice'] != null
          ? SimplPrice.fromJson(json['simplPrice'] as Map<String, dynamic>)
          : null,
      originalPrice: json['originalPrice'] as int?,
    );
  }

  final SimplPrice? simplPrice;
  final int? originalPrice;

  Map<String, dynamic> toJson() {
    return {
      if (simplPrice != null) 'simplPrice': simplPrice?.toJson(),
      'originalPrice': originalPrice,
    };
  }
}

class SimplPrice {
  SimplPrice({this.amount, this.displayAmount, this.currencyAmount, this.currencySymbol});

  factory SimplPrice.fromJson(Map<String, dynamic> json) {
    return SimplPrice(
      amount: (json['amount'] as num?)?.toDouble(),
      displayAmount: json['displayAmount'] as String?,
      currencyAmount: json['currencyAmount'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
    );
  }

  final double? amount;
  final String? displayAmount;
  final String? currencyAmount;
  final String? currencySymbol;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'displayAmount': displayAmount,
      'currencyAmount': currencyAmount,
      'currencySymbol': currencySymbol,
    };
  }
}

// --- Other Classes (unchanged structure, just factory + naming) ---

class SubscriptionStatus {
  SubscriptionStatus({this.status});

  factory SubscriptionStatus.fromJson(Map<String, dynamic> json) {
    return SubscriptionStatus(status: json['status'] as bool?);
  }

  final bool? status;

  Map<String, dynamic> toJson() => {'status': status};
}

class AvailableDeals {
  AvailableDeals({this.headerName, this.websiteUrl, this.dealType, this.price});

  factory AvailableDeals.fromJson(Map<String, dynamic> json) {
    return AvailableDeals(
      headerName: json['headerName'] as String?,
      websiteUrl: json['websiteUrl'] as String?,
      dealType: json['dealType'] as String?,
      price: json['price'] != null ? Price.fromJson(json['price'] as Map<String, dynamic>) : null,
    );
  }

  final String? headerName;
  final String? websiteUrl;
  final String? dealType;
  final Price? price;

  Map<String, dynamic> toJson() {
    return {
      'headerName': headerName,
      'websiteUrl': websiteUrl,
      'dealType': dealType,
      if (price != null) 'price': price?.toJson(),
    };
  }
}

class Price {
  Price({this.amount, this.displayAmount, this.currencyAmount, this.currencySymbol});

  factory Price.fromJson(Map<String, dynamic> json) {
    return Price(
      amount: json['amount'] as int?,
      displayAmount: json['displayAmount'] as String?,
      currencyAmount: json['currencyAmount'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
    );
  }

  final int? amount;
  final String? displayAmount;
  final String? currencyAmount;
  final String? currencySymbol;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'displayAmount': displayAmount,
      'currencyAmount': currencyAmount,
      'currencySymbol': currencySymbol,
    };
  }
}

class PropertyMinPrice {
  PropertyMinPrice({this.amount, this.displayAmount, this.currencyAmount, this.currencySymbol});

  factory PropertyMinPrice.fromJson(Map<String, dynamic> json) {
    return PropertyMinPrice(
      amount: json['amount'] as int?,
      displayAmount: json['displayAmount'] as String?,
      currencyAmount: json['currencyAmount'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
    );
  }

  final int? amount;
  final String? displayAmount;
  final String? currencyAmount;
  final String? currencySymbol;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'displayAmount': displayAmount,
      'currencyAmount': currencyAmount,
      'currencySymbol': currencySymbol,
    };
  }
}

class PropertyMaxPrice {
  PropertyMaxPrice({this.amount, this.displayAmount, this.currencyAmount, this.currencySymbol});

  factory PropertyMaxPrice.fromJson(Map<String, dynamic> json) {
    return PropertyMaxPrice(
      amount: json['amount'] as int?,
      displayAmount: json['displayAmount'] as String?,
      currencyAmount: json['currencyAmount'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
    );
  }

  final int? amount;
  final String? displayAmount;
  final String? currencyAmount;
  final String? currencySymbol;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'displayAmount': displayAmount,
      'currencyAmount': currencyAmount,
      'currencySymbol': currencySymbol,
    };
  }
}

class MarkedPrice {
  MarkedPrice({this.amount, this.displayAmount, this.currencyAmount, this.currencySymbol});

  factory MarkedPrice.fromJson(Map<String, dynamic> json) {
    return MarkedPrice(
      amount: (json['amount'] as num?)?.toDouble(),
      displayAmount: json['displayAmount'] as String?,
      currencyAmount: json['currencyAmount'] as String?,
      currencySymbol: json['currencySymbol'] as String?,
    );
  }

  final double? amount;
  final String? displayAmount;
  final String? currencyAmount;
  final String? currencySymbol;

  Map<String, dynamic> toJson() {
    return {
      'amount': amount,
      'displayAmount': displayAmount,
      'currencyAmount': currencyAmount,
      'currencySymbol': currencySymbol,
    };
  }
}

class PropertyAddress {
  PropertyAddress({
    this.street,
    this.city,
    this.state,
    this.country,
    this.zipcode,
    this.mapAddress,
    this.latitude,
    this.longitude,
  });

  factory PropertyAddress.fromJson(Map<String, dynamic> json) {
    return PropertyAddress(
      street: json['street'] as String?,
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      zipcode: json['zipcode'] as String?,
      mapAddress: json['mapAddress'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );
  }

  final String? street;
  final String? city;
  final String? state;
  final String? country;
  final String? zipcode;
  final String? mapAddress;
  final double? latitude;
  final double? longitude;

  Map<String, dynamic> toJson() {
    return {
      'street': street,
      'city': city,
      'state': state,
      'country': country,
      'zipcode': zipcode,
      'mapAddress': mapAddress,
      'latitude': latitude,
      'longitude': longitude,
    };
  }
}

class PropertyPoliciesAndAmenities {
  PropertyPoliciesAndAmenities({this.present, this.data});

  factory PropertyPoliciesAndAmenities.fromJson(Map<String, dynamic> json) {
    return PropertyPoliciesAndAmenities(
      present: json['present'] as bool?,
      data: json['data'] != null
          ? AmenitiesData.fromJson(json['data'] as Map<String, dynamic>)
          : null,
    );
  }

  final bool? present;
  final AmenitiesData? data;

  Map<String, dynamic> toJson() {
    return {
      'present': present,
      if (data != null) 'data': data?.toJson(),
    };
  }
}

class AmenitiesData {
  AmenitiesData({
    this.cancelPolicy,
    this.refundPolicy,
    this.childPolicy,
    this.damagePolicy,
    this.propertyRestriction,
    this.petsAllowed,
    this.coupleFriendly,
    this.suitableForChildren,
    this.bachularsAllowed,
    this.freeWifi,
    this.freeCancellation,
    this.payAtHotel,
    this.payNow,
    this.lastUpdatedOn,
  });

  factory AmenitiesData.fromJson(Map<String, dynamic> json) {
    return AmenitiesData(
      cancelPolicy: json['cancelPolicy'] as String?,
      refundPolicy: json['refundPolicy'] as String?,
      childPolicy: json['childPolicy'] as String?,
      damagePolicy: json['damagePolicy'] as String?,
      propertyRestriction: json['propertyRestriction'] as String?,
      petsAllowed: json['petsAllowed'] as bool?,
      coupleFriendly: json['coupleFriendly'] as bool?,
      suitableForChildren: json['suitableForChildren'] as bool?,
      bachularsAllowed: json['bachularsAllowed'] as bool?,
      freeWifi: json['freeWifi'] as bool?,
      freeCancellation: json['freeCancellation'] as bool?,
      payAtHotel: json['payAtHotel'] as bool?,
      payNow: json['payNow'] as bool?,
      lastUpdatedOn: json['lastUpdatedOn'] as String?,
    );
  }

  final String? cancelPolicy;
  final String? refundPolicy;
  final String? childPolicy;
  final String? damagePolicy;
  final String? propertyRestriction;
  final bool? petsAllowed;
  final bool? coupleFriendly;
  final bool? suitableForChildren;
  final bool? bachularsAllowed;
  final bool? freeWifi;
  final bool? freeCancellation;
  final bool? payAtHotel;
  final bool? payNow;
  final String? lastUpdatedOn;

  Map<String, dynamic> toJson() {
    return {
      'cancelPolicy': cancelPolicy,
      'refundPolicy': refundPolicy,
      'childPolicy': childPolicy,
      'damagePolicy': damagePolicy,
      'propertyRestriction': propertyRestriction,
      'petsAllowed': petsAllowed,
      'coupleFriendly': coupleFriendly,
      'suitableForChildren': suitableForChildren,
      'bachularsAllowed': bachularsAllowed,
      'freeWifi': freeWifi,
      'freeCancellation': freeCancellation,
      'payAtHotel': payAtHotel,
      'payNow': payNow,
      'lastUpdatedOn': lastUpdatedOn,
    };
  }
}

class PropertyImage {
  PropertyImage({this.fullUrl, this.location, this.imageName});

  factory PropertyImage.fromJson(Map<String, dynamic> json) {
    return PropertyImage(
      fullUrl: json['fullUrl'] as String?,
      location: json['location'] as String?,
      imageName: json['imageName'] as String?,
    );
  }

  final String? fullUrl;
  final String? location;
  final String? imageName;

  Map<String, dynamic> toJson() {
    return {
      'fullUrl': fullUrl,
      'location': location,
      'imageName': imageName,
    };
  }
}