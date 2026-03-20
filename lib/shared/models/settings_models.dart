class ClientSettings {
  const ClientSettings({
    required this.bookingPricing,
    required this.deliveryReview,
    required this.appRuntime,
    required this.paymentAccounts,
  });

  factory ClientSettings.fromJson(Map<String, dynamic> json) {
    return ClientSettings(
      bookingPricing: BookingPricingSettings.fromJson(
        _asMap(json['booking_pricing']),
      ),
      deliveryReview: DeliveryReviewSettings.fromJson(
        _asMap(json['delivery_review']),
      ),
      appRuntime: AppRuntimeSettings.fromJson(_asMap(json['app_runtime'])),
      paymentAccounts: _asList(json['platform_payment_accounts'])
          .map(PlatformPaymentAccountSettings.fromJson)
          .toList(growable: false),
    );
  }

  final BookingPricingSettings bookingPricing;
  final DeliveryReviewSettings deliveryReview;
  final AppRuntimeSettings appRuntime;
  final List<PlatformPaymentAccountSettings> paymentAccounts;
}

class BookingPricingSettings {
  const BookingPricingSettings({
    required this.platformFeeRate,
    required this.carrierFeeRate,
    required this.insuranceRate,
    required this.insuranceMinFeeDzd,
    required this.taxRate,
    required this.paymentResubmissionDeadlineHours,
  });

  factory BookingPricingSettings.fromJson(Map<String, dynamic> json) {
    return BookingPricingSettings(
      platformFeeRate: (json['platform_fee_rate'] as num?)?.toDouble() ?? 0.05,
      carrierFeeRate: (json['carrier_fee_rate'] as num?)?.toDouble() ?? 0,
      insuranceRate: (json['insurance_rate'] as num?)?.toDouble() ?? 0.01,
      insuranceMinFeeDzd:
          (json['insurance_min_fee_dzd'] as num?)?.toDouble() ?? 100,
      taxRate: (json['tax_rate'] as num?)?.toDouble() ?? 0,
      paymentResubmissionDeadlineHours:
          (json['payment_resubmission_deadline_hours'] as num?)?.toInt() ?? 24,
    );
  }

  final double platformFeeRate;
  final double carrierFeeRate;
  final double insuranceRate;
  final double insuranceMinFeeDzd;
  final double taxRate;
  final int paymentResubmissionDeadlineHours;
}

class DeliveryReviewSettings {
  const DeliveryReviewSettings({required this.graceWindowHours});

  factory DeliveryReviewSettings.fromJson(Map<String, dynamic> json) {
    return DeliveryReviewSettings(
      graceWindowHours: (json['grace_window_hours'] as num?)?.toInt() ?? 24,
    );
  }

  final int graceWindowHours;
}

class AppRuntimeSettings {
  const AppRuntimeSettings({
    required this.maintenanceMode,
    required this.forceUpdateRequired,
    required this.minimumSupportedAndroidVersion,
    required this.minimumSupportedIosVersion,
  });

  factory AppRuntimeSettings.fromJson(Map<String, dynamic> json) {
    return AppRuntimeSettings(
      maintenanceMode: json['maintenance_mode'] as bool? ?? false,
      forceUpdateRequired: json['force_update_required'] as bool? ?? false,
      minimumSupportedAndroidVersion:
          (json['minimum_supported_android_version'] as num?)?.toInt() ?? 1,
      minimumSupportedIosVersion:
          (json['minimum_supported_ios_version'] as num?)?.toInt() ?? 1,
    );
  }

  final bool maintenanceMode;
  final bool forceUpdateRequired;
  final int minimumSupportedAndroidVersion;
  final int minimumSupportedIosVersion;
}

class PlatformPaymentAccountSettings {
  const PlatformPaymentAccountSettings({
    required this.id,
    required this.paymentRail,
    required this.displayName,
    required this.accountIdentifier,
    required this.accountHolderName,
    required this.instructionsText,
  });

  factory PlatformPaymentAccountSettings.fromJson(Map<String, dynamic> json) {
    return PlatformPaymentAccountSettings(
      id: (json['id'] as String?)?.trim() ?? '',
      paymentRail: (json['payment_rail'] as String?)?.trim() ?? '',
      displayName: (json['display_name'] as String?)?.trim() ?? '',
      accountIdentifier: (json['account_identifier'] as String?)?.trim() ?? '',
      accountHolderName:
          (json['account_holder_name'] as String?)?.trim() ?? '',
      instructionsText: (json['instructions_text'] as String?)?.trim(),
    );
  }

  final String id;
  final String paymentRail;
  final String displayName;
  final String accountIdentifier;
  final String accountHolderName;
  final String? instructionsText;
}

Map<String, dynamic> _asMap(Object? value) {
  return Map<String, dynamic>.from(
    (value as Map?) ?? const <String, dynamic>{},
  );
}

List<Map<String, dynamic>> _asList(Object? value) {
  return (value as List<dynamic>? ?? const <dynamic>[])
      .cast<Map<Object?, Object?>>()
      .map(Map<String, dynamic>.from)
      .toList(growable: false);
}
