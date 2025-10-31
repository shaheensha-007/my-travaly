class SimplehostalModel {
  SimplehostalModel({
    this.status,
    this.message,
    this.responseCode,
    this.data,
  });

  SimplehostalModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    responseCode = json['responseCode'];
    data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }

  bool? status;
  String? message;
  int? responseCode;
  Data? data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['message'] = message;
    map['responseCode'] = responseCode;
    if (data != null) {
      map['data'] = data?.toJson();
    }
    return map;
  }
}

class Data {
  Data({
    this.present,
    this.totalNumberOfResult,
    this.autoCompleteList,
  });

  Data.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    totalNumberOfResult = json['totalNumberOfResult'];
    autoCompleteList = json['autoCompleteList'] != null
        ? AutoCompleteList.fromJson(json['autoCompleteList'])
        : null;
  }

  bool? present;
  int? totalNumberOfResult;
  AutoCompleteList? autoCompleteList;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['present'] = present;
    map['totalNumberOfResult'] = totalNumberOfResult;
    map['autoCompleteList'] = autoCompleteList?.toJson();
    return map;
  }
}

class AutoCompleteList {
  AutoCompleteList({
    this.byPropertyName,
    this.byStreet,
    this.byCity,
    this.byState,
    this.byCountry,
  });

  AutoCompleteList.fromJson(Map<String, dynamic> json) {
    byPropertyName = json['byPropertyName'] != null
        ? ByPropertyName.fromJson(json['byPropertyName'])
        : null;
    byStreet = json['byStreet'] != null
        ? ByStreet.fromJson(json['byStreet'])
        : null;
    byCity = json['byCity'] != null ? ByCity.fromJson(json['byCity']) : null;
    byState = json['byState'] != null ? ByState.fromJson(json['byState']) : null;
    byCountry = json['byCountry'] != null
        ? ByCountry.fromJson(json['byCountry'])
        : null;
  }

  ByPropertyName? byPropertyName;
  ByStreet? byStreet;
  ByCity? byCity;
  ByState? byState;
  ByCountry? byCountry;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    if (byPropertyName != null) map['byPropertyName'] = byPropertyName?.toJson();
    if (byStreet != null) map['byStreet'] = byStreet?.toJson();
    if (byCity != null) map['byCity'] = byCity?.toJson();
    if (byState != null) map['byState'] = byState?.toJson();
    if (byCountry != null) map['byCountry'] = byCountry?.toJson();
    return map;
  }
}

// ============ REUSABLE CLASSES ============

class SearchResult {
  SearchResult({
    this.valueToDisplay,
    this.propertyName,
    this.address,
    this.searchArray,
  });

  SearchResult.fromJson(Map<String, dynamic> json) {
    valueToDisplay = json['valueToDisplay'];
    propertyName = json['propertyName'];
    address = json['address'] != null ? Address.fromJson(json['address']) : null;
    searchArray = json['searchArray'] != null
        ? SearchArray.fromJson(json['searchArray'])
        : null;
  }

  String? valueToDisplay;
  String? propertyName; // Only for property name results
  Address? address;
  SearchArray? searchArray;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['valueToDisplay'] = valueToDisplay;
    map['propertyName'] = propertyName;
    if (address != null) map['address'] = address?.toJson();
    if (searchArray != null) map['searchArray'] = searchArray?.toJson();
    return map;
  }
}

class Address {
  Address({
    this.street,
    this.city,
    this.state,
    this.country,
  });

  Address.fromJson(Map<String, dynamic> json) {
    street = json['street'];
    city = json['city'];
    state = json['state'];
    country = json['country'];
  }

  String? street;
  String? city;
  String? state;
  String? country;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['street'] = street;
    map['city'] = city;
    map['state'] = state;
    map['country'] = country;
    return map;
  }
}

class SearchArray {
  SearchArray({this.type, this.query});

  SearchArray.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    query = json['query']?.cast<String>();
  }

  String? type;
  List<String>? query;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['type'] = type;
    map['query'] = query;
    return map;
  }
}

// ============ CATEGORY CONTAINERS ============

class ByPropertyName {
  ByPropertyName({this.present, this.listOfResult, this.numberOfResult});

  ByPropertyName.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    if (json['listOfResult'] != null) {
      listOfResult = (json['listOfResult'] as List)
          .map((v) => SearchResult.fromJson(v))
          .toList();
    }
    numberOfResult = json['numberOfResult'];
  }

  bool? present;
  List<SearchResult>? listOfResult;
  int? numberOfResult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['present'] = present;
    if (listOfResult != null) {
      map['listOfResult'] = listOfResult!.map((v) => v.toJson()).toList();
    }
    map['numberOfResult'] = numberOfResult;
    return map;
  }
}

class ByStreet {
  ByStreet({this.present, this.listOfResult, this.numberOfResult});

  ByStreet.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    if (json['listOfResult'] != null) {
      listOfResult = (json['listOfResult'] as List)
          .map((v) => SearchResult.fromJson(v))
          .toList();
    }
    numberOfResult = json['numberOfResult'];
  }

  bool? present;
  List<SearchResult>? listOfResult;
  int? numberOfResult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['present'] = present;
    if (listOfResult != null) {
      map['listOfResult'] = listOfResult!.map((v) => v.toJson()).toList();
    }
    map['numberOfResult'] = numberOfResult;
    return map;
  }
}

class ByCity {
  ByCity({this.present, this.listOfResult, this.numberOfResult});

  ByCity.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    if (json['listOfResult'] != null) {
      listOfResult = (json['listOfResult'] as List)
          .map((v) => SearchResult.fromJson(v))
          .toList();
    }
    numberOfResult = json['numberOfResult'];
  }

  bool? present;
  List<SearchResult>? listOfResult;
  int? numberOfResult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['present'] = present;
    if (listOfResult != null) {
      map['listOfResult'] = listOfResult!.map((v) => v.toJson()).toList();
    }
    map['numberOfResult'] = numberOfResult;
    return map;
  }
}

class ByState {
  ByState({this.present, this.listOfResult, this.numberOfResult});

  ByState.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    if (json['listOfResult'] != null) {
      listOfResult = (json['listOfResult'] as List)
          .map((v) => SearchResult.fromJson(v))
          .toList();
    }
    numberOfResult = json['numberOfResult'];
  }

  bool? present;
  List<SearchResult>? listOfResult;
  int? numberOfResult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['present'] = present;
    if (listOfResult != null) {
      map['listOfResult'] = listOfResult!.map((v) => v.toJson()).toList();
    }
    map['numberOfResult'] = numberOfResult;
    return map;
  }
}

class ByCountry {
  ByCountry({this.present, this.listOfResult, this.numberOfResult});

  ByCountry.fromJson(Map<String, dynamic> json) {
    present = json['present'];
    if (json['listOfResult'] != null) {
      listOfResult = (json['listOfResult'] as List)
          .map((v) => SearchResult.fromJson(v))
          .toList();
    }
    numberOfResult = json['numberOfResult'];
  }

  bool? present;
  List<SearchResult>? listOfResult;
  int? numberOfResult;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['present'] = present;
    if (listOfResult != null) {
      map['listOfResult'] = listOfResult!.map((v) => v.toJson()).toList();
    }
    map['numberOfResult'] = numberOfResult;
    return map;
  }
}