enum PayoutAccountType {
  ccp,
  dahabia,
  bank
  ;

  static PayoutAccountType fromDatabase(Object? value) {
    return switch (value) {
      'ccp' => PayoutAccountType.ccp,
      'dahabia' => PayoutAccountType.dahabia,
      _ => PayoutAccountType.bank,
    };
  }

  String get databaseValue => name;
}

class CarrierPayoutAccount {
  const CarrierPayoutAccount({
    required this.id,
    required this.carrierId,
    required this.accountType,
    required this.accountHolderName,
    required this.accountIdentifier,
    required this.bankOrCcpName,
    required this.isActive,
    required this.isVerified,
    required this.verifiedAt,
    required this.createdAt,
    required this.updatedAt,
  });

  factory CarrierPayoutAccount.fromJson(Map<String, dynamic> json) {
    return CarrierPayoutAccount(
      id: json['id'] as String,
      carrierId: json['carrier_id'] as String,
      accountType: PayoutAccountType.fromDatabase(json['account_type']),
      accountHolderName: (json['account_holder_name'] as String?)?.trim() ?? '',
      accountIdentifier: (json['account_identifier'] as String?)?.trim() ?? '',
      bankOrCcpName: (json['bank_or_ccp_name'] as String?)?.trim(),
      isActive: json['is_active'] as bool? ?? false,
      isVerified: json['is_verified'] as bool? ?? false,
      verifiedAt: DateTime.tryParse(json['verified_at'] as String? ?? ''),
      createdAt: DateTime.tryParse(json['created_at'] as String? ?? ''),
      updatedAt: DateTime.tryParse(json['updated_at'] as String? ?? ''),
    );
  }

  final String id;
  final String carrierId;
  final PayoutAccountType accountType;
  final String accountHolderName;
  final String accountIdentifier;
  final String? bankOrCcpName;
  final bool isActive;
  final bool isVerified;
  final DateTime? verifiedAt;
  final DateTime? createdAt;
  final DateTime? updatedAt;
}
