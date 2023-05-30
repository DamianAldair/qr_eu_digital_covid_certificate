/// Class for grouping certificate types
abstract class CertificateType {
  Map<String, dynamic> toMap();
}

/// Certificate type specific information.
///
/// Vaccination certificate
class VaccinationCertificate extends CertificateType {
  /// Disease or agent targeted: COVID-19 (SARS-CoV or one of its variants)
  final String agentTargeted;

  /// COVID-19 vaccine or prophylaxis
  final String vaccineOrProphylaxis;

  /// COVID-19 vaccine product
  final String product;

  /// COVID-19 vaccine marketing authorisation holder or manufacturer
  final String manufacturer;

  /// Number in a series of doses
  final int number;

  /// The overall number of doses in the series
  final int total;

  /// Date of vaccination
  final DateTime date;

  /// Member State or third country in which the vaccine was administered
  final String memberState;

  /// Certificate issuer
  final String issuer;

  /// Unique certificate identifier
  final String identifier;

  /// Default constructor
  VaccinationCertificate({
    required this.agentTargeted,
    required this.vaccineOrProphylaxis,
    required this.product,
    required this.manufacturer,
    required this.number,
    required this.total,
    required this.date,
    required this.memberState,
    required this.issuer,
    required this.identifier,
  });

  /// Initialization from a map
  factory VaccinationCertificate.fromMap(Map<String, dynamic> map) => VaccinationCertificate(
        agentTargeted: map["tg"] as String,
        vaccineOrProphylaxis: map["vp"] as String,
        product: map["mp"] as String,
        manufacturer: map["ma"] as String,
        number: (map["dn"] / 1.0 as double).toInt(),
        total: (map["sd"] / 1.0 as double).toInt(),
        date: DateTime.parse(map["dt"] as String),
        memberState: map["co"] as String,
        issuer: map["is"] as String,
        identifier: map["ci"] as String,
      );

  /// Get as a Map
  @override
  Map<String, dynamic> toMap() => {
        "tg": agentTargeted,
        "vp": vaccineOrProphylaxis,
        "mp": product,
        "ma": manufacturer,
        "dn": number,
        "sd": total,
        "dt": date.toIso8601String().split('T').first,
        "co": memberState,
        "is": issuer,
        "ci": identifier,
      };
}

/// Certificate type specific information.
///
/// Test certificate
class TestCertificate extends CertificateType {
  /// Disease or agent targeted: COVID-19 (SARS-CoV or one of its variants)
  final String agentTargeted;

  /// The type of test
  final String type;

  ///  Test name (nucleic acid amplification tests only)
  final String name;

  /// Test device identifier (rapid antigen tests only)
  final String deviceIdentifier;

  /// Date and time of the test sample collection
  final DateTime sampleCollection;

  /// Result of the test
  final String result;

  /// Testing centre or facility
  final String centreOrFacility;

  /// Member State or third country in which the test was carried out
  final String memberState;

  /// Certificate issuer
  final String issuer;

  /// Unique certificate identifier
  final String identifier;

  /// Default constructor
  TestCertificate({
    required this.agentTargeted,
    required this.type,
    required this.name,
    required this.deviceIdentifier,
    required this.sampleCollection,
    required this.result,
    required this.centreOrFacility,
    required this.memberState,
    required this.issuer,
    required this.identifier,
  });

  /// Initialization from a map
  factory TestCertificate.fromMap(Map<String, dynamic> map) => TestCertificate(
        agentTargeted: map["tg"] as String,
        type: map["tt"] as String,
        name: map["nm"] as String,
        deviceIdentifier: map["ma"] as String,
        sampleCollection: DateTime.parse(map["sc"] as String),
        result: map["tr"] as String,
        centreOrFacility: map["tc"] as String,
        memberState: map["co"] as String,
        issuer: map["is"] as String,
        identifier: map["ci"] as String,
      );

  /// Get as a Map
  @override
  Map<String, dynamic> toMap() => {
        "tg": agentTargeted,
        "tt": type,
        "nm": name,
        "ma": deviceIdentifier,
        "sc": sampleCollection.toIso8601String(),
        "tr": result,
        "tc": centreOrFacility,
        "co": memberState,
        "is": issuer,
        "ci": identifier,
      };
}

/// Certificate type specific information.
///
/// Recovery certificate
class RecoveryCertificate extends CertificateType {
  /// Disease or agent from which the holder has recovered: COVID-19 (SARS-CoV- 2 or one of its variants)
  final String agentTargeted;

  /// Date of the holder’s first positive NAAT test result
  final DateTime dateFirstPositive;

  /// Member State or third country in which the test was carried out
  final String memberState;

  /// Certificate issuer
  final String issuer;

  /// Certificate valid from
  final DateTime validFrom;

  /// Certificate valid until
  final DateTime validUntil;

  /// Unique certificate identifier
  final String identifier;

  /// Default constructor
  RecoveryCertificate({
    required this.agentTargeted,
    required this.dateFirstPositive,
    required this.memberState,
    required this.issuer,
    required this.validFrom,
    required this.validUntil,
    required this.identifier,
  });

  /// Initialization from a map
  factory RecoveryCertificate.fromMap(Map<String, dynamic> map) => RecoveryCertificate(
        agentTargeted: map["tg"] as String,
        dateFirstPositive: DateTime.parse(map["fr"] as String),
        memberState: map["co"] as String,
        issuer: map["is"] as String,
        validFrom: DateTime.parse(map["df"] as String),
        validUntil: DateTime.parse(map["du"] as String),
        identifier: map["ci"] as String,
      );

  /// Get as a Map
  @override
  Map<String, dynamic> toMap() => {
        "tg": agentTargeted,
        "fr": dateFirstPositive.toIso8601String().split('T').first,
        "co": memberState,
        "is": issuer,
        "df": validFrom.toIso8601String().split('T').first,
        "du": validUntil.toIso8601String().split('T').first,
        "ci": identifier,
      };
}
