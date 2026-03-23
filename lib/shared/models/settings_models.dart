import 'package:freezed_annotation/freezed_annotation.dart';

part 'settings_models.freezed.dart';

@freezed
abstract class ClientSettings with _$ClientSettings {
  const factory ClientSettings({
    required BookingPricingSettings bookingPricing,
    required DeliveryReviewSettings deliveryReview,
    required AppRuntimeSettings appRuntime,
    required LocalizationSettings localization,
    required List<PlatformPaymentAccountSettings> paymentAccounts,
  }) = _ClientSettings;

  const ClientSettings._();

  factory ClientSettings.fromJson(Map<String, dynamic> json) {
    return ClientSettings(
      bookingPricing: BookingPricingSettings.fromJson(
        _asMap(json['booking_pricing']),
      ),
      deliveryReview: DeliveryReviewSettings.fromJson(
        _asMap(json['delivery_review']),
      ),
      appRuntime: AppRuntimeSettings.fromJson(_asMap(json['app_runtime'])),
      localization: LocalizationSettings.fromJson(_asMap(json['localization'])),
      paymentAccounts: _asList(
        json['platform_payment_accounts'],
      ).map(PlatformPaymentAccountSettings.fromJson).toList(growable: false),
    );
  }
}

@freezed
abstract class LocalizationSettings with _$LocalizationSettings {
  const factory LocalizationSettings({
    required String fallbackLocale,
    required List<String> enabledLocaleCodes,
  }) = _LocalizationSettings;

  const LocalizationSettings._();

  factory LocalizationSettings.fromJson(Map<String, dynamic> json) {
    final enabledLocaleCodes = <String>{
      for (final item in json['enabled_locales'] as List<dynamic>? ?? const [])
        if ((item as String?)?.trim().isNotEmpty ?? false)
          (item!).trim().toLowerCase(),
    }.toList(growable: false);

    return LocalizationSettings(
      fallbackLocale:
          (json['fallback_locale'] as String?)?.trim().toLowerCase() ?? 'ar',
      enabledLocaleCodes: enabledLocaleCodes,
    );
  }
}

@freezed
abstract class BookingPricingSettings with _$BookingPricingSettings {
  const factory BookingPricingSettings({
    required double platformFeeRate,
    required double carrierFeeRate,
    required double insuranceRate,
    required double insuranceMinFeeDzd,
    required double taxRate,
    required int paymentResubmissionDeadlineHours,
  }) = _BookingPricingSettings;

  const BookingPricingSettings._();

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
}

@freezed
abstract class DeliveryReviewSettings with _$DeliveryReviewSettings {
  const factory DeliveryReviewSettings({
    required int graceWindowHours,
  }) = _DeliveryReviewSettings;

  const DeliveryReviewSettings._();

  factory DeliveryReviewSettings.fromJson(Map<String, dynamic> json) {
    return DeliveryReviewSettings(
      graceWindowHours: (json['grace_window_hours'] as num?)?.toInt() ?? 24,
    );
  }
}

@freezed
abstract class AppRuntimeSettings with _$AppRuntimeSettings {
  const factory AppRuntimeSettings({
    required bool maintenanceMode,
    required bool forceUpdateRequired,
    required int minimumSupportedAndroidVersion,
    required int minimumSupportedIosVersion,
  }) = _AppRuntimeSettings;

  const AppRuntimeSettings._();

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
}

@freezed
abstract class PlatformPaymentAccountSettings
    with _$PlatformPaymentAccountSettings {
  const factory PlatformPaymentAccountSettings({
    required String id,
    required String paymentRail,
    required String displayName,
    required String accountIdentifier,
    required String accountHolderName,
    required String? instructionsText,
  }) = _PlatformPaymentAccountSettings;

  const PlatformPaymentAccountSettings._();

  factory PlatformPaymentAccountSettings.fromJson(Map<String, dynamic> json) {
    return PlatformPaymentAccountSettings(
      id: (json['id'] as String?)?.trim() ?? '',
      paymentRail: (json['payment_rail'] as String?)?.trim() ?? '',
      displayName: (json['display_name'] as String?)?.trim() ?? '',
      accountIdentifier: (json['account_identifier'] as String?)?.trim() ?? '',
      accountHolderName: (json['account_holder_name'] as String?)?.trim() ?? '',
      instructionsText: (json['instructions_text'] as String?)?.trim(),
    );
  }
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
