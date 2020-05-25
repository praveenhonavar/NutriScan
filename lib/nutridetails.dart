import 'dart:io';


class Nutridetails {
  FoodSearchCriteria foodSearchCriteria;
  int totalHits;
  int currentPage;
  int totalPages;
  List<Foods> foods;

  Nutridetails(
      {this.foodSearchCriteria,
      this.totalHits,
      this.currentPage,
      this.totalPages,
      this.foods});

  Nutridetails.fromJson(Map<String, dynamic> json) {
    foodSearchCriteria = json['foodSearchCriteria'] != null
        ? new FoodSearchCriteria.fromJson(json['foodSearchCriteria'])
        : null;
    totalHits = json['totalHits'];
    currentPage = json['currentPage'];
    totalPages = json['totalPages'];
    if (json['foods'] != null) {
      foods = new List<Foods>();
      json['foods'].forEach((v) {
        foods.add(new Foods.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.foodSearchCriteria != null) {
      data['foodSearchCriteria'] = this.foodSearchCriteria.toJson();
    }
    data['totalHits'] = this.totalHits;
    data['currentPage'] = this.currentPage;
    data['totalPages'] = this.totalPages;
    if (this.foods != null) {
      data['foods'] = this.foods.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class FoodSearchCriteria {
  String query;
  String generalSearchInput;
  int pageNumber;
  bool requireAllWords;

  FoodSearchCriteria(
      {this.query,
      this.generalSearchInput,
      this.pageNumber,
      this.requireAllWords});

  FoodSearchCriteria.fromJson(Map<String, dynamic> json) {
    query = json['query'];
    generalSearchInput = json['generalSearchInput'];
    pageNumber = json['pageNumber'];
    requireAllWords = json['requireAllWords'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['query'] = this.query;
    data['generalSearchInput'] = this.generalSearchInput;
    data['pageNumber'] = this.pageNumber;
    data['requireAllWords'] = this.requireAllWords;
    return data;
  }
}

class Foods {
  int fdcId;
  String description;
  String dataType;
  String ndbNumber;
  String publishedDate;
  List<FoodNutrients> foodNutrients;
  String allHighlightFields;
  double score;
  String gtinUpc;
  String brandOwner;
  String ingredients;
  File foodimg;

  Foods(
      {this.fdcId,
      this.description,
      this.dataType,
      this.ndbNumber,
      this.publishedDate,
      this.foodNutrients,
      this.allHighlightFields,
      this.score,
      this.gtinUpc,
      this.brandOwner,
      this.ingredients});

  Foods.fromJson(Map<String, dynamic> json) {
    fdcId = json['fdcId'];
    description = json['description'];
    dataType = json['dataType'];
    ndbNumber = json['ndbNumber'];
    publishedDate = json['publishedDate'];
    if (json['foodNutrients'] != null) {
      foodNutrients = new List<FoodNutrients>();
      json['foodNutrients'].forEach((v) {
        foodNutrients.add(new FoodNutrients.fromJson(v));
      });
    }
    allHighlightFields = json['allHighlightFields'];
    score = json['score'];
    gtinUpc = json['gtinUpc'];
    brandOwner = json['brandOwner'];
    ingredients = json['ingredients'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['fdcId'] = this.fdcId;
    data['description'] = this.description;
    data['dataType'] = this.dataType;
    data['ndbNumber'] = this.ndbNumber;
    data['publishedDate'] = this.publishedDate;
    if (this.foodNutrients != null) {
      data['foodNutrients'] =
          this.foodNutrients.map((v) => v.toJson()).toList();
    }
    data['allHighlightFields'] = this.allHighlightFields;
    data['score'] = this.score;
    data['gtinUpc'] = this.gtinUpc;
    data['brandOwner'] = this.brandOwner;
    data['ingredients'] = this.ingredients;
    return data;
  }
}

class FoodNutrients {
  int nutrientId;
  String nutrientName;
  String nutrientNumber;
  String unitName;
  String derivationCode;
  String derivationDescription;
  double value;

  FoodNutrients(
      {
      this.nutrientId,
      this.nutrientName,
      this.nutrientNumber,
      this.unitName,
      this.derivationCode,
      this.derivationDescription,
      this.value});

  FoodNutrients.fromJson(Map<String, dynamic> json) {
    nutrientId = json['nutrientId'];
    nutrientName = json['nutrientName'];
    nutrientNumber = json['nutrientNumber'];
    unitName = json['unitName'];
    derivationCode = json['derivationCode'];
    derivationDescription = json['derivationDescription'];
    value = json['value'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['nutrientId'] = this.nutrientId;
    data['nutrientName'] = this.nutrientName;
    data['nutrientNumber'] = this.nutrientNumber;
    data['unitName'] = this.unitName;
    data['derivationCode'] = this.derivationCode;
    data['derivationDescription'] = this.derivationDescription;
    data['value'] = this.value;
    return data;
  }
}
