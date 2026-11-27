/// Typed model for a single Random User Generator profile.
///
/// Every field is nullable so missing values in the API response are handled
/// gracefully instead of crashing the UI. Credential/hash fields
/// (password, salt, md5, sha1, sha256) are intentionally NOT parsed.
class RandomUser {
  const RandomUser({
    this.gender,
    this.name,
    this.location,
    this.email,
    this.phone,
    this.cell,
    this.picture,
    this.nat,
    this.dob,
    this.registered,
    this.id,
    this.login,
  });

  final String? gender;
  final Name? name;
  final Location? location;
  final String? email;
  final String? phone;
  final String? cell;
  final Picture? picture;
  final String? nat;
  final DateInfo? dob;
  final DateInfo? registered;
  final UserId? id;
  final Login? login;

  factory RandomUser.fromJson(Map<String, dynamic> json) {
    return RandomUser(
      gender: json['gender'] as String?,
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : Location.fromJson(json['location'] as Map<String, dynamic>),
      email: json['email'] as String?,
      phone: json['phone'] as String?,
      cell: json['cell'] as String?,
      picture: json['picture'] == null
          ? null
          : Picture.fromJson(json['picture'] as Map<String, dynamic>),
      nat: json['nat'] as String?,
      dob: json['dob'] == null
          ? null
          : DateInfo.fromJson(json['dob'] as Map<String, dynamic>),
      registered: json['registered'] == null
          ? null
          : DateInfo.fromJson(json['registered'] as Map<String, dynamic>),
      id: json['id'] == null
          ? null
          : UserId.fromJson(json['id'] as Map<String, dynamic>),
      login: json['login'] == null
          ? null
          : Login.fromJson(json['login'] as Map<String, dynamic>),
    );
  }
}

class Name {
  const Name({this.title, this.first, this.last});

  final String? title;
  final String? first;
  final String? last;

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        title: json['title'] as String?,
        first: json['first'] as String?,
        last: json['last'] as String?,
      );

  /// Full display name, e.g. "Ms. Alice Dupont".
  String get full => [title, first, last]
      .where((part) => part != null && part.trim().isNotEmpty)
      .join(' ')
      .trim();
}

class Street {
  const Street({this.number, this.name});

  final int? number;
  final String? name;

  factory Street.fromJson(Map<String, dynamic> json) => Street(
        number: (json['number'] as num?)?.toInt(),
        name: json['name'] as String?,
      );

  String get full => [number?.toString(), name]
      .where((part) => part != null && part.trim().isNotEmpty)
      .join(' ')
      .trim();
}

class Timezone {
  const Timezone({this.offset, this.description});

  final String? offset;
  final String? description;

  factory Timezone.fromJson(Map<String, dynamic> json) => Timezone(
        offset: json['offset'] as String?,
        description: json['description'] as String?,
      );

  String get full => [offset, description]
      .where((part) => part != null && part.trim().isNotEmpty)
      .join(' ')
      .trim();
}

class Location {
  const Location({
    this.street,
    this.city,
    this.state,
    this.country,
    this.postcode,
    this.timezone,
  });

  final Street? street;
  final String? city;
  final String? state;
  final String? country;
  /// The API may return postcode as an int or a string; normalised to String.
  final String? postcode;
  final Timezone? timezone;

  factory Location.fromJson(Map<String, dynamic> json) {
    final rawPostcode = json['postcode'];
    return Location(
      street: json['street'] == null
          ? null
          : Street.fromJson(json['street'] as Map<String, dynamic>),
      city: json['city'] as String?,
      state: json['state'] as String?,
      country: json['country'] as String?,
      postcode: rawPostcode?.toString(),
      timezone: json['timezone'] == null
          ? null
          : Timezone.fromJson(json['timezone'] as Map<String, dynamic>),
    );
  }

  /// e.g. "Cebu City, Cebu, Philippines".
  String get cityStateCountry => [city, state, country]
      .where((part) => part != null && part.trim().isNotEmpty)
      .join(', ')
      .trim();
}

class Picture {
  const Picture({this.large, this.medium, this.thumbnail});

  final String? large;
  final String? medium;
  final String? thumbnail;

  factory Picture.fromJson(Map<String, dynamic> json) => Picture(
        large: json['large'] as String?,
        medium: json['medium'] as String?,
        thumbnail: json['thumbnail'] as String?,
      );
}

class DateInfo {
  const DateInfo({this.date, this.age});

  final String? date;
  final int? age;

  factory DateInfo.fromJson(Map<String, dynamic> json) => DateInfo(
        date: json['date'] as String?,
        age: (json['age'] as num?)?.toInt(),
      );
}

class UserId {
  const UserId({this.name, this.value});

  final String? name;
  final String? value;

  factory UserId.fromJson(Map<String, dynamic> json) => UserId(
        name: json['name'] as String?,
        value: json['value'] as String?,
      );
}

/// Only the non-secret account identifiers are retained.
/// Password, salt, md5, sha1 and sha256 are deliberately omitted.
class Login {
  const Login({this.uuid, this.username});

  final String? uuid;
  final String? username;

  factory Login.fromJson(Map<String, dynamic> json) => Login(
        uuid: json['uuid'] as String?,
        username: json['username'] as String?,
      );
}
