class SteelSection {
  final int id;
  final String label;
  final String labelAr;
  final String symbol;
  final List<SteelType> types;

  SteelSection({
    required this.id,
    required this.label,
    required this.labelAr,
    required this.symbol,
    required this.types,
  });

  factory SteelSection.fromJson(Map<String, dynamic> json) {
    try {
      return SteelSection(
        id: json['id'] as int,
        label: json['label'] as String,
        labelAr: json['labelAr'] as String,
        symbol: json['symbol'] as String,
        types: (json['types'] as List<dynamic>)
            .map((type) => SteelType.fromJson(type as Map<String, dynamic>))
            .toList(),
      );
    } catch (e) {
      throw FormatException(
        'Invalid SteelSection JSON format: $e',
        json.toString(),
      );
    }
  }
}

class SteelType {
  final String name;
  final String symbol;
  final List<SteelVariant> variants;

  SteelType({required this.name, required this.symbol, required this.variants});

  factory SteelType.fromJson(Map<String, dynamic> json) {
    try {
      return SteelType(
        name: json['name'] as String,
        symbol: json['symbol'] as String,
        variants: (json['variants'] as List<dynamic>)
            .map(
              (variant) =>
                  SteelVariant.fromJson(variant as Map<String, dynamic>),
            )
            .toList(),
      );
    } catch (e) {
      throw FormatException(
        'Invalid SteelType JSON format: $e',
        json.toString(),
      );
    }
  }
}

class SteelVariant {
  final String size;
  final LocalizedName name;
  final String img;
  final String bigImg;
  final dynamic country;
  final double weight;
  final double h;
  final double b;
  final double tw;
  final double tf;
  final double al;
  final double? r;
  final double d;
  final double hi;
  final double ss;
  final double a;
  final double av;
  final double ix;
  final double iy;
  final double sx;
  final double sy;
  final double zx;
  final double zy;
  final double rx;
  final double ry;
  final double j;

  SteelVariant({
    required this.size,
    required this.name,
    required this.img,
    required this.bigImg,
    required this.country,
    required this.weight,
    required this.h,
    required this.b,
    required this.tw,
    required this.tf,
    required this.al,
    this.r,
    required this.d,
    required this.hi,
    required this.ss,
    required this.a,
    required this.av,
    required this.ix,
    required this.iy,
    required this.sx,
    required this.sy,
    required this.zx,
    required this.zy,
    required this.rx,
    required this.ry,
    required this.j,
  });

  factory SteelVariant.fromJson(Map<String, dynamic> json) {
    try {
      return SteelVariant(
        size: json['size'] as String,
        name: LocalizedName.fromJson(json['name'] as Map<String, dynamic>),
        img: json['img'] as String,
        bigImg: json['bigImg'] as String,
        country: json['country'],
        weight: _toDouble(json['weight']),
        h: _toDouble(json['h']),
        b: _toDouble(json['b']),
        tw: _toDouble(json['tw']),
        tf: _toDouble(json['tf']),
        al: _toDouble(json['Al']),
        r: json['r'] != null ? _toDouble(json['r']) : null,
        d: _toDouble(json['d']),
        hi: _toDouble(json['hi']),
        ss: _toDouble(json['ss']),
        a: _toDouble(json['A']),
        av: _toDouble(json['Av']),
        ix: _toDouble(json['Ix']),
        iy: _toDouble(json['Iy']),
        sx: _toDouble(json['Sx']),
        sy: _toDouble(json['Sy']),
        zx: _toDouble(json['Zx']),
        zy: _toDouble(json['Zy']),
        rx: _toDouble(json['rx']),
        ry: _toDouble(json['ry']),
        j: _toDouble(json['J']),
      );
    } catch (e) {
      throw FormatException(
        'Invalid SteelVariant JSON format: $e',
        json.toString(),
      );
    }
  }

  static double _toDouble(dynamic value) {
    if (value == null) return 0.0;
    if (value is double) return value;
    if (value is int) return value.toDouble();
    if (value is String) return double.tryParse(value) ?? 0.0;
    return 0.0;
  }

  String get countryString {
    if (country is String) {
      return country as String;
    } else if (country is num) {
      return country.toString();
    }
    return 'Unknown';
  }
}

class LocalizedName {
  final String ar;
  final String en;

  LocalizedName({required this.ar, required this.en});

  factory LocalizedName.fromJson(Map<String, dynamic> json) {
    try {
      return LocalizedName(ar: json['ar'] as String, en: json['en'] as String);
    } catch (e) {
      throw FormatException(
        'Invalid LocalizedName JSON format: $e',
        json.toString(),
      );
    }
  }
}
