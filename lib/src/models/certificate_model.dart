import 'package:qr_eu_digital_covid_certificate/src/models/certificate_type_model.dart';
import 'package:qr_eu_digital_covid_certificate/src/utils.dart' as util;

/// Object represented by a COVID Certificate of the European Union
class CovidCertificate {
  final DateTime issuedAt;
  final DateTime expiresAt;
  final String version;
  final String country;
  final String? identification;
  final String forename;
  final String standardisedForename;
  final String surname;
  final String standardisedSurname;
  final DateTime dateOfBirth;
  final CertificateType type;

  CovidCertificate({
    required this.issuedAt,
    required this.expiresAt,
    required this.version,
    required this.country,
    this.identification,
    required this.forename,
    required this.standardisedForename,
    required this.surname,
    required this.standardisedSurname,
    required this.dateOfBirth,
    required this.type,
  });

  factory CovidCertificate.fromMap(Map<dynamic, dynamic> map) {
    final cert = (map[-260] as Map)[1] as Map;
    final nam = cert["nam"] as Map;
    final CertificateType type;
    if (cert["v"] != null) {
      type = VaccinationCertificate.fromMap(util.toMap<String, dynamic>((cert["v"] as List).first));
    } else if (cert["t"] != null) {
      type = TestCertificate.fromMap((cert["t"] as List).first);
    } else if (cert["r"] != null) {
      type = RecoveryCertificate.fromMap((cert["r"] as List).first);
    } else {
      throw Error();
    }
    return CovidCertificate(
      issuedAt: DateTime.fromMillisecondsSinceEpoch(
        map[6] * 1000,
        isUtc: true,
      ),
      expiresAt: DateTime.fromMillisecondsSinceEpoch(
        map[4] * 1000,
        isUtc: true,
      ),
      version: cert["ver"],
      country: map[1],
      identification: cert["id"],
      forename: nam["gn"]!,
      standardisedForename: nam["gnt"]!,
      surname: nam["fn"]!,
      standardisedSurname: nam["fnt"]!,
      dateOfBirth: DateTime.parse(cert["dob"]),
      type: type,
    );
  }

  Map toMap() {
    final String c;
    switch (type.runtimeType) {
      case VaccinationCertificate:
        c = 'v';
        break;
      case TestCertificate:
        c = 't';
        break;
      case RecoveryCertificate:
        c = 'r';
        break;
      default:
        throw Error();
    }
    final map = {
      "ver": version,
      "country": country,
      "nam": {
        "gn": forename,
        "fn": surname,
        "gnt": standardisedForename,
        "fnt": standardisedSurname,
      },
      "dob": dateOfBirth.toIso8601String().split('T').first,
      c: [type.toMap()],
    };
    if (identification != null) {
      map.addEntries({"id": identification!}.entries);
    }
    return {
      1: country,
      4: issuedAt.millisecondsSinceEpoch,
      6: expiresAt.millisecondsSinceEpoch,
      -260: {
        1: map,
      }
    };
  }
}
