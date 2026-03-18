import 'package:fleetfill/core/auth/auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final publicCarrierProfileProvider =
    FutureProvider.family<CarrierPublicProfileView, String>((ref, carrierId) {
      return ref
          .read(authRepositoryProvider)
          .fetchCarrierPublicProfile(carrierId);
    });
