class IpGetModel {
  final String? ip;
  final String? network;
  final String? version;
  final String? city;
  final String? region;
  final String? regionCode;
  final String? country;
  final String? countryName;
  final String? countryCode;
  final String? countryCodeIso3;
  final String? countryCapital;
  final String? countryTld;
  final String? continentCode;
  final bool? inEu;
  final String? postal;
  final double? latitude;
  final double? longitude;
  final String? timezone;
  final String? utcOffset;
  final String? countryCallingCode;
  final String? currency;
  final String? currencyName;
  final String? languages;
  final double? countryArea;
  final int? countryPopulation;
  final String? asn;
  final String? org;

  IpGetModel({
    this.ip,
    this.network,
    this.version,
    this.city,
    this.region,
    this.regionCode,
    this.country,
    this.countryName,
    this.countryCode,
    this.countryCodeIso3,
    this.countryCapital,
    this.countryTld,
    this.continentCode,
    this.inEu,
    this.postal,
    this.latitude,
    this.longitude,
    this.timezone,
    this.utcOffset,
    this.countryCallingCode,
    this.currency,
    this.currencyName,
    this.languages,
    this.countryArea,
    this.countryPopulation,
    this.asn,
    this.org,
  });

  factory IpGetModel.fromJson(Map<String, dynamic> json) {
    return IpGetModel(
      ip: json['ip']?.toString(),
      network: json['network']?.toString(),
      version: json['version']?.toString(),
      city: json['city']?.toString(),
      region: json['region']?.toString(),
      regionCode: json['region_code']?.toString(),
      country: json['country']?.toString(),
      countryName: json['country_name']?.toString(),
      countryCode: json['country_code']?.toString(),
      countryCodeIso3: json['country_code_iso3']?.toString(),
      countryCapital: json['country_capital']?.toString(),
      countryTld: json['country_tld']?.toString(),
      continentCode: json['continent_code']?.toString(),
      inEu: json['in_eu'] as bool?,
      postal: json['postal']?.toString(),
      latitude: json['latitude']?.toDouble(),
      longitude: json['longitude']?.toDouble(),
      timezone: json['timezone']?.toString(),
      utcOffset: json['utc_offset']?.toString(),
      countryCallingCode: json['country_calling_code']?.toString(),
      currency: json['currency']?.toString(),
      currencyName: json['currency_name']?.toString(),
      languages: json['languages']?.toString(),
      countryArea: json['country_area']?.toDouble(),
      countryPopulation: json['country_population']?.toInt(),
      asn: json['asn']?.toString(),
      org: json['org']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'ip': ip,
      'network': network,
      'version': version,
      'city': city,
      'region': region,
      'region_code': regionCode,
      'country': country,
      'country_name': countryName,
      'country_code': countryCode,
      'country_code_iso3': countryCodeIso3,
      'country_capital': countryCapital,
      'country_tld': countryTld,
      'continent_code': continentCode,
      'in_eu': inEu,
      'postal': postal,
      'latitude': latitude,
      'longitude': longitude,
      'timezone': timezone,
      'utc_offset': utcOffset,
      'country_calling_code': countryCallingCode,
      'currency': currency,
      'currency_name': currencyName,
      'languages': languages,
      'country_area': countryArea,
      'country_population': countryPopulation,
      'asn': asn,
      'org': org,
    };
  }
}
