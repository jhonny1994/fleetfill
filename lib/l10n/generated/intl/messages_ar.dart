// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a ar locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'ar';

  static String m0(documentCount, vehicleCount) =>
      "${documentCount} وثائق معلقة عبر ${vehicleCount} مركبات";

  static String m1(bookingId) => "Booking ${bookingId}";

  static String m2(carrierId) => "Carrier ${carrierId}";

  static String m3(reason) => "التحقق يحتاج إلى إجراء: ${reason}";

  static String m4(documentId) => "Document ${documentId}";

  static String m5(documentId) => "Generated document ${documentId}";

  static String m6(languageCode) => "اللغة الحالية: ${languageCode}";

  static String m7(notificationId) => "Notification ${notificationId}";

  static String m8(tripId) => "One-off trip ${tripId}";

  static String m9(proofId) => "Proof ${proofId}";

  static String m10(routeId) => "Route ${routeId}";

  static String m11(dates) =>
      "لا توجد نتيجة مطابقة في اليوم نفسه. أقرب التواريخ المطابقة: ${dates}";

  static String m12(count) => "نتائج البحث (${count})";

  static String m13(shipmentId) => "Shipment ${shipmentId}";

  static String m14(index) => "العنصر ${index}";

  static String m15(bookingId) => "Tracking ${bookingId}";

  static String m16(reason) => "تحقق المركبة يحتاج إلى إجراء: ${reason}";

  static String m17(reason) => "مرفوض: ${reason}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "adminAuditLogDescription": MessageLookupByLibrary.simpleMessage(
      "راجع أحدث الإجراءات الإدارية الحساسة ونتائجها.",
    ),
    "adminAuditLogTitle": MessageLookupByLibrary.simpleMessage(
      "Admin audit log",
    ),
    "adminDashboardDescription": MessageLookupByLibrary.simpleMessage(
      "Operational backlog health, alerts, and quick counts live here.",
    ),
    "adminDashboardNavLabel": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "adminDashboardTitle": MessageLookupByLibrary.simpleMessage(
      "Admin dashboard",
    ),
    "adminPaymentProofQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد إثباتات دفع تحتاج إلى مراجعة الآن.",
    ),
    "adminPaymentProofQueueTitle": MessageLookupByLibrary.simpleMessage(
      "مراجعة إثباتات الدفع",
    ),
    "adminQueuesDescription": MessageLookupByLibrary.simpleMessage(
      "Payments, verification, disputes, payouts, and email queues stay segmented inside one page.",
    ),
    "adminQueuesNavLabel": MessageLookupByLibrary.simpleMessage("Queues"),
    "adminQueuesTitle": MessageLookupByLibrary.simpleMessage("Admin queues"),
    "adminSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "Platform settings, maintenance mode, version policy, and monitoring summary live here.",
    ),
    "adminSettingsNavLabel": MessageLookupByLibrary.simpleMessage("Settings"),
    "adminSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Admin settings",
    ),
    "adminUsersDescription": MessageLookupByLibrary.simpleMessage(
      "User search and investigation live here.",
    ),
    "adminUsersNavLabel": MessageLookupByLibrary.simpleMessage("Users"),
    "adminUsersTitle": MessageLookupByLibrary.simpleMessage("Users"),
    "adminVerificationApproveAction": MessageLookupByLibrary.simpleMessage(
      "اعتماد",
    ),
    "adminVerificationApproveAllAction": MessageLookupByLibrary.simpleMessage(
      "اعتماد الكل",
    ),
    "adminVerificationApproveAllSuccess": MessageLookupByLibrary.simpleMessage(
      "تم اعتماد ملف التحقق.",
    ),
    "adminVerificationApprovedMessage": MessageLookupByLibrary.simpleMessage(
      "تم اعتماد وثيقة التحقق.",
    ),
    "adminVerificationAuditEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد عناصر تدقيق تحقق حديثة.",
    ),
    "adminVerificationAuditTitle": MessageLookupByLibrary.simpleMessage(
      "سجل تدقيق التحقق",
    ),
    "adminVerificationMissingDocumentsMessage":
        MessageLookupByLibrary.simpleMessage("لم يتم إرسال أي وثائق تحقق بعد."),
    "adminVerificationPacketDescription": MessageLookupByLibrary.simpleMessage(
      "راجع وثائق الملف الشخصي والمركبة معا قبل فتح الوصول التشغيلي.",
    ),
    "adminVerificationPacketTitle": MessageLookupByLibrary.simpleMessage(
      "ملف التحقق",
    ),
    "adminVerificationPendingDocumentsLabel":
        MessageLookupByLibrary.simpleMessage("الوثائق المعلقة"),
    "adminVerificationQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد ملفات تحقق للناقلين تحتاج إلى مراجعة الآن.",
    ),
    "adminVerificationQueueItemSubtitle": m0,
    "adminVerificationQueueSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "ملخص طابور التحقق",
    ),
    "adminVerificationQueueTitle": MessageLookupByLibrary.simpleMessage(
      "طابور تحقق الناقلين",
    ),
    "adminVerificationRejectAction": MessageLookupByLibrary.simpleMessage(
      "رفض",
    ),
    "adminVerificationRejectReasonHint": MessageLookupByLibrary.simpleMessage(
      "أضف السبب الذي يجب أن يراه الناقل.",
    ),
    "adminVerificationRejectReasonTitle": MessageLookupByLibrary.simpleMessage(
      "سبب الرفض",
    ),
    "adminVerificationRejectedMessage": MessageLookupByLibrary.simpleMessage(
      "تم رفض وثيقة التحقق.",
    ),
    "appGenericErrorMessage": MessageLookupByLibrary.simpleMessage(
      "تعذر على FleetFill إكمال هذا الإجراء حاليا.",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("FleetFill"),
    "authAccountCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء الحساب. تابع عبر تسجيل الدخول.",
    ),
    "authAuthenticationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "سجّل الدخول لمتابعة هذا الإجراء.",
    ),
    "authConfirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "أعد إدخال كلمة المرور",
    ),
    "authConfirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "تأكيد كلمة المرور",
    ),
    "authContinueWithLabel": MessageLookupByLibrary.simpleMessage(
      "أو المتابعة عبر",
    ),
    "authCreateAccountAction": MessageLookupByLibrary.simpleMessage(
      "إنشاء حساب",
    ),
    "authCreateAccountCta": MessageLookupByLibrary.simpleMessage(
      "إنشاء حساب جديد",
    ),
    "authCreatePasswordHint": MessageLookupByLibrary.simpleMessage(
      "أنشئ كلمة مرور قوية",
    ),
    "authEmailHint": MessageLookupByLibrary.simpleMessage("you@example.com"),
    "authEmailLabel": MessageLookupByLibrary.simpleMessage("البريد الإلكتروني"),
    "authEmailNotConfirmedMessage": MessageLookupByLibrary.simpleMessage(
      "أكد بريدك الإلكتروني قبل تسجيل الدخول.",
    ),
    "authForgotPasswordCta": MessageLookupByLibrary.simpleMessage(
      "هل نسيت كلمة المرور؟",
    ),
    "authForgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Password reset request handling belongs in the auth shell.",
    ),
    "authForgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Forgot password",
    ),
    "authGenericErrorMessage": MessageLookupByLibrary.simpleMessage(
      "تعذر على FleetFill إكمال طلب التحقق هذا.",
    ),
    "authGoogleAction": MessageLookupByLibrary.simpleMessage(
      "المتابعة عبر Google",
    ),
    "authGoogleStartedMessage": MessageLookupByLibrary.simpleMessage(
      "بدأ تسجيل الدخول عبر Google. عد إلى هنا بعد الموافقة.",
    ),
    "authGoogleUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "تسجيل الدخول عبر Google غير متاح في هذه البيئة.",
    ),
    "authHaveAccountCta": MessageLookupByLibrary.simpleMessage(
      "لديك حساب بالفعل؟ سجّل الدخول",
    ),
    "authHidePasswordAction": MessageLookupByLibrary.simpleMessage(
      "إخفاء كلمة المرور",
    ),
    "authInvalidCredentialsMessage": MessageLookupByLibrary.simpleMessage(
      "تحقق من البريد الإلكتروني وكلمة المرور ثم أعد المحاولة.",
    ),
    "authInvalidEmailMessage": MessageLookupByLibrary.simpleMessage(
      "أدخل بريدا إلكترونيا صالحا.",
    ),
    "authKeepSignedInLabel": MessageLookupByLibrary.simpleMessage(
      "إبقائي مسجّل الدخول",
    ),
    "authNetworkErrorMessage": MessageLookupByLibrary.simpleMessage(
      "تم اكتشاف مشكلة في الشبكة. أعد المحاولة بعد قليل.",
    ),
    "authNewPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "كلمة المرور الجديدة",
    ),
    "authPasswordHint": MessageLookupByLibrary.simpleMessage(
      "أدخل كلمة المرور",
    ),
    "authPasswordLabel": MessageLookupByLibrary.simpleMessage("كلمة المرور"),
    "authPasswordMinLengthMessage": MessageLookupByLibrary.simpleMessage(
      "استخدم 8 أحرف على الأقل.",
    ),
    "authPasswordMismatchMessage": MessageLookupByLibrary.simpleMessage(
      "كلمتا المرور غير متطابقتين.",
    ),
    "authPasswordResetInfoMessage": MessageLookupByLibrary.simpleMessage(
      "سيرسل FleetFill رابط إعادة التعيين إلى البريد الإلكتروني المسجل.",
    ),
    "authPasswordUpdatedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تحديث كلمة المرور.",
    ),
    "authRequiredFieldMessage": MessageLookupByLibrary.simpleMessage(
      "هذا الحقل مطلوب.",
    ),
    "authResetEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "تم إرسال تعليمات إعادة تعيين كلمة المرور.",
    ),
    "authResetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "عيّن كلمة مرور جديدة بعد فتح رابط الاسترداد الآمن.",
    ),
    "authResetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reset password",
    ),
    "authResetPasswordUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "افتح هذه الشاشة من رابط استعادة كلمة المرور لتعيين كلمة مرور جديدة.",
    ),
    "authSendResetAction": MessageLookupByLibrary.simpleMessage(
      "إرسال رابط إعادة التعيين",
    ),
    "authSessionExpiredAction": MessageLookupByLibrary.simpleMessage(
      "تسجيل الدخول مرة أخرى",
    ),
    "authSessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "انتهت الجلسة. سجّل الدخول مرة أخرى للمتابعة بأمان.",
    ),
    "authSessionExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "انتهت الجلسة",
    ),
    "authShowPasswordAction": MessageLookupByLibrary.simpleMessage(
      "إظهار كلمة المرور",
    ),
    "authSignInAction": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "authSignInDescription": MessageLookupByLibrary.simpleMessage(
      "Email/password and Google sign-in entry points live here.",
    ),
    "authSignInSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الدخول بنجاح.",
    ),
    "authSignInTitle": MessageLookupByLibrary.simpleMessage("Sign in"),
    "authSignUpDescription": MessageLookupByLibrary.simpleMessage(
      "أنشئ حساب FleetFill للبدء في الشحن أو نشر السعة.",
    ),
    "authSignUpTitle": MessageLookupByLibrary.simpleMessage("Create account"),
    "authUpdatePasswordAction": MessageLookupByLibrary.simpleMessage(
      "تحديث كلمة المرور",
    ),
    "authUserAlreadyRegisteredMessage": MessageLookupByLibrary.simpleMessage(
      "يوجد حساب بالفعل لهذا البريد الإلكتروني.",
    ),
    "authVerificationEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "تحقق من بريدك الإلكتروني لتأكيد الحساب قبل تسجيل الدخول.",
    ),
    "bookingBasePriceLabel": MessageLookupByLibrary.simpleMessage(
      "السعر الأساسي",
    ),
    "bookingCarrierFeeLabel": MessageLookupByLibrary.simpleMessage(
      "رسوم الناقل",
    ),
    "bookingCarrierPayoutLabel": MessageLookupByLibrary.simpleMessage(
      "مستحق الناقل",
    ),
    "bookingConfirmAction": MessageLookupByLibrary.simpleMessage("تأكيد الحجز"),
    "bookingCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "تم إنشاء الحجز. تابع إلى تعليمات الدفع.",
    ),
    "bookingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Shared booking detail routes sit above role shells.",
    ),
    "bookingDetailTitle": m1,
    "bookingInsuranceAction": MessageLookupByLibrary.simpleMessage(
      "خيار التأمين",
    ),
    "bookingInsuranceDescription": MessageLookupByLibrary.simpleMessage(
      "التأمين اختياري ويُحسب كنسبة مئوية مع حد أدنى للرسوم.",
    ),
    "bookingInsuranceFeeLabel": MessageLookupByLibrary.simpleMessage(
      "رسوم التأمين",
    ),
    "bookingInsuranceIncludedLabel": MessageLookupByLibrary.simpleMessage(
      "مضاف",
    ),
    "bookingInsuranceLabel": MessageLookupByLibrary.simpleMessage("التأمين"),
    "bookingInsuranceNotIncludedLabel": MessageLookupByLibrary.simpleMessage(
      "غير مضاف",
    ),
    "bookingPaymentReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "مرجع الدفع",
    ),
    "bookingPlatformFeeLabel": MessageLookupByLibrary.simpleMessage(
      "رسوم المنصة",
    ),
    "bookingPricingBreakdownAction": MessageLookupByLibrary.simpleMessage(
      "تفصيل السعر",
    ),
    "bookingReviewDescription": MessageLookupByLibrary.simpleMessage(
      "Carrier reputation, trip detail, and pricing review live here before payment.",
    ),
    "bookingReviewTitle": MessageLookupByLibrary.simpleMessage(
      "Booking review",
    ),
    "bookingStatusCancelledLabel": MessageLookupByLibrary.simpleMessage("ملغى"),
    "bookingStatusCompletedLabel": MessageLookupByLibrary.simpleMessage(
      "مكتمل",
    ),
    "bookingStatusConfirmedLabel": MessageLookupByLibrary.simpleMessage("مؤكد"),
    "bookingStatusDeliveredPendingReviewLabel":
        MessageLookupByLibrary.simpleMessage("تم التسليم وبانتظار المراجعة"),
    "bookingStatusDisputedLabel": MessageLookupByLibrary.simpleMessage(
      "متنازع عليه",
    ),
    "bookingStatusInTransitLabel": MessageLookupByLibrary.simpleMessage(
      "في الطريق",
    ),
    "bookingStatusPaymentUnderReviewLabel":
        MessageLookupByLibrary.simpleMessage("الدفع قيد المراجعة"),
    "bookingStatusPendingPaymentLabel": MessageLookupByLibrary.simpleMessage(
      "بانتظار الدفع",
    ),
    "bookingStatusPickedUpLabel": MessageLookupByLibrary.simpleMessage(
      "تم الاستلام",
    ),
    "bookingTaxFeeLabel": MessageLookupByLibrary.simpleMessage("الضريبة"),
    "bookingTotalLabel": MessageLookupByLibrary.simpleMessage(
      "الإجمالي النهائي",
    ),
    "bookingTrackingNumberLabel": MessageLookupByLibrary.simpleMessage(
      "رقم التتبع",
    ),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("إلغاء"),
    "carrierBookingsDescription": MessageLookupByLibrary.simpleMessage(
      "Active and historical booking worklists live in this branch.",
    ),
    "carrierBookingsNavLabel": MessageLookupByLibrary.simpleMessage("Bookings"),
    "carrierBookingsTitle": MessageLookupByLibrary.simpleMessage(
      "Carrier bookings",
    ),
    "carrierHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Verification, trips, booking actions, and payout reminders live here.",
    ),
    "carrierHomeNavLabel": MessageLookupByLibrary.simpleMessage("Home"),
    "carrierHomeTitle": MessageLookupByLibrary.simpleMessage("Carrier home"),
    "carrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Carrier verification status, payout reminders, and profile tools live here.",
    ),
    "carrierProfileNavLabel": MessageLookupByLibrary.simpleMessage("Profile"),
    "carrierProfileSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Carrier details",
    ),
    "carrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Carrier profile",
    ),
    "carrierProfileVerificationLabel": MessageLookupByLibrary.simpleMessage(
      "Verification",
    ),
    "carrierProfileVerificationPending": MessageLookupByLibrary.simpleMessage(
      "Pending",
    ),
    "carrierProfileVerificationRejected": MessageLookupByLibrary.simpleMessage(
      "Rejected",
    ),
    "carrierProfileVerificationVerified": MessageLookupByLibrary.simpleMessage(
      "Verified",
    ),
    "carrierPublicProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Public carrier reputation and trust cues live here.",
    ),
    "carrierPublicProfileTitle": m2,
    "carrierVehiclesShortcutDescription": MessageLookupByLibrary.simpleMessage(
      "أدر الشاحنات وارفع الوثائق الناقصة وعالج عوائق التحقق.",
    ),
    "carrierVerificationCenterDescription": MessageLookupByLibrary.simpleMessage(
      "ارفع واستبدل وثائق التحقق الخاصة بالملف الشخصي أو المركبة من مكان واحد.",
    ),
    "carrierVerificationCenterTitle": MessageLookupByLibrary.simpleMessage(
      "مركز التحقق",
    ),
    "carrierVerificationPendingBanner": MessageLookupByLibrary.simpleMessage(
      "ملف التحقق الخاص بك قيد المراجعة. ارفع أي وثائق ناقصة لتسريع الاعتماد.",
    ),
    "carrierVerificationQueueHint": MessageLookupByLibrary.simpleMessage(
      "تبقى متطلبات التحقق والوثائق الناقصة مجمعة داخل فرع الملف الشخصي.",
    ),
    "carrierVerificationRejectedBanner": m3,
    "carrierVerificationSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "ملخص التحقق",
    ),
    "confirmLabel": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "documentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "افتح هذا المستند عبر العارض الآمن عندما يصبح الوصول جاهزا.",
    ),
    "documentViewerOpenAction": MessageLookupByLibrary.simpleMessage(
      "افتح المستند",
    ),
    "documentViewerTitle": m4,
    "documentViewerUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "الوصول الآمن إلى المستند غير متاح مؤقتا.",
    ),
    "editCarrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "حدّث بيانات الاتصال ومعلومات الناقل الخاصة بك.",
    ),
    "editCarrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Edit carrier profile",
    ),
    "editShipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "حدّث بيانات الاتصال الخاصة بالمرسل.",
    ),
    "editShipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Edit shipper profile",
    ),
    "errorTitle": MessageLookupByLibrary.simpleMessage("حدثت مشكلة"),
    "forbiddenAdminStepUpMessage": MessageLookupByLibrary.simpleMessage(
      "أعد تسجيل التحقق حديثا قبل فتح هذا القسم الإداري الحساس.",
    ),
    "forbiddenMessage": MessageLookupByLibrary.simpleMessage(
      "هذا القسم غير متاح لهذا الحساب.",
    ),
    "forbiddenTitle": MessageLookupByLibrary.simpleMessage("الوصول مقيّد"),
    "generatedDocumentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "افتح الفواتير والإيصالات المولدة من مسار مشترك وآمن.",
    ),
    "generatedDocumentViewerTitle": m5,
    "generatedDocumentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "ستظهر الفاتورة والإيصال المولدان هنا عند توفرهما.",
    ),
    "generatedDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "المستندات المولدة",
    ),
    "languageOptionArabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "languageOptionEnglish": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
    "languageOptionFrench": MessageLookupByLibrary.simpleMessage("الفرنسية"),
    "languageSelectionCurrentMessage": m6,
    "languageSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "اختر اللغة التي تريد استخدامها داخل FleetFill.",
    ),
    "languageSelectionTitle": MessageLookupByLibrary.simpleMessage(
      "Language selection",
    ),
    "loadMoreLabel": MessageLookupByLibrary.simpleMessage("تحميل المزيد"),
    "loadingMessage": MessageLookupByLibrary.simpleMessage(
      "يقوم FleetFill بتحضير مساحة العمل الخاصة بك.",
    ),
    "loadingTitle": MessageLookupByLibrary.simpleMessage("جار التحميل"),
    "maintenanceDescription": MessageLookupByLibrary.simpleMessage(
      "خدمة FleetFill غير متاحة مؤقتا أثناء أعمال الصيانة.",
    ),
    "maintenanceTitle": MessageLookupByLibrary.simpleMessage(
      "Maintenance mode",
    ),
    "mediaUploadPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Guide the user back to media access when they need to upload proof or documents.",
    ),
    "mediaUploadPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Media upload permission",
    ),
    "moneySummaryTitle": MessageLookupByLibrary.simpleMessage("ملخص التسعير"),
    "myRoutesActiveRoutesLabel": MessageLookupByLibrary.simpleMessage(
      "المسارات المتكررة النشطة",
    ),
    "myRoutesActiveTripsLabel": MessageLookupByLibrary.simpleMessage(
      "الرحلات الفردية النشطة",
    ),
    "myRoutesAddAction": MessageLookupByLibrary.simpleMessage("إضافة سعة"),
    "myRoutesCreateRouteAction": MessageLookupByLibrary.simpleMessage(
      "إضافة مسار متكرر",
    ),
    "myRoutesCreateTripAction": MessageLookupByLibrary.simpleMessage(
      "إضافة رحلة فردية",
    ),
    "myRoutesDescription": MessageLookupByLibrary.simpleMessage(
      "Recurring routes and one-off trips stay grouped in one branch.",
    ),
    "myRoutesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "انشر مسارا متكررا أو رحلة فردية لبدء عرض السعة.",
    ),
    "myRoutesNavLabel": MessageLookupByLibrary.simpleMessage("Routes"),
    "myRoutesOneOffTab": MessageLookupByLibrary.simpleMessage(
      "الرحلات الفردية",
    ),
    "myRoutesPublishedCapacityLabel": MessageLookupByLibrary.simpleMessage(
      "السعة المنشورة",
    ),
    "myRoutesRecurringTab": MessageLookupByLibrary.simpleMessage(
      "المسارات المتكررة",
    ),
    "myRoutesReservedCapacityLabel": MessageLookupByLibrary.simpleMessage(
      "السعة المحجوزة",
    ),
    "myRoutesRouteListTitle": MessageLookupByLibrary.simpleMessage(
      "المسارات المتكررة",
    ),
    "myRoutesSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "ملخص نشر السعة",
    ),
    "myRoutesTitle": MessageLookupByLibrary.simpleMessage("My routes"),
    "myRoutesTripListTitle": MessageLookupByLibrary.simpleMessage(
      "الرحلات الفردية",
    ),
    "myRoutesUpcomingDeparturesLabel": MessageLookupByLibrary.simpleMessage(
      "الانطلاقات القادمة",
    ),
    "myRoutesUtilizationLabel": MessageLookupByLibrary.simpleMessage(
      "معدل الاستخدام",
    ),
    "myShipmentsDescription": MessageLookupByLibrary.simpleMessage(
      "Active, history, and draft shipment states stay inside this branch.",
    ),
    "myShipmentsNavLabel": MessageLookupByLibrary.simpleMessage("Shipments"),
    "myShipmentsTitle": MessageLookupByLibrary.simpleMessage("My shipments"),
    "noExactResultsMessage": MessageLookupByLibrary.simpleMessage(
      "لا يوجد مسار مطابق تماما لهذا البحث حاليا.",
    ),
    "noExactResultsTitle": MessageLookupByLibrary.simpleMessage(
      "لم يتم العثور على مسار مطابق",
    ),
    "notFoundMessage": MessageLookupByLibrary.simpleMessage(
      "تعذر العثور على الصفحة أو العنصر المطلوب.",
    ),
    "notFoundTitle": MessageLookupByLibrary.simpleMessage("غير موجود"),
    "notificationDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع التفاصيل الكاملة لهذا الإشعار.",
    ),
    "notificationDetailTitle": m7,
    "notificationsCenterDescription": MessageLookupByLibrary.simpleMessage(
      "راجع التنبيهات الأخيرة وتحديثات الحجوزات والتذكيرات المهمة.",
    ),
    "notificationsCenterTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "notificationsPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Explain why tracking and booking updates matter before opening system settings.",
    ),
    "notificationsPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications permission",
    ),
    "offlineMessage": MessageLookupByLibrary.simpleMessage(
      "أنت غير متصل حاليا. بعض الإجراءات غير متاحة مؤقتا.",
    ),
    "oneOffTripActivateAction": MessageLookupByLibrary.simpleMessage(
      "تفعيل الرحلة",
    ),
    "oneOffTripActivateConfirmationMessage":
        MessageLookupByLibrary.simpleMessage(
          "هل تريد تفعيل هذه الرحلة للحجوزات الجديدة؟",
        ),
    "oneOffTripActivatedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تفعيل الرحلة الفردية.",
    ),
    "oneOffTripCreateTitle": MessageLookupByLibrary.simpleMessage(
      "إضافة رحلة فردية",
    ),
    "oneOffTripCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "تمت إضافة الرحلة الفردية.",
    ),
    "oneOffTripDeactivateAction": MessageLookupByLibrary.simpleMessage(
      "إلغاء تفعيل الرحلة",
    ),
    "oneOffTripDeactivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد إلغاء تفعيل هذه الرحلة للحجوزات الجديدة؟ ستبقى الحجوزات الحالية كما هي.",
    ),
    "oneOffTripDeactivatedMessage": MessageLookupByLibrary.simpleMessage(
      "تم إلغاء تفعيل الرحلة الفردية.",
    ),
    "oneOffTripDeleteAction": MessageLookupByLibrary.simpleMessage(
      "حذف الرحلة",
    ),
    "oneOffTripDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "لا يمكن حذف هذه الرحلة لأنها تحتوي بالفعل على حجوزات.",
    ),
    "oneOffTripDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد حذف هذه الرحلة الفردية من FleetFill؟",
    ),
    "oneOffTripDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حذف الرحلة الفردية.",
    ),
    "oneOffTripDepartureLabel": MessageLookupByLibrary.simpleMessage(
      "الانطلاق",
    ),
    "oneOffTripDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع تفاصيل هذه الرحلة الفردية قبل الحجز أو المتابعة التشغيلية.",
    ),
    "oneOffTripDetailTitle": m8,
    "oneOffTripEditTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل الرحلة الفردية",
    ),
    "oneOffTripEditorDescription": MessageLookupByLibrary.simpleMessage(
      "انشر رحلة بتاريخ محدد مع المركبة والمسار والانطلاق وتفاصيل السعة.",
    ),
    "oneOffTripSaveAction": MessageLookupByLibrary.simpleMessage("حفظ الرحلة"),
    "oneOffTripSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تحديث الرحلة الفردية.",
    ),
    "paymentFlowDescription": MessageLookupByLibrary.simpleMessage(
      "Instructions, reference, proof upload, and payment status remain in one coherent flow.",
    ),
    "paymentFlowTitle": MessageLookupByLibrary.simpleMessage("Payment flow"),
    "paymentInstructionsTitle": MessageLookupByLibrary.simpleMessage(
      "تعليمات الدفع",
    ),
    "paymentProofAlreadyReviewedMessage": MessageLookupByLibrary.simpleMessage(
      "تمت مراجعة إثبات الدفع هذا بالفعل.",
    ),
    "paymentProofAmountLabel": MessageLookupByLibrary.simpleMessage(
      "المبلغ المرسل",
    ),
    "paymentProofApprovedMessage": MessageLookupByLibrary.simpleMessage(
      "تمت الموافقة على إثبات الدفع.",
    ),
    "paymentProofDecisionNoteLabel": MessageLookupByLibrary.simpleMessage(
      "ملاحظة القرار",
    ),
    "paymentProofEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "ارفع إثبات الدفع بعد إتمام الدفع الخارجي.",
    ),
    "paymentProofExactAmountRequiredMessage":
        MessageLookupByLibrary.simpleMessage(
          "يجب أن يطابق المبلغ المتحقق منه إجمالي الحجز تماما.",
        ),
    "paymentProofLatestTitle": MessageLookupByLibrary.simpleMessage(
      "آخر إثبات تم إرساله",
    ),
    "paymentProofPendingWindowMessage": MessageLookupByLibrary.simpleMessage(
      "لا يمكن إرسال إثبات الدفع إلا ما دام الدفع ما يزال معلقا.",
    ),
    "paymentProofReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "المرجع المرسل",
    ),
    "paymentProofRejectedMessage": MessageLookupByLibrary.simpleMessage(
      "تم رفض إثبات الدفع.",
    ),
    "paymentProofRejectionReasonLabel": MessageLookupByLibrary.simpleMessage(
      "سبب الرفض",
    ),
    "paymentProofRejectionReasonRequiredMessage":
        MessageLookupByLibrary.simpleMessage("سبب الرفض مطلوب."),
    "paymentProofResubmitAction": MessageLookupByLibrary.simpleMessage(
      "إعادة إرسال الإثبات",
    ),
    "paymentProofSectionTitle": MessageLookupByLibrary.simpleMessage(
      "إثبات الدفع",
    ),
    "paymentProofStatusLabel": MessageLookupByLibrary.simpleMessage(
      "حالة الإثبات",
    ),
    "paymentProofStatusPendingLabel": MessageLookupByLibrary.simpleMessage(
      "بانتظار المراجعة",
    ),
    "paymentProofStatusRejectedLabel": MessageLookupByLibrary.simpleMessage(
      "مرفوض",
    ),
    "paymentProofStatusVerifiedLabel": MessageLookupByLibrary.simpleMessage(
      "تم التحقق منه",
    ),
    "paymentProofUploadAction": MessageLookupByLibrary.simpleMessage(
      "رفع إثبات الدفع",
    ),
    "paymentProofUploadedMessage": MessageLookupByLibrary.simpleMessage(
      "تم رفع إثبات الدفع.",
    ),
    "paymentProofVerifiedAmountLabel": MessageLookupByLibrary.simpleMessage(
      "المبلغ المتحقق منه",
    ),
    "paymentProofVerifiedReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "المرجع المتحقق منه",
    ),
    "paymentStatusProofSubmittedLabel": MessageLookupByLibrary.simpleMessage(
      "تم إرسال الإثبات",
    ),
    "paymentStatusRefundedLabel": MessageLookupByLibrary.simpleMessage(
      "تم رد المبلغ",
    ),
    "paymentStatusRejectedLabel": MessageLookupByLibrary.simpleMessage("مرفوض"),
    "paymentStatusReleasedToCarrierLabel": MessageLookupByLibrary.simpleMessage(
      "تم تحويله إلى الناقل",
    ),
    "paymentStatusSecuredLabel": MessageLookupByLibrary.simpleMessage("مؤمّن"),
    "paymentStatusUnderVerificationLabel": MessageLookupByLibrary.simpleMessage(
      "قيد التحقق",
    ),
    "paymentStatusUnpaidLabel": MessageLookupByLibrary.simpleMessage(
      "غير مدفوع",
    ),
    "payoutAccountAddAction": MessageLookupByLibrary.simpleMessage(
      "إضافة حساب تحويل",
    ),
    "payoutAccountDeleteAction": MessageLookupByLibrary.simpleMessage(
      "حذف الحساب",
    ),
    "payoutAccountDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "لا يمكن حذف هذا الحساب حاليا.",
    ),
    "payoutAccountDeleteConfirmationMessage":
        MessageLookupByLibrary.simpleMessage(
          "هل تريد حذف حساب التحويل هذا من FleetFill؟",
        ),
    "payoutAccountDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حذف حساب التحويل.",
    ),
    "payoutAccountEditAction": MessageLookupByLibrary.simpleMessage(
      "تعديل الحساب",
    ),
    "payoutAccountHolderLabel": MessageLookupByLibrary.simpleMessage(
      "اسم صاحب الحساب",
    ),
    "payoutAccountIdentifierLabel": MessageLookupByLibrary.simpleMessage(
      "رقم الحساب أو المعرّف",
    ),
    "payoutAccountInstitutionLabel": MessageLookupByLibrary.simpleMessage(
      "اسم البنك أو CCP",
    ),
    "payoutAccountSaveAction": MessageLookupByLibrary.simpleMessage(
      "حفظ الحساب",
    ),
    "payoutAccountSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حفظ حساب التحويل.",
    ),
    "payoutAccountTypeBankLabel": MessageLookupByLibrary.simpleMessage(
      "تحويل بنكي",
    ),
    "payoutAccountTypeCcpLabel": MessageLookupByLibrary.simpleMessage("CCP"),
    "payoutAccountTypeDahabiaLabel": MessageLookupByLibrary.simpleMessage(
      "الذهبية",
    ),
    "payoutAccountTypeLabel": MessageLookupByLibrary.simpleMessage(
      "وسيلة التحويل",
    ),
    "payoutAccountsDescription": MessageLookupByLibrary.simpleMessage(
      "Carrier payout accounts stay grouped under the profile branch.",
    ),
    "payoutAccountsTitle": MessageLookupByLibrary.simpleMessage(
      "Payout accounts",
    ),
    "phoneCompletionDescription": MessageLookupByLibrary.simpleMessage(
      "Operational actions stay gated until a phone number is present.",
    ),
    "phoneCompletionSaveAction": MessageLookupByLibrary.simpleMessage(
      "حفظ رقم الهاتف",
    ),
    "phoneCompletionSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حفظ رقم الهاتف.",
    ),
    "phoneCompletionTitle": MessageLookupByLibrary.simpleMessage(
      "Phone completion",
    ),
    "priceCurrencyLabel": MessageLookupByLibrary.simpleMessage("دج"),
    "pricePerKgUnitLabel": MessageLookupByLibrary.simpleMessage("دج/كلغ"),
    "profileCarrierVerificationHint": MessageLookupByLibrary.simpleMessage(
      "أكمل بيانات الناقل أولا، ثم ارفع وثائق التحقق المطلوبة من ملفك الشخصي.",
    ),
    "profileCompanyNameLabel": MessageLookupByLibrary.simpleMessage(
      "اسم الشركة",
    ),
    "profileFullNameLabel": MessageLookupByLibrary.simpleMessage(
      "الاسم الكامل",
    ),
    "profilePhoneLabel": MessageLookupByLibrary.simpleMessage("رقم الهاتف"),
    "profileSetupDescription": MessageLookupByLibrary.simpleMessage(
      "أكمل بيانات الملف المطلوبة قبل استخدام الميزات التشغيلية.",
    ),
    "profileSetupSaveAction": MessageLookupByLibrary.simpleMessage(
      "حفظ الملف الشخصي",
    ),
    "profileSetupSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حفظ بيانات الملف الشخصي.",
    ),
    "profileSetupTitle": MessageLookupByLibrary.simpleMessage("Profile setup"),
    "profileVerificationDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "وثائق تحقق الملف الشخصي",
    ),
    "proofViewerDescription": MessageLookupByLibrary.simpleMessage(
      "افتح هذا الإثبات من خلال مسار مشترك وآمن عندما يصبح الوصول جاهزا.",
    ),
    "proofViewerTitle": m9,
    "publicationActiveLabel": MessageLookupByLibrary.simpleMessage("نشط"),
    "publicationEffectiveDateFutureMessage":
        MessageLookupByLibrary.simpleMessage(
          "اختر تاريخا ووقتا للسريان يساوي الآن أو بعده.",
        ),
    "publicationInactiveLabel": MessageLookupByLibrary.simpleMessage("غير نشط"),
    "publicationNoRevisionsMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد مراجعات للمسار حتى الآن.",
    ),
    "publicationRevisionHistoryTitle": MessageLookupByLibrary.simpleMessage(
      "سجل المراجعات",
    ),
    "publicationSameLaneErrorMessage": MessageLookupByLibrary.simpleMessage(
      "يجب أن تكون بلديتا الانطلاق والوصول مختلفتين.",
    ),
    "publicationSearchCommunesHint": MessageLookupByLibrary.simpleMessage(
      "ابحث عن بلدية",
    ),
    "publicationSelectValueAction": MessageLookupByLibrary.simpleMessage(
      "اختر",
    ),
    "publicationVehicleUnavailableMessage":
        MessageLookupByLibrary.simpleMessage(
          "اختر إحدى مركباتك المتاحة لهذا النشر.",
        ),
    "publicationVerifiedCarrierRequiredMessage":
        MessageLookupByLibrary.simpleMessage("أكمل تحقق الناقل قبل نشر السعة."),
    "publicationVerifiedVehicleRequiredMessage":
        MessageLookupByLibrary.simpleMessage("اختر مركبة موثقة قبل نشر السعة."),
    "publicationWeekdaysRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "اختر يوما واحدا على الأقل للانطلاق.",
    ),
    "retryLabel": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "roleSelectionCarrierDescription": MessageLookupByLibrary.simpleMessage(
      "انشر الرحلات، وأدر الحجوزات، وتابع التحقق.",
    ),
    "roleSelectionCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "المتابعة كناقل",
    ),
    "roleSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "اختر دورا واحدا لهذا الحساب قبل بدء الاستخدام التشغيلي.",
    ),
    "roleSelectionShipperDescription": MessageLookupByLibrary.simpleMessage(
      "أنشئ الشحنات، وقارن الرحلات المطابقة، وتابع التسليم.",
    ),
    "roleSelectionShipperTitle": MessageLookupByLibrary.simpleMessage(
      "المتابعة كمرسل",
    ),
    "roleSelectionTitle": MessageLookupByLibrary.simpleMessage("اختيار الدور"),
    "routeActivateAction": MessageLookupByLibrary.simpleMessage("تفعيل المسار"),
    "routeActivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد تفعيل هذا المسار للحجوزات الجديدة؟",
    ),
    "routeActivatedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تفعيل المسار.",
    ),
    "routeCreateTitle": MessageLookupByLibrary.simpleMessage(
      "إضافة مسار متكرر",
    ),
    "routeCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "تمت إضافة المسار المتكرر.",
    ),
    "routeDeactivateAction": MessageLookupByLibrary.simpleMessage(
      "إلغاء تفعيل المسار",
    ),
    "routeDeactivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد إلغاء تفعيل هذا المسار للحجوزات الجديدة؟ ستبقى الحجوزات الحالية كما هي.",
    ),
    "routeDeactivatedMessage": MessageLookupByLibrary.simpleMessage(
      "تم إلغاء تفعيل المسار.",
    ),
    "routeDeleteAction": MessageLookupByLibrary.simpleMessage("حذف المسار"),
    "routeDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "لا يمكن حذف هذا المسار لأنه يحتوي بالفعل على حجوزات.",
    ),
    "routeDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد حذف هذا المسار المتكرر من FleetFill؟",
    ),
    "routeDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حذف المسار المتكرر.",
    ),
    "routeDepartureTimeLabel": MessageLookupByLibrary.simpleMessage(
      "وقت الانطلاق الافتراضي",
    ),
    "routeDestinationLabel": MessageLookupByLibrary.simpleMessage(
      "بلدية الوصول",
    ),
    "routeDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع تفاصيل هذا المسار قبل الحجز أو المتابعة.",
    ),
    "routeDetailTitle": m10,
    "routeEditTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل المسار المتكرر",
    ),
    "routeEditorDescription": MessageLookupByLibrary.simpleMessage(
      "انشر مسارا متكررا مع المركبة والجدول وتفاصيل السعة.",
    ),
    "routeEffectiveFromLabel": MessageLookupByLibrary.simpleMessage("يسري من"),
    "routeErrorMessage": MessageLookupByLibrary.simpleMessage(
      "تعذر على FleetFill فتح هذه الشاشة.",
    ),
    "routeOriginLabel": MessageLookupByLibrary.simpleMessage("بلدية الانطلاق"),
    "routePricePerKgLabel": MessageLookupByLibrary.simpleMessage(
      "السعر لكل كلغ (دج)",
    ),
    "routeRecurringDaysLabel": MessageLookupByLibrary.simpleMessage(
      "أيام التكرار",
    ),
    "routeSaveAction": MessageLookupByLibrary.simpleMessage("حفظ المسار"),
    "routeSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تحديث المسار المتكرر.",
    ),
    "routeStatusLabel": MessageLookupByLibrary.simpleMessage("حالة النشر"),
    "routeVehicleLabel": MessageLookupByLibrary.simpleMessage(
      "المركبة المخصصة",
    ),
    "sampleBasePriceAmount": MessageLookupByLibrary.simpleMessage("DZD 12,500"),
    "sampleBasePriceLabel": MessageLookupByLibrary.simpleMessage(
      "السعر الأساسي",
    ),
    "samplePlatformFeeAmount": MessageLookupByLibrary.simpleMessage(
      "DZD 1,200",
    ),
    "samplePlatformFeeLabel": MessageLookupByLibrary.simpleMessage(
      "رسوم المنصة",
    ),
    "sampleTotalAmount": MessageLookupByLibrary.simpleMessage("DZD 13,700"),
    "sampleTotalLabel": MessageLookupByLibrary.simpleMessage("الإجمالي"),
    "searchCarrierLabel": MessageLookupByLibrary.simpleMessage("الناقل"),
    "searchCarrierRatingLabel": MessageLookupByLibrary.simpleMessage(
      "تقييم الناقل",
    ),
    "searchDepartureLabel": MessageLookupByLibrary.simpleMessage("الانطلاق"),
    "searchEstimatedPriceLabel": MessageLookupByLibrary.simpleMessage(
      "الإجمالي التقديري",
    ),
    "searchRequestedDateLabel": MessageLookupByLibrary.simpleMessage(
      "تاريخ الانطلاق المطلوب",
    ),
    "searchResultTypeLabel": MessageLookupByLibrary.simpleMessage("نوع السعة"),
    "searchShipmentSelectorLabel": MessageLookupByLibrary.simpleMessage(
      "مسودة الشحنة",
    ),
    "searchShipmentSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "ملخص الشحنة",
    ),
    "searchSortLowestPriceLabel": MessageLookupByLibrary.simpleMessage(
      "الأقل سعرا",
    ),
    "searchSortNearestDepartureLabel": MessageLookupByLibrary.simpleMessage(
      "أقرب انطلاق",
    ),
    "searchSortRecommendedLabel": MessageLookupByLibrary.simpleMessage(
      "موصى به",
    ),
    "searchSortTopRatedLabel": MessageLookupByLibrary.simpleMessage(
      "الأعلى تقييما",
    ),
    "searchTripsAction": MessageLookupByLibrary.simpleMessage(
      "ابحث عن سعة مطابقة",
    ),
    "searchTripsControlsAction": MessageLookupByLibrary.simpleMessage(
      "الترتيب والفلاتر",
    ),
    "searchTripsDescription": MessageLookupByLibrary.simpleMessage(
      "The search form and exact-route results stay on one page with inline states.",
    ),
    "searchTripsFilterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد نتائج تطابق الترتيب والفلاتر الحالية.",
    ),
    "searchTripsNavLabel": MessageLookupByLibrary.simpleMessage("Search"),
    "searchTripsNearestDateMessage": m11,
    "searchTripsNearestDateTitle": MessageLookupByLibrary.simpleMessage(
      "تم العثور على أقرب التواريخ المطابقة",
    ),
    "searchTripsNoRouteMessage": MessageLookupByLibrary.simpleMessage(
      "لا يوجد مسار مطابق لهذا الخط ضمن نافذة البحث القريبة.",
    ),
    "searchTripsNoRouteTitle": MessageLookupByLibrary.simpleMessage(
      "أعد تعريف بحثك",
    ),
    "searchTripsOneOffLabel": MessageLookupByLibrary.simpleMessage(
      "رحلة فردية",
    ),
    "searchTripsRecurringLabel": MessageLookupByLibrary.simpleMessage(
      "مسار متكرر",
    ),
    "searchTripsRequiresDraftMessage": MessageLookupByLibrary.simpleMessage(
      "أنشئ مسودة شحنة واحدة على الأقل للبحث عن سعة مطابقة.",
    ),
    "searchTripsResultsTitle": m12,
    "searchTripsTitle": MessageLookupByLibrary.simpleMessage("Search trips"),
    "settingsDescription": MessageLookupByLibrary.simpleMessage(
      "أدر اللغة والمظهر والدعم وتفضيلات الإشعارات.",
    ),
    "settingsSignedOutMessage": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل خروجك.",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "sharedScaffoldPreviewMessage": MessageLookupByLibrary.simpleMessage(
      "تبقى البطاقات والقوالب المشتركة متسقة عبر جميع أسطح الأدوار.",
    ),
    "sharedScaffoldPreviewTitle": MessageLookupByLibrary.simpleMessage(
      "معاينة الأساس المشترك",
    ),
    "shipmentAddItemAction": MessageLookupByLibrary.simpleMessage("إضافة عنصر"),
    "shipmentCategoryLabel": MessageLookupByLibrary.simpleMessage("الفئة"),
    "shipmentCreateAction": MessageLookupByLibrary.simpleMessage("إنشاء شحنة"),
    "shipmentCreateTitle": MessageLookupByLibrary.simpleMessage(
      "إنشاء مسودة شحنة",
    ),
    "shipmentDeleteAction": MessageLookupByLibrary.simpleMessage("حذف الشحنة"),
    "shipmentDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد حذف مسودة الشحنة هذه من FleetFill؟",
    ),
    "shipmentDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حذف مسودة الشحنة.",
    ),
    "shipmentDescriptionLabel": MessageLookupByLibrary.simpleMessage("الوصف"),
    "shipmentDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع ملخص الشحنة ومحتوياتها والحجز المرتبط بها.",
    ),
    "shipmentDetailTitle": m13,
    "shipmentEditAction": MessageLookupByLibrary.simpleMessage("تعديل الشحنة"),
    "shipmentEditTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل مسودة الشحنة",
    ),
    "shipmentItemLabelField": MessageLookupByLibrary.simpleMessage(
      "اسم العنصر",
    ),
    "shipmentItemNotesLabel": MessageLookupByLibrary.simpleMessage(
      "ملاحظات العنصر",
    ),
    "shipmentItemQuantityLabel": MessageLookupByLibrary.simpleMessage("الكمية"),
    "shipmentItemTitle": m14,
    "shipmentItemVolumeLabel": MessageLookupByLibrary.simpleMessage(
      "حجم العنصر (م3)",
    ),
    "shipmentItemWeightLabel": MessageLookupByLibrary.simpleMessage(
      "وزن العنصر (كلغ)",
    ),
    "shipmentItemsTitle": MessageLookupByLibrary.simpleMessage("عناصر الشحنة"),
    "shipmentPickupEndLabel": MessageLookupByLibrary.simpleMessage(
      "نهاية نافذة الاستلام",
    ),
    "shipmentPickupStartLabel": MessageLookupByLibrary.simpleMessage(
      "بداية نافذة الاستلام",
    ),
    "shipmentPickupWindowOrderMessage": MessageLookupByLibrary.simpleMessage(
      "يجب أن تكون نهاية نافذة الاستلام بعد بدايتها.",
    ),
    "shipmentRemoveItemAction": MessageLookupByLibrary.simpleMessage(
      "إزالة العنصر",
    ),
    "shipmentSaveAction": MessageLookupByLibrary.simpleMessage("حفظ الشحنة"),
    "shipmentSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حفظ مسودة الشحنة.",
    ),
    "shipmentStatusBookedLabel": MessageLookupByLibrary.simpleMessage("محجوزة"),
    "shipmentStatusCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "ملغاة",
    ),
    "shipmentStatusDraftLabel": MessageLookupByLibrary.simpleMessage("مسودة"),
    "shipmentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "أنشئ مسودة شحنة قبل البحث عن سعة مطابقة.",
    ),
    "shipperHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Active bookings, recent notifications, quick actions, and support shortcut live here.",
    ),
    "shipperHomeNavLabel": MessageLookupByLibrary.simpleMessage("Home"),
    "shipperHomeTitle": MessageLookupByLibrary.simpleMessage("Shipper home"),
    "shipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Profile, phone, preferences, and support shortcuts stay in one branch.",
    ),
    "shipperProfileNavLabel": MessageLookupByLibrary.simpleMessage("Profile"),
    "shipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Shipper profile",
    ),
    "splashDescription": MessageLookupByLibrary.simpleMessage(
      "Bootstrap and blocking initialization states start here.",
    ),
    "splashTitle": MessageLookupByLibrary.simpleMessage("Splash"),
    "statusNeedsReviewLabel": MessageLookupByLibrary.simpleMessage(
      "يحتاج مراجعة",
    ),
    "statusReadyLabel": MessageLookupByLibrary.simpleMessage("جاهز"),
    "supportDescription": MessageLookupByLibrary.simpleMessage(
      "Support starts with clear email guidance and structured issue details.",
    ),
    "supportTitle": MessageLookupByLibrary.simpleMessage("Support"),
    "suspendedMessage": MessageLookupByLibrary.simpleMessage(
      "حسابك موقوف حاليا. تواصل مع دعم FleetFill عبر البريد الإلكتروني.",
    ),
    "suspendedTitle": MessageLookupByLibrary.simpleMessage("الحساب موقوف"),
    "trackingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Tracking timeline, delivery confirmation, dispute, and rating actions stay together here.",
    ),
    "trackingDetailTitle": m15,
    "updateRequiredDescription": MessageLookupByLibrary.simpleMessage(
      "حدّث FleetFill للمتابعة باستخدام الإصدار المدعوم.",
    ),
    "updateRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Update required",
    ),
    "userDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Shipper and carrier specifics remain section-based inside one user detail view.",
    ),
    "userDetailTitle": MessageLookupByLibrary.simpleMessage("User detail"),
    "vehicleCapacityVolumeLabel": MessageLookupByLibrary.simpleMessage(
      "حجم السعة (م3)",
    ),
    "vehicleCapacityWeightLabel": MessageLookupByLibrary.simpleMessage(
      "سعة الوزن (كغ)",
    ),
    "vehicleCreateAction": MessageLookupByLibrary.simpleMessage("إضافة مركبة"),
    "vehicleCreateTitle": MessageLookupByLibrary.simpleMessage("إضافة مركبة"),
    "vehicleCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "تمت إضافة المركبة.",
    ),
    "vehicleDeleteAction": MessageLookupByLibrary.simpleMessage("حذف المركبة"),
    "vehicleDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد حذف هذه المركبة من FleetFill؟",
    ),
    "vehicleDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حذف المركبة.",
    ),
    "vehicleDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Vehicle details, documents, and verification status appear here.",
    ),
    "vehicleDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Vehicle detail",
    ),
    "vehicleEditTitle": MessageLookupByLibrary.simpleMessage("تعديل المركبة"),
    "vehicleEditorDescription": MessageLookupByLibrary.simpleMessage(
      "أبق بيانات المركبة محدثة حتى تظل مسارات الطرق والتحقق صالحة.",
    ),
    "vehiclePlateLabel": MessageLookupByLibrary.simpleMessage("رقم اللوحة"),
    "vehiclePositiveNumberMessage": MessageLookupByLibrary.simpleMessage(
      "أدخل رقما أكبر من الصفر.",
    ),
    "vehicleSaveAction": MessageLookupByLibrary.simpleMessage("حفظ المركبة"),
    "vehicleSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تحديث المركبة.",
    ),
    "vehicleSummaryTitle": MessageLookupByLibrary.simpleMessage("ملخص المركبة"),
    "vehicleTypeLabel": MessageLookupByLibrary.simpleMessage("نوع المركبة"),
    "vehicleVerificationDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "وثائق تحقق المركبة",
    ),
    "vehicleVerificationRejectedBanner": m16,
    "vehiclesDescription": MessageLookupByLibrary.simpleMessage(
      "Vehicles remain under the carrier profile branch.",
    ),
    "vehiclesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "أضف مركبة قبل نشر السعة أو إكمال التحقق الكامل.",
    ),
    "vehiclesTitle": MessageLookupByLibrary.simpleMessage("Vehicles"),
    "verificationDocumentDriverIdentityLabel":
        MessageLookupByLibrary.simpleMessage("هوية السائق أو الرخصة"),
    "verificationDocumentMissingMessage": MessageLookupByLibrary.simpleMessage(
      "لم يتم رفع أي ملف بعد.",
    ),
    "verificationDocumentNeedsAttentionMessage":
        MessageLookupByLibrary.simpleMessage("راجع سبب الرفض ثم ارفع بديلا."),
    "verificationDocumentOpenPreparedMessage":
        MessageLookupByLibrary.simpleMessage(
          "تم تجهيز الوصول الآمن إلى الوثيقة.",
        ),
    "verificationDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "تم الرفع وينتظر مراجعة الإدارة.",
    ),
    "verificationDocumentRejectedMessage": m17,
    "verificationDocumentReplacedMessage": MessageLookupByLibrary.simpleMessage(
      "تم استبدال وثيقة التحقق.",
    ),
    "verificationDocumentTransportLicenseLabel":
        MessageLookupByLibrary.simpleMessage("رخصة النقل"),
    "verificationDocumentTruckInspectionLabel":
        MessageLookupByLibrary.simpleMessage("الفحص التقني للشاحنة"),
    "verificationDocumentTruckInsuranceLabel":
        MessageLookupByLibrary.simpleMessage("تأمين الشاحنة"),
    "verificationDocumentTruckRegistrationLabel":
        MessageLookupByLibrary.simpleMessage("تسجيل الشاحنة"),
    "verificationDocumentUploadedMessage": MessageLookupByLibrary.simpleMessage(
      "تم رفع وثيقة التحقق.",
    ),
    "verificationDocumentVerifiedMessage": MessageLookupByLibrary.simpleMessage(
      "تم التحقق منها واعتمادها.",
    ),
    "verificationReplaceAction": MessageLookupByLibrary.simpleMessage(
      "استبدال",
    ),
    "verificationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "أكمل خطوات التحقق المطلوبة قبل المتابعة.",
    ),
    "verificationRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "التحقق مطلوب",
    ),
    "verificationUploadAction": MessageLookupByLibrary.simpleMessage("رفع"),
  };
}
