import '../../domain/entities/covid_case.dart';

class CovidCaseModel extends CovidCase {
  CovidCaseModel({
    String? country,
    required int newConfirmed,
    required int totalConfirmed,
    required int newDeaths,
    required int totalDeaths,
    required int newRecovered,
    required int totalRecovered,
    required String updatedAt,
  }) : super(
          country: country!,
          newConfirmed: newConfirmed,
          totalConfirmed: totalConfirmed,
          newDeaths: newDeaths,
          totalDeaths: totalDeaths,
          newRecovered: newRecovered,
          totalRecovered: totalRecovered,
          updatedAt: updatedAt,
        );

  CovidCaseModel copyWith({
    String? country,
    required int newConfirmed,
    required int totalConfirmed,
    required int newDeaths,
    required int totalDeaths,
    required int newRecovered,
    required int totalRecovered,
  }) {
    return CovidCaseModel(
      country: country ?? this.country,
      newConfirmed: newConfirmed,
      totalConfirmed: totalConfirmed,
      newDeaths: newDeaths,
      totalDeaths: totalDeaths,
      newRecovered: newRecovered,
      totalRecovered: totalRecovered,
      updatedAt: updatedAt,
    );
  }

  factory CovidCaseModel.fromJson(Map<String, dynamic> json) {
    return CovidCaseModel(
      country: json['Country'] ?? '',
      newConfirmed: json['NewConfirmed'] ?? 0,
      totalConfirmed: json['TotalConfirmed'] ?? 0,
      newDeaths: json['NewDeaths'] ?? 0,
      totalDeaths: json['TotalDeaths'] ?? 0,
      newRecovered: json['NewRecovered'] ?? 0,
      totalRecovered: json['TotalRecovered'] ?? 0,
      updatedAt: json['Date']??'',
    );
  }

// Ignore: implicit_dynamic_map_literal
  Map<String, dynamic> toJson() {
    return {
      'Country': country,
      'NewConfirmed': newConfirmed,
      'TotalConfirmed': totalConfirmed,
      'NewDeaths': newDeaths,
      'TotalDeaths': totalDeaths,
      'NewRecovered': newRecovered,
      'TotalRecovered': totalRecovered,
      'Date': updatedAt
    };
  }
}
