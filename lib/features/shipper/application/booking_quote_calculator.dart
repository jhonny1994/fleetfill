import 'package:fleetfill/features/shipper/domain/domain.dart';
import 'package:fleetfill/shared/models/models.dart';

BookingPricingQuote calculateBookingQuote({
  required BookingReviewSelection bookingSelection,
  required bool includeInsurance,
  required ClientSettings? settings,
}) {
  final pricing = settings?.bookingPricing;
  final platformFeeRate = pricing?.platformFeeRate ?? 0.05;
  final carrierFeeRate = pricing?.carrierFeeRate ?? 0;
  final insuranceRate = pricing?.insuranceRate ?? 0.01;
  final insuranceMinFee = pricing?.insuranceMinFeeDzd ?? 100;
  final taxRate = pricing?.taxRate ?? 0;

  final base =
      bookingSelection.shipment.totalWeightKg *
      bookingSelection.result.pricePerKgDzd;
  final platformFee = base * platformFeeRate;
  final carrierFee = base * carrierFeeRate;
  final insuranceFee = includeInsurance
      ? (base * insuranceRate) < insuranceMinFee
            ? insuranceMinFee
            : base * insuranceRate
      : 0.0;
  final taxFee = (base + platformFee + carrierFee + insuranceFee) * taxRate;
  final total = base + platformFee + carrierFee + insuranceFee + taxFee;
  final payout = base + carrierFee;

  return BookingPricingQuote(
    pricePerKgDzd: bookingSelection.result.pricePerKgDzd,
    basePriceDzd: base,
    platformFeeDzd: platformFee,
    carrierFeeDzd: carrierFee,
    insuranceRate: includeInsurance ? insuranceRate : null,
    insuranceFeeDzd: insuranceFee,
    taxFeeDzd: taxFee,
    shipperTotalDzd: total,
    carrierPayoutDzd: payout,
  );
}
