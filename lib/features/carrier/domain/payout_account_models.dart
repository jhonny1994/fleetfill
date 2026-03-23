import 'package:freezed_annotation/freezed_annotation.dart';

part 'payout_account_models.freezed.dart';

enum PayoutAccountType {
  ccp,
  dahabia,
  bank;

  static PayoutAccountType fromDatabase(Object? value) {
    return switch (value) {
      'ccp' => PayoutAccountType.ccp,
      'dahabia' => PayoutAccountType.dahabia,
      _ => PayoutAccountType.bank,
    };
  }

  String get databaseValue => name;
}

@freezed
abstract class CarrierPayoutAccount with _$CarrierPayoutAccount {
  const factory CarrierPayoutAccount({
    required String id,
    required String carrierId,
    required PayoutAccountType accountType,
    required String accountHolderName,
    required String accountIdentifier,
    required String? bankOrCcpName,
    required bool isActive,
    required bool isVerified,
    required DateTime? verifiedAt,
    required DateTime? createdAt,
    required DateTime? updatedAt,
  }) = _CarrierPayoutAccount;

  const CarrierPayoutAccount._();

  factory CarrierPayoutAccount.fromJson(Map<String, dynamic> json) {
    return CarrierPayoutAccount(
      id: json['id'] as String,
      carrierId: json['carrier_id'] as String,
      accountType: PayoutAccountType.fromDatabase(json['account_type']),
      accountHolderName:
          (json['account_holder_name'] as String?)?.trim() ?? '',
      accountIdentifier:
          (json['account_identifier'] as String?)?.trim() ?? '',
      bankOrCcpName: (json['bank_or_ccp_name'] as String?)?.trim(),
      isActive: json['is_active'] as bool? ?? false,
      isVerified: json['is_verified'] as bool? ?? false,
      verifiedAt: DateTime.tryParse(json['verified_at'] as String? ?? ''),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }
}
