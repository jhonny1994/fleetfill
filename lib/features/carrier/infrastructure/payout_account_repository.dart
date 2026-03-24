import 'package:fleetfill/core/auth/auth.dart';
import 'package:fleetfill/core/config/config.dart';
import 'package:fleetfill/core/utils/app_logger.dart';
import 'package:fleetfill/features/carrier/domain/payout_account_models.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final payoutAccountRepositoryProvider = Provider<PayoutAccountRepository>((
  ref,
) {
  final environment = ref.watch(appEnvironmentConfigProvider);
  final logger = ref.watch(appLoggerProvider);
  return PayoutAccountRepository(environment: environment, logger: logger);
});

class PayoutAccountRepository {
  const PayoutAccountRepository({
    required this.environment,
    required this.logger,
  });

  final AppEnvironmentConfig environment;
  final AppLogger logger;

  SupabaseClient get _client => Supabase.instance.client;

  Future<List<CarrierPayoutAccount>> fetchMyPayoutAccounts() async {
    final response = await _client
        .from('payout_accounts')
        .select()
        .order('is_active', ascending: false)
        .order('created_at', ascending: false);

    return (response as List<dynamic>)
        .cast<Map<String, dynamic>>()
        .map(CarrierPayoutAccount.fromJson)
        .toList(growable: false);
  }

  Future<CarrierPayoutAccount> createPayoutAccount({
    required PayoutAccountType accountType,
    required String accountHolderName,
    required String accountIdentifier,
    required bool isActive,
    String? bankOrCcpName,
  }) async {
    final userId = _client.auth.currentUser?.id;
    if (userId == null) {
      throw const AuthException('authentication_required');
    }
    _validatePayoutAccountInput(
      accountType: accountType,
      bankOrCcpName: bankOrCcpName,
    );

    final response = await _client
        .from('payout_accounts')
        .insert({
          'carrier_id': userId,
          'account_type': accountType.databaseValue,
          'account_holder_name': accountHolderName.trim(),
          'account_identifier': accountIdentifier.trim(),
          'bank_or_ccp_name': _normalizedInstitutionName(
            accountType,
            bankOrCcpName,
          ),
          'is_active': isActive,
        })
        .select()
        .single();

    return CarrierPayoutAccount.fromJson(response);
  }

  Future<CarrierPayoutAccount> updatePayoutAccount({
    required String payoutAccountId,
    required PayoutAccountType accountType,
    required String accountHolderName,
    required String accountIdentifier,
    required bool isActive,
    String? bankOrCcpName,
  }) async {
    _validatePayoutAccountInput(
      accountType: accountType,
      bankOrCcpName: bankOrCcpName,
    );
    final response = await _client
        .from('payout_accounts')
        .update({
          'account_type': accountType.databaseValue,
          'account_holder_name': accountHolderName.trim(),
          'account_identifier': accountIdentifier.trim(),
          'bank_or_ccp_name': _normalizedInstitutionName(
            accountType,
            bankOrCcpName,
          ),
          'is_active': isActive,
        })
        .eq('id', payoutAccountId)
        .select()
        .single();

    return CarrierPayoutAccount.fromJson(response);
  }

  Future<void> deletePayoutAccount(String payoutAccountId) async {
    await _client.from('payout_accounts').delete().eq('id', payoutAccountId);
  }

  Future<void> refreshAuthSession(Ref ref) {
    return ref.read(authSessionControllerProvider.notifier).refresh();
  }

  String? _nullable(String? value) {
    final trimmed = value?.trim();
    if (trimmed == null || trimmed.isEmpty) {
      return null;
    }
    return trimmed;
  }

  void _validatePayoutAccountInput({
    required PayoutAccountType accountType,
    required String? bankOrCcpName,
  }) {
    if (accountType == PayoutAccountType.bank &&
        _nullable(bankOrCcpName) == null) {
      throw const FormatException(
        'Bank name is required for bank payout accounts.',
      );
    }
  }

  String? _normalizedInstitutionName(
    PayoutAccountType accountType,
    String? bankOrCcpName,
  ) {
    if (accountType == PayoutAccountType.ccp) {
      return null;
    }
    return _nullable(bankOrCcpName);
  }
}
