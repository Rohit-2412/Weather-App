class Snow {
  double? oneHour;

  Snow({this.oneHour});

  factory Snow.fromJson(Map<String, dynamic> json) => Snow(
        oneHour: (json['oneHour'] as num?)?.toDouble(),
      );

  Map<String, dynamic> toJson() => {
        'oneHour': oneHour,
      };
}
