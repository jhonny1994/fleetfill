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

  static String m1(bookingId) => "الحجز ${bookingId}";

  static String m2(carrierId) => "الناقل ${carrierId}";

  static String m3(reason) => "التحقق يحتاج إلى إجراء: ${reason}";

  static String m4(count) => "الملفات المحددة: ${count}";

  static String m5(documentId) => "المستند ${documentId}";

  static String m6(documentId) => "المستند المُولَّد ${documentId}";

  static String m7(languageCode) => "لغة التطبيق الحالية: ${languageCode}";

  static String m8(milestoneLabel) => "الحالة الحالية: ${milestoneLabel}";

  static String m9(notificationId) => "الإشعار ${notificationId}";

  static String m10(documentType) => "أصبح ${documentType} جاهزا للعرض الآمن.";

  static String m11(tripId) => "الرحلة الفردية ${tripId}";

  static String m12(proofId) => "الإثبات ${proofId}";

  static String m13(routeId) => "المسار ${routeId}";

  static String m14(dates) =>
      "لا توجد نتيجة مطابقة في اليوم نفسه. أقرب التواريخ المطابقة: ${dates}";

  static String m15(count) => "نتائج البحث (${count})";

  static String m16(shipmentId) => "الشحنة ${shipmentId}";

  static String m17(supportEmail) => "بريد الدعم: ${supportEmail}";

  static String m18(bookingId) => "التتبع ${bookingId}";

  static String m19(reason) => "تحقق المركبة يحتاج إلى إجراء: ${reason}";

  static String m20(reason) => "مرفوض: ${reason}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "adminAuditLogDescription": MessageLookupByLibrary.simpleMessage(
      "راجع أحدث الإجراءات الإدارية الحساسة ونتائجها.",
    ),
    "adminAuditLogEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لم يتم تسجيل أي أحداث تدقيق إدارية بعد.",
    ),
    "adminAuditLogTitle": MessageLookupByLibrary.simpleMessage(
      "سجل تدقيق الإدارة",
    ),
    "adminDashboardAutomationTitle": MessageLookupByLibrary.simpleMessage(
      "المهام الحساسة للوقت",
    ),
    "adminDashboardBacklogHealthTitle": MessageLookupByLibrary.simpleMessage(
      "العمل المعلّق",
    ),
    "adminDashboardDeadLetterLabel": MessageLookupByLibrary.simpleMessage(
      "الرسائل الفاشلة",
    ),
    "adminDashboardDescription": MessageLookupByLibrary.simpleMessage(
      "راقب العمل المعلّق والتنبيهات وحالة الخدمة.",
    ),
    "adminDashboardEmailBacklogLabel": MessageLookupByLibrary.simpleMessage(
      "رسائل بانتظار الإرسال",
    ),
    "adminDashboardEmailHealthTitle": MessageLookupByLibrary.simpleMessage(
      "تسليم البريد الإلكتروني",
    ),
    "adminDashboardNavLabel": MessageLookupByLibrary.simpleMessage(
      "لوحة المعلومات",
    ),
    "adminDashboardOverdueDeliveryReviewsLabel":
        MessageLookupByLibrary.simpleMessage("مراجعات التسليم المتأخرة"),
    "adminDashboardOverduePaymentResubmissionsLabel":
        MessageLookupByLibrary.simpleMessage("إعادات إرسال الدفع المتأخرة"),
    "adminDashboardTitle": MessageLookupByLibrary.simpleMessage(
      "لوحة معلومات الإدارة",
    ),
    "adminDisputesQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد نزاعات بانتظار المراجعة الآن.",
    ),
    "adminDisputesQueueTitle": MessageLookupByLibrary.simpleMessage("النزاعات"),
    "adminEligiblePayoutsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد تحويلات جاهزة للإطلاق حاليا.",
    ),
    "adminEmailDeadLetterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد رسائل فاشلة تحتاج إلى متابعة الآن.",
    ),
    "adminEmailDeadLetterTitle": MessageLookupByLibrary.simpleMessage(
      "الرسائل الفاشلة",
    ),
    "adminEmailErrorCodeLabel": MessageLookupByLibrary.simpleMessage(
      "رمز الخطأ",
    ),
    "adminEmailErrorMessageLabel": MessageLookupByLibrary.simpleMessage(
      "رسالة الخطأ",
    ),
    "adminEmailLocaleLabel": MessageLookupByLibrary.simpleMessage(
      "اللغة المطلوبة",
    ),
    "adminEmailPayloadSnapshotLabel": MessageLookupByLibrary.simpleMessage(
      "لقطة الحمولة",
    ),
    "adminEmailProviderLabel": MessageLookupByLibrary.simpleMessage("المزوّد"),
    "adminEmailQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد سجلات بريد إلكتروني تطابق عوامل التصفية الحالية.",
    ),
    "adminEmailQueueTitle": MessageLookupByLibrary.simpleMessage(
      "تسليم البريد الإلكتروني",
    ),
    "adminEmailResendAction": MessageLookupByLibrary.simpleMessage(
      "إعادة الإرسال",
    ),
    "adminEmailResendSuccess": MessageLookupByLibrary.simpleMessage(
      "تمت جدولة إعادة إرسال البريد الإلكتروني.",
    ),
    "adminEmailSearchLabel": MessageLookupByLibrary.simpleMessage(
      "ابحث في سجلات البريد الإلكتروني",
    ),
    "adminEmailStatusAllLabel": MessageLookupByLibrary.simpleMessage(
      "كل الحالات",
    ),
    "adminEmailStatusBouncedLabel": MessageLookupByLibrary.simpleMessage(
      "مرتد",
    ),
    "adminEmailStatusDeadLetterLabel": MessageLookupByLibrary.simpleMessage(
      "معطلة",
    ),
    "adminEmailStatusDeliveredLabel": MessageLookupByLibrary.simpleMessage(
      "تم التسليم",
    ),
    "adminEmailStatusFilterLabel": MessageLookupByLibrary.simpleMessage(
      "حالة البريد الإلكتروني",
    ),
    "adminEmailStatusHardFailedLabel": MessageLookupByLibrary.simpleMessage(
      "فشل نهائي",
    ),
    "adminEmailStatusQueuedLabel": MessageLookupByLibrary.simpleMessage(
      "في الانتظار",
    ),
    "adminEmailStatusRenderFailedLabel": MessageLookupByLibrary.simpleMessage(
      "فشل توليد القالب",
    ),
    "adminEmailStatusSentLabel": MessageLookupByLibrary.simpleMessage(
      "تم الإرسال",
    ),
    "adminEmailStatusSoftFailedLabel": MessageLookupByLibrary.simpleMessage(
      "فشل مؤقت",
    ),
    "adminEmailStatusSuppressedLabel": MessageLookupByLibrary.simpleMessage(
      "مقيد",
    ),
    "adminEmailSubjectPreviewLabel": MessageLookupByLibrary.simpleMessage(
      "معاينة العنوان",
    ),
    "adminEmailTemplateKeyLabel": MessageLookupByLibrary.simpleMessage(
      "مفتاح القالب",
    ),
    "adminEmailTemplateLanguageLabel": MessageLookupByLibrary.simpleMessage(
      "لغة القالب",
    ),
    "adminPaymentProofQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد إثباتات دفع تحتاج إلى مراجعة الآن.",
    ),
    "adminPaymentProofQueueTitle": MessageLookupByLibrary.simpleMessage(
      "مراجعة إثباتات الدفع",
    ),
    "adminPayoutEligibleTitle": MessageLookupByLibrary.simpleMessage(
      "الدفعات المؤهلة",
    ),
    "adminPayoutQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لم يتم تحرير أي تحويلات بعد.",
    ),
    "adminPayoutQueueTitle": MessageLookupByLibrary.simpleMessage("التحويلات"),
    "adminPayoutReleaseAction": MessageLookupByLibrary.simpleMessage(
      "إطلاق الدفعة",
    ),
    "adminQueueDisputesTabLabel": MessageLookupByLibrary.simpleMessage(
      "النزاعات",
    ),
    "adminQueueEmailTabLabel": MessageLookupByLibrary.simpleMessage(
      "البريد الإلكتروني",
    ),
    "adminQueuePaymentsTabLabel": MessageLookupByLibrary.simpleMessage(
      "المدفوعات",
    ),
    "adminQueuePayoutsTabLabel": MessageLookupByLibrary.simpleMessage(
      "الدفعات",
    ),
    "adminQueueVerificationTabLabel": MessageLookupByLibrary.simpleMessage(
      "التحقق",
    ),
    "adminQueuesDescription": MessageLookupByLibrary.simpleMessage(
      "راجع المدفوعات والتحقق والنزاعات والتحويلات والبريد الإلكتروني في مكان واحد.",
    ),
    "adminQueuesNavLabel": MessageLookupByLibrary.simpleMessage("العمليات"),
    "adminQueuesTitle": MessageLookupByLibrary.simpleMessage("العمليات"),
    "adminSettingsDeliveryGraceLabel": MessageLookupByLibrary.simpleMessage(
      "نافذة السماح للتسليم (بالساعات)",
    ),
    "adminSettingsDeliverySectionTitle": MessageLookupByLibrary.simpleMessage(
      "سياسة مراجعة التسليم",
    ),
    "adminSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "أدر الوصول إلى التطبيق وقواعد التسعير ووضع الصيانة وأدوات البريد الإلكتروني.",
    ),
    "adminSettingsEmailResendEnabledLabel":
        MessageLookupByLibrary.simpleMessage(
          "تفعيل إعادة إرسال البريد الإلكتروني من الإدارة",
        ),
    "adminSettingsFeatureFlagsSectionTitle":
        MessageLookupByLibrary.simpleMessage("الميزات الاختيارية"),
    "adminSettingsForceUpdateLabel": MessageLookupByLibrary.simpleMessage(
      "فرض التحديث",
    ),
    "adminSettingsInsuranceMinimumLabel": MessageLookupByLibrary.simpleMessage(
      "الحد الأدنى لرسوم التأمين",
    ),
    "adminSettingsInsuranceRateLabel": MessageLookupByLibrary.simpleMessage(
      "نسبة التأمين",
    ),
    "adminSettingsMaintenanceModeLabel": MessageLookupByLibrary.simpleMessage(
      "وضع الصيانة",
    ),
    "adminSettingsMinimumAndroidVersionLabel":
        MessageLookupByLibrary.simpleMessage("الحد الأدنى لإصدار Android"),
    "adminSettingsMinimumIosVersionLabel": MessageLookupByLibrary.simpleMessage(
      "الحد الأدنى لإصدار iOS",
    ),
    "adminSettingsMonitoringSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "ملخص الخدمة",
    ),
    "adminSettingsNavLabel": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "adminSettingsPaymentDeadlineLabel": MessageLookupByLibrary.simpleMessage(
      "مهلة إعادة إرسال الدفع (بالساعات)",
    ),
    "adminSettingsPlatformFeeRateLabel": MessageLookupByLibrary.simpleMessage(
      "نسبة رسوم المنصة",
    ),
    "adminSettingsPricingSectionTitle": MessageLookupByLibrary.simpleMessage(
      "سياسة التسعير",
    ),
    "adminSettingsRuntimeSectionTitle": MessageLookupByLibrary.simpleMessage(
      "الوصول إلى التطبيق",
    ),
    "adminSettingsSaveAction": MessageLookupByLibrary.simpleMessage(
      "حفظ الإعدادات",
    ),
    "adminSettingsSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تحديث إعدادات الإدارة.",
    ),
    "adminSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "إعدادات الإدارة",
    ),
    "adminUserAccountSectionTitle": MessageLookupByLibrary.simpleMessage(
      "ملخص الحساب",
    ),
    "adminUserBookingsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد حجوزات مرتبطة بهذا المستخدم بعد.",
    ),
    "adminUserBookingsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "الحجوزات المرتبطة",
    ),
    "adminUserDocumentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد وثائق تحقق متاحة لهذا المستخدم.",
    ),
    "adminUserDocumentsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "وثائق التحقق",
    ),
    "adminUserEmailEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد سجلات بريد إلكتروني حديثة لهذا المستخدم.",
    ),
    "adminUserEmailSectionTitle": MessageLookupByLibrary.simpleMessage(
      "الرسائل الأخيرة",
    ),
    "adminUserReactivateAction": MessageLookupByLibrary.simpleMessage(
      "إعادة تفعيل المستخدم",
    ),
    "adminUserReactivateSuccess": MessageLookupByLibrary.simpleMessage(
      "تمت إعادة تفعيل المستخدم.",
    ),
    "adminUserReasonHint": MessageLookupByLibrary.simpleMessage(
      "أضف سببا تشغيليا لهذا التغيير.",
    ),
    "adminUserRoleAdminLabel": MessageLookupByLibrary.simpleMessage("الإدارة"),
    "adminUserRoleCarrierLabel": MessageLookupByLibrary.simpleMessage("الناقل"),
    "adminUserRoleLabel": MessageLookupByLibrary.simpleMessage("الدور"),
    "adminUserRoleShipperLabel": MessageLookupByLibrary.simpleMessage("الشاحن"),
    "adminUserStatusActiveLabel": MessageLookupByLibrary.simpleMessage("نشط"),
    "adminUserStatusLabel": MessageLookupByLibrary.simpleMessage("حالة الحساب"),
    "adminUserStatusSuspendedLabel": MessageLookupByLibrary.simpleMessage(
      "معلّق",
    ),
    "adminUserSuspendAction": MessageLookupByLibrary.simpleMessage(
      "تعليق المستخدم",
    ),
    "adminUserSuspendSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تعليق المستخدم.",
    ),
    "adminUserVehiclesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد مركبات مرتبطة بهذا المستخدم.",
    ),
    "adminUserVehiclesSectionTitle": MessageLookupByLibrary.simpleMessage(
      "المركبات",
    ),
    "adminUsersDescription": MessageLookupByLibrary.simpleMessage(
      "ابحث عن المستخدمين وراجع الحسابات والحجوزات والوثائق.",
    ),
    "adminUsersEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا يوجد مستخدمون يطابقون هذا البحث.",
    ),
    "adminUsersNavLabel": MessageLookupByLibrary.simpleMessage("المستخدمون"),
    "adminUsersSearchLabel": MessageLookupByLibrary.simpleMessage(
      "ابحث عن المستخدمين",
    ),
    "adminUsersTitle": MessageLookupByLibrary.simpleMessage("مستخدمو الإدارة"),
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
      "راجع وثائق الملف الشخصي والمركبة قبل اعتماد الناقل.",
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
      "تحقق الناقلين",
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
    "authCancelledMessage": MessageLookupByLibrary.simpleMessage(
      "تم إلغاء تسجيل الدخول.",
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
      "اطلب رابط إعادة تعيين كلمة المرور لحساب FleetFill الخاص بك.",
    ),
    "authForgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "نسيت كلمة المرور",
    ),
    "authGenericErrorMessage": MessageLookupByLibrary.simpleMessage(
      "تعذر على FleetFill إتمام طلب المصادقة هذا.",
    ),
    "authGoogleAction": MessageLookupByLibrary.simpleMessage(
      "المتابعة عبر Google",
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
      "إعادة تعيين كلمة المرور",
    ),
    "authResetPasswordUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "افتح هذه الشاشة من رابط استعادة كلمة المرور لتعيين كلمة مرور جديدة.",
    ),
    "authRoleAlreadyAssignedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تحديد دور هذا الحساب بالفعل ولا يمكن تغييره من هنا.",
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
      "سجّل الدخول ببريدك الإلكتروني وكلمة المرور أو تابع عبر Google عند توفره.",
    ),
    "authSignInSuccess": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل الدخول بنجاح.",
    ),
    "authSignInTitle": MessageLookupByLibrary.simpleMessage("تسجيل الدخول"),
    "authSignUpDescription": MessageLookupByLibrary.simpleMessage(
      "أنشئ حساب FleetFill للبدء في الشحن أو نشر السعة.",
    ),
    "authSignUpTitle": MessageLookupByLibrary.simpleMessage("إنشاء حساب"),
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
      "تم إنشاء الحجز. تابع إلى الدفع.",
    ),
    "bookingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع حالة الحجز وتفاصيل الدفع وملخص السعر.",
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
      "راجع سمعة الناقل وتفاصيل الرحلة والسعر قبل الدفع.",
    ),
    "bookingReviewTitle": MessageLookupByLibrary.simpleMessage("مراجعة الحجز"),
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
      "تابع الحجوزات الحالية وتقدم التسليم والرحلات المكتملة.",
    ),
    "carrierBookingsNavLabel": MessageLookupByLibrary.simpleMessage("الحجوزات"),
    "carrierBookingsTitle": MessageLookupByLibrary.simpleMessage(
      "حجوزات الناقل",
    ),
    "carrierGatePayoutMessage": MessageLookupByLibrary.simpleMessage(
      "أضف حساب دفع قبل فتح حجوزات الناقل حتى تتم تسوية الأعمال المكتملة بشكل صحيح.",
    ),
    "carrierGatePayoutTitle": MessageLookupByLibrary.simpleMessage(
      "حساب الدفع مطلوب",
    ),
    "carrierGatePhoneMessage": MessageLookupByLibrary.simpleMessage(
      "أضف رقم هاتفك قبل فتح هذه المساحة الخاصة بالناقل حتى تصلك تحديثات الحجز والتشغيل.",
    ),
    "carrierGatePhoneTitle": MessageLookupByLibrary.simpleMessage(
      "رقم الهاتف مطلوب",
    ),
    "carrierGateVerificationMessage": MessageLookupByLibrary.simpleMessage(
      "أكمل تحقق الناقل قبل فتح هذه المساحة لنشر المسارات أو إدارة الحجوزات.",
    ),
    "carrierGateVerificationTitle": MessageLookupByLibrary.simpleMessage(
      "التحقق مطلوب",
    ),
    "carrierHomeDescription": MessageLookupByLibrary.simpleMessage(
      "راجع حالة التحقق وجهوزية أسطولك والمهام التالية.",
    ),
    "carrierHomeNavLabel": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "carrierHomeTitle": MessageLookupByLibrary.simpleMessage("الرئيسية للناقل"),
    "carrierMilestoneUpdatedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تحديث مرحلة الحجز.",
    ),
    "carrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "أدر بيانات نشاطك والتحقق وحسابات التحويل والمركبات.",
    ),
    "carrierProfileNavLabel": MessageLookupByLibrary.simpleMessage(
      "الملف الشخصي",
    ),
    "carrierProfileSectionTitle": MessageLookupByLibrary.simpleMessage(
      "بيانات الناقل",
    ),
    "carrierProfileTitle": MessageLookupByLibrary.simpleMessage("ملف الناقل"),
    "carrierProfileVerificationLabel": MessageLookupByLibrary.simpleMessage(
      "التحقق",
    ),
    "carrierProfileVerificationPending": MessageLookupByLibrary.simpleMessage(
      "قيد المراجعة",
    ),
    "carrierProfileVerificationRejected": MessageLookupByLibrary.simpleMessage(
      "مرفوض",
    ),
    "carrierProfileVerificationVerified": MessageLookupByLibrary.simpleMessage(
      "موثّق",
    ),
    "carrierPublicProfileCommentsTitle": MessageLookupByLibrary.simpleMessage(
      "التعليقات الأخيرة",
    ),
    "carrierPublicProfileDescription": MessageLookupByLibrary.simpleMessage(
      "تظهر هنا مؤشرات سمعة الناقل العامة وعناصر الثقة.",
    ),
    "carrierPublicProfileNoCommentsMessage":
        MessageLookupByLibrary.simpleMessage(
          "لا توجد تعليقات تقييم مرئية بعد.",
        ),
    "carrierPublicProfileRatingLabel": MessageLookupByLibrary.simpleMessage(
      "متوسط التقييم",
    ),
    "carrierPublicProfileReviewCountLabel":
        MessageLookupByLibrary.simpleMessage("عدد التقييمات"),
    "carrierPublicProfileSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "ملخص الناقل",
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
      "أكمل خطوات التحقق المتبقية من ملفك الشخصي.",
    ),
    "carrierVerificationRejectedBanner": m3,
    "carrierVerificationSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "ملخص التحقق",
    ),
    "confirmLabel": MessageLookupByLibrary.simpleMessage("تأكيد"),
    "contactSupportAction": MessageLookupByLibrary.simpleMessage(
      "التواصل مع الدعم",
    ),
    "deliveryConfirmAction": MessageLookupByLibrary.simpleMessage(
      "تأكيد التسليم",
    ),
    "deliveryConfirmedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تأكيد التسليم.",
    ),
    "disputeEvidenceAddAction": MessageLookupByLibrary.simpleMessage(
      "إضافة ملفات دليل",
    ),
    "disputeEvidenceEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لم يتم إرفاق أي ملفات دليل بهذا النزاع بعد.",
    ),
    "disputeEvidenceSelectedCount": m4,
    "disputeEvidenceTitle": MessageLookupByLibrary.simpleMessage("أدلة النزاع"),
    "documentPreviewUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "المعاينة غير متاحة لهذا الملف. افتحه في تطبيق آخر.",
    ),
    "documentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "اعرض هذا المستند هنا أو افتحه في تطبيق آخر.",
    ),
    "documentViewerOpenAction": MessageLookupByLibrary.simpleMessage(
      "افتح المستند",
    ),
    "documentViewerTitle": m5,
    "documentViewerUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "الوصول الآمن إلى المستند غير متاح مؤقتا.",
    ),
    "editCarrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "حدّث بيانات الاتصال ومعلومات الناقل الخاصة بك.",
    ),
    "editCarrierProfileSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تحديث ملف الناقل.",
    ),
    "editCarrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل ملف الناقل",
    ),
    "editShipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "حدّث بيانات الاتصال الخاصة بالشاحن.",
    ),
    "editShipperProfileSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم تحديث ملف الشاحن.",
    ),
    "editShipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل ملف الشاحن",
    ),
    "errorTitle": MessageLookupByLibrary.simpleMessage("حدثت مشكلة"),
    "forbiddenAdminStepUpMessage": MessageLookupByLibrary.simpleMessage(
      "أعد تسجيل الدخول حديثا قبل فتح هذا القسم الإداري الحساس.",
    ),
    "forbiddenMessage": MessageLookupByLibrary.simpleMessage(
      "هذا القسم غير متاح لهذا الحساب.",
    ),
    "forbiddenTitle": MessageLookupByLibrary.simpleMessage("الوصول مقيّد"),
    "generatedDocumentAvailableAtLabel": MessageLookupByLibrary.simpleMessage(
      "متاح في",
    ),
    "generatedDocumentDownloadAction": MessageLookupByLibrary.simpleMessage(
      "تنزيل PDF",
    ),
    "generatedDocumentFailedMessage": MessageLookupByLibrary.simpleMessage(
      "تعذر إنشاء هذا المستند حتى الآن. حاول لاحقا أو تواصل مع الدعم إذا استمرت المشكلة.",
    ),
    "generatedDocumentFailureReasonLabel": MessageLookupByLibrary.simpleMessage(
      "المشكلة",
    ),
    "generatedDocumentOpenInBrowserAction":
        MessageLookupByLibrary.simpleMessage("فتح في المتصفح"),
    "generatedDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "لا يزال هذا المستند قيد الإنشاء. عد بعد قليل.",
    ),
    "generatedDocumentStatusFailedLabel": MessageLookupByLibrary.simpleMessage(
      "يحتاج إلى إعادة إنشاء",
    ),
    "generatedDocumentStatusPendingLabel": MessageLookupByLibrary.simpleMessage(
      "قيد الإنشاء",
    ),
    "generatedDocumentTypeBookingInvoice": MessageLookupByLibrary.simpleMessage(
      "فاتورة الحجز",
    ),
    "generatedDocumentTypePaymentReceipt": MessageLookupByLibrary.simpleMessage(
      "إيصال الدفع",
    ),
    "generatedDocumentTypePayoutReceipt": MessageLookupByLibrary.simpleMessage(
      "إيصال التحويل",
    ),
    "generatedDocumentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "اعرض فاتورتك أو إيصالك أو نزله.",
    ),
    "generatedDocumentViewerTitle": m6,
    "generatedDocumentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "ستظهر الفاتورة والإيصال المولدان هنا عند توفرهما.",
    ),
    "generatedDocumentsTapReadyHint": MessageLookupByLibrary.simpleMessage(
      "اضغط على أي مستند جاهز لفتحه بشكل آمن.",
    ),
    "generatedDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "المستندات المولدة",
    ),
    "goBackAction": MessageLookupByLibrary.simpleMessage("رجوع"),
    "languageOptionArabic": MessageLookupByLibrary.simpleMessage("العربية"),
    "languageOptionEnglish": MessageLookupByLibrary.simpleMessage("الإنجليزية"),
    "languageOptionFrench": MessageLookupByLibrary.simpleMessage("الفرنسية"),
    "languageSelectionCurrentMessage": m7,
    "languageSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "اختر اللغة التي تريد استخدامها داخل FleetFill.",
    ),
    "languageSelectionTitle": MessageLookupByLibrary.simpleMessage(
      "اختيار اللغة",
    ),
    "legalDisputePolicyBody": MessageLookupByLibrary.simpleMessage(
      "يجب فتح النزاعات خلال نافذة مراجعة التسليم. تراجع FleetFill الشحنة وإثبات الدفع والتتبع والمستندات المرتبطة قبل حسم الحالة. وقد ينتهي النزاع بإكمال الحجز أو إلغائه أو رد المبلغ.",
    ),
    "legalDisputePolicyTitle": MessageLookupByLibrary.simpleMessage(
      "سياسة النزاعات",
    ),
    "legalPaymentDisclosureBody": MessageLookupByLibrary.simpleMessage(
      "يظهر تفصيل السعر ورسوم المنصة والضرائب وخيار التأمين قبل إرسال إثبات الدفع. تتحقق FleetFill من إثبات الدفع مقابل إجمالي الحجز، وتؤمن الأموال قبل اكتمال التسليم، ولا تطلق مستحق الناقل إلا بعد أن يصبح الحجز مؤهلا للتحويل.",
    ),
    "legalPaymentDisclosureTitle": MessageLookupByLibrary.simpleMessage(
      "إفصاح الدفع والضمان",
    ),
    "legalPoliciesDescription": MessageLookupByLibrary.simpleMessage(
      "راجع شروط الخدمة والخصوصية والدفع والنزاعات قبل استخدام FleetFill.",
    ),
    "legalPoliciesSupportHint": MessageLookupByLibrary.simpleMessage(
      "إذا احتجت إلى توضيح حول هذه السياسات، فتواصل مع دعم FleetFill قبل متابعة الحجز أو الدفع أو النزاع.",
    ),
    "legalPoliciesTitle": MessageLookupByLibrary.simpleMessage(
      "السياسات والإفصاحات",
    ),
    "legalPrivacyBody": MessageLookupByLibrary.simpleMessage(
      "تحتفظ FleetFill ببيانات الدفع والشحن والدعم والتدقيق فقط عند الحاجة لتشغيل الخدمة والتحقيق في النزاعات والوفاء بالالتزامات القانونية أو المالية. ويظل الوصول محصورا بصاحب الحساب والموظفين المصرح لهم.",
    ),
    "legalPrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "الخصوصية والاحتفاظ بالبيانات",
    ),
    "legalTermsBody": MessageLookupByLibrary.simpleMessage(
      "تستلم FleetFill دفعة الشاحن قبل أي تحويل إلى الناقل. يغطي كل حجز شحنة واحدة على مسار أو رحلة مؤكدة واحدة. يبقى الشاحن مسؤولا عن دقة تفاصيل الشحنة، ويبقى الناقل مسؤولا عن صلاحية الوثائق والامتثال القانوني للنقل.",
    ),
    "legalTermsTitle": MessageLookupByLibrary.simpleMessage("شروط الخدمة"),
    "loadMoreLabel": MessageLookupByLibrary.simpleMessage("تحميل المزيد"),
    "loadingMessage": MessageLookupByLibrary.simpleMessage(
      "جارٍ تجهيز كل شيء لك.",
    ),
    "loadingTitle": MessageLookupByLibrary.simpleMessage("جار التحميل"),
    "locationUnavailableLabel": MessageLookupByLibrary.simpleMessage(
      "الموقع غير متاح",
    ),
    "maintenanceDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill غير متاح مؤقتا بينما نجري بعض التحسينات. حاول مرة أخرى قريبا.",
    ),
    "maintenanceTitle": MessageLookupByLibrary.simpleMessage("سنعود قريبا"),
    "mediaUploadPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "اسمح بالوصول إلى الصور والملفات حتى تتمكن من رفع إثبات الدفع والوثائق.",
    ),
    "mediaUploadPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "السماح بالصور والملفات",
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
      "أدر مساراتك المتكررة ورحلاتك الفردية.",
    ),
    "myRoutesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "انشر مسارا متكررا أو رحلة فردية لبدء عرض السعة.",
    ),
    "myRoutesNavLabel": MessageLookupByLibrary.simpleMessage("المسارات"),
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
    "myRoutesTitle": MessageLookupByLibrary.simpleMessage("مساراتي"),
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
      "أنشئ الشحنات وراجع المسودات وتابع الأحمال المحجوزة.",
    ),
    "myShipmentsNavLabel": MessageLookupByLibrary.simpleMessage("الشحنات"),
    "myShipmentsTitle": MessageLookupByLibrary.simpleMessage("شحناتي"),
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
    "notificationBookingConfirmedBody": MessageLookupByLibrary.simpleMessage(
      "تم تأكيد الحجز. اتبع خطوات الدفع للحفاظ على سيره.",
    ),
    "notificationBookingConfirmedTitle": MessageLookupByLibrary.simpleMessage(
      "تم تأكيد الحجز",
    ),
    "notificationBookingMilestoneUpdatedBody": m8,
    "notificationBookingMilestoneUpdatedTitle":
        MessageLookupByLibrary.simpleMessage("تم تحديث مرحلة الحجز"),
    "notificationCarrierReviewSubmittedBody":
        MessageLookupByLibrary.simpleMessage(
          "تمت إضافة تقييم جديد إلى ملفك الشخصي.",
        ),
    "notificationCarrierReviewSubmittedTitle":
        MessageLookupByLibrary.simpleMessage("تم استلام تقييم الناقل"),
    "notificationDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع التفاصيل الكاملة لهذا الإشعار.",
    ),
    "notificationDetailTitle": m9,
    "notificationDisputeOpenedBody": MessageLookupByLibrary.simpleMessage(
      "تم فتح النزاع وهو بانتظار المراجعة.",
    ),
    "notificationDisputeOpenedTitle": MessageLookupByLibrary.simpleMessage(
      "تم فتح النزاع",
    ),
    "notificationDisputeResolvedBody": MessageLookupByLibrary.simpleMessage(
      "تم حل النزاع. راجع آخر تحديث للحجز والدفع.",
    ),
    "notificationDisputeResolvedTitle": MessageLookupByLibrary.simpleMessage(
      "تم حل النزاع",
    ),
    "notificationGeneratedDocumentReadyBody": m10,
    "notificationGeneratedDocumentReadyTitle":
        MessageLookupByLibrary.simpleMessage("المستند جاهز"),
    "notificationPaymentProofSubmittedBody":
        MessageLookupByLibrary.simpleMessage(
          "استلمنا إثبات الدفع. سنراجعه قريبا.",
        ),
    "notificationPaymentProofSubmittedTitle":
        MessageLookupByLibrary.simpleMessage("تم إرسال إثبات الدفع"),
    "notificationPaymentRejectedBody": MessageLookupByLibrary.simpleMessage(
      "تم رفض إثبات الدفع. تحقق من السبب وأرسل إثباتا جديدا قبل انتهاء المهلة.",
    ),
    "notificationPaymentRejectedTitle": MessageLookupByLibrary.simpleMessage(
      "تم رفض إثبات الدفع",
    ),
    "notificationPaymentSecuredBody": MessageLookupByLibrary.simpleMessage(
      "تم تأمين الدفع وأصبح الحجز مؤكدا.",
    ),
    "notificationPaymentSecuredTitle": MessageLookupByLibrary.simpleMessage(
      "تم تأمين الدفع",
    ),
    "notificationPayoutReleasedBody": MessageLookupByLibrary.simpleMessage(
      "تم صرف مستحق الناقل لهذا الحجز.",
    ),
    "notificationPayoutReleasedTitle": MessageLookupByLibrary.simpleMessage(
      "تم صرف مستحق الناقل",
    ),
    "notificationsCenterDescription": MessageLookupByLibrary.simpleMessage(
      "ابق على اطلاع على الحجوزات والمدفوعات ومراحل التسليم وتنبيهات الحساب.",
    ),
    "notificationsCenterTitle": MessageLookupByLibrary.simpleMessage(
      "الإشعارات",
    ),
    "notificationsOnboardingEnableAction": MessageLookupByLibrary.simpleMessage(
      "تفعيل الإشعارات",
    ),
    "notificationsOnboardingSkipAction": MessageLookupByLibrary.simpleMessage(
      "تخطي الآن",
    ),
    "notificationsOnboardingValueMessage": MessageLookupByLibrary.simpleMessage(
      "فعّل الإشعارات لمتابعة تأكيدات الحجز ومراجعات الدفع ومراحل التسليم وتنبيهات الحساب بوضوح وبدون تخمين.",
    ),
    "notificationsPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "فعّل الإشعارات لتصلك تحديثات الحجز ومراحل التسليم وتنبيهات الدفع.",
    ),
    "notificationsPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "تفعيل الإشعارات",
    ),
    "notificationsSettingsDisabledMessage":
        MessageLookupByLibrary.simpleMessage(
          "ستبقى الإشعارات متوقفة الآن. يمكنك تفعيلها لاحقا من الإعدادات.",
        ),
    "notificationsSettingsEnabledMessage": MessageLookupByLibrary.simpleMessage(
      "تم تفعيل الإشعارات على هذا الجهاز.",
    ),
    "notificationsSettingsEntryDescription":
        MessageLookupByLibrary.simpleMessage(
          "أدر حالة الإذن وافتح مركز الإشعارات.",
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
      "راجع هذه الرحلة قبل الحجز.",
    ),
    "oneOffTripDetailTitle": m11,
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
    "openNotificationsAction": MessageLookupByLibrary.simpleMessage(
      "فتح الإشعارات",
    ),
    "paymentFlowDescription": MessageLookupByLibrary.simpleMessage(
      "اتبع خطوات الدفع وارفع الإثبات وتابع حالة المراجعة.",
    ),
    "paymentFlowTitle": MessageLookupByLibrary.simpleMessage("الدفع"),
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
      "تم تأكيد الدفع.",
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
      "تم استلام إثبات الدفع.",
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
      "أضف الحسابات التي تستقبل عليها التحويلات وأدرها.",
    ),
    "payoutAccountsTitle": MessageLookupByLibrary.simpleMessage(
      "حسابات التحويل",
    ),
    "phoneCompletionDescription": MessageLookupByLibrary.simpleMessage(
      "أضف رقم هاتف لمواصلة استخدام FleetFill.",
    ),
    "phoneCompletionSaveAction": MessageLookupByLibrary.simpleMessage(
      "حفظ رقم الهاتف",
    ),
    "phoneCompletionSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حفظ رقم الهاتف.",
    ),
    "phoneCompletionTitle": MessageLookupByLibrary.simpleMessage(
      "إكمال رقم الهاتف",
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
      "أضف بياناتك حتى يتمكن العملاء والناقلون والدعم من التواصل معك.",
    ),
    "profileSetupSaveAction": MessageLookupByLibrary.simpleMessage(
      "حفظ الملف الشخصي",
    ),
    "profileSetupSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حفظ بيانات الملف الشخصي.",
    ),
    "profileSetupTitle": MessageLookupByLibrary.simpleMessage(
      "إعداد الملف الشخصي",
    ),
    "profileVerificationDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "وثائق تحقق الملف الشخصي",
    ),
    "proofViewerDescription": MessageLookupByLibrary.simpleMessage(
      "اعرض إثبات الدفع لهذا الحجز هنا أو افتحه في تطبيق آخر.",
    ),
    "proofViewerTitle": m12,
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
    "ratingCommentLabel": MessageLookupByLibrary.simpleMessage("تعليق التقييم"),
    "ratingSubmitAction": MessageLookupByLibrary.simpleMessage("إرسال التقييم"),
    "ratingSubmittedMessage": MessageLookupByLibrary.simpleMessage(
      "تم إرسال تقييم الناقل.",
    ),
    "retryLabel": MessageLookupByLibrary.simpleMessage("إعادة المحاولة"),
    "roleSelectionCarrierDescription": MessageLookupByLibrary.simpleMessage(
      "انشر الرحلات، وأدر الحجوزات، وتابع التحقق.",
    ),
    "roleSelectionCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "المتابعة كناقل",
    ),
    "roleSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "اختر كيف تريد استخدام FleetFill حتى نجهز الأدوات المناسبة لحسابك.",
    ),
    "roleSelectionShipperDescription": MessageLookupByLibrary.simpleMessage(
      "أنشئ الشحنات، وقارن الرحلات المطابقة، وتابع التسليم.",
    ),
    "roleSelectionShipperTitle": MessageLookupByLibrary.simpleMessage(
      "المتابعة كشاحن",
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
    "routeDestinationWilayaLabel": MessageLookupByLibrary.simpleMessage(
      "ولاية الوصول",
    ),
    "routeDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع هذا المسار قبل الحجز.",
    ),
    "routeDetailTitle": m13,
    "routeEditTitle": MessageLookupByLibrary.simpleMessage(
      "تعديل المسار المتكرر",
    ),
    "routeEditorDescription": MessageLookupByLibrary.simpleMessage(
      "انشر مسارا متكررا مع المركبة والجدول وتفاصيل السعة.",
    ),
    "routeEffectiveFromLabel": MessageLookupByLibrary.simpleMessage("يسري من"),
    "routeErrorMessage": MessageLookupByLibrary.simpleMessage(
      "تعذر على FleetFill فتح هذا المسار.",
    ),
    "routeOriginLabel": MessageLookupByLibrary.simpleMessage("بلدية الانطلاق"),
    "routeOriginWilayaLabel": MessageLookupByLibrary.simpleMessage(
      "ولاية الانطلاق",
    ),
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
    "sampleBasePriceAmount": MessageLookupByLibrary.simpleMessage("12,500 دج"),
    "sampleBasePriceLabel": MessageLookupByLibrary.simpleMessage(
      "السعر الأساسي",
    ),
    "samplePlatformFeeAmount": MessageLookupByLibrary.simpleMessage("1,200 دج"),
    "samplePlatformFeeLabel": MessageLookupByLibrary.simpleMessage(
      "رسوم المنصة",
    ),
    "sampleTotalAmount": MessageLookupByLibrary.simpleMessage("13,700 دج"),
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
      "اختر شحنة وتاريخا للعثور على الرحلات المناسبة.",
    ),
    "searchTripsFilterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد نتائج تطابق الترتيب والفلاتر الحالية.",
    ),
    "searchTripsNavLabel": MessageLookupByLibrary.simpleMessage("البحث"),
    "searchTripsNearestDateMessage": m14,
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
      "أنشئ شحنة قبل البحث عن الرحلات المناسبة.",
    ),
    "searchTripsResultsTitle": m15,
    "searchTripsTitle": MessageLookupByLibrary.simpleMessage("البحث عن رحلة"),
    "settingsAccountSectionTitle": MessageLookupByLibrary.simpleMessage(
      "الحساب",
    ),
    "settingsDescription": MessageLookupByLibrary.simpleMessage(
      "أدر اللغة والمظهر والإشعارات وخيارات الدعم.",
    ),
    "settingsSignOutAction": MessageLookupByLibrary.simpleMessage(
      "تسجيل الخروج",
    ),
    "settingsSignedOutMessage": MessageLookupByLibrary.simpleMessage(
      "تم تسجيل خروجك.",
    ),
    "settingsThemeModeDarkLabel": MessageLookupByLibrary.simpleMessage("داكنة"),
    "settingsThemeModeLightLabel": MessageLookupByLibrary.simpleMessage(
      "فاتحة",
    ),
    "settingsThemeModeSystemLabel": MessageLookupByLibrary.simpleMessage(
      "النظام",
    ),
    "settingsThemeModeTitle": MessageLookupByLibrary.simpleMessage("السمة"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("الإعدادات"),
    "sharedScaffoldPreviewMessage": MessageLookupByLibrary.simpleMessage(
      "هذه الميزة ستتوفر قريبا.",
    ),
    "sharedScaffoldPreviewTitle": MessageLookupByLibrary.simpleMessage("قريبا"),
    "shipmentCreateAction": MessageLookupByLibrary.simpleMessage("إنشاء شحنة"),
    "shipmentCreateTitle": MessageLookupByLibrary.simpleMessage("إنشاء شحنة"),
    "shipmentDeleteAction": MessageLookupByLibrary.simpleMessage("حذف الشحنة"),
    "shipmentDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "هل تريد حذف هذه الشحنة؟",
    ),
    "shipmentDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حذف الشحنة.",
    ),
    "shipmentDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "تفاصيل الشحنة",
    ),
    "shipmentDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع المسار والوزن والحجم وتفاصيل الشحنة.",
    ),
    "shipmentDetailTitle": m16,
    "shipmentEditAction": MessageLookupByLibrary.simpleMessage("تعديل الشحنة"),
    "shipmentEditTitle": MessageLookupByLibrary.simpleMessage("تعديل الشحنة"),
    "shipmentSaveAction": MessageLookupByLibrary.simpleMessage("حفظ الشحنة"),
    "shipmentSavedMessage": MessageLookupByLibrary.simpleMessage(
      "تم حفظ الشحنة.",
    ),
    "shipmentStatusBookedLabel": MessageLookupByLibrary.simpleMessage("محجوزة"),
    "shipmentStatusCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "ملغاة",
    ),
    "shipmentStatusDraftLabel": MessageLookupByLibrary.simpleMessage("مسودة"),
    "shipmentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "أنشئ مسودة شحنة قبل البحث عن سعة مطابقة.",
    ),
    "shipperHomeActiveBookingsLabel": MessageLookupByLibrary.simpleMessage(
      "الحجوزات النشطة",
    ),
    "shipperHomeDescription": MessageLookupByLibrary.simpleMessage(
      "تابع حجوزاتك النشطة وراجع التحديثات وانتقل بسرعة إلى أهم الإجراءات.",
    ),
    "shipperHomeNavLabel": MessageLookupByLibrary.simpleMessage("الرئيسية"),
    "shipperHomeNoRecentNotificationMessage":
        MessageLookupByLibrary.simpleMessage("ستظهر آخر التحديثات هنا."),
    "shipperHomeQuickActionsTitle": MessageLookupByLibrary.simpleMessage(
      "إجراءات سريعة",
    ),
    "shipperHomeTitle": MessageLookupByLibrary.simpleMessage("الرئيسية للشاحن"),
    "shipperHomeUnreadNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "الإشعارات غير المقروءة",
    ),
    "shipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "أدر بيانات التواصل والإعدادات وخيارات الدعم.",
    ),
    "shipperProfileNavLabel": MessageLookupByLibrary.simpleMessage("الملف"),
    "shipperProfileSectionTitle": MessageLookupByLibrary.simpleMessage(
      "بيانات الشاحن",
    ),
    "shipperProfileTitle": MessageLookupByLibrary.simpleMessage("ملف الشاحن"),
    "splashDescription": MessageLookupByLibrary.simpleMessage(
      "نجهز FleetFill لك الآن.",
    ),
    "splashTitle": MessageLookupByLibrary.simpleMessage("جارٍ التجهيز"),
    "startupConfigurationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill غير متاح حاليا. يرجى المحاولة لاحقا.",
    ),
    "startupConfigurationRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "FleetFill غير متاح",
    ),
    "statusNeedsReviewLabel": MessageLookupByLibrary.simpleMessage(
      "يحتاج مراجعة",
    ),
    "statusReadyLabel": MessageLookupByLibrary.simpleMessage("جاهز"),
    "supportConfiguredEmailMessage": m17,
    "supportDescription": MessageLookupByLibrary.simpleMessage(
      "اطرح سؤالا أو أبلغ عن مشكلة أو اطلب المساعدة بشأن حجز أو دفعة.",
    ),
    "supportMessageLabel": MessageLookupByLibrary.simpleMessage("رسالة الدعم"),
    "supportMessageSentMessage": MessageLookupByLibrary.simpleMessage(
      "تم إرسال رسالة الدعم.",
    ),
    "supportReferenceHintMessage": MessageLookupByLibrary.simpleMessage(
      "أضف أي معرّف حجز أو رقم تتبع أو مرجع دفع يساعد فريق الدعم على التحقيق بسرعة أكبر.",
    ),
    "supportSendAction": MessageLookupByLibrary.simpleMessage("إرسال الرسالة"),
    "supportSubjectLabel": MessageLookupByLibrary.simpleMessage("موضوع الدعم"),
    "supportTitle": MessageLookupByLibrary.simpleMessage("الدعم"),
    "suspendedMessage": MessageLookupByLibrary.simpleMessage(
      "حسابك موقوف حاليا. تواصل مع دعم FleetFill عبر البريد الإلكتروني.",
    ),
    "suspendedTitle": MessageLookupByLibrary.simpleMessage("الحساب موقوف"),
    "trackingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "تابع تقدم التسليم وأكد الاستلام وافتح نزاعا أو اترك تقييما.",
    ),
    "trackingDetailTitle": m18,
    "trackingEventCancelledLabel": MessageLookupByLibrary.simpleMessage("ملغى"),
    "trackingEventCompletedLabel": MessageLookupByLibrary.simpleMessage(
      "مكتمل",
    ),
    "trackingEventConfirmedLabel": MessageLookupByLibrary.simpleMessage("مؤكد"),
    "trackingEventDeliveredPendingReviewLabel":
        MessageLookupByLibrary.simpleMessage("تم التسليم وبانتظار المراجعة"),
    "trackingEventDisputedLabel": MessageLookupByLibrary.simpleMessage(
      "متنازع عليه",
    ),
    "trackingEventInTransitLabel": MessageLookupByLibrary.simpleMessage(
      "في الطريق",
    ),
    "trackingEventPaymentUnderReviewLabel":
        MessageLookupByLibrary.simpleMessage("الدفع قيد المراجعة"),
    "trackingEventPickedUpLabel": MessageLookupByLibrary.simpleMessage(
      "تم الاستلام",
    ),
    "trackingTimelineEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "لا توجد أحداث تتبع متاحة بعد.",
    ),
    "trackingTimelineTitle": MessageLookupByLibrary.simpleMessage(
      "الخط الزمني للتتبع",
    ),
    "updateRequiredDescription": MessageLookupByLibrary.simpleMessage(
      "حدّث FleetFill لمتابعة الاستخدام بأحدث إصدار مدعوم.",
    ),
    "updateRequiredTitle": MessageLookupByLibrary.simpleMessage("تحديث مطلوب"),
    "userDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع بيانات الحساب والحجوزات والمركبات والوثائق.",
    ),
    "userDetailTitle": MessageLookupByLibrary.simpleMessage("تفاصيل المستخدم"),
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
      "تظهر هنا تفاصيل المركبة ووثائقها وحالة التحقق.",
    ),
    "vehicleDetailTitle": MessageLookupByLibrary.simpleMessage(
      "تفاصيل المركبة",
    ),
    "vehicleEditTitle": MessageLookupByLibrary.simpleMessage("تعديل المركبة"),
    "vehicleEditorDescription": MessageLookupByLibrary.simpleMessage(
      "أبق بيانات المركبة محدثة قبل نشر الرحلات.",
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
    "vehicleVerificationRejectedBanner": m19,
    "vehiclesDescription": MessageLookupByLibrary.simpleMessage(
      "أضف المركبات التي تستخدمها للنقل وأدرها.",
    ),
    "vehiclesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "أضف مركبة قبل نشر السعة أو إكمال التحقق الكامل.",
    ),
    "vehiclesTitle": MessageLookupByLibrary.simpleMessage("المركبات"),
    "verificationDocumentDriverIdentityLabel":
        MessageLookupByLibrary.simpleMessage("هوية السائق أو الرخصة"),
    "verificationDocumentMissingMessage": MessageLookupByLibrary.simpleMessage(
      "لم يتم رفع أي ملف بعد.",
    ),
    "verificationDocumentNeedsAttentionMessage":
        MessageLookupByLibrary.simpleMessage("راجع سبب الرفض ثم ارفع بديلا."),
    "verificationDocumentOpenPreparedMessage":
        MessageLookupByLibrary.simpleMessage("وثيقتك جاهزة للفتح."),
    "verificationDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "تم الرفع وينتظر مراجعة الإدارة.",
    ),
    "verificationDocumentRejectedMessage": m20,
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
    "welcomeBackAction": MessageLookupByLibrary.simpleMessage("رجوع"),
    "welcomeCarrierDescription": MessageLookupByLibrary.simpleMessage(
      "انشر السعة المتاحة وراجع الشحنات المناسبة.",
    ),
    "welcomeCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "لديك سعة نقل متاحة",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "يربط FleetFill بين الشحنات وسعة النقل المتاحة.",
    ),
    "welcomeExactMatchDescription": MessageLookupByLibrary.simpleMessage(
      "تربط أدوات البحث والنشر بين المسار والتاريخ المناسبين.",
    ),
    "welcomeExactMatchTitle": MessageLookupByLibrary.simpleMessage(
      "مطابقة الشحنات والنقل",
    ),
    "welcomeHighlightsMessage": MessageLookupByLibrary.simpleMessage(
      "طابق الشحنات مع النقل المتاح وتابع إثبات الدفع وتحديثات التسليم في مكان واحد.",
    ),
    "welcomeLanguageAction": MessageLookupByLibrary.simpleMessage(
      "اختيار اللغة",
    ),
    "welcomeLanguageDescription": MessageLookupByLibrary.simpleMessage(
      "اختر لغة التطبيق لحسابك. يمكنك تغييرها لاحقا من الإعدادات.",
    ),
    "welcomeLanguageTitle": MessageLookupByLibrary.simpleMessage("اختر لغتك"),
    "welcomeNextAction": MessageLookupByLibrary.simpleMessage("التالي"),
    "welcomePaymentDescription": MessageLookupByLibrary.simpleMessage(
      "يبقى إثبات الدفع وتحديثات الحجز واضحة من البداية حتى التسليم.",
    ),
    "welcomePaymentTitle": MessageLookupByLibrary.simpleMessage(
      "اجعل كل حجز واضحا",
    ),
    "welcomeShipperDescription": MessageLookupByLibrary.simpleMessage(
      "أنشئ شحنة وراجع خيارات النقل المناسبة.",
    ),
    "welcomeShipperTitle": MessageLookupByLibrary.simpleMessage(
      "لديك بضائع تريد نقلها",
    ),
    "welcomeSkipAction": MessageLookupByLibrary.simpleMessage("تخطي"),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage(
      "انقل البضائع أو وفّر النقل",
    ),
    "welcomeTrackingDescription": MessageLookupByLibrary.simpleMessage(
      "تابع تحديثات حالة واضحة من الحجز حتى التسليم من دون خرائط مباشرة وهمية.",
    ),
    "welcomeTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "تتبع بسيط بالمراحل",
    ),
    "welcomeTrustDescription": MessageLookupByLibrary.simpleMessage(
      "يبقي FleetFill المطابقة وتحديثات الحجز واضحة للطرفين.",
    ),
    "welcomeTrustTitle": MessageLookupByLibrary.simpleMessage("كيف يعمل"),
  };
}
