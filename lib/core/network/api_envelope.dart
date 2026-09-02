import 'package:amna_food_industries_mobile_app/core/network/api_exception.dart';

/// Pluggable response envelope parser for Odoo / custom backends.
abstract class ApiEnvelope {
  const ApiEnvelope();

  Map<String, dynamic> unwrap(dynamic raw);

  factory ApiEnvelope.fromEnv(String? style) {
    return switch (style?.toLowerCase()) {
      'direct' => const DirectApiEnvelope(),
      'ok_data' => const OkDataApiEnvelope(),
      _ => const OkDataApiEnvelope(),
    };
  }
}

/// Response body is already the payload map.
class DirectApiEnvelope extends ApiEnvelope {
  const DirectApiEnvelope();

  @override
  Map<String, dynamic> unwrap(dynamic raw) {
    if (raw is Map<String, dynamic>) return raw;
    if (raw is Map) return Map<String, dynamic>.from(raw);
    throw ApiException(message: 'Unexpected API response');
  }
}

/// `{ "ok": true, "data": { ... } }` style envelope.
class OkDataApiEnvelope extends ApiEnvelope {
  const OkDataApiEnvelope();

  @override
  Map<String, dynamic> unwrap(dynamic raw) {
    if (raw is! Map) {
      throw ApiException(message: 'Unexpected API response');
    }

    final map = Map<String, dynamic>.from(raw);
    if (map.containsKey('ok') && map['ok'] != true) {
      throw ApiException(
        message: map['message']?.toString() ?? 'Request failed',
        data: map,
      );
    }

    final data = map['data'];
    if (data is Map<String, dynamic>) return data;
    if (data is Map) return Map<String, dynamic>.from(data);
    if (data == null) return map;
    return {'value': data};
  }
}
