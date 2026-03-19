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

  static String m11(shipmentId) => "Shipment ${shipmentId}";

  static String m12(bookingId) => "Tracking ${bookingId}";

  static String m13(reason) => "تحقق المركبة يحتاج إلى إجراء: ${reason}";

  static String m14(reason) => "مرفوض: ${reason}";

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
    "bookingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Shared booking detail routes sit above role shells.",
    ),
    "bookingDetailTitle": m1,
    "bookingReviewDescription": MessageLookupByLibrary.simpleMessage(
      "Carrier reputation, trip detail, and pricing review live here before payment.",
    ),
    "bookingReviewTitle": MessageLookupByLibrary.simpleMessage(
      "Booking review",
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
    "myRoutesDescription": MessageLookupByLibrary.simpleMessage(
      "Recurring routes and one-off trips stay grouped in one branch.",
    ),
    "myRoutesNavLabel": MessageLookupByLibrary.simpleMessage("Routes"),
    "myRoutesTitle": MessageLookupByLibrary.simpleMessage("My routes"),
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
    "oneOffTripDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع تفاصيل هذه الرحلة الفردية قبل الحجز أو المتابعة التشغيلية.",
    ),
    "oneOffTripDetailTitle": m8,
    "paymentFlowDescription": MessageLookupByLibrary.simpleMessage(
      "Instructions, reference, proof upload, and payment status remain in one coherent flow.",
    ),
    "paymentFlowTitle": MessageLookupByLibrary.simpleMessage("Payment flow"),
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
    "routeDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع تفاصيل هذا المسار قبل الحجز أو المتابعة.",
    ),
    "routeDetailTitle": m10,
    "routeErrorMessage": MessageLookupByLibrary.simpleMessage(
      "تعذر على FleetFill فتح هذه الشاشة.",
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
    "searchTripsDescription": MessageLookupByLibrary.simpleMessage(
      "The search form and exact-route results stay on one page with inline states.",
    ),
    "searchTripsNavLabel": MessageLookupByLibrary.simpleMessage("Search"),
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
    "shipmentDetailDescription": MessageLookupByLibrary.simpleMessage(
      "راجع ملخص الشحنة ومحتوياتها والحجز المرتبط بها.",
    ),
    "shipmentDetailTitle": m11,
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
    "trackingDetailTitle": m12,
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
    "vehicleVerificationRejectedBanner": m13,
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
    "verificationDocumentRejectedMessage": m14,
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
