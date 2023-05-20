import 'dart:io';
import 'dart:typed_data';

import 'package:base45/base45.dart';
import 'package:cbor/cbor.dart';
import 'package:qr_eu_digital_covid_certificate/src/models/certificate_model.dart';

abstract class ParseCovidCertificate {
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

  static CovidCertificate toObject(String encryptedData) => CovidCertificate.fromMap(toMap(encryptedData));
}
