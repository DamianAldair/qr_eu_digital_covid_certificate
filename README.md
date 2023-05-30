# QR - EU Digital COVID Certificate

by [Damian Aldair](https://github.com/DamianAldair)

---

A package for parsing the encrypted plaintext contained in the QR code of EU COVID-19 digital vaccination certificates.

Ideal for working in applications using QR readers.

## Note

This type of format is used in COVID certificates in the European Union and other countries such as Cuba.

[JSON Schema for EU Digital COVID Certificates](https://health.ec.europa.eu/publications/json-schema-eu-digital-covid-certificates_en)

## Getting started

Just import this library in the pubspec.yaml.

```yaml
dependencies:
  qr_eu_digital_covid_certificate:
```

All done.

## Usage

```dart
final Map<dynamic, dynamic> certificate = ParseCovidCertificate.toMap(exampleData);
final CovidCertificate cert = ParseCovidCertificate.toObject(exampleData);
```