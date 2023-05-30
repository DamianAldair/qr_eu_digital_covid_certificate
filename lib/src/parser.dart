import 'dart:io';
import 'dart:typed_data';

import 'package:base45/base45.dart';
import 'package:cbor/cbor.dart';
import 'package:qr_eu_digital_covid_certificate/src/models/certificate_model.dart';

/// Access point to library methods
abstract class ParseCovidCertificate {
  /// Converts the encoded `String` resulting from scanning the COVID Certificate QR to a `Map`.
  static Map toMap(String encryptedData) {
    String ed = encryptedData;
    if (ed.startsWith('HC1')) {
      ed = ed.substring(3);
      if (ed.startsWith(':')) {
        ed = ed.substring(1);
      }
    }
    final Uint8List bytes = Base45.decode(ed);
    final List<int> decompressed = zlib.decode(bytes);
    final CborValue decoded = cbor.decode(decompressed);
    final List<dynamic> cborContent = decoded.toObject() as List<dynamic>;
    final Map payload = cbor.decode(cborContent[2]).toObject() as Map;
    return payload;
  }

  /// Converts the COVID Certificate from a `Map` with a suitable structure to a `CovidCertificate` object.
  static CovidCertificate toObject(String encryptedData) => CovidCertificate.fromMap(toMap(encryptedData));
}
