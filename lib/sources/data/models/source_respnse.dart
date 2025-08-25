import 'source.dart';

class SourceRespnse {
  String? status;
  List<Source>? sources;

  SourceRespnse({this.status, this.sources});

  factory SourceRespnse.fromJson(Map<String, dynamic> json) => SourceRespnse(
    status: json['status']?.toString(),
    sources: (json['sources'] as List<dynamic>?)
        ?.map((e) => Source.fromJson(Map<String, dynamic>.from(e)))
        .toList(),
  );

  Map<String, dynamic> toJson() => {
    if (status != null) 'status': status,
    if (sources != null) 'sources': sources?.map((e) => e.toJson()).toList(),
  };
}
