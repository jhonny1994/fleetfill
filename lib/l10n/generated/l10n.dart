// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(
      _current != null,
      'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.',
    );
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(
      instance != null,
      'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?',
    );
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `FleetFill`
  String get appTitle {
    return Intl.message('FleetFill', name: 'appTitle', desc: '', args: []);
  }

  /// `استعرض آخر الإجراءات الإدارية الحساسة ونتائجها.`
  String get adminAuditLogDescription {
    return Intl.message(
      'استعرض آخر الإجراءات الإدارية الحساسة ونتائجها.',
      name: 'adminAuditLogDescription',
      desc: '',
      args: [],
    );
  }

  /// `سجل تدقيق الإدارة`
  String get adminAuditLogTitle {
    return Intl.message(
      'سجل تدقيق الإدارة',
      name: 'adminAuditLogTitle',
      desc: '',
      args: [],
    );
  }

  /// `راقب العمل المعلّق والتنبيهات وحالة الخدمة.`
  String get adminDashboardDescription {
    return Intl.message(
      'راقب العمل المعلّق والتنبيهات وحالة الخدمة.',
      name: 'adminDashboardDescription',
      desc: '',
      args: [],
    );
  }

  /// `الرئيسية`
  String get adminDashboardNavLabel {
    return Intl.message(
      'الرئيسية',
      name: 'adminDashboardNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `لوحة التحكم`
  String get adminDashboardTitle {
    return Intl.message(
      'لوحة التحكم',
      name: 'adminDashboardTitle',
      desc: '',
      args: [],
    );
  }

  /// `راجع المدفوعات والتحقق والنزاعات والتحويلات والبريد الإلكتروني في مكان واحد.`
  String get adminQueuesDescription {
    return Intl.message(
      'راجع المدفوعات والتحقق والنزاعات والتحويلات والبريد الإلكتروني في مكان واحد.',
      name: 'adminQueuesDescription',
      desc: '',
      args: [],
    );
  }

  /// `العمليات`
  String get adminQueuesNavLabel {
    return Intl.message(
      'العمليات',
      name: 'adminQueuesNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `العمليات`
  String get adminQueuesTitle {
    return Intl.message(
      'العمليات',
      name: 'adminQueuesTitle',
      desc: '',
      args: [],
    );
  }

  /// `اعتماد`
  String get adminVerificationApproveAction {
    return Intl.message(
      'اعتماد',
      name: 'adminVerificationApproveAction',
      desc: '',
      args: [],
    );
  }

  /// `اعتماد الكل`
  String get adminVerificationApproveAllAction {
    return Intl.message(
      'اعتماد الكل',
      name: 'adminVerificationApproveAllAction',
      desc: '',
      args: [],
    );
  }

  /// `تم اعتماد ملف التحقق.`
  String get adminVerificationApproveAllSuccess {
    return Intl.message(
      'تم اعتماد ملف التحقق.',
      name: 'adminVerificationApproveAllSuccess',
      desc: '',
      args: [],
    );
  }

  /// `تم اعتماد وثيقة التحقق.`
  String get adminVerificationApprovedMessage {
    return Intl.message(
      'تم اعتماد وثيقة التحقق.',
      name: 'adminVerificationApprovedMessage',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد عناصر تدقيق تحقق حديثة.`
  String get adminVerificationAuditEmptyMessage {
    return Intl.message(
      'لا توجد عناصر تدقيق تحقق حديثة.',
      name: 'adminVerificationAuditEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `سجل تدقيق التحقق`
  String get adminVerificationAuditTitle {
    return Intl.message(
      'سجل تدقيق التحقق',
      name: 'adminVerificationAuditTitle',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم إرسال أي وثائق تحقق بعد.`
  String get adminVerificationMissingDocumentsMessage {
    return Intl.message(
      'لم يتم إرسال أي وثائق تحقق بعد.',
      name: 'adminVerificationMissingDocumentsMessage',
      desc: '',
      args: [],
    );
  }

  /// `راجع وثائق الملف الشخصي والمركبة قبل اعتماد الناقل.`
  String get adminVerificationPacketDescription {
    return Intl.message(
      'راجع وثائق الملف الشخصي والمركبة قبل اعتماد الناقل.',
      name: 'adminVerificationPacketDescription',
      desc: '',
      args: [],
    );
  }

  /// `ملف التحقق`
  String get adminVerificationPacketTitle {
    return Intl.message(
      'ملف التحقق',
      name: 'adminVerificationPacketTitle',
      desc: '',
      args: [],
    );
  }

  /// `وثائق بانتظار المراجعة`
  String get adminVerificationPendingDocumentsLabel {
    return Intl.message(
      'وثائق بانتظار المراجعة',
      name: 'adminVerificationPendingDocumentsLabel',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد طلبات تحقق تحتاج مراجعة حاليا.`
  String get adminVerificationQueueEmptyMessage {
    return Intl.message(
      'لا توجد طلبات تحقق تحتاج مراجعة حاليا.',
      name: 'adminVerificationQueueEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `ملخص التحقق`
  String get adminVerificationQueueSummaryTitle {
    return Intl.message(
      'ملخص التحقق',
      name: 'adminVerificationQueueSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `تحقق الناقلين`
  String get adminVerificationQueueTitle {
    return Intl.message(
      'تحقق الناقلين',
      name: 'adminVerificationQueueTitle',
      desc: '',
      args: [],
    );
  }

  /// `رفض`
  String get adminVerificationRejectAction {
    return Intl.message(
      'رفض',
      name: 'adminVerificationRejectAction',
      desc: '',
      args: [],
    );
  }

  /// `تم رفض وثيقة التحقق.`
  String get adminVerificationRejectedMessage {
    return Intl.message(
      'تم رفض وثيقة التحقق.',
      name: 'adminVerificationRejectedMessage',
      desc: '',
      args: [],
    );
  }

  /// `أضف السبب الذي يجب أن يراه الناقل.`
  String get adminVerificationRejectReasonHint {
    return Intl.message(
      'أضف السبب الذي يجب أن يراه الناقل.',
      name: 'adminVerificationRejectReasonHint',
      desc: '',
      args: [],
    );
  }

  /// `سبب الرفض`
  String get adminVerificationRejectReasonTitle {
    return Intl.message(
      'سبب الرفض',
      name: 'adminVerificationRejectReasonTitle',
      desc: '',
      args: [],
    );
  }

  /// `{documentCount} وثائق معلقة عبر {vehicleCount} مركبات`
  String adminVerificationQueueItemSubtitle(
    Object documentCount,
    Object vehicleCount,
  ) {
    return Intl.message(
      '$documentCount وثائق معلقة عبر $vehicleCount مركبات',
      name: 'adminVerificationQueueItemSubtitle',
      desc: '',
      args: [documentCount, vehicleCount],
    );
  }

  /// `أدر الوصول إلى التطبيق وقواعد التسعير ووضع الصيانة وأدوات البريد الإلكتروني.`
  String get adminSettingsDescription {
    return Intl.message(
      'أدر الوصول إلى التطبيق وقواعد التسعير ووضع الصيانة وأدوات البريد الإلكتروني.',
      name: 'adminSettingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `الإعدادات`
  String get adminSettingsNavLabel {
    return Intl.message(
      'الإعدادات',
      name: 'adminSettingsNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `إعدادات الإدارة`
  String get adminSettingsTitle {
    return Intl.message(
      'إعدادات الإدارة',
      name: 'adminSettingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `ابحث عن المستخدمين وراجع الحسابات والحجوزات والوثائق.`
  String get adminUsersDescription {
    return Intl.message(
      'ابحث عن المستخدمين وراجع الحسابات والحجوزات والوثائق.',
      name: 'adminUsersDescription',
      desc: '',
      args: [],
    );
  }

  /// `المستخدمون`
  String get adminUsersNavLabel {
    return Intl.message(
      'المستخدمون',
      name: 'adminUsersNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `المستخدمون`
  String get adminUsersTitle {
    return Intl.message(
      'المستخدمون',
      name: 'adminUsersTitle',
      desc: '',
      args: [],
    );
  }

  /// `اطلب رابط إعادة تعيين كلمة المرور لحسابك على FleetFill.`
  String get authForgotPasswordDescription {
    return Intl.message(
      'اطلب رابط إعادة تعيين كلمة المرور لحسابك على FleetFill.',
      name: 'authForgotPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `هل نسيت كلمة المرور؟`
  String get authForgotPasswordCta {
    return Intl.message(
      'هل نسيت كلمة المرور؟',
      name: 'authForgotPasswordCta',
      desc: '',
      args: [],
    );
  }

  /// `نسيت كلمة المرور`
  String get authForgotPasswordTitle {
    return Intl.message(
      'نسيت كلمة المرور',
      name: 'authForgotPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `إنشاء حساب`
  String get authCreateAccountAction {
    return Intl.message(
      'إنشاء حساب',
      name: 'authCreateAccountAction',
      desc: '',
      args: [],
    );
  }

  /// `إنشاء حساب جديد`
  String get authCreateAccountCta {
    return Intl.message(
      'إنشاء حساب جديد',
      name: 'authCreateAccountCta',
      desc: '',
      args: [],
    );
  }

  /// `سجّل دخولك أولًا لتتمكن من المتابعة.`
  String get authAuthenticationRequiredMessage {
    return Intl.message(
      'سجّل دخولك أولًا لتتمكن من المتابعة.',
      name: 'authAuthenticationRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `you@example.com`
  String get authEmailHint {
    return Intl.message(
      'you@example.com',
      name: 'authEmailHint',
      desc: '',
      args: [],
    );
  }

  /// `تم إنشاء حسابك بنجاح.`
  String get authAccountCreatedMessage {
    return Intl.message(
      'تم إنشاء حسابك بنجاح.',
      name: 'authAccountCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تأكيد كلمة المرور`
  String get authConfirmPasswordLabel {
    return Intl.message(
      'تأكيد كلمة المرور',
      name: 'authConfirmPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `البريد الإلكتروني`
  String get authEmailLabel {
    return Intl.message(
      'البريد الإلكتروني',
      name: 'authEmailLabel',
      desc: '',
      args: [],
    );
  }

  /// `فعّل بريدك الإلكتروني`
  String get authConfirmEmailTitle {
    return Intl.message(
      'فعّل بريدك الإلكتروني',
      name: 'authConfirmEmailTitle',
      desc: '',
      args: [],
    );
  }

  /// `افتح رابط التفعيل من صندوق بريدك حتى يكتمل إنشاء الحساب وتتابع داخل FleetFill.`
  String get authConfirmEmailDescription {
    return Intl.message(
      'افتح رابط التفعيل من صندوق بريدك حتى يكتمل إنشاء الحساب وتتابع داخل FleetFill.',
      name: 'authConfirmEmailDescription',
      desc: '',
      args: [],
    );
  }

  /// `افتح هذه الصفحة مباشرة بعد إنشاء الحساب أو محاولة تسجيل الدخول حتى يعرف FleetFill أي بريد يجب إعادة إرسال رسالة التفعيل إليه.`
  String get authConfirmEmailMissingAddressMessage {
    return Intl.message(
      'افتح هذه الصفحة مباشرة بعد إنشاء الحساب أو محاولة تسجيل الدخول حتى يعرف FleetFill أي بريد يجب إعادة إرسال رسالة التفعيل إليه.',
      name: 'authConfirmEmailMissingAddressMessage',
      desc: '',
      args: [],
    );
  }

  /// `فعّل بريدك الإلكتروني أولا ثم سجّل دخولك.`
  String get authEmailNotConfirmedMessage {
    return Intl.message(
      'فعّل بريدك الإلكتروني أولا ثم سجّل دخولك.',
      name: 'authEmailNotConfirmedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تعذّر إتمام هذا الطلب حاليا. حاول مرة أخرى.`
  String get authGenericErrorMessage {
    return Intl.message(
      'تعذّر إتمام هذا الطلب حاليا. حاول مرة أخرى.',
      name: 'authGenericErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `دور هذا الحساب محدّد مسبقا ولا يمكن تغييره من هنا.`
  String get authRoleAlreadyAssignedMessage {
    return Intl.message(
      'دور هذا الحساب محدّد مسبقا ولا يمكن تغييره من هنا.',
      name: 'authRoleAlreadyAssignedMessage',
      desc: '',
      args: [],
    );
  }

  /// `المتابعة عبر Google`
  String get authGoogleAction {
    return Intl.message(
      'المتابعة عبر Google',
      name: 'authGoogleAction',
      desc: '',
      args: [],
    );
  }

  /// `تم إلغاء تسجيل الدخول.`
  String get authCancelledMessage {
    return Intl.message(
      'تم إلغاء تسجيل الدخول.',
      name: 'authCancelledMessage',
      desc: '',
      args: [],
    );
  }

  /// `العودة إلى تسجيل الدخول`
  String get authBackToSignInAction {
    return Intl.message(
      'العودة إلى تسجيل الدخول',
      name: 'authBackToSignInAction',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الدخول عبر Google غير متاح في هذه البيئة.`
  String get authGoogleUnavailableMessage {
    return Intl.message(
      'تسجيل الدخول عبر Google غير متاح في هذه البيئة.',
      name: 'authGoogleUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `ابقني مسجّل الدخول`
  String get authKeepSignedInLabel {
    return Intl.message(
      'ابقني مسجّل الدخول',
      name: 'authKeepSignedInLabel',
      desc: '',
      args: [],
    );
  }

  /// `لديك حساب؟ سجّل دخولك`
  String get authHaveAccountCta {
    return Intl.message(
      'لديك حساب؟ سجّل دخولك',
      name: 'authHaveAccountCta',
      desc: '',
      args: [],
    );
  }

  /// `البريد أو كلمة المرور غير صحيح. راجعهما وأعد المحاولة.`
  String get authInvalidCredentialsMessage {
    return Intl.message(
      'البريد أو كلمة المرور غير صحيح. راجعهما وأعد المحاولة.',
      name: 'authInvalidCredentialsMessage',
      desc: '',
      args: [],
    );
  }

  /// `البريد الإلكتروني غير صحيح.`
  String get authInvalidEmailMessage {
    return Intl.message(
      'البريد الإلكتروني غير صحيح.',
      name: 'authInvalidEmailMessage',
      desc: '',
      args: [],
    );
  }

  /// `توجد مشكلة في الاتصال. أعد المحاولة بعد لحظات.`
  String get authNetworkErrorMessage {
    return Intl.message(
      'توجد مشكلة في الاتصال. أعد المحاولة بعد لحظات.',
      name: 'authNetworkErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `كلمة المرور الجديدة`
  String get authNewPasswordLabel {
    return Intl.message(
      'كلمة المرور الجديدة',
      name: 'authNewPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `كلمة المرور`
  String get authPasswordLabel {
    return Intl.message(
      'كلمة المرور',
      name: 'authPasswordLabel',
      desc: '',
      args: [],
    );
  }

  /// `أدخل كلمة المرور`
  String get authPasswordHint {
    return Intl.message(
      'أدخل كلمة المرور',
      name: 'authPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `أنشئ كلمة مرور قوية`
  String get authCreatePasswordHint {
    return Intl.message(
      'أنشئ كلمة مرور قوية',
      name: 'authCreatePasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `أعد إدخال كلمة المرور`
  String get authConfirmPasswordHint {
    return Intl.message(
      'أعد إدخال كلمة المرور',
      name: 'authConfirmPasswordHint',
      desc: '',
      args: [],
    );
  }

  /// `استخدم 8 أحرف على الأقل.`
  String get authPasswordMinLengthMessage {
    return Intl.message(
      'استخدم 8 أحرف على الأقل.',
      name: 'authPasswordMinLengthMessage',
      desc: '',
      args: [],
    );
  }

  /// `كلمتا المرور مختلفتان.`
  String get authPasswordMismatchMessage {
    return Intl.message(
      'كلمتا المرور مختلفتان.',
      name: 'authPasswordMismatchMessage',
      desc: '',
      args: [],
    );
  }

  /// `اختر كلمة مرور أقوى وحاول مرة أخرى.`
  String get authWeakPasswordMessage {
    return Intl.message(
      'اختر كلمة مرور أقوى وحاول مرة أخرى.',
      name: 'authWeakPasswordMessage',
      desc: '',
      args: [],
    );
  }

  /// `سنرسل لك رابط إعادة التعيين إلى بريدك المسجّل.`
  String get authPasswordResetInfoMessage {
    return Intl.message(
      'سنرسل لك رابط إعادة التعيين إلى بريدك المسجّل.',
      name: 'authPasswordResetInfoMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم تغيير كلمة المرور بنجاح.`
  String get authPasswordUpdatedMessage {
    return Intl.message(
      'تم تغيير كلمة المرور بنجاح.',
      name: 'authPasswordUpdatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `افتح بريدك الإلكتروني`
  String get authPasswordResetSentTitle {
    return Intl.message(
      'افتح بريدك الإلكتروني',
      name: 'authPasswordResetSentTitle',
      desc: '',
      args: [],
    );
  }

  /// `استخدم رابط الاسترداد الذي وصلك عبر البريد لاختيار كلمة مرور جديدة.`
  String get authPasswordResetSentDescription {
    return Intl.message(
      'استخدم رابط الاسترداد الذي وصلك عبر البريد لاختيار كلمة مرور جديدة.',
      name: 'authPasswordResetSentDescription',
      desc: '',
      args: [],
    );
  }

  /// `هذا الحقل مطلوب.`
  String get authRequiredFieldMessage {
    return Intl.message(
      'هذا الحقل مطلوب.',
      name: 'authRequiredFieldMessage',
      desc: '',
      args: [],
    );
  }

  /// `محاولات كثيرة. انتظر قليلًا وأعد المحاولة.`
  String get authRateLimitedMessage {
    return Intl.message(
      'محاولات كثيرة. انتظر قليلًا وأعد المحاولة.',
      name: 'authRateLimitedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تعذّر إرسال رسالة التأكيد حاليا. تأكد من إعدادات البريد وحاول مرة أخرى.`
  String get authEmailDeliveryIssueMessage {
    return Intl.message(
      'تعذّر إرسال رسالة التأكيد حاليا. تأكد من إعدادات البريد وحاول مرة أخرى.',
      name: 'authEmailDeliveryIssueMessage',
      desc: '',
      args: [],
    );
  }

  /// `فتح صفحة تسجيل الدخول`
  String get authOpenSignInAction {
    return Intl.message(
      'فتح صفحة تسجيل الدخول',
      name: 'authOpenSignInAction',
      desc: '',
      args: [],
    );
  }

  /// `اطلب رابطا جديدا`
  String get authRequestAnotherLinkAction {
    return Intl.message(
      'اطلب رابطا جديدا',
      name: 'authRequestAnotherLinkAction',
      desc: '',
      args: [],
    );
  }

  /// `إعادة إرسال رسالة التفعيل`
  String get authResendConfirmationAction {
    return Intl.message(
      'إعادة إرسال رسالة التفعيل',
      name: 'authResendConfirmationAction',
      desc: '',
      args: [],
    );
  }

  /// `إعادة إرسال رسالة إعادة التعيين`
  String get authResendResetEmailAction {
    return Intl.message(
      'إعادة إرسال رسالة إعادة التعيين',
      name: 'authResendResetEmailAction',
      desc: '',
      args: [],
    );
  }

  /// `اختر كلمة مرور جديدة بعد فتح رابط الاسترداد.`
  String get authResetPasswordDescription {
    return Intl.message(
      'اختر كلمة مرور جديدة بعد فتح رابط الاسترداد.',
      name: 'authResetPasswordDescription',
      desc: '',
      args: [],
    );
  }

  /// `افتح هذه الصفحة من رابط استعادة كلمة المرور الذي وصلك على البريد.`
  String get authResetPasswordUnavailableMessage {
    return Intl.message(
      'افتح هذه الصفحة من رابط استعادة كلمة المرور الذي وصلك على البريد.',
      name: 'authResetPasswordUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم إرسال تعليمات إعادة تعيين كلمة المرور.`
  String get authResetEmailSentMessage {
    return Intl.message(
      'تم إرسال تعليمات إعادة تعيين كلمة المرور.',
      name: 'authResetEmailSentMessage',
      desc: '',
      args: [],
    );
  }

  /// `إعادة تعيين كلمة المرور`
  String get authResetPasswordTitle {
    return Intl.message(
      'إعادة تعيين كلمة المرور',
      name: 'authResetPasswordTitle',
      desc: '',
      args: [],
    );
  }

  /// `إرسال رابط إعادة التعيين`
  String get authSendResetAction {
    return Intl.message(
      'إرسال رابط إعادة التعيين',
      name: 'authSendResetAction',
      desc: '',
      args: [],
    );
  }

  /// `إنشاء الحسابات غير متاح حاليا. حاول لاحقا.`
  String get authSignUpUnavailableMessage {
    return Intl.message(
      'إنشاء الحسابات غير متاح حاليا. حاول لاحقا.',
      name: 'authSignUpUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `أو المتابعة عبر`
  String get authContinueWithLabel {
    return Intl.message(
      'أو المتابعة عبر',
      name: 'authContinueWithLabel',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الدخول مرة أخرى`
  String get authSessionExpiredAction {
    return Intl.message(
      'تسجيل الدخول مرة أخرى',
      name: 'authSessionExpiredAction',
      desc: '',
      args: [],
    );
  }

  /// `انتهت جلستك. سجّل دخولك من جديد للمتابعة.`
  String get authSessionExpiredMessage {
    return Intl.message(
      'انتهت جلستك. سجّل دخولك من جديد للمتابعة.',
      name: 'authSessionExpiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `انتهت الجلسة`
  String get authSessionExpiredTitle {
    return Intl.message(
      'انتهت الجلسة',
      name: 'authSessionExpiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `استخدم بريدك وكلمة المرور، أو تابع مباشرة عبر Google.`
  String get authSignInDescription {
    return Intl.message(
      'استخدم بريدك وكلمة المرور، أو تابع مباشرة عبر Google.',
      name: 'authSignInDescription',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الدخول`
  String get authSignInAction {
    return Intl.message(
      'تسجيل الدخول',
      name: 'authSignInAction',
      desc: '',
      args: [],
    );
  }

  /// `تم تسجيل الدخول بنجاح.`
  String get authSignInSuccess {
    return Intl.message(
      'تم تسجيل الدخول بنجاح.',
      name: 'authSignInSuccess',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الدخول`
  String get authSignInTitle {
    return Intl.message(
      'تسجيل الدخول',
      name: 'authSignInTitle',
      desc: '',
      args: [],
    );
  }

  /// `أنشئ حسابك على FleetFill وابدأ بشحن بضاعتك أو عرض شاحنتك.`
  String get authSignUpDescription {
    return Intl.message(
      'أنشئ حسابك على FleetFill وابدأ بشحن بضاعتك أو عرض شاحنتك.',
      name: 'authSignUpDescription',
      desc: '',
      args: [],
    );
  }

  /// `إنشاء حساب`
  String get authSignUpTitle {
    return Intl.message(
      'إنشاء حساب',
      name: 'authSignUpTitle',
      desc: '',
      args: [],
    );
  }

  /// `تغيير كلمة المرور`
  String get authUpdatePasswordAction {
    return Intl.message(
      'تغيير كلمة المرور',
      name: 'authUpdatePasswordAction',
      desc: '',
      args: [],
    );
  }

  /// `استخدم بريدا إلكترونيا مختلفا`
  String get authUseDifferentEmailAction {
    return Intl.message(
      'استخدم بريدا إلكترونيا مختلفا',
      name: 'authUseDifferentEmailAction',
      desc: '',
      args: [],
    );
  }

  /// `هذا البريد مسجّل مسبقا. سجّل دخولك أو استعد كلمة المرور.`
  String get authUserAlreadyRegisteredMessage {
    return Intl.message(
      'هذا البريد مسجّل مسبقا. سجّل دخولك أو استعد كلمة المرور.',
      name: 'authUserAlreadyRegisteredMessage',
      desc: '',
      args: [],
    );
  }

  /// `راجع بريدك الإلكتروني وفعّل حسابك قبل تسجيل الدخول.`
  String get authVerificationEmailSentMessage {
    return Intl.message(
      'راجع بريدك الإلكتروني وفعّل حسابك قبل تسجيل الدخول.',
      name: 'authVerificationEmailSentMessage',
      desc: '',
      args: [],
    );
  }

  /// `اشحن بضاعتك أو املأ شاحنتك`
  String get welcomeTitle {
    return Intl.message(
      'اشحن بضاعتك أو املأ شاحنتك',
      name: 'welcomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `FleetFill يوصل بين الشحنات والشاحنات المتاحة في الوقت المناسب.`
  String get welcomeDescription {
    return Intl.message(
      'FleetFill يوصل بين الشحنات والشاحنات المتاحة في الوقت المناسب.',
      name: 'welcomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `اختر اللغة`
  String get welcomeLanguageAction {
    return Intl.message(
      'اختر اللغة',
      name: 'welcomeLanguageAction',
      desc: '',
      args: [],
    );
  }

  /// `ابحث عن شاحنة، ادفع بأمان، وتابع شحنتك خطوة بخطوة — كل ذلك من مكان واحد.`
  String get welcomeHighlightsMessage {
    return Intl.message(
      'ابحث عن شاحنة، ادفع بأمان، وتابع شحنتك خطوة بخطوة — كل ذلك من مكان واحد.',
      name: 'welcomeHighlightsMessage',
      desc: '',
      args: [],
    );
  }

  /// `لديك بضاعة تريد نقلها`
  String get welcomeShipperTitle {
    return Intl.message(
      'لديك بضاعة تريد نقلها',
      name: 'welcomeShipperTitle',
      desc: '',
      args: [],
    );
  }

  /// `سجّل شحنتك واعثر على الشاحنة المناسبة بسرعة.`
  String get welcomeShipperDescription {
    return Intl.message(
      'سجّل شحنتك واعثر على الشاحنة المناسبة بسرعة.',
      name: 'welcomeShipperDescription',
      desc: '',
      args: [],
    );
  }

  /// `لديك شاحنة وأماكن فارغة`
  String get welcomeCarrierTitle {
    return Intl.message(
      'لديك شاحنة وأماكن فارغة',
      name: 'welcomeCarrierTitle',
      desc: '',
      args: [],
    );
  }

  /// `اعرض رحلاتك واستقبل حجوزات من مرسلين يبحثون عن نقل.`
  String get welcomeCarrierDescription {
    return Intl.message(
      'اعرض رحلاتك واستقبل حجوزات من مرسلين يبحثون عن نقل.',
      name: 'welcomeCarrierDescription',
      desc: '',
      args: [],
    );
  }

  /// `تخطّي`
  String get welcomeSkipAction {
    return Intl.message('تخطّي', name: 'welcomeSkipAction', desc: '', args: []);
  }

  /// `السابق`
  String get welcomeBackAction {
    return Intl.message(
      'السابق',
      name: 'welcomeBackAction',
      desc: '',
      args: [],
    );
  }

  /// `التالي`
  String get welcomeNextAction {
    return Intl.message(
      'التالي',
      name: 'welcomeNextAction',
      desc: '',
      args: [],
    );
  }

  /// `كيف يعمل FleetFill؟`
  String get welcomeTrustTitle {
    return Intl.message(
      'كيف يعمل FleetFill؟',
      name: 'welcomeTrustTitle',
      desc: '',
      args: [],
    );
  }

  /// `كل شيء واضح بين المرسل والناقل — من الحجز إلى التسليم.`
  String get welcomeTrustDescription {
    return Intl.message(
      'كل شيء واضح بين المرسل والناقل — من الحجز إلى التسليم.',
      name: 'welcomeTrustDescription',
      desc: '',
      args: [],
    );
  }

  /// `اربط الشحنة بالشاحنة المناسبة`
  String get welcomeExactMatchTitle {
    return Intl.message(
      'اربط الشحنة بالشاحنة المناسبة',
      name: 'welcomeExactMatchTitle',
      desc: '',
      args: [],
    );
  }

  /// `ابحث بالمسار والتاريخ واحصل على نتائج مطابقة فعلًا.`
  String get welcomeExactMatchDescription {
    return Intl.message(
      'ابحث بالمسار والتاريخ واحصل على نتائج مطابقة فعلًا.',
      name: 'welcomeExactMatchDescription',
      desc: '',
      args: [],
    );
  }

  /// `دفع مضمون وشفاف`
  String get welcomePaymentTitle {
    return Intl.message(
      'دفع مضمون وشفاف',
      name: 'welcomePaymentTitle',
      desc: '',
      args: [],
    );
  }

  /// `ارفع إثبات الدفع وتابع حالته — كل خطوة محسوبة من البداية للتسليم.`
  String get welcomePaymentDescription {
    return Intl.message(
      'ارفع إثبات الدفع وتابع حالته — كل خطوة محسوبة من البداية للتسليم.',
      name: 'welcomePaymentDescription',
      desc: '',
      args: [],
    );
  }

  /// `تتبّع واقعي مرحلة بمرحلة`
  String get welcomeTrackingTitle {
    return Intl.message(
      'تتبّع واقعي مرحلة بمرحلة',
      name: 'welcomeTrackingTitle',
      desc: '',
      args: [],
    );
  }

  /// `تابع حالة شحنتك الحقيقية بدون خرائط وهمية — من الاستلام حتى التسليم.`
  String get welcomeTrackingDescription {
    return Intl.message(
      'تابع حالة شحنتك الحقيقية بدون خرائط وهمية — من الاستلام حتى التسليم.',
      name: 'welcomeTrackingDescription',
      desc: '',
      args: [],
    );
  }

  /// `اختر لغة التطبيق`
  String get welcomeLanguageTitle {
    return Intl.message(
      'اختر لغة التطبيق',
      name: 'welcomeLanguageTitle',
      desc: '',
      args: [],
    );
  }

  /// `اختر اللغة التي تناسبك. يمكنك تغييرها لاحقًا من الإعدادات.`
  String get welcomeLanguageDescription {
    return Intl.message(
      'اختر اللغة التي تناسبك. يمكنك تغييرها لاحقًا من الإعدادات.',
      name: 'welcomeLanguageDescription',
      desc: '',
      args: [],
    );
  }

  /// `العمل المعلّق`
  String get adminDashboardBacklogHealthTitle {
    return Intl.message(
      'العمل المعلّق',
      name: 'adminDashboardBacklogHealthTitle',
      desc: '',
      args: [],
    );
  }

  /// `المهام الحساسة للوقت`
  String get adminDashboardAutomationTitle {
    return Intl.message(
      'المهام الحساسة للوقت',
      name: 'adminDashboardAutomationTitle',
      desc: '',
      args: [],
    );
  }

  /// `مراجعات التسليم المتأخرة`
  String get adminDashboardOverdueDeliveryReviewsLabel {
    return Intl.message(
      'مراجعات التسليم المتأخرة',
      name: 'adminDashboardOverdueDeliveryReviewsLabel',
      desc: '',
      args: [],
    );
  }

  /// `إعادات إرسال الدفع المتأخرة`
  String get adminDashboardOverduePaymentResubmissionsLabel {
    return Intl.message(
      'إعادات إرسال الدفع المتأخرة',
      name: 'adminDashboardOverduePaymentResubmissionsLabel',
      desc: '',
      args: [],
    );
  }

  /// `تسليم البريد التشغيلي`
  String get adminDashboardEmailHealthTitle {
    return Intl.message(
      'تسليم البريد التشغيلي',
      name: 'adminDashboardEmailHealthTitle',
      desc: '',
      args: [],
    );
  }

  /// `رسائل بانتظار الإرسال`
  String get adminDashboardEmailBacklogLabel {
    return Intl.message(
      'رسائل بانتظار الإرسال',
      name: 'adminDashboardEmailBacklogLabel',
      desc: '',
      args: [],
    );
  }

  /// `الرسائل الفاشلة`
  String get adminDashboardDeadLetterLabel {
    return Intl.message(
      'الرسائل الفاشلة',
      name: 'adminDashboardDeadLetterLabel',
      desc: '',
      args: [],
    );
  }

  /// `المدفوعات`
  String get adminQueuePaymentsTabLabel {
    return Intl.message(
      'المدفوعات',
      name: 'adminQueuePaymentsTabLabel',
      desc: '',
      args: [],
    );
  }

  /// `التحقق`
  String get adminQueueVerificationTabLabel {
    return Intl.message(
      'التحقق',
      name: 'adminQueueVerificationTabLabel',
      desc: '',
      args: [],
    );
  }

  /// `النزاعات`
  String get adminQueueDisputesTabLabel {
    return Intl.message(
      'النزاعات',
      name: 'adminQueueDisputesTabLabel',
      desc: '',
      args: [],
    );
  }

  /// `الدفعات`
  String get adminQueuePayoutsTabLabel {
    return Intl.message(
      'الدفعات',
      name: 'adminQueuePayoutsTabLabel',
      desc: '',
      args: [],
    );
  }

  /// `البريد التشغيلي`
  String get adminQueueEmailTabLabel {
    return Intl.message(
      'البريد التشغيلي',
      name: 'adminQueueEmailTabLabel',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد تحويلات جاهزة للإطلاق حاليا.`
  String get adminEligiblePayoutsEmptyMessage {
    return Intl.message(
      'لا توجد تحويلات جاهزة للإطلاق حاليا.',
      name: 'adminEligiblePayoutsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `الدفعات المؤهلة`
  String get adminPayoutEligibleTitle {
    return Intl.message(
      'الدفعات المؤهلة',
      name: 'adminPayoutEligibleTitle',
      desc: '',
      args: [],
    );
  }

  /// `إطلاق الدفعة`
  String get adminPayoutReleaseAction {
    return Intl.message(
      'إطلاق الدفعة',
      name: 'adminPayoutReleaseAction',
      desc: '',
      args: [],
    );
  }

  /// `تسليم البريد التشغيلي`
  String get adminEmailQueueTitle {
    return Intl.message(
      'تسليم البريد التشغيلي',
      name: 'adminEmailQueueTitle',
      desc: '',
      args: [],
    );
  }

  /// `ابحث في سجلات البريد الإلكتروني`
  String get adminEmailSearchLabel {
    return Intl.message(
      'ابحث في سجلات البريد الإلكتروني',
      name: 'adminEmailSearchLabel',
      desc: '',
      args: [],
    );
  }

  /// `حالة البريد الإلكتروني`
  String get adminEmailStatusFilterLabel {
    return Intl.message(
      'حالة البريد الإلكتروني',
      name: 'adminEmailStatusFilterLabel',
      desc: '',
      args: [],
    );
  }

  /// `كل الحالات`
  String get adminEmailStatusAllLabel {
    return Intl.message(
      'كل الحالات',
      name: 'adminEmailStatusAllLabel',
      desc: '',
      args: [],
    );
  }

  /// `في الانتظار`
  String get adminEmailStatusQueuedLabel {
    return Intl.message(
      'في الانتظار',
      name: 'adminEmailStatusQueuedLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم الإرسال`
  String get adminEmailStatusSentLabel {
    return Intl.message(
      'تم الإرسال',
      name: 'adminEmailStatusSentLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم التسليم`
  String get adminEmailStatusDeliveredLabel {
    return Intl.message(
      'تم التسليم',
      name: 'adminEmailStatusDeliveredLabel',
      desc: '',
      args: [],
    );
  }

  /// `فشل توليد القالب`
  String get adminEmailStatusRenderFailedLabel {
    return Intl.message(
      'فشل توليد القالب',
      name: 'adminEmailStatusRenderFailedLabel',
      desc: '',
      args: [],
    );
  }

  /// `فشل مؤقت`
  String get adminEmailStatusSoftFailedLabel {
    return Intl.message(
      'فشل مؤقت',
      name: 'adminEmailStatusSoftFailedLabel',
      desc: '',
      args: [],
    );
  }

  /// `فشل نهائي`
  String get adminEmailStatusHardFailedLabel {
    return Intl.message(
      'فشل نهائي',
      name: 'adminEmailStatusHardFailedLabel',
      desc: '',
      args: [],
    );
  }

  /// `مرتد`
  String get adminEmailStatusBouncedLabel {
    return Intl.message(
      'مرتد',
      name: 'adminEmailStatusBouncedLabel',
      desc: '',
      args: [],
    );
  }

  /// `مقيد`
  String get adminEmailStatusSuppressedLabel {
    return Intl.message(
      'مقيد',
      name: 'adminEmailStatusSuppressedLabel',
      desc: '',
      args: [],
    );
  }

  /// `معطلة`
  String get adminEmailStatusDeadLetterLabel {
    return Intl.message(
      'معطلة',
      name: 'adminEmailStatusDeadLetterLabel',
      desc: '',
      args: [],
    );
  }

  /// `مفتاح القالب`
  String get adminEmailTemplateKeyLabel {
    return Intl.message(
      'مفتاح القالب',
      name: 'adminEmailTemplateKeyLabel',
      desc: '',
      args: [],
    );
  }

  /// `لغة القالب`
  String get adminEmailTemplateLanguageLabel {
    return Intl.message(
      'لغة القالب',
      name: 'adminEmailTemplateLanguageLabel',
      desc: '',
      args: [],
    );
  }

  /// `اللغة المطلوبة`
  String get adminEmailLocaleLabel {
    return Intl.message(
      'اللغة المطلوبة',
      name: 'adminEmailLocaleLabel',
      desc: '',
      args: [],
    );
  }

  /// `المزوّد`
  String get adminEmailProviderLabel {
    return Intl.message(
      'المزوّد',
      name: 'adminEmailProviderLabel',
      desc: '',
      args: [],
    );
  }

  /// `معاينة العنوان`
  String get adminEmailSubjectPreviewLabel {
    return Intl.message(
      'معاينة العنوان',
      name: 'adminEmailSubjectPreviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `رمز الخطأ`
  String get adminEmailErrorCodeLabel {
    return Intl.message(
      'رمز الخطأ',
      name: 'adminEmailErrorCodeLabel',
      desc: '',
      args: [],
    );
  }

  /// `رسالة الخطأ`
  String get adminEmailErrorMessageLabel {
    return Intl.message(
      'رسالة الخطأ',
      name: 'adminEmailErrorMessageLabel',
      desc: '',
      args: [],
    );
  }

  /// `لقطة الحمولة`
  String get adminEmailPayloadSnapshotLabel {
    return Intl.message(
      'لقطة الحمولة',
      name: 'adminEmailPayloadSnapshotLabel',
      desc: '',
      args: [],
    );
  }

  /// `إعادة الإرسال`
  String get adminEmailResendAction {
    return Intl.message(
      'إعادة الإرسال',
      name: 'adminEmailResendAction',
      desc: '',
      args: [],
    );
  }

  /// `تمت جدولة إعادة إرسال البريد الإلكتروني.`
  String get adminEmailResendSuccess {
    return Intl.message(
      'تمت جدولة إعادة إرسال البريد الإلكتروني.',
      name: 'adminEmailResendSuccess',
      desc: '',
      args: [],
    );
  }

  /// `الرسائل التشغيلية الفاشلة`
  String get adminEmailDeadLetterTitle {
    return Intl.message(
      'الرسائل التشغيلية الفاشلة',
      name: 'adminEmailDeadLetterTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد رسائل فاشلة تحتاج إلى متابعة الآن.`
  String get adminEmailDeadLetterEmptyMessage {
    return Intl.message(
      'لا توجد رسائل فاشلة تحتاج إلى متابعة الآن.',
      name: 'adminEmailDeadLetterEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد سجلات بريد إلكتروني تطابق عوامل التصفية الحالية.`
  String get adminEmailQueueEmptyMessage {
    return Intl.message(
      'لا توجد سجلات بريد إلكتروني تطابق عوامل التصفية الحالية.',
      name: 'adminEmailQueueEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `ابحث عن المستخدمين`
  String get adminUsersSearchLabel {
    return Intl.message(
      'ابحث عن المستخدمين',
      name: 'adminUsersSearchLabel',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد مستخدمون يطابقون هذا البحث.`
  String get adminUsersEmptyMessage {
    return Intl.message(
      'لا يوجد مستخدمون يطابقون هذا البحث.',
      name: 'adminUsersEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `ملخص الحساب`
  String get adminUserAccountSectionTitle {
    return Intl.message(
      'ملخص الحساب',
      name: 'adminUserAccountSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `الدور`
  String get adminUserRoleLabel {
    return Intl.message(
      'الدور',
      name: 'adminUserRoleLabel',
      desc: '',
      args: [],
    );
  }

  /// `حالة الحساب`
  String get adminUserStatusLabel {
    return Intl.message(
      'حالة الحساب',
      name: 'adminUserStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `نشط`
  String get adminUserStatusActiveLabel {
    return Intl.message(
      'نشط',
      name: 'adminUserStatusActiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `معلّق`
  String get adminUserStatusSuspendedLabel {
    return Intl.message(
      'معلّق',
      name: 'adminUserStatusSuspendedLabel',
      desc: '',
      args: [],
    );
  }

  /// `تعليق المستخدم`
  String get adminUserSuspendAction {
    return Intl.message(
      'تعليق المستخدم',
      name: 'adminUserSuspendAction',
      desc: '',
      args: [],
    );
  }

  /// `إعادة تفعيل المستخدم`
  String get adminUserReactivateAction {
    return Intl.message(
      'إعادة تفعيل المستخدم',
      name: 'adminUserReactivateAction',
      desc: '',
      args: [],
    );
  }

  /// `أضف سببا تشغيليا لهذا التغيير.`
  String get adminUserReasonHint {
    return Intl.message(
      'أضف سببا تشغيليا لهذا التغيير.',
      name: 'adminUserReasonHint',
      desc: '',
      args: [],
    );
  }

  /// `تمت إعادة تفعيل المستخدم.`
  String get adminUserReactivateSuccess {
    return Intl.message(
      'تمت إعادة تفعيل المستخدم.',
      name: 'adminUserReactivateSuccess',
      desc: '',
      args: [],
    );
  }

  /// `تم تعليق المستخدم.`
  String get adminUserSuspendSuccess {
    return Intl.message(
      'تم تعليق المستخدم.',
      name: 'adminUserSuspendSuccess',
      desc: '',
      args: [],
    );
  }

  /// `الحجوزات المرتبطة`
  String get adminUserBookingsSectionTitle {
    return Intl.message(
      'الحجوزات المرتبطة',
      name: 'adminUserBookingsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد حجوزات مرتبطة بهذا المستخدم بعد.`
  String get adminUserBookingsEmptyMessage {
    return Intl.message(
      'لا توجد حجوزات مرتبطة بهذا المستخدم بعد.',
      name: 'adminUserBookingsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `المركبات`
  String get adminUserVehiclesSectionTitle {
    return Intl.message(
      'المركبات',
      name: 'adminUserVehiclesSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد مركبات مرتبطة بهذا المستخدم.`
  String get adminUserVehiclesEmptyMessage {
    return Intl.message(
      'لا توجد مركبات مرتبطة بهذا المستخدم.',
      name: 'adminUserVehiclesEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `وثائق التحقق`
  String get adminUserDocumentsSectionTitle {
    return Intl.message(
      'وثائق التحقق',
      name: 'adminUserDocumentsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد وثائق تحقق متاحة لهذا المستخدم.`
  String get adminUserDocumentsEmptyMessage {
    return Intl.message(
      'لا توجد وثائق تحقق متاحة لهذا المستخدم.',
      name: 'adminUserDocumentsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `آخر الرسائل التشغيلية`
  String get adminUserEmailSectionTitle {
    return Intl.message(
      'آخر الرسائل التشغيلية',
      name: 'adminUserEmailSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد سجلات بريد إلكتروني حديثة لهذا المستخدم.`
  String get adminUserEmailEmptyMessage {
    return Intl.message(
      'لا توجد سجلات بريد إلكتروني حديثة لهذا المستخدم.',
      name: 'adminUserEmailEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `المرسل`
  String get adminUserRoleShipperLabel {
    return Intl.message(
      'المرسل',
      name: 'adminUserRoleShipperLabel',
      desc: '',
      args: [],
    );
  }

  /// `الناقل`
  String get adminUserRoleCarrierLabel {
    return Intl.message(
      'الناقل',
      name: 'adminUserRoleCarrierLabel',
      desc: '',
      args: [],
    );
  }

  /// `الإدارة`
  String get adminUserRoleAdminLabel {
    return Intl.message(
      'الإدارة',
      name: 'adminUserRoleAdminLabel',
      desc: '',
      args: [],
    );
  }

  /// `ملخص الخدمة`
  String get adminSettingsMonitoringSummaryTitle {
    return Intl.message(
      'ملخص الخدمة',
      name: 'adminSettingsMonitoringSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `الوصول إلى التطبيق`
  String get adminSettingsRuntimeSectionTitle {
    return Intl.message(
      'الوصول إلى التطبيق',
      name: 'adminSettingsRuntimeSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `وضع الصيانة`
  String get adminSettingsMaintenanceModeLabel {
    return Intl.message(
      'وضع الصيانة',
      name: 'adminSettingsMaintenanceModeLabel',
      desc: '',
      args: [],
    );
  }

  /// `فرض التحديث`
  String get adminSettingsForceUpdateLabel {
    return Intl.message(
      'فرض التحديث',
      name: 'adminSettingsForceUpdateLabel',
      desc: '',
      args: [],
    );
  }

  /// `الحد الأدنى لإصدار Android`
  String get adminSettingsMinimumAndroidVersionLabel {
    return Intl.message(
      'الحد الأدنى لإصدار Android',
      name: 'adminSettingsMinimumAndroidVersionLabel',
      desc: '',
      args: [],
    );
  }

  /// `الحد الأدنى لإصدار iOS`
  String get adminSettingsMinimumIosVersionLabel {
    return Intl.message(
      'الحد الأدنى لإصدار iOS',
      name: 'adminSettingsMinimumIosVersionLabel',
      desc: '',
      args: [],
    );
  }

  /// `حفظ الإعدادات`
  String get adminSettingsSaveAction {
    return Intl.message(
      'حفظ الإعدادات',
      name: 'adminSettingsSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث إعدادات الإدارة.`
  String get adminSettingsSavedMessage {
    return Intl.message(
      'تم تحديث إعدادات الإدارة.',
      name: 'adminSettingsSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `سياسة التسعير`
  String get adminSettingsPricingSectionTitle {
    return Intl.message(
      'سياسة التسعير',
      name: 'adminSettingsPricingSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `نسبة رسوم المنصة`
  String get adminSettingsPlatformFeeRateLabel {
    return Intl.message(
      'نسبة رسوم المنصة',
      name: 'adminSettingsPlatformFeeRateLabel',
      desc: '',
      args: [],
    );
  }

  /// `نسبة التأمين`
  String get adminSettingsInsuranceRateLabel {
    return Intl.message(
      'نسبة التأمين',
      name: 'adminSettingsInsuranceRateLabel',
      desc: '',
      args: [],
    );
  }

  /// `الحد الأدنى لرسوم التأمين`
  String get adminSettingsInsuranceMinimumLabel {
    return Intl.message(
      'الحد الأدنى لرسوم التأمين',
      name: 'adminSettingsInsuranceMinimumLabel',
      desc: '',
      args: [],
    );
  }

  /// `مهلة إعادة إرسال الدفع (بالساعات)`
  String get adminSettingsPaymentDeadlineLabel {
    return Intl.message(
      'مهلة إعادة إرسال الدفع (بالساعات)',
      name: 'adminSettingsPaymentDeadlineLabel',
      desc: '',
      args: [],
    );
  }

  /// `سياسة مراجعة التسليم`
  String get adminSettingsDeliverySectionTitle {
    return Intl.message(
      'سياسة مراجعة التسليم',
      name: 'adminSettingsDeliverySectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `نافذة السماح للتسليم (بالساعات)`
  String get adminSettingsDeliveryGraceLabel {
    return Intl.message(
      'نافذة السماح للتسليم (بالساعات)',
      name: 'adminSettingsDeliveryGraceLabel',
      desc: '',
      args: [],
    );
  }

  /// `سياسة اللغات`
  String get adminSettingsLocalizationSectionTitle {
    return Intl.message(
      'سياسة اللغات',
      name: 'adminSettingsLocalizationSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `لغة الرجوع`
  String get adminSettingsFallbackLocaleLabel {
    return Intl.message(
      'لغة الرجوع',
      name: 'adminSettingsFallbackLocaleLabel',
      desc: '',
      args: [],
    );
  }

  /// `اللغات المفعلة`
  String get adminSettingsEnabledLocalesLabel {
    return Intl.message(
      'اللغات المفعلة',
      name: 'adminSettingsEnabledLocalesLabel',
      desc: '',
      args: [],
    );
  }

  /// `الميزات الاختيارية`
  String get adminSettingsFeatureFlagsSectionTitle {
    return Intl.message(
      'الميزات الاختيارية',
      name: 'adminSettingsFeatureFlagsSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `تفعيل إعادة إرسال البريد الإلكتروني من الإدارة`
  String get adminSettingsEmailResendEnabledLabel {
    return Intl.message(
      'تفعيل إعادة إرسال البريد الإلكتروني من الإدارة',
      name: 'adminSettingsEmailResendEnabledLabel',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم تسجيل أي أحداث تدقيق إدارية بعد.`
  String get adminAuditLogEmptyMessage {
    return Intl.message(
      'لم يتم تسجيل أي أحداث تدقيق إدارية بعد.',
      name: 'adminAuditLogEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `راجع حالة الحجز وتفاصيل الدفع وملخص السعر.`
  String get bookingDetailDescription {
    return Intl.message(
      'راجع حالة الحجز وتفاصيل الدفع وملخص السعر.',
      name: 'bookingDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `الحجز {bookingId}`
  String bookingDetailTitle(Object bookingId) {
    return Intl.message(
      'الحجز $bookingId',
      name: 'bookingDetailTitle',
      desc: '',
      args: [bookingId],
    );
  }

  /// `تفاصيل الحجز`
  String get bookingDetailPageTitle {
    return Intl.message(
      'تفاصيل الحجز',
      name: 'bookingDetailPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `راجع سمعة الناقل وتفاصيل الرحلة والسعر قبل الدفع.`
  String get bookingReviewDescription {
    return Intl.message(
      'راجع سمعة الناقل وتفاصيل الرحلة والسعر قبل الدفع.',
      name: 'bookingReviewDescription',
      desc: '',
      args: [],
    );
  }

  /// `مراجعة الحجز`
  String get bookingReviewTitle {
    return Intl.message(
      'مراجعة الحجز',
      name: 'bookingReviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `إلغاء`
  String get cancelLabel {
    return Intl.message('إلغاء', name: 'cancelLabel', desc: '', args: []);
  }

  /// `تابع حجوزاتك الحالية وسير التسليم والرحلات المكتملة.`
  String get carrierBookingsDescription {
    return Intl.message(
      'تابع حجوزاتك الحالية وسير التسليم والرحلات المكتملة.',
      name: 'carrierBookingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `الحجوزات`
  String get carrierBookingsNavLabel {
    return Intl.message(
      'الحجوزات',
      name: 'carrierBookingsNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `حجوزاتي`
  String get carrierBookingsTitle {
    return Intl.message(
      'حجوزاتي',
      name: 'carrierBookingsTitle',
      desc: '',
      args: [],
    );
  }

  /// `تابع حالة التحقق وجاهزية أسطولك والمهام التي تنتظرك.`
  String get carrierHomeDescription {
    return Intl.message(
      'تابع حالة التحقق وجاهزية أسطولك والمهام التي تنتظرك.',
      name: 'carrierHomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `الرئيسية`
  String get carrierHomeNavLabel {
    return Intl.message(
      'الرئيسية',
      name: 'carrierHomeNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `الرئيسية للناقل`
  String get carrierHomeTitle {
    return Intl.message(
      'الرئيسية للناقل',
      name: 'carrierHomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `أدر بيانات نشاطك، وثائق التحقق، حسابات التحويل، والمركبات.`
  String get carrierProfileDescription {
    return Intl.message(
      'أدر بيانات نشاطك، وثائق التحقق، حسابات التحويل، والمركبات.',
      name: 'carrierProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `الملف الشخصي`
  String get carrierProfileNavLabel {
    return Intl.message(
      'الملف الشخصي',
      name: 'carrierProfileNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `بيانات الناقل`
  String get carrierProfileSectionTitle {
    return Intl.message(
      'بيانات الناقل',
      name: 'carrierProfileSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `التحقق`
  String get carrierProfileVerificationLabel {
    return Intl.message(
      'التحقق',
      name: 'carrierProfileVerificationLabel',
      desc: '',
      args: [],
    );
  }

  /// `قيد المراجعة`
  String get carrierProfileVerificationPending {
    return Intl.message(
      'قيد المراجعة',
      name: 'carrierProfileVerificationPending',
      desc: '',
      args: [],
    );
  }

  /// `مرفوض`
  String get carrierProfileVerificationRejected {
    return Intl.message(
      'مرفوض',
      name: 'carrierProfileVerificationRejected',
      desc: '',
      args: [],
    );
  }

  /// `موثّق`
  String get carrierProfileVerificationVerified {
    return Intl.message(
      'موثّق',
      name: 'carrierProfileVerificationVerified',
      desc: '',
      args: [],
    );
  }

  /// `ملف الناقل`
  String get carrierProfileTitle {
    return Intl.message(
      'ملف الناقل',
      name: 'carrierProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `أدر تحقق الناقل من مكان واحد عبر رفع وثائق السائق والمركبة المطلوبة.`
  String get carrierVerificationCenterDescription {
    return Intl.message(
      'أدر تحقق الناقل من مكان واحد عبر رفع وثائق السائق والمركبة المطلوبة.',
      name: 'carrierVerificationCenterDescription',
      desc: '',
      args: [],
    );
  }

  /// `تحقق الناقل`
  String get carrierVerificationCenterTitle {
    return Intl.message(
      'تحقق الناقل',
      name: 'carrierVerificationCenterTitle',
      desc: '',
      args: [],
    );
  }

  /// `ملفك قيد المراجعة. ارفع أي وثائق ناقصة لتسريع الاعتماد.`
  String get carrierVerificationPendingBanner {
    return Intl.message(
      'ملفك قيد المراجعة. ارفع أي وثائق ناقصة لتسريع الاعتماد.',
      name: 'carrierVerificationPendingBanner',
      desc: '',
      args: [],
    );
  }

  /// `أكمل خطوات التحقق المتبقية من ملفك الشخصي.`
  String get carrierVerificationQueueHint {
    return Intl.message(
      'أكمل خطوات التحقق المتبقية من ملفك الشخصي.',
      name: 'carrierVerificationQueueHint',
      desc: '',
      args: [],
    );
  }

  /// `التحقق يحتاج تصحيح: {reason}`
  String carrierVerificationRejectedBanner(Object reason) {
    return Intl.message(
      'التحقق يحتاج تصحيح: $reason',
      name: 'carrierVerificationRejectedBanner',
      desc: '',
      args: [reason],
    );
  }

  /// `ملخص التحقق`
  String get carrierVerificationSummaryTitle {
    return Intl.message(
      'ملخص التحقق',
      name: 'carrierVerificationSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `أدر الشاحنات وارفع الوثائق الناقصة وعالج عوائق التحقق.`
  String get carrierVehiclesShortcutDescription {
    return Intl.message(
      'أدر الشاحنات وارفع الوثائق الناقصة وعالج عوائق التحقق.',
      name: 'carrierVehiclesShortcutDescription',
      desc: '',
      args: [],
    );
  }

  /// `التعليقات الأخيرة`
  String get carrierPublicProfileCommentsTitle {
    return Intl.message(
      'التعليقات الأخيرة',
      name: 'carrierPublicProfileCommentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `استعرض سمعة هذا الناقل وتقييماته وحالة تحققه.`
  String get carrierPublicProfileDescription {
    return Intl.message(
      'استعرض سمعة هذا الناقل وتقييماته وحالة تحققه.',
      name: 'carrierPublicProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد تقييمات بعد.`
  String get carrierPublicProfileNoCommentsMessage {
    return Intl.message(
      'لا توجد تقييمات بعد.',
      name: 'carrierPublicProfileNoCommentsMessage',
      desc: '',
      args: [],
    );
  }

  /// `متوسط التقييم`
  String get carrierPublicProfileRatingLabel {
    return Intl.message(
      'متوسط التقييم',
      name: 'carrierPublicProfileRatingLabel',
      desc: '',
      args: [],
    );
  }

  /// `عدد التقييمات`
  String get carrierPublicProfileReviewCountLabel {
    return Intl.message(
      'عدد التقييمات',
      name: 'carrierPublicProfileReviewCountLabel',
      desc: '',
      args: [],
    );
  }

  /// `ملخص الناقل`
  String get carrierPublicProfileSummaryTitle {
    return Intl.message(
      'ملخص الناقل',
      name: 'carrierPublicProfileSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `الناقل {carrierId}`
  String carrierPublicProfileTitle(Object carrierId) {
    return Intl.message(
      'الناقل $carrierId',
      name: 'carrierPublicProfileTitle',
      desc: '',
      args: [carrierId],
    );
  }

  /// `ملف الناقل`
  String get carrierPublicProfilePageTitle {
    return Intl.message(
      'ملف الناقل',
      name: 'carrierPublicProfilePageTitle',
      desc: '',
      args: [],
    );
  }

  /// `تأكيد`
  String get confirmLabel {
    return Intl.message('تأكيد', name: 'confirmLabel', desc: '', args: []);
  }

  /// `اعرض هذا المستند هنا أو افتحه في تطبيق آخر.`
  String get documentViewerDescription {
    return Intl.message(
      'اعرض هذا المستند هنا أو افتحه في تطبيق آخر.',
      name: 'documentViewerDescription',
      desc: '',
      args: [],
    );
  }

  /// `افتح المستند`
  String get documentViewerOpenAction {
    return Intl.message(
      'افتح المستند',
      name: 'documentViewerOpenAction',
      desc: '',
      args: [],
    );
  }

  /// `المستند {documentId}`
  String documentViewerTitle(Object documentId) {
    return Intl.message(
      'المستند $documentId',
      name: 'documentViewerTitle',
      desc: '',
      args: [documentId],
    );
  }

  /// `المستند`
  String get documentViewerPageTitle {
    return Intl.message(
      'المستند',
      name: 'documentViewerPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `الوصول الآمن إلى المستند غير متاح مؤقتا.`
  String get documentViewerUnavailableMessage {
    return Intl.message(
      'الوصول الآمن إلى المستند غير متاح مؤقتا.',
      name: 'documentViewerUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `مستند التحقق`
  String get verificationDocumentViewerTitle {
    return Intl.message(
      'مستند التحقق',
      name: 'verificationDocumentViewerTitle',
      desc: '',
      args: [],
    );
  }

  /// `حدّث بيانات الاتصال ومعلومات الناقل الخاصة بك.`
  String get editCarrierProfileDescription {
    return Intl.message(
      'حدّث بيانات الاتصال ومعلومات الناقل الخاصة بك.',
      name: 'editCarrierProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث ملف الناقل.`
  String get editCarrierProfileSavedMessage {
    return Intl.message(
      'تم تحديث ملف الناقل.',
      name: 'editCarrierProfileSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تعديل ملف الناقل`
  String get editCarrierProfileTitle {
    return Intl.message(
      'تعديل ملف الناقل',
      name: 'editCarrierProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `حدّث بيانات الاتصال الخاصة بالمرسل.`
  String get editShipperProfileDescription {
    return Intl.message(
      'حدّث بيانات الاتصال الخاصة بالمرسل.',
      name: 'editShipperProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث ملف المرسل.`
  String get editShipperProfileSavedMessage {
    return Intl.message(
      'تم تحديث ملف المرسل.',
      name: 'editShipperProfileSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تعديل ملف المرسل`
  String get editShipperProfileTitle {
    return Intl.message(
      'تعديل ملف المرسل',
      name: 'editShipperProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `حدث خطأ`
  String get errorTitle {
    return Intl.message('حدث خطأ', name: 'errorTitle', desc: '', args: []);
  }

  /// `اعرض فاتورتك أو إيصالك أو نزله.`
  String get generatedDocumentViewerDescription {
    return Intl.message(
      'اعرض فاتورتك أو إيصالك أو نزله.',
      name: 'generatedDocumentViewerDescription',
      desc: '',
      args: [],
    );
  }

  /// `المستند المُولَّد {documentId}`
  String generatedDocumentViewerTitle(Object documentId) {
    return Intl.message(
      'المستند المُولَّد $documentId',
      name: 'generatedDocumentViewerTitle',
      desc: '',
      args: [documentId],
    );
  }

  /// `المستند المُولَّد`
  String get generatedDocumentViewerPageTitle {
    return Intl.message(
      'المستند المُولَّد',
      name: 'generatedDocumentViewerPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `إيصال الدفع`
  String get generatedDocumentTypePaymentReceipt {
    return Intl.message(
      'إيصال الدفع',
      name: 'generatedDocumentTypePaymentReceipt',
      desc: '',
      args: [],
    );
  }

  /// `إيصال التحويل`
  String get generatedDocumentTypePayoutReceipt {
    return Intl.message(
      'إيصال التحويل',
      name: 'generatedDocumentTypePayoutReceipt',
      desc: '',
      args: [],
    );
  }

  /// `قيد الإنشاء`
  String get generatedDocumentStatusPendingLabel {
    return Intl.message(
      'قيد الإنشاء',
      name: 'generatedDocumentStatusPendingLabel',
      desc: '',
      args: [],
    );
  }

  /// `يحتاج إلى إعادة إنشاء`
  String get generatedDocumentStatusFailedLabel {
    return Intl.message(
      'يحتاج إلى إعادة إنشاء',
      name: 'generatedDocumentStatusFailedLabel',
      desc: '',
      args: [],
    );
  }

  /// `لا يزال هذا المستند قيد الإنشاء. عد بعد قليل.`
  String get generatedDocumentPendingMessage {
    return Intl.message(
      'لا يزال هذا المستند قيد الإنشاء. عد بعد قليل.',
      name: 'generatedDocumentPendingMessage',
      desc: '',
      args: [],
    );
  }

  /// `تعذر إنشاء هذا المستند حتى الآن. حاول لاحقا أو تواصل مع الدعم إذا استمرت المشكلة.`
  String get generatedDocumentFailedMessage {
    return Intl.message(
      'تعذر إنشاء هذا المستند حتى الآن. حاول لاحقا أو تواصل مع الدعم إذا استمرت المشكلة.',
      name: 'generatedDocumentFailedMessage',
      desc: '',
      args: [],
    );
  }

  /// `متاح في`
  String get generatedDocumentAvailableAtLabel {
    return Intl.message(
      'متاح في',
      name: 'generatedDocumentAvailableAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `المشكلة`
  String get generatedDocumentFailureReasonLabel {
    return Intl.message(
      'المشكلة',
      name: 'generatedDocumentFailureReasonLabel',
      desc: '',
      args: [],
    );
  }

  /// `فتح في المتصفح`
  String get generatedDocumentOpenInBrowserAction {
    return Intl.message(
      'فتح في المتصفح',
      name: 'generatedDocumentOpenInBrowserAction',
      desc: '',
      args: [],
    );
  }

  /// `تنزيل PDF`
  String get generatedDocumentDownloadAction {
    return Intl.message(
      'تنزيل PDF',
      name: 'generatedDocumentDownloadAction',
      desc: '',
      args: [],
    );
  }

  /// `المستند جاهز`
  String get notificationGeneratedDocumentReadyTitle {
    return Intl.message(
      'المستند جاهز',
      name: 'notificationGeneratedDocumentReadyTitle',
      desc: '',
      args: [],
    );
  }

  /// `أصبح {documentType} جاهزا للعرض الآمن.`
  String notificationGeneratedDocumentReadyBody(Object documentType) {
    return Intl.message(
      'أصبح $documentType جاهزا للعرض الآمن.',
      name: 'notificationGeneratedDocumentReadyBody',
      desc: '',
      args: [documentType],
    );
  }

  /// `تم اعتماد التحقق`
  String get notificationVerificationPacketApprovedTitle {
    return Intl.message(
      'تم اعتماد التحقق',
      name: 'notificationVerificationPacketApprovedTitle',
      desc: '',
      args: [],
    );
  }

  /// `تم اعتماد ملف التحقق الخاص بك. يمكنك الآن متابعة عمليات الناقل.`
  String get notificationVerificationPacketApprovedBody {
    return Intl.message(
      'تم اعتماد ملف التحقق الخاص بك. يمكنك الآن متابعة عمليات الناقل.',
      name: 'notificationVerificationPacketApprovedBody',
      desc: '',
      args: [],
    );
  }

  /// `تم رفض وثيقة التحقق`
  String get notificationVerificationDocumentRejectedTitle {
    return Intl.message(
      'تم رفض وثيقة التحقق',
      name: 'notificationVerificationDocumentRejectedTitle',
      desc: '',
      args: [],
    );
  }

  /// `تم رفض {documentType}. السبب: {reason}`
  String notificationVerificationDocumentRejectedBody(
    Object documentType,
    Object reason,
  ) {
    return Intl.message(
      'تم رفض $documentType. السبب: $reason',
      name: 'notificationVerificationDocumentRejectedBody',
      desc: '',
      args: [documentType, reason],
    );
  }

  /// `أدلة النزاع`
  String get disputeEvidenceTitle {
    return Intl.message(
      'أدلة النزاع',
      name: 'disputeEvidenceTitle',
      desc: '',
      args: [],
    );
  }

  /// `إضافة ملفات دليل`
  String get disputeEvidenceAddAction {
    return Intl.message(
      'إضافة ملفات دليل',
      name: 'disputeEvidenceAddAction',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم إرفاق أي ملفات دليل بهذا النزاع بعد.`
  String get disputeEvidenceEmptyMessage {
    return Intl.message(
      'لم يتم إرفاق أي ملفات دليل بهذا النزاع بعد.',
      name: 'disputeEvidenceEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `الملفات المحددة: {count}`
  String disputeEvidenceSelectedCount(Object count) {
    return Intl.message(
      'الملفات المحددة: $count',
      name: 'disputeEvidenceSelectedCount',
      desc: '',
      args: [count],
    );
  }

  /// `هذا القسم غير متاح لحسابك.`
  String get forbiddenMessage {
    return Intl.message(
      'هذا القسم غير متاح لحسابك.',
      name: 'forbiddenMessage',
      desc: '',
      args: [],
    );
  }

  /// `ممنوع الوصول`
  String get forbiddenTitle {
    return Intl.message(
      'ممنوع الوصول',
      name: 'forbiddenTitle',
      desc: '',
      args: [],
    );
  }

  /// `أعد تسجيل الدخول قبل فتح هذا القسم الحساس.`
  String get forbiddenAdminStepUpMessage {
    return Intl.message(
      'أعد تسجيل الدخول قبل فتح هذا القسم الحساس.',
      name: 'forbiddenAdminStepUpMessage',
      desc: '',
      args: [],
    );
  }

  /// `اختر اللغة التي تريد استخدامها داخل FleetFill.`
  String get languageSelectionDescription {
    return Intl.message(
      'اختر اللغة التي تريد استخدامها داخل FleetFill.',
      name: 'languageSelectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `لغة التطبيق الحالية: {languageCode}`
  String languageSelectionCurrentMessage(Object languageCode) {
    return Intl.message(
      'لغة التطبيق الحالية: $languageCode',
      name: 'languageSelectionCurrentMessage',
      desc: '',
      args: [languageCode],
    );
  }

  /// `العربية`
  String get languageOptionArabic {
    return Intl.message(
      'العربية',
      name: 'languageOptionArabic',
      desc: '',
      args: [],
    );
  }

  /// `الإنجليزية`
  String get languageOptionEnglish {
    return Intl.message(
      'الإنجليزية',
      name: 'languageOptionEnglish',
      desc: '',
      args: [],
    );
  }

  /// `الفرنسية`
  String get languageOptionFrench {
    return Intl.message(
      'الفرنسية',
      name: 'languageOptionFrench',
      desc: '',
      args: [],
    );
  }

  /// `اختيار اللغة`
  String get languageSelectionTitle {
    return Intl.message(
      'اختيار اللغة',
      name: 'languageSelectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `لحظة، نجهّز كل شيء لك.`
  String get loadingMessage {
    return Intl.message(
      'لحظة، نجهّز كل شيء لك.',
      name: 'loadingMessage',
      desc: '',
      args: [],
    );
  }

  /// `جاري التحميل`
  String get loadingTitle {
    return Intl.message(
      'جاري التحميل',
      name: 'loadingTitle',
      desc: '',
      args: [],
    );
  }

  /// `FleetFill متوقف مؤقتا للتحسين. حاول مرة أخرى قريبا.`
  String get maintenanceDescription {
    return Intl.message(
      'FleetFill متوقف مؤقتا للتحسين. حاول مرة أخرى قريبا.',
      name: 'maintenanceDescription',
      desc: '',
      args: [],
    );
  }

  /// `سنعود قريبًا`
  String get maintenanceTitle {
    return Intl.message(
      'سنعود قريبًا',
      name: 'maintenanceTitle',
      desc: '',
      args: [],
    );
  }

  /// `اسمح بالوصول إلى الصور والملفات لتتمكن من رفع إثبات الدفع والوثائق.`
  String get mediaUploadPermissionDescription {
    return Intl.message(
      'اسمح بالوصول إلى الصور والملفات لتتمكن من رفع إثبات الدفع والوثائق.',
      name: 'mediaUploadPermissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `السماح بالصور والملفات`
  String get mediaUploadPermissionTitle {
    return Intl.message(
      'السماح بالصور والملفات',
      name: 'mediaUploadPermissionTitle',
      desc: '',
      args: [],
    );
  }

  /// `ملخص التسعير`
  String get moneySummaryTitle {
    return Intl.message(
      'ملخص التسعير',
      name: 'moneySummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `أدر مساراتك المتكررة ورحلاتك الفردية.`
  String get myRoutesDescription {
    return Intl.message(
      'أدر مساراتك المتكررة ورحلاتك الفردية.',
      name: 'myRoutesDescription',
      desc: '',
      args: [],
    );
  }

  /// `المسارات`
  String get myRoutesNavLabel {
    return Intl.message(
      'المسارات',
      name: 'myRoutesNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `مساراتي`
  String get myRoutesTitle {
    return Intl.message('مساراتي', name: 'myRoutesTitle', desc: '', args: []);
  }

  /// `أنشئ الشحنات وراجع المسودات وتابع الأحمال المحجوزة.`
  String get myShipmentsDescription {
    return Intl.message(
      'أنشئ الشحنات وراجع المسودات وتابع الأحمال المحجوزة.',
      name: 'myShipmentsDescription',
      desc: '',
      args: [],
    );
  }

  /// `الشحنات`
  String get myShipmentsNavLabel {
    return Intl.message(
      'الشحنات',
      name: 'myShipmentsNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `شحناتي`
  String get myShipmentsTitle {
    return Intl.message('شحناتي', name: 'myShipmentsTitle', desc: '', args: []);
  }

  /// `لا يوجد مسار مطابق تماما لهذا البحث حاليا.`
  String get noExactResultsMessage {
    return Intl.message(
      'لا يوجد مسار مطابق تماما لهذا البحث حاليا.',
      name: 'noExactResultsMessage',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم العثور على مسار مطابق`
  String get noExactResultsTitle {
    return Intl.message(
      'لم يتم العثور على مسار مطابق',
      name: 'noExactResultsTitle',
      desc: '',
      args: [],
    );
  }

  /// `راجع التفاصيل الكاملة لهذا الإشعار.`
  String get notificationDetailDescription {
    return Intl.message(
      'راجع التفاصيل الكاملة لهذا الإشعار.',
      name: 'notificationDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `الإشعار {notificationId}`
  String notificationDetailTitle(Object notificationId) {
    return Intl.message(
      'الإشعار $notificationId',
      name: 'notificationDetailTitle',
      desc: '',
      args: [notificationId],
    );
  }

  /// `الإشعار`
  String get notificationDetailPageTitle {
    return Intl.message(
      'الإشعار',
      name: 'notificationDetailPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `ابق على اطلاع على الحجوزات والمدفوعات ومراحل التسليم وتنبيهات الحساب.`
  String get notificationsCenterDescription {
    return Intl.message(
      'ابق على اطلاع على الحجوزات والمدفوعات ومراحل التسليم وتنبيهات الحساب.',
      name: 'notificationsCenterDescription',
      desc: '',
      args: [],
    );
  }

  /// `الإشعارات`
  String get notificationsCenterTitle {
    return Intl.message(
      'الإشعارات',
      name: 'notificationsCenterTitle',
      desc: '',
      args: [],
    );
  }

  /// `أدر حالة الإذن وافتح مركز الإشعارات.`
  String get notificationsSettingsEntryDescription {
    return Intl.message(
      'أدر حالة الإذن وافتح مركز الإشعارات.',
      name: 'notificationsSettingsEntryDescription',
      desc: '',
      args: [],
    );
  }

  /// `تم تفعيل الإشعارات على هذا الجهاز.`
  String get notificationsSettingsEnabledMessage {
    return Intl.message(
      'تم تفعيل الإشعارات على هذا الجهاز.',
      name: 'notificationsSettingsEnabledMessage',
      desc: '',
      args: [],
    );
  }

  /// `ستبقى الإشعارات متوقفة الآن. يمكنك تفعيلها لاحقا من الإعدادات.`
  String get notificationsSettingsDisabledMessage {
    return Intl.message(
      'ستبقى الإشعارات متوقفة الآن. يمكنك تفعيلها لاحقا من الإعدادات.',
      name: 'notificationsSettingsDisabledMessage',
      desc: '',
      args: [],
    );
  }

  /// `فعّل الإشعارات حتى توصلك تأكيدات الحجز وتحديثات الدفع ومراحل التسليم أول بأول.`
  String get notificationsOnboardingValueMessage {
    return Intl.message(
      'فعّل الإشعارات حتى توصلك تأكيدات الحجز وتحديثات الدفع ومراحل التسليم أول بأول.',
      name: 'notificationsOnboardingValueMessage',
      desc: '',
      args: [],
    );
  }

  /// `تفعيل الإشعارات`
  String get notificationsOnboardingEnableAction {
    return Intl.message(
      'تفعيل الإشعارات',
      name: 'notificationsOnboardingEnableAction',
      desc: '',
      args: [],
    );
  }

  /// `تخطي الآن`
  String get notificationsOnboardingSkipAction {
    return Intl.message(
      'تخطي الآن',
      name: 'notificationsOnboardingSkipAction',
      desc: '',
      args: [],
    );
  }

  /// `تم تأكيد الحجز`
  String get notificationBookingConfirmedTitle {
    return Intl.message(
      'تم تأكيد الحجز',
      name: 'notificationBookingConfirmedTitle',
      desc: '',
      args: [],
    );
  }

  /// `تم تأكيد الحجز. اتبع خطوات الدفع للحفاظ على سيره.`
  String get notificationBookingConfirmedBody {
    return Intl.message(
      'تم تأكيد الحجز. اتبع خطوات الدفع للحفاظ على سيره.',
      name: 'notificationBookingConfirmedBody',
      desc: '',
      args: [],
    );
  }

  /// `تم إرسال إثبات الدفع`
  String get notificationPaymentProofSubmittedTitle {
    return Intl.message(
      'تم إرسال إثبات الدفع',
      name: 'notificationPaymentProofSubmittedTitle',
      desc: '',
      args: [],
    );
  }

  /// `استلمنا إثبات الدفع. سنراجعه قريبا.`
  String get notificationPaymentProofSubmittedBody {
    return Intl.message(
      'استلمنا إثبات الدفع. سنراجعه قريبا.',
      name: 'notificationPaymentProofSubmittedBody',
      desc: '',
      args: [],
    );
  }

  /// `تم تأمين الدفع`
  String get notificationPaymentSecuredTitle {
    return Intl.message(
      'تم تأمين الدفع',
      name: 'notificationPaymentSecuredTitle',
      desc: '',
      args: [],
    );
  }

  /// `تم تأمين الدفع وأصبح الحجز مؤكدا.`
  String get notificationPaymentSecuredBody {
    return Intl.message(
      'تم تأمين الدفع وأصبح الحجز مؤكدا.',
      name: 'notificationPaymentSecuredBody',
      desc: '',
      args: [],
    );
  }

  /// `تم رفض إثبات الدفع`
  String get notificationPaymentRejectedTitle {
    return Intl.message(
      'تم رفض إثبات الدفع',
      name: 'notificationPaymentRejectedTitle',
      desc: '',
      args: [],
    );
  }

  /// `تم رفض إثبات الدفع. تحقق من السبب وأرسل إثباتا جديدا قبل انتهاء المهلة.`
  String get notificationPaymentRejectedBody {
    return Intl.message(
      'تم رفض إثبات الدفع. تحقق من السبب وأرسل إثباتا جديدا قبل انتهاء المهلة.',
      name: 'notificationPaymentRejectedBody',
      desc: '',
      args: [],
    );
  }

  /// `تم فتح النزاع`
  String get notificationDisputeOpenedTitle {
    return Intl.message(
      'تم فتح النزاع',
      name: 'notificationDisputeOpenedTitle',
      desc: '',
      args: [],
    );
  }

  /// `تم فتح النزاع وهو بانتظار المراجعة.`
  String get notificationDisputeOpenedBody {
    return Intl.message(
      'تم فتح النزاع وهو بانتظار المراجعة.',
      name: 'notificationDisputeOpenedBody',
      desc: '',
      args: [],
    );
  }

  /// `تم حل النزاع`
  String get notificationDisputeResolvedTitle {
    return Intl.message(
      'تم حل النزاع',
      name: 'notificationDisputeResolvedTitle',
      desc: '',
      args: [],
    );
  }

  /// `تم حل النزاع. راجع آخر تحديث للحجز والدفع.`
  String get notificationDisputeResolvedBody {
    return Intl.message(
      'تم حل النزاع. راجع آخر تحديث للحجز والدفع.',
      name: 'notificationDisputeResolvedBody',
      desc: '',
      args: [],
    );
  }

  /// `تم صرف مستحق الناقل`
  String get notificationPayoutReleasedTitle {
    return Intl.message(
      'تم صرف مستحق الناقل',
      name: 'notificationPayoutReleasedTitle',
      desc: '',
      args: [],
    );
  }

  /// `تم صرف مستحق الناقل لهذا الحجز.`
  String get notificationPayoutReleasedBody {
    return Intl.message(
      'تم صرف مستحق الناقل لهذا الحجز.',
      name: 'notificationPayoutReleasedBody',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث مرحلة الحجز`
  String get notificationBookingMilestoneUpdatedTitle {
    return Intl.message(
      'تم تحديث مرحلة الحجز',
      name: 'notificationBookingMilestoneUpdatedTitle',
      desc: '',
      args: [],
    );
  }

  /// `الحالة الحالية: {milestoneLabel}`
  String notificationBookingMilestoneUpdatedBody(Object milestoneLabel) {
    return Intl.message(
      'الحالة الحالية: $milestoneLabel',
      name: 'notificationBookingMilestoneUpdatedBody',
      desc: '',
      args: [milestoneLabel],
    );
  }

  /// `تم استلام تقييم الناقل`
  String get notificationCarrierReviewSubmittedTitle {
    return Intl.message(
      'تم استلام تقييم الناقل',
      name: 'notificationCarrierReviewSubmittedTitle',
      desc: '',
      args: [],
    );
  }

  /// `تمت إضافة تقييم جديد إلى ملفك الشخصي.`
  String get notificationCarrierReviewSubmittedBody {
    return Intl.message(
      'تمت إضافة تقييم جديد إلى ملفك الشخصي.',
      name: 'notificationCarrierReviewSubmittedBody',
      desc: '',
      args: [],
    );
  }

  /// `فعّل الإشعارات لتصلك تحديثات الحجز ومراحل التسليم وتنبيهات الدفع.`
  String get notificationsPermissionDescription {
    return Intl.message(
      'فعّل الإشعارات لتصلك تحديثات الحجز ومراحل التسليم وتنبيهات الدفع.',
      name: 'notificationsPermissionDescription',
      desc: '',
      args: [],
    );
  }

  /// `تفعيل الإشعارات`
  String get notificationsPermissionTitle {
    return Intl.message(
      'تفعيل الإشعارات',
      name: 'notificationsPermissionTitle',
      desc: '',
      args: [],
    );
  }

  /// `تعذر العثور على الصفحة أو العنصر المطلوب.`
  String get notFoundMessage {
    return Intl.message(
      'تعذر العثور على الصفحة أو العنصر المطلوب.',
      name: 'notFoundMessage',
      desc: '',
      args: [],
    );
  }

  /// `غير موجود`
  String get notFoundTitle {
    return Intl.message('غير موجود', name: 'notFoundTitle', desc: '', args: []);
  }

  /// `لا يوجد اتصال حاليًا. بعض الإجراءات غير متاحة مؤقتًا.`
  String get offlineMessage {
    return Intl.message(
      'لا يوجد اتصال حاليًا. بعض الإجراءات غير متاحة مؤقتًا.',
      name: 'offlineMessage',
      desc: '',
      args: [],
    );
  }

  /// `راجع هذه الرحلة قبل الحجز.`
  String get oneOffTripDetailDescription {
    return Intl.message(
      'راجع هذه الرحلة قبل الحجز.',
      name: 'oneOffTripDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `الرحلة الفردية {tripId}`
  String oneOffTripDetailTitle(Object tripId) {
    return Intl.message(
      'الرحلة الفردية $tripId',
      name: 'oneOffTripDetailTitle',
      desc: '',
      args: [tripId],
    );
  }

  /// `تفاصيل الرحلة الفردية`
  String get oneOffTripDetailPageTitle {
    return Intl.message(
      'تفاصيل الرحلة الفردية',
      name: 'oneOffTripDetailPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `اتبع خطوات الدفع وارفع الإثبات وتابع حالة المراجعة.`
  String get paymentFlowDescription {
    return Intl.message(
      'اتبع خطوات الدفع وارفع الإثبات وتابع حالة المراجعة.',
      name: 'paymentFlowDescription',
      desc: '',
      args: [],
    );
  }

  /// `الدفع`
  String get paymentFlowTitle {
    return Intl.message('الدفع', name: 'paymentFlowTitle', desc: '', args: []);
  }

  /// `افتح تفاصيل الدفع`
  String get paymentFlowOpenAction {
    return Intl.message(
      'افتح تفاصيل الدفع',
      name: 'paymentFlowOpenAction',
      desc: '',
      args: [],
    );
  }

  /// `أضف الحسابات التي تستقبل عليها التحويلات وأدرها.`
  String get payoutAccountsDescription {
    return Intl.message(
      'أضف الحسابات التي تستقبل عليها التحويلات وأدرها.',
      name: 'payoutAccountsDescription',
      desc: '',
      args: [],
    );
  }

  /// `حسابات التحويل`
  String get payoutAccountsTitle {
    return Intl.message(
      'حسابات التحويل',
      name: 'payoutAccountsTitle',
      desc: '',
      args: [],
    );
  }

  /// `أضف رقم هاتف لمواصلة استخدام FleetFill.`
  String get phoneCompletionDescription {
    return Intl.message(
      'أضف رقم هاتف لمواصلة استخدام FleetFill.',
      name: 'phoneCompletionDescription',
      desc: '',
      args: [],
    );
  }

  /// `حفظ رقم الهاتف`
  String get phoneCompletionSaveAction {
    return Intl.message(
      'حفظ رقم الهاتف',
      name: 'phoneCompletionSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `تم حفظ رقم الهاتف.`
  String get phoneCompletionSavedMessage {
    return Intl.message(
      'تم حفظ رقم الهاتف.',
      name: 'phoneCompletionSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `إكمال رقم الهاتف`
  String get phoneCompletionTitle {
    return Intl.message(
      'إكمال رقم الهاتف',
      name: 'phoneCompletionTitle',
      desc: '',
      args: [],
    );
  }

  /// `رقم الهاتف مطلوب`
  String get carrierGatePhoneTitle {
    return Intl.message(
      'رقم الهاتف مطلوب',
      name: 'carrierGatePhoneTitle',
      desc: '',
      args: [],
    );
  }

  /// `أضف رقم هاتفك قبل فتح هذه المساحة الخاصة بالناقل حتى تصلك تحديثات الحجز والتشغيل.`
  String get carrierGatePhoneMessage {
    return Intl.message(
      'أضف رقم هاتفك قبل فتح هذه المساحة الخاصة بالناقل حتى تصلك تحديثات الحجز والتشغيل.',
      name: 'carrierGatePhoneMessage',
      desc: '',
      args: [],
    );
  }

  /// `التحقق مطلوب`
  String get carrierGateVerificationTitle {
    return Intl.message(
      'التحقق مطلوب',
      name: 'carrierGateVerificationTitle',
      desc: '',
      args: [],
    );
  }

  /// `أكمل تحقق الناقل قبل فتح هذه المساحة لنشر المسارات أو إدارة الحجوزات.`
  String get carrierGateVerificationMessage {
    return Intl.message(
      'أكمل تحقق الناقل قبل فتح هذه المساحة لنشر المسارات أو إدارة الحجوزات.',
      name: 'carrierGateVerificationMessage',
      desc: '',
      args: [],
    );
  }

  /// `حساب الدفع مطلوب`
  String get carrierGatePayoutTitle {
    return Intl.message(
      'حساب الدفع مطلوب',
      name: 'carrierGatePayoutTitle',
      desc: '',
      args: [],
    );
  }

  /// `أضف حساب دفع قبل فتح حجوزات الناقل حتى تتم تسوية الأعمال المكتملة بشكل صحيح.`
  String get carrierGatePayoutMessage {
    return Intl.message(
      'أضف حساب دفع قبل فتح حجوزات الناقل حتى تتم تسوية الأعمال المكتملة بشكل صحيح.',
      name: 'carrierGatePayoutMessage',
      desc: '',
      args: [],
    );
  }

  /// `وثائق السائق`
  String get profileVerificationDocumentsTitle {
    return Intl.message(
      'وثائق السائق',
      name: 'profileVerificationDocumentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `أضف بياناتك حتى يتمكن العملاء والناقلون والدعم من التواصل معك.`
  String get profileSetupDescription {
    return Intl.message(
      'أضف بياناتك حتى يتمكن العملاء والناقلون والدعم من التواصل معك.',
      name: 'profileSetupDescription',
      desc: '',
      args: [],
    );
  }

  /// `أكمل بيانات الناقل أولًا، ثم ارفع وثائق التحقق من ملفك الشخصي.`
  String get profileCarrierVerificationHint {
    return Intl.message(
      'أكمل بيانات الناقل أولًا، ثم ارفع وثائق التحقق من ملفك الشخصي.',
      name: 'profileCarrierVerificationHint',
      desc: '',
      args: [],
    );
  }

  /// `اسم الشركة`
  String get profileCompanyNameLabel {
    return Intl.message(
      'اسم الشركة',
      name: 'profileCompanyNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `الاسم الكامل`
  String get profileFullNameLabel {
    return Intl.message(
      'الاسم الكامل',
      name: 'profileFullNameLabel',
      desc: '',
      args: [],
    );
  }

  /// `أدخل اسم شركة صالحا.`
  String get profileInvalidCompanyNameMessage {
    return Intl.message(
      'أدخل اسم شركة صالحا.',
      name: 'profileInvalidCompanyNameMessage',
      desc: '',
      args: [],
    );
  }

  /// `أدخل اسما كاملا صالحا بأحرف عربية أو لاتينية.`
  String get profileInvalidNameMessage {
    return Intl.message(
      'أدخل اسما كاملا صالحا بأحرف عربية أو لاتينية.',
      name: 'profileInvalidNameMessage',
      desc: '',
      args: [],
    );
  }

  /// `أدخل رقم هاتف جزائري صالحا.`
  String get profileInvalidAlgerianPhoneMessage {
    return Intl.message(
      'أدخل رقم هاتف جزائري صالحا.',
      name: 'profileInvalidAlgerianPhoneMessage',
      desc: '',
      args: [],
    );
  }

  /// `رقم الهاتف`
  String get profilePhoneLabel {
    return Intl.message(
      'رقم الهاتف',
      name: 'profilePhoneLabel',
      desc: '',
      args: [],
    );
  }

  /// `حفظ الملف الشخصي`
  String get profileSetupSaveAction {
    return Intl.message(
      'حفظ الملف الشخصي',
      name: 'profileSetupSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `تم حفظ بيانات الملف الشخصي.`
  String get profileSetupSavedMessage {
    return Intl.message(
      'تم حفظ بيانات الملف الشخصي.',
      name: 'profileSetupSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `إعداد الملف الشخصي`
  String get profileSetupTitle {
    return Intl.message(
      'إعداد الملف الشخصي',
      name: 'profileSetupTitle',
      desc: '',
      args: [],
    );
  }

  /// `اعرض إثبات الدفع لهذا الحجز هنا أو افتحه في تطبيق آخر.`
  String get proofViewerDescription {
    return Intl.message(
      'اعرض إثبات الدفع لهذا الحجز هنا أو افتحه في تطبيق آخر.',
      name: 'proofViewerDescription',
      desc: '',
      args: [],
    );
  }

  /// `الإثبات {proofId}`
  String proofViewerTitle(Object proofId) {
    return Intl.message(
      'الإثبات $proofId',
      name: 'proofViewerTitle',
      desc: '',
      args: [proofId],
    );
  }

  /// `إثبات الدفع`
  String get proofViewerPageTitle {
    return Intl.message(
      'إثبات الدفع',
      name: 'proofViewerPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `إعادة المحاولة`
  String get retryLabel {
    return Intl.message(
      'إعادة المحاولة',
      name: 'retryLabel',
      desc: '',
      args: [],
    );
  }

  /// `اختر كيف تريد استخدام FleetFill حتى نجهز الأدوات المناسبة لحسابك.`
  String get roleSelectionDescription {
    return Intl.message(
      'اختر كيف تريد استخدام FleetFill حتى نجهز الأدوات المناسبة لحسابك.',
      name: 'roleSelectionDescription',
      desc: '',
      args: [],
    );
  }

  /// `انشر رحلاتك، أدر الحجوزات، وأكمل التحقق.`
  String get roleSelectionCarrierDescription {
    return Intl.message(
      'انشر رحلاتك، أدر الحجوزات، وأكمل التحقق.',
      name: 'roleSelectionCarrierDescription',
      desc: '',
      args: [],
    );
  }

  /// `أنا ناقل`
  String get roleSelectionCarrierTitle {
    return Intl.message(
      'أنا ناقل',
      name: 'roleSelectionCarrierTitle',
      desc: '',
      args: [],
    );
  }

  /// `سجّل شحناتك، قارن بين العروض، وتابع التسليم.`
  String get roleSelectionShipperDescription {
    return Intl.message(
      'سجّل شحناتك، قارن بين العروض، وتابع التسليم.',
      name: 'roleSelectionShipperDescription',
      desc: '',
      args: [],
    );
  }

  /// `أنا مرسل`
  String get roleSelectionShipperTitle {
    return Intl.message(
      'أنا مرسل',
      name: 'roleSelectionShipperTitle',
      desc: '',
      args: [],
    );
  }

  /// `كيف تريد استخدام FleetFill؟`
  String get roleSelectionTitle {
    return Intl.message(
      'كيف تريد استخدام FleetFill؟',
      name: 'roleSelectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `راجع هذا المسار قبل الحجز.`
  String get routeDetailDescription {
    return Intl.message(
      'راجع هذا المسار قبل الحجز.',
      name: 'routeDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `المسار {routeId}`
  String routeDetailTitle(Object routeId) {
    return Intl.message(
      'المسار $routeId',
      name: 'routeDetailTitle',
      desc: '',
      args: [routeId],
    );
  }

  /// `تفاصيل المسار`
  String get routeDetailPageTitle {
    return Intl.message(
      'تفاصيل المسار',
      name: 'routeDetailPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `تعذر على FleetFill فتح هذا المسار.`
  String get routeErrorMessage {
    return Intl.message(
      'تعذر على FleetFill فتح هذا المسار.',
      name: 'routeErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `اختر شحنة وتاريخا للعثور على الرحلات المناسبة.`
  String get searchTripsDescription {
    return Intl.message(
      'اختر شحنة وتاريخا للعثور على الرحلات المناسبة.',
      name: 'searchTripsDescription',
      desc: '',
      args: [],
    );
  }

  /// `البحث`
  String get searchTripsNavLabel {
    return Intl.message(
      'البحث',
      name: 'searchTripsNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `البحث عن رحلة`
  String get searchTripsTitle {
    return Intl.message(
      'البحث عن رحلة',
      name: 'searchTripsTitle',
      desc: '',
      args: [],
    );
  }

  /// `السعر الأساسي`
  String get sampleBasePriceLabel {
    return Intl.message(
      'السعر الأساسي',
      name: 'sampleBasePriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `رسوم المنصة`
  String get samplePlatformFeeLabel {
    return Intl.message(
      'رسوم المنصة',
      name: 'samplePlatformFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `الإجمالي`
  String get sampleTotalLabel {
    return Intl.message(
      'الإجمالي',
      name: 'sampleTotalLabel',
      desc: '',
      args: [],
    );
  }

  /// `الحساب`
  String get settingsAccountSectionTitle {
    return Intl.message(
      'الحساب',
      name: 'settingsAccountSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `أدر اللغة والمظهر والإشعارات وخيارات الدعم.`
  String get settingsDescription {
    return Intl.message(
      'أدر اللغة والمظهر والإشعارات وخيارات الدعم.',
      name: 'settingsDescription',
      desc: '',
      args: [],
    );
  }

  /// `السمة`
  String get settingsThemeModeTitle {
    return Intl.message(
      'السمة',
      name: 'settingsThemeModeTitle',
      desc: '',
      args: [],
    );
  }

  /// `النظام`
  String get settingsThemeModeSystemLabel {
    return Intl.message(
      'النظام',
      name: 'settingsThemeModeSystemLabel',
      desc: '',
      args: [],
    );
  }

  /// `فاتحة`
  String get settingsThemeModeLightLabel {
    return Intl.message(
      'فاتحة',
      name: 'settingsThemeModeLightLabel',
      desc: '',
      args: [],
    );
  }

  /// `داكنة`
  String get settingsThemeModeDarkLabel {
    return Intl.message(
      'داكنة',
      name: 'settingsThemeModeDarkLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم تسجيل خروجك.`
  String get settingsSignedOutMessage {
    return Intl.message(
      'تم تسجيل خروجك.',
      name: 'settingsSignedOutMessage',
      desc: '',
      args: [],
    );
  }

  /// `تسجيل الخروج`
  String get settingsSignOutAction {
    return Intl.message(
      'تسجيل الخروج',
      name: 'settingsSignOutAction',
      desc: '',
      args: [],
    );
  }

  /// `الإعدادات`
  String get settingsTitle {
    return Intl.message('الإعدادات', name: 'settingsTitle', desc: '', args: []);
  }

  /// `هذه الميزة ستتوفر قريبا.`
  String get sharedScaffoldPreviewMessage {
    return Intl.message(
      'هذه الميزة ستتوفر قريبا.',
      name: 'sharedScaffoldPreviewMessage',
      desc: '',
      args: [],
    );
  }

  /// `قريبا`
  String get sharedScaffoldPreviewTitle {
    return Intl.message(
      'قريبا',
      name: 'sharedScaffoldPreviewTitle',
      desc: '',
      args: [],
    );
  }

  /// `12,500 دج`
  String get sampleBasePriceAmount {
    return Intl.message(
      '12,500 دج',
      name: 'sampleBasePriceAmount',
      desc: '',
      args: [],
    );
  }

  /// `1,200 دج`
  String get samplePlatformFeeAmount {
    return Intl.message(
      '1,200 دج',
      name: 'samplePlatformFeeAmount',
      desc: '',
      args: [],
    );
  }

  /// `13,700 دج`
  String get sampleTotalAmount {
    return Intl.message(
      '13,700 دج',
      name: 'sampleTotalAmount',
      desc: '',
      args: [],
    );
  }

  /// `راجع المسار والوزن والحجم وتفاصيل الشحنة.`
  String get shipmentDetailDescription {
    return Intl.message(
      'راجع المسار والوزن والحجم وتفاصيل الشحنة.',
      name: 'shipmentDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `الشحنة {shipmentId}`
  String shipmentDetailTitle(Object shipmentId) {
    return Intl.message(
      'الشحنة $shipmentId',
      name: 'shipmentDetailTitle',
      desc: '',
      args: [shipmentId],
    );
  }

  /// `تفاصيل الشحنة`
  String get shipmentDetailPageTitle {
    return Intl.message(
      'تفاصيل الشحنة',
      name: 'shipmentDetailPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `تابع حجوزاتك وآخر التحديثات وانتقل بسرعة لأهم الإجراءات.`
  String get shipperHomeDescription {
    return Intl.message(
      'تابع حجوزاتك وآخر التحديثات وانتقل بسرعة لأهم الإجراءات.',
      name: 'shipperHomeDescription',
      desc: '',
      args: [],
    );
  }

  /// `الحجوزات النشطة`
  String get shipperHomeActiveBookingsLabel {
    return Intl.message(
      'الحجوزات النشطة',
      name: 'shipperHomeActiveBookingsLabel',
      desc: '',
      args: [],
    );
  }

  /// `الإشعارات غير المقروءة`
  String get shipperHomeUnreadNotificationsLabel {
    return Intl.message(
      'الإشعارات غير المقروءة',
      name: 'shipperHomeUnreadNotificationsLabel',
      desc: '',
      args: [],
    );
  }

  /// `ستظهر آخر التحديثات هنا.`
  String get shipperHomeNoRecentNotificationMessage {
    return Intl.message(
      'ستظهر آخر التحديثات هنا.',
      name: 'shipperHomeNoRecentNotificationMessage',
      desc: '',
      args: [],
    );
  }

  /// `إجراءات سريعة`
  String get shipperHomeQuickActionsTitle {
    return Intl.message(
      'إجراءات سريعة',
      name: 'shipperHomeQuickActionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `الرئيسية`
  String get shipperHomeNavLabel {
    return Intl.message(
      'الرئيسية',
      name: 'shipperHomeNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `الرئيسية للمرسل`
  String get shipperHomeTitle {
    return Intl.message(
      'الرئيسية للمرسل',
      name: 'shipperHomeTitle',
      desc: '',
      args: [],
    );
  }

  /// `أدر بيانات التواصل والإعدادات وخيارات الدعم.`
  String get shipperProfileDescription {
    return Intl.message(
      'أدر بيانات التواصل والإعدادات وخيارات الدعم.',
      name: 'shipperProfileDescription',
      desc: '',
      args: [],
    );
  }

  /// `الملف`
  String get shipperProfileNavLabel {
    return Intl.message(
      'الملف',
      name: 'shipperProfileNavLabel',
      desc: '',
      args: [],
    );
  }

  /// `بيانات المرسل`
  String get shipperProfileSectionTitle {
    return Intl.message(
      'بيانات المرسل',
      name: 'shipperProfileSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `ملف المرسل`
  String get shipperProfileTitle {
    return Intl.message(
      'ملف المرسل',
      name: 'shipperProfileTitle',
      desc: '',
      args: [],
    );
  }

  /// `لحظة، نجهّز FleetFill لك.`
  String get splashDescription {
    return Intl.message(
      'لحظة، نجهّز FleetFill لك.',
      name: 'splashDescription',
      desc: '',
      args: [],
    );
  }

  /// `جاري التجهيز`
  String get splashTitle {
    return Intl.message(
      'جاري التجهيز',
      name: 'splashTitle',
      desc: '',
      args: [],
    );
  }

  /// `FleetFill غير متاح`
  String get startupConfigurationRequiredTitle {
    return Intl.message(
      'FleetFill غير متاح',
      name: 'startupConfigurationRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `FleetFill غير متاح حاليا. يرجى المحاولة لاحقا.`
  String get startupConfigurationRequiredMessage {
    return Intl.message(
      'FleetFill غير متاح حاليا. يرجى المحاولة لاحقا.',
      name: 'startupConfigurationRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `جديد`
  String get notificationNewLabel {
    return Intl.message(
      'جديد',
      name: 'notificationNewLabel',
      desc: '',
      args: [],
    );
  }

  /// `تمت رؤيته`
  String get notificationSeenLabel {
    return Intl.message(
      'تمت رؤيته',
      name: 'notificationSeenLabel',
      desc: '',
      args: [],
    );
  }

  /// `يتطلب الإعداد`
  String get statusSetupRequiredLabel {
    return Intl.message(
      'يتطلب الإعداد',
      name: 'statusSetupRequiredLabel',
      desc: '',
      args: [],
    );
  }

  /// `يحتاج مراجعة`
  String get statusNeedsReviewLabel {
    return Intl.message(
      'يحتاج مراجعة',
      name: 'statusNeedsReviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `جاهز`
  String get statusReadyLabel {
    return Intl.message('جاهز', name: 'statusReadyLabel', desc: '', args: []);
  }

  /// `اطرح سؤالا أو أبلغ عن مشكلة أو اطلب المساعدة بشأن حجز أو دفعة.`
  String get supportDescription {
    return Intl.message(
      'اطرح سؤالا أو أبلغ عن مشكلة أو اطلب المساعدة بشأن حجز أو دفعة.',
      name: 'supportDescription',
      desc: '',
      args: [],
    );
  }

  /// `الدعم`
  String get supportTitle {
    return Intl.message('الدعم', name: 'supportTitle', desc: '', args: []);
  }

  /// `حسابك موقوف. تواصل مع دعم FleetFill للمساعدة.`
  String get suspendedMessage {
    return Intl.message(
      'حسابك موقوف. تواصل مع دعم FleetFill للمساعدة.',
      name: 'suspendedMessage',
      desc: '',
      args: [],
    );
  }

  /// `الحساب موقوف`
  String get suspendedTitle {
    return Intl.message(
      'الحساب موقوف',
      name: 'suspendedTitle',
      desc: '',
      args: [],
    );
  }

  /// `تابع تقدم التسليم وأكد الاستلام وافتح نزاعا أو اترك تقييما.`
  String get trackingDetailDescription {
    return Intl.message(
      'تابع تقدم التسليم وأكد الاستلام وافتح نزاعا أو اترك تقييما.',
      name: 'trackingDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `التتبع {bookingId}`
  String trackingDetailTitle(Object bookingId) {
    return Intl.message(
      'التتبع $bookingId',
      name: 'trackingDetailTitle',
      desc: '',
      args: [bookingId],
    );
  }

  /// `التتبع`
  String get trackingDetailPageTitle {
    return Intl.message(
      'التتبع',
      name: 'trackingDetailPageTitle',
      desc: '',
      args: [],
    );
  }

  /// `حدّث FleetFill لمتابعة الاستخدام بأحدث إصدار مدعوم.`
  String get updateRequiredDescription {
    return Intl.message(
      'حدّث FleetFill لمتابعة الاستخدام بأحدث إصدار مدعوم.',
      name: 'updateRequiredDescription',
      desc: '',
      args: [],
    );
  }

  /// `تحديث مطلوب`
  String get updateRequiredTitle {
    return Intl.message(
      'تحديث مطلوب',
      name: 'updateRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `راجع بيانات الحساب والحجوزات والمركبات والوثائق.`
  String get userDetailDescription {
    return Intl.message(
      'راجع بيانات الحساب والحجوزات والمركبات والوثائق.',
      name: 'userDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل المستخدم`
  String get userDetailTitle {
    return Intl.message(
      'تفاصيل المستخدم',
      name: 'userDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `حجم السعة (م3)`
  String get vehicleCapacityVolumeLabel {
    return Intl.message(
      'حجم السعة (م3)',
      name: 'vehicleCapacityVolumeLabel',
      desc: '',
      args: [],
    );
  }

  /// `سعة الوزن (كغ)`
  String get vehicleCapacityWeightLabel {
    return Intl.message(
      'سعة الوزن (كغ)',
      name: 'vehicleCapacityWeightLabel',
      desc: '',
      args: [],
    );
  }

  /// `إضافة مركبة`
  String get vehicleCreateAction {
    return Intl.message(
      'إضافة مركبة',
      name: 'vehicleCreateAction',
      desc: '',
      args: [],
    );
  }

  /// `إضافة مركبة`
  String get vehicleCreateTitle {
    return Intl.message(
      'إضافة مركبة',
      name: 'vehicleCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `تمت إضافة المركبة.`
  String get vehicleCreatedMessage {
    return Intl.message(
      'تمت إضافة المركبة.',
      name: 'vehicleCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `حذف المركبة`
  String get vehicleDeleteAction {
    return Intl.message(
      'حذف المركبة',
      name: 'vehicleDeleteAction',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد حذف هذه المركبة من FleetFill؟`
  String get vehicleDeleteConfirmationMessage {
    return Intl.message(
      'هل تريد حذف هذه المركبة من FleetFill؟',
      name: 'vehicleDeleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم حذف المركبة.`
  String get vehicleDeletedMessage {
    return Intl.message(
      'تم حذف المركبة.',
      name: 'vehicleDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تظهر هنا تفاصيل المركبة ووثائقها وحالة التحقق.`
  String get vehicleDetailDescription {
    return Intl.message(
      'تظهر هنا تفاصيل المركبة ووثائقها وحالة التحقق.',
      name: 'vehicleDetailDescription',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل المركبة`
  String get vehicleDetailTitle {
    return Intl.message(
      'تفاصيل المركبة',
      name: 'vehicleDetailTitle',
      desc: '',
      args: [],
    );
  }

  /// `تعديل المركبة`
  String get vehicleEditTitle {
    return Intl.message(
      'تعديل المركبة',
      name: 'vehicleEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `أبق بيانات المركبة محدثة قبل نشر الرحلات.`
  String get vehicleEditorDescription {
    return Intl.message(
      'أبق بيانات المركبة محدثة قبل نشر الرحلات.',
      name: 'vehicleEditorDescription',
      desc: '',
      args: [],
    );
  }

  /// `رقم اللوحة`
  String get vehiclePlateLabel {
    return Intl.message(
      'رقم اللوحة',
      name: 'vehiclePlateLabel',
      desc: '',
      args: [],
    );
  }

  /// `أدخل رقما أكبر من الصفر.`
  String get vehiclePositiveNumberMessage {
    return Intl.message(
      'أدخل رقما أكبر من الصفر.',
      name: 'vehiclePositiveNumberMessage',
      desc: '',
      args: [],
    );
  }

  /// `تحقق المركبة يحتاج تصحيح: {reason}`
  String vehicleVerificationRejectedBanner(Object reason) {
    return Intl.message(
      'تحقق المركبة يحتاج تصحيح: $reason',
      name: 'vehicleVerificationRejectedBanner',
      desc: '',
      args: [reason],
    );
  }

  /// `حفظ المركبة`
  String get vehicleSaveAction {
    return Intl.message(
      'حفظ المركبة',
      name: 'vehicleSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث المركبة.`
  String get vehicleSavedMessage {
    return Intl.message(
      'تم تحديث المركبة.',
      name: 'vehicleSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `ملخص المركبة`
  String get vehicleSummaryTitle {
    return Intl.message(
      'ملخص المركبة',
      name: 'vehicleSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `نوع المركبة`
  String get vehicleTypeLabel {
    return Intl.message(
      'نوع المركبة',
      name: 'vehicleTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `أضف المركبات التي تستخدمها للنقل وأدرها.`
  String get vehiclesDescription {
    return Intl.message(
      'أضف المركبات التي تستخدمها للنقل وأدرها.',
      name: 'vehiclesDescription',
      desc: '',
      args: [],
    );
  }

  /// `أضف مركبة قبل نشر السعة أو إكمال التحقق الكامل.`
  String get vehiclesEmptyMessage {
    return Intl.message(
      'أضف مركبة قبل نشر السعة أو إكمال التحقق الكامل.',
      name: 'vehiclesEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `المركبات`
  String get vehiclesTitle {
    return Intl.message('المركبات', name: 'vehiclesTitle', desc: '', args: []);
  }

  /// `وثائق المركبة`
  String get vehicleVerificationDocumentsTitle {
    return Intl.message(
      'وثائق المركبة',
      name: 'vehicleVerificationDocumentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `رخصة السياقة`
  String get verificationDocumentDriverIdentityLabel {
    return Intl.message(
      'رخصة السياقة',
      name: 'verificationDocumentDriverIdentityLabel',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم رفع أي ملف بعد.`
  String get verificationDocumentMissingMessage {
    return Intl.message(
      'لم يتم رفع أي ملف بعد.',
      name: 'verificationDocumentMissingMessage',
      desc: '',
      args: [],
    );
  }

  /// `راجع سبب الرفض ثم ارفع بديلا.`
  String get verificationDocumentNeedsAttentionMessage {
    return Intl.message(
      'راجع سبب الرفض ثم ارفع بديلا.',
      name: 'verificationDocumentNeedsAttentionMessage',
      desc: '',
      args: [],
    );
  }

  /// `وثيقتك جاهزة للفتح.`
  String get verificationDocumentOpenPreparedMessage {
    return Intl.message(
      'وثيقتك جاهزة للفتح.',
      name: 'verificationDocumentOpenPreparedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم الرفع وينتظر مراجعة الإدارة.`
  String get verificationDocumentPendingMessage {
    return Intl.message(
      'تم الرفع وينتظر مراجعة الإدارة.',
      name: 'verificationDocumentPendingMessage',
      desc: '',
      args: [],
    );
  }

  /// `مرفوض: {reason}`
  String verificationDocumentRejectedMessage(Object reason) {
    return Intl.message(
      'مرفوض: $reason',
      name: 'verificationDocumentRejectedMessage',
      desc: '',
      args: [reason],
    );
  }

  /// `يرجى مراجعة متطلبات الوثيقة ورفع ملف أوضح.`
  String get verificationDocumentRejectedFallbackReason {
    return Intl.message(
      'يرجى مراجعة متطلبات الوثيقة ورفع ملف أوضح.',
      name: 'verificationDocumentRejectedFallbackReason',
      desc: '',
      args: [],
    );
  }

  /// `تم استبدال وثيقة التحقق.`
  String get verificationDocumentReplacedMessage {
    return Intl.message(
      'تم استبدال وثيقة التحقق.',
      name: 'verificationDocumentReplacedMessage',
      desc: '',
      args: [],
    );
  }

  /// `رخصة النقل (قديمة)`
  String get verificationDocumentTransportLicenseLabel {
    return Intl.message(
      'رخصة النقل (قديمة)',
      name: 'verificationDocumentTransportLicenseLabel',
      desc: '',
      args: [],
    );
  }

  /// `الفحص التقني للشاحنة`
  String get verificationDocumentTruckInspectionLabel {
    return Intl.message(
      'الفحص التقني للشاحنة',
      name: 'verificationDocumentTruckInspectionLabel',
      desc: '',
      args: [],
    );
  }

  /// `تأمين الشاحنة`
  String get verificationDocumentTruckInsuranceLabel {
    return Intl.message(
      'تأمين الشاحنة',
      name: 'verificationDocumentTruckInsuranceLabel',
      desc: '',
      args: [],
    );
  }

  /// `البطاقة الرمادية`
  String get verificationDocumentTruckRegistrationLabel {
    return Intl.message(
      'البطاقة الرمادية',
      name: 'verificationDocumentTruckRegistrationLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم رفع وثيقة التحقق.`
  String get verificationDocumentUploadedMessage {
    return Intl.message(
      'تم رفع وثيقة التحقق.',
      name: 'verificationDocumentUploadedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم التحقق منها واعتمادها.`
  String get verificationDocumentVerifiedMessage {
    return Intl.message(
      'تم التحقق منها واعتمادها.',
      name: 'verificationDocumentVerifiedMessage',
      desc: '',
      args: [],
    );
  }

  /// `استبدال`
  String get verificationReplaceAction {
    return Intl.message(
      'استبدال',
      name: 'verificationReplaceAction',
      desc: '',
      args: [],
    );
  }

  /// `رفع`
  String get verificationUploadAction {
    return Intl.message(
      'رفع',
      name: 'verificationUploadAction',
      desc: '',
      args: [],
    );
  }

  /// `أكمل خطوات التحقق المطلوبة قبل المتابعة.`
  String get verificationRequiredMessage {
    return Intl.message(
      'أكمل خطوات التحقق المطلوبة قبل المتابعة.',
      name: 'verificationRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `التحقق مطلوب`
  String get verificationRequiredTitle {
    return Intl.message(
      'التحقق مطلوب',
      name: 'verificationRequiredTitle',
      desc: '',
      args: [],
    );
  }

  /// `إضافة سعة`
  String get myRoutesAddAction {
    return Intl.message(
      'إضافة سعة',
      name: 'myRoutesAddAction',
      desc: '',
      args: [],
    );
  }

  /// `المسارات المتكررة النشطة`
  String get myRoutesActiveRoutesLabel {
    return Intl.message(
      'المسارات المتكررة النشطة',
      name: 'myRoutesActiveRoutesLabel',
      desc: '',
      args: [],
    );
  }

  /// `الرحلات الفردية النشطة`
  String get myRoutesActiveTripsLabel {
    return Intl.message(
      'الرحلات الفردية النشطة',
      name: 'myRoutesActiveTripsLabel',
      desc: '',
      args: [],
    );
  }

  /// `إضافة مسار متكرر`
  String get myRoutesCreateRouteAction {
    return Intl.message(
      'إضافة مسار متكرر',
      name: 'myRoutesCreateRouteAction',
      desc: '',
      args: [],
    );
  }

  /// `إضافة رحلة فردية`
  String get myRoutesCreateTripAction {
    return Intl.message(
      'إضافة رحلة فردية',
      name: 'myRoutesCreateTripAction',
      desc: '',
      args: [],
    );
  }

  /// `انشر مسارا متكررا أو رحلة فردية لبدء عرض السعة.`
  String get myRoutesEmptyMessage {
    return Intl.message(
      'انشر مسارا متكررا أو رحلة فردية لبدء عرض السعة.',
      name: 'myRoutesEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `الرحلات الفردية`
  String get myRoutesOneOffTab {
    return Intl.message(
      'الرحلات الفردية',
      name: 'myRoutesOneOffTab',
      desc: '',
      args: [],
    );
  }

  /// `السعة المنشورة`
  String get myRoutesPublishedCapacityLabel {
    return Intl.message(
      'السعة المنشورة',
      name: 'myRoutesPublishedCapacityLabel',
      desc: '',
      args: [],
    );
  }

  /// `المسارات المتكررة`
  String get myRoutesRecurringTab {
    return Intl.message(
      'المسارات المتكررة',
      name: 'myRoutesRecurringTab',
      desc: '',
      args: [],
    );
  }

  /// `السعة المحجوزة`
  String get myRoutesReservedCapacityLabel {
    return Intl.message(
      'السعة المحجوزة',
      name: 'myRoutesReservedCapacityLabel',
      desc: '',
      args: [],
    );
  }

  /// `المسارات المتكررة`
  String get myRoutesRouteListTitle {
    return Intl.message(
      'المسارات المتكررة',
      name: 'myRoutesRouteListTitle',
      desc: '',
      args: [],
    );
  }

  /// `ملخص نشر السعة`
  String get myRoutesSummaryTitle {
    return Intl.message(
      'ملخص نشر السعة',
      name: 'myRoutesSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `الرحلات الفردية`
  String get myRoutesTripListTitle {
    return Intl.message(
      'الرحلات الفردية',
      name: 'myRoutesTripListTitle',
      desc: '',
      args: [],
    );
  }

  /// `الانطلاقات القادمة`
  String get myRoutesUpcomingDeparturesLabel {
    return Intl.message(
      'الانطلاقات القادمة',
      name: 'myRoutesUpcomingDeparturesLabel',
      desc: '',
      args: [],
    );
  }

  /// `معدل الاستخدام`
  String get myRoutesUtilizationLabel {
    return Intl.message(
      'معدل الاستخدام',
      name: 'myRoutesUtilizationLabel',
      desc: '',
      args: [],
    );
  }

  /// `تفعيل الرحلة`
  String get oneOffTripActivateAction {
    return Intl.message(
      'تفعيل الرحلة',
      name: 'oneOffTripActivateAction',
      desc: '',
      args: [],
    );
  }

  /// `تم تفعيل الرحلة الفردية.`
  String get oneOffTripActivatedMessage {
    return Intl.message(
      'تم تفعيل الرحلة الفردية.',
      name: 'oneOffTripActivatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `إضافة رحلة فردية`
  String get oneOffTripCreateTitle {
    return Intl.message(
      'إضافة رحلة فردية',
      name: 'oneOffTripCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `تمت إضافة الرحلة الفردية.`
  String get oneOffTripCreatedMessage {
    return Intl.message(
      'تمت إضافة الرحلة الفردية.',
      name: 'oneOffTripCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `إلغاء تفعيل الرحلة`
  String get oneOffTripDeactivateAction {
    return Intl.message(
      'إلغاء تفعيل الرحلة',
      name: 'oneOffTripDeactivateAction',
      desc: '',
      args: [],
    );
  }

  /// `تم إلغاء تفعيل الرحلة الفردية.`
  String get oneOffTripDeactivatedMessage {
    return Intl.message(
      'تم إلغاء تفعيل الرحلة الفردية.',
      name: 'oneOffTripDeactivatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `حذف الرحلة`
  String get oneOffTripDeleteAction {
    return Intl.message(
      'حذف الرحلة',
      name: 'oneOffTripDeleteAction',
      desc: '',
      args: [],
    );
  }

  /// `تم حذف الرحلة الفردية.`
  String get oneOffTripDeletedMessage {
    return Intl.message(
      'تم حذف الرحلة الفردية.',
      name: 'oneOffTripDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `الانطلاق`
  String get oneOffTripDepartureLabel {
    return Intl.message(
      'الانطلاق',
      name: 'oneOffTripDepartureLabel',
      desc: '',
      args: [],
    );
  }

  /// `انشر رحلة بتاريخ محدد مع المركبة والمسار والانطلاق وتفاصيل السعة.`
  String get oneOffTripEditorDescription {
    return Intl.message(
      'انشر رحلة بتاريخ محدد مع المركبة والمسار والانطلاق وتفاصيل السعة.',
      name: 'oneOffTripEditorDescription',
      desc: '',
      args: [],
    );
  }

  /// `تعديل الرحلة الفردية`
  String get oneOffTripEditTitle {
    return Intl.message(
      'تعديل الرحلة الفردية',
      name: 'oneOffTripEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `حفظ الرحلة`
  String get oneOffTripSaveAction {
    return Intl.message(
      'حفظ الرحلة',
      name: 'oneOffTripSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث الرحلة الفردية.`
  String get oneOffTripSavedMessage {
    return Intl.message(
      'تم تحديث الرحلة الفردية.',
      name: 'oneOffTripSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `نشط`
  String get publicationActiveLabel {
    return Intl.message(
      'نشط',
      name: 'publicationActiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `غير نشط`
  String get publicationInactiveLabel {
    return Intl.message(
      'غير نشط',
      name: 'publicationInactiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد مراجعات للمسار حتى الآن.`
  String get publicationNoRevisionsMessage {
    return Intl.message(
      'لا توجد مراجعات للمسار حتى الآن.',
      name: 'publicationNoRevisionsMessage',
      desc: '',
      args: [],
    );
  }

  /// `سجل المراجعات`
  String get publicationRevisionHistoryTitle {
    return Intl.message(
      'سجل المراجعات',
      name: 'publicationRevisionHistoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `يجب أن تكون بلديتا الانطلاق والوصول مختلفتين.`
  String get publicationSameLaneErrorMessage {
    return Intl.message(
      'يجب أن تكون بلديتا الانطلاق والوصول مختلفتين.',
      name: 'publicationSameLaneErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `ابحث عن بلدية`
  String get publicationSearchCommunesHint {
    return Intl.message(
      'ابحث عن بلدية',
      name: 'publicationSearchCommunesHint',
      desc: '',
      args: [],
    );
  }

  /// `اختر`
  String get publicationSelectValueAction {
    return Intl.message(
      'اختر',
      name: 'publicationSelectValueAction',
      desc: '',
      args: [],
    );
  }

  /// `اختر يوما واحدا على الأقل للانطلاق.`
  String get publicationWeekdaysRequiredMessage {
    return Intl.message(
      'اختر يوما واحدا على الأقل للانطلاق.',
      name: 'publicationWeekdaysRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `تفعيل المسار`
  String get routeActivateAction {
    return Intl.message(
      'تفعيل المسار',
      name: 'routeActivateAction',
      desc: '',
      args: [],
    );
  }

  /// `تم تفعيل المسار.`
  String get routeActivatedMessage {
    return Intl.message(
      'تم تفعيل المسار.',
      name: 'routeActivatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `إضافة مسار متكرر`
  String get routeCreateTitle {
    return Intl.message(
      'إضافة مسار متكرر',
      name: 'routeCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `تمت إضافة المسار المتكرر.`
  String get routeCreatedMessage {
    return Intl.message(
      'تمت إضافة المسار المتكرر.',
      name: 'routeCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `إلغاء تفعيل المسار`
  String get routeDeactivateAction {
    return Intl.message(
      'إلغاء تفعيل المسار',
      name: 'routeDeactivateAction',
      desc: '',
      args: [],
    );
  }

  /// `تم إلغاء تفعيل المسار.`
  String get routeDeactivatedMessage {
    return Intl.message(
      'تم إلغاء تفعيل المسار.',
      name: 'routeDeactivatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `حذف المسار`
  String get routeDeleteAction {
    return Intl.message(
      'حذف المسار',
      name: 'routeDeleteAction',
      desc: '',
      args: [],
    );
  }

  /// `تم حذف المسار المتكرر.`
  String get routeDeletedMessage {
    return Intl.message(
      'تم حذف المسار المتكرر.',
      name: 'routeDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `وقت الانطلاق الافتراضي`
  String get routeDepartureTimeLabel {
    return Intl.message(
      'وقت الانطلاق الافتراضي',
      name: 'routeDepartureTimeLabel',
      desc: '',
      args: [],
    );
  }

  /// `بلدية الوصول`
  String get routeDestinationLabel {
    return Intl.message(
      'بلدية الوصول',
      name: 'routeDestinationLabel',
      desc: '',
      args: [],
    );
  }

  /// `انشر مسارا متكررا مع المركبة والجدول وتفاصيل السعة.`
  String get routeEditorDescription {
    return Intl.message(
      'انشر مسارا متكررا مع المركبة والجدول وتفاصيل السعة.',
      name: 'routeEditorDescription',
      desc: '',
      args: [],
    );
  }

  /// `تعديل المسار المتكرر`
  String get routeEditTitle {
    return Intl.message(
      'تعديل المسار المتكرر',
      name: 'routeEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `يسري من`
  String get routeEffectiveFromLabel {
    return Intl.message(
      'يسري من',
      name: 'routeEffectiveFromLabel',
      desc: '',
      args: [],
    );
  }

  /// `بلدية الانطلاق`
  String get routeOriginLabel {
    return Intl.message(
      'بلدية الانطلاق',
      name: 'routeOriginLabel',
      desc: '',
      args: [],
    );
  }

  /// `السعر لكل كلغ (دج)`
  String get routePricePerKgLabel {
    return Intl.message(
      'السعر لكل كلغ (دج)',
      name: 'routePricePerKgLabel',
      desc: '',
      args: [],
    );
  }

  /// `أيام التكرار`
  String get routeRecurringDaysLabel {
    return Intl.message(
      'أيام التكرار',
      name: 'routeRecurringDaysLabel',
      desc: '',
      args: [],
    );
  }

  /// `حفظ المسار`
  String get routeSaveAction {
    return Intl.message(
      'حفظ المسار',
      name: 'routeSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث المسار المتكرر.`
  String get routeSavedMessage {
    return Intl.message(
      'تم تحديث المسار المتكرر.',
      name: 'routeSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `حالة النشر`
  String get routeStatusLabel {
    return Intl.message(
      'حالة النشر',
      name: 'routeStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `المركبة المخصصة`
  String get routeVehicleLabel {
    return Intl.message(
      'المركبة المخصصة',
      name: 'routeVehicleLabel',
      desc: '',
      args: [],
    );
  }

  /// `تعذّر إكمال هذا الإجراء حاليا. حاول مرة أخرى.`
  String get appGenericErrorMessage {
    return Intl.message(
      'تعذّر إكمال هذا الإجراء حاليا. حاول مرة أخرى.',
      name: 'appGenericErrorMessage',
      desc: '',
      args: [],
    );
  }

  /// `إظهار كلمة المرور`
  String get authShowPasswordAction {
    return Intl.message(
      'إظهار كلمة المرور',
      name: 'authShowPasswordAction',
      desc: '',
      args: [],
    );
  }

  /// `إخفاء كلمة المرور`
  String get authHidePasswordAction {
    return Intl.message(
      'إخفاء كلمة المرور',
      name: 'authHidePasswordAction',
      desc: '',
      args: [],
    );
  }

  /// `إضافة حساب تحويل`
  String get payoutAccountAddAction {
    return Intl.message(
      'إضافة حساب تحويل',
      name: 'payoutAccountAddAction',
      desc: '',
      args: [],
    );
  }

  /// `حذف الحساب`
  String get payoutAccountDeleteAction {
    return Intl.message(
      'حذف الحساب',
      name: 'payoutAccountDeleteAction',
      desc: '',
      args: [],
    );
  }

  /// `لا يمكن حذف هذا الحساب حاليا.`
  String get payoutAccountDeleteBlockedMessage {
    return Intl.message(
      'لا يمكن حذف هذا الحساب حاليا.',
      name: 'payoutAccountDeleteBlockedMessage',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد حذف حساب التحويل هذا من FleetFill؟`
  String get payoutAccountDeleteConfirmationMessage {
    return Intl.message(
      'هل تريد حذف حساب التحويل هذا من FleetFill؟',
      name: 'payoutAccountDeleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم حذف حساب التحويل.`
  String get payoutAccountDeletedMessage {
    return Intl.message(
      'تم حذف حساب التحويل.',
      name: 'payoutAccountDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تعديل الحساب`
  String get payoutAccountEditAction {
    return Intl.message(
      'تعديل الحساب',
      name: 'payoutAccountEditAction',
      desc: '',
      args: [],
    );
  }

  /// `اسم صاحب الحساب`
  String get payoutAccountHolderLabel {
    return Intl.message(
      'اسم صاحب الحساب',
      name: 'payoutAccountHolderLabel',
      desc: '',
      args: [],
    );
  }

  /// `رقم الحساب أو المعرّف`
  String get payoutAccountIdentifierLabel {
    return Intl.message(
      'رقم الحساب أو المعرّف',
      name: 'payoutAccountIdentifierLabel',
      desc: '',
      args: [],
    );
  }

  /// `اسم البنك أو CCP`
  String get payoutAccountInstitutionLabel {
    return Intl.message(
      'اسم البنك أو CCP',
      name: 'payoutAccountInstitutionLabel',
      desc: '',
      args: [],
    );
  }

  /// `حفظ الحساب`
  String get payoutAccountSaveAction {
    return Intl.message(
      'حفظ الحساب',
      name: 'payoutAccountSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `تم حفظ حساب التحويل.`
  String get payoutAccountSavedMessage {
    return Intl.message(
      'تم حفظ حساب التحويل.',
      name: 'payoutAccountSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `وسيلة التحويل`
  String get payoutAccountTypeLabel {
    return Intl.message(
      'وسيلة التحويل',
      name: 'payoutAccountTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `تحويل بنكي`
  String get payoutAccountTypeBankLabel {
    return Intl.message(
      'تحويل بنكي',
      name: 'payoutAccountTypeBankLabel',
      desc: '',
      args: [],
    );
  }

  /// `CCP`
  String get payoutAccountTypeCcpLabel {
    return Intl.message(
      'CCP',
      name: 'payoutAccountTypeCcpLabel',
      desc: '',
      args: [],
    );
  }

  /// `الذهبية`
  String get payoutAccountTypeDahabiaLabel {
    return Intl.message(
      'الذهبية',
      name: 'payoutAccountTypeDahabiaLabel',
      desc: '',
      args: [],
    );
  }

  /// `اختر تاريخا ووقتا للسريان يساوي الآن أو بعده.`
  String get publicationEffectiveDateFutureMessage {
    return Intl.message(
      'اختر تاريخا ووقتا للسريان يساوي الآن أو بعده.',
      name: 'publicationEffectiveDateFutureMessage',
      desc: '',
      args: [],
    );
  }

  /// `اختر إحدى مركباتك المتاحة لهذا النشر.`
  String get publicationVehicleUnavailableMessage {
    return Intl.message(
      'اختر إحدى مركباتك المتاحة لهذا النشر.',
      name: 'publicationVehicleUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `أكمل تحقق الناقل قبل نشر السعة.`
  String get publicationVerifiedCarrierRequiredMessage {
    return Intl.message(
      'أكمل تحقق الناقل قبل نشر السعة.',
      name: 'publicationVerifiedCarrierRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `اختر مركبة موثقة قبل نشر السعة.`
  String get publicationVerifiedVehicleRequiredMessage {
    return Intl.message(
      'اختر مركبة موثقة قبل نشر السعة.',
      name: 'publicationVerifiedVehicleRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `لا يمكن حذف هذا المسار لأنه يحتوي بالفعل على حجوزات.`
  String get routeDeleteBlockedMessage {
    return Intl.message(
      'لا يمكن حذف هذا المسار لأنه يحتوي بالفعل على حجوزات.',
      name: 'routeDeleteBlockedMessage',
      desc: '',
      args: [],
    );
  }

  /// `لا يمكن حذف هذه الرحلة لأنها تحتوي بالفعل على حجوزات.`
  String get oneOffTripDeleteBlockedMessage {
    return Intl.message(
      'لا يمكن حذف هذه الرحلة لأنها تحتوي بالفعل على حجوزات.',
      name: 'oneOffTripDeleteBlockedMessage',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد تفعيل هذا المسار للحجوزات الجديدة؟`
  String get routeActivateConfirmationMessage {
    return Intl.message(
      'هل تريد تفعيل هذا المسار للحجوزات الجديدة؟',
      name: 'routeActivateConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد إلغاء تفعيل هذا المسار للحجوزات الجديدة؟ ستبقى الحجوزات الحالية كما هي.`
  String get routeDeactivateConfirmationMessage {
    return Intl.message(
      'هل تريد إلغاء تفعيل هذا المسار للحجوزات الجديدة؟ ستبقى الحجوزات الحالية كما هي.',
      name: 'routeDeactivateConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد حذف هذا المسار المتكرر من FleetFill؟`
  String get routeDeleteConfirmationMessage {
    return Intl.message(
      'هل تريد حذف هذا المسار المتكرر من FleetFill؟',
      name: 'routeDeleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `تحميل المزيد`
  String get loadMoreLabel {
    return Intl.message(
      'تحميل المزيد',
      name: 'loadMoreLabel',
      desc: '',
      args: [],
    );
  }

  /// `دج/كلغ`
  String get pricePerKgUnitLabel {
    return Intl.message(
      'دج/كلغ',
      name: 'pricePerKgUnitLabel',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد تفعيل هذه الرحلة للحجوزات الجديدة؟`
  String get oneOffTripActivateConfirmationMessage {
    return Intl.message(
      'هل تريد تفعيل هذه الرحلة للحجوزات الجديدة؟',
      name: 'oneOffTripActivateConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد إلغاء تفعيل هذه الرحلة للحجوزات الجديدة؟ ستبقى الحجوزات الحالية كما هي.`
  String get oneOffTripDeactivateConfirmationMessage {
    return Intl.message(
      'هل تريد إلغاء تفعيل هذه الرحلة للحجوزات الجديدة؟ ستبقى الحجوزات الحالية كما هي.',
      name: 'oneOffTripDeactivateConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد حذف هذه الرحلة الفردية من FleetFill؟`
  String get oneOffTripDeleteConfirmationMessage {
    return Intl.message(
      'هل تريد حذف هذه الرحلة الفردية من FleetFill؟',
      name: 'oneOffTripDeleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `دج`
  String get priceCurrencyLabel {
    return Intl.message('دج', name: 'priceCurrencyLabel', desc: '', args: []);
  }

  /// `إنشاء شحنة`
  String get shipmentCreateAction {
    return Intl.message(
      'إنشاء شحنة',
      name: 'shipmentCreateAction',
      desc: '',
      args: [],
    );
  }

  /// `إنشاء شحنة`
  String get shipmentCreateTitle {
    return Intl.message(
      'إنشاء شحنة',
      name: 'shipmentCreateTitle',
      desc: '',
      args: [],
    );
  }

  /// `تعديل الشحنة`
  String get shipmentEditAction {
    return Intl.message(
      'تعديل الشحنة',
      name: 'shipmentEditAction',
      desc: '',
      args: [],
    );
  }

  /// `تعديل الشحنة`
  String get shipmentEditTitle {
    return Intl.message(
      'تعديل الشحنة',
      name: 'shipmentEditTitle',
      desc: '',
      args: [],
    );
  }

  /// `حفظ الشحنة`
  String get shipmentSaveAction {
    return Intl.message(
      'حفظ الشحنة',
      name: 'shipmentSaveAction',
      desc: '',
      args: [],
    );
  }

  /// `تم حفظ الشحنة.`
  String get shipmentSavedMessage {
    return Intl.message(
      'تم حفظ الشحنة.',
      name: 'shipmentSavedMessage',
      desc: '',
      args: [],
    );
  }

  /// `حذف الشحنة`
  String get shipmentDeleteAction {
    return Intl.message(
      'حذف الشحنة',
      name: 'shipmentDeleteAction',
      desc: '',
      args: [],
    );
  }

  /// `هل تريد حذف هذه الشحنة؟`
  String get shipmentDeleteConfirmationMessage {
    return Intl.message(
      'هل تريد حذف هذه الشحنة؟',
      name: 'shipmentDeleteConfirmationMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم حذف الشحنة.`
  String get shipmentDeletedMessage {
    return Intl.message(
      'تم حذف الشحنة.',
      name: 'shipmentDeletedMessage',
      desc: '',
      args: [],
    );
  }

  /// `أنشئ مسودة شحنة قبل البحث عن سعة مطابقة.`
  String get shipmentsEmptyMessage {
    return Intl.message(
      'أنشئ مسودة شحنة قبل البحث عن سعة مطابقة.',
      name: 'shipmentsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل الشحنة`
  String get shipmentDescriptionLabel {
    return Intl.message(
      'تفاصيل الشحنة',
      name: 'shipmentDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `مسودة`
  String get shipmentStatusDraftLabel {
    return Intl.message(
      'مسودة',
      name: 'shipmentStatusDraftLabel',
      desc: '',
      args: [],
    );
  }

  /// `محجوزة`
  String get shipmentStatusBookedLabel {
    return Intl.message(
      'محجوزة',
      name: 'shipmentStatusBookedLabel',
      desc: '',
      args: [],
    );
  }

  /// `ملغاة`
  String get shipmentStatusCancelledLabel {
    return Intl.message(
      'ملغاة',
      name: 'shipmentStatusCancelledLabel',
      desc: '',
      args: [],
    );
  }

  /// `أنشئ شحنة قبل البحث عن الرحلات المناسبة.`
  String get searchTripsRequiresDraftMessage {
    return Intl.message(
      'أنشئ شحنة قبل البحث عن الرحلات المناسبة.',
      name: 'searchTripsRequiresDraftMessage',
      desc: '',
      args: [],
    );
  }

  /// `مسودة الشحنة`
  String get searchShipmentSelectorLabel {
    return Intl.message(
      'مسودة الشحنة',
      name: 'searchShipmentSelectorLabel',
      desc: '',
      args: [],
    );
  }

  /// `تاريخ الانطلاق المطلوب`
  String get searchRequestedDateLabel {
    return Intl.message(
      'تاريخ الانطلاق المطلوب',
      name: 'searchRequestedDateLabel',
      desc: '',
      args: [],
    );
  }

  /// `ملخص الشحنة`
  String get searchShipmentSummaryTitle {
    return Intl.message(
      'ملخص الشحنة',
      name: 'searchShipmentSummaryTitle',
      desc: '',
      args: [],
    );
  }

  /// `ابحث عن سعة مطابقة`
  String get searchTripsAction {
    return Intl.message(
      'ابحث عن سعة مطابقة',
      name: 'searchTripsAction',
      desc: '',
      args: [],
    );
  }

  /// `الترتيب والفلاتر`
  String get searchTripsControlsAction {
    return Intl.message(
      'الترتيب والفلاتر',
      name: 'searchTripsControlsAction',
      desc: '',
      args: [],
    );
  }

  /// `موصى به`
  String get searchSortRecommendedLabel {
    return Intl.message(
      'موصى به',
      name: 'searchSortRecommendedLabel',
      desc: '',
      args: [],
    );
  }

  /// `الأعلى تقييما`
  String get searchSortTopRatedLabel {
    return Intl.message(
      'الأعلى تقييما',
      name: 'searchSortTopRatedLabel',
      desc: '',
      args: [],
    );
  }

  /// `الأقل سعرا`
  String get searchSortLowestPriceLabel {
    return Intl.message(
      'الأقل سعرا',
      name: 'searchSortLowestPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `أقرب انطلاق`
  String get searchSortNearestDepartureLabel {
    return Intl.message(
      'أقرب انطلاق',
      name: 'searchSortNearestDepartureLabel',
      desc: '',
      args: [],
    );
  }

  /// `الناقل`
  String get searchCarrierLabel {
    return Intl.message(
      'الناقل',
      name: 'searchCarrierLabel',
      desc: '',
      args: [],
    );
  }

  /// `الإجمالي التقديري`
  String get searchEstimatedPriceLabel {
    return Intl.message(
      'الإجمالي التقديري',
      name: 'searchEstimatedPriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `الانطلاق`
  String get searchDepartureLabel {
    return Intl.message(
      'الانطلاق',
      name: 'searchDepartureLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم العثور على أقرب التواريخ المطابقة`
  String get searchTripsNearestDateTitle {
    return Intl.message(
      'تم العثور على أقرب التواريخ المطابقة',
      name: 'searchTripsNearestDateTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد نتيجة مطابقة في اليوم نفسه. أقرب التواريخ المطابقة: {dates}`
  String searchTripsNearestDateMessage(Object dates) {
    return Intl.message(
      'لا توجد نتيجة مطابقة في اليوم نفسه. أقرب التواريخ المطابقة: $dates',
      name: 'searchTripsNearestDateMessage',
      desc: '',
      args: [dates],
    );
  }

  /// `أعد تعريف بحثك`
  String get searchTripsNoRouteTitle {
    return Intl.message(
      'أعد تعريف بحثك',
      name: 'searchTripsNoRouteTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا يوجد مسار مطابق لهذا الخط ضمن نافذة البحث القريبة.`
  String get searchTripsNoRouteMessage {
    return Intl.message(
      'لا يوجد مسار مطابق لهذا الخط ضمن نافذة البحث القريبة.',
      name: 'searchTripsNoRouteMessage',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد نتائج تطابق الترتيب والفلاتر الحالية.`
  String get searchTripsFilterEmptyMessage {
    return Intl.message(
      'لا توجد نتائج تطابق الترتيب والفلاتر الحالية.',
      name: 'searchTripsFilterEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `نتائج البحث ({count})`
  String searchTripsResultsTitle(Object count) {
    return Intl.message(
      'نتائج البحث ($count)',
      name: 'searchTripsResultsTitle',
      desc: '',
      args: [count],
    );
  }

  /// `مسار متكرر`
  String get searchTripsRecurringLabel {
    return Intl.message(
      'مسار متكرر',
      name: 'searchTripsRecurringLabel',
      desc: '',
      args: [],
    );
  }

  /// `رحلة فردية`
  String get searchTripsOneOffLabel {
    return Intl.message(
      'رحلة فردية',
      name: 'searchTripsOneOffLabel',
      desc: '',
      args: [],
    );
  }

  /// `تأكيد الحجز`
  String get bookingConfirmAction {
    return Intl.message(
      'تأكيد الحجز',
      name: 'bookingConfirmAction',
      desc: '',
      args: [],
    );
  }

  /// `تم إنشاء الحجز. تابع إلى الدفع.`
  String get bookingCreatedMessage {
    return Intl.message(
      'تم إنشاء الحجز. تابع إلى الدفع.',
      name: 'bookingCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `خيار التأمين`
  String get bookingInsuranceAction {
    return Intl.message(
      'خيار التأمين',
      name: 'bookingInsuranceAction',
      desc: '',
      args: [],
    );
  }

  /// `التأمين`
  String get bookingInsuranceLabel {
    return Intl.message(
      'التأمين',
      name: 'bookingInsuranceLabel',
      desc: '',
      args: [],
    );
  }

  /// `التأمين اختياري ويُحسب كنسبة مئوية مع حد أدنى للرسوم.`
  String get bookingInsuranceDescription {
    return Intl.message(
      'التأمين اختياري ويُحسب كنسبة مئوية مع حد أدنى للرسوم.',
      name: 'bookingInsuranceDescription',
      desc: '',
      args: [],
    );
  }

  /// `مضاف`
  String get bookingInsuranceIncludedLabel {
    return Intl.message(
      'مضاف',
      name: 'bookingInsuranceIncludedLabel',
      desc: '',
      args: [],
    );
  }

  /// `غير مضاف`
  String get bookingInsuranceNotIncludedLabel {
    return Intl.message(
      'غير مضاف',
      name: 'bookingInsuranceNotIncludedLabel',
      desc: '',
      args: [],
    );
  }

  /// `تفصيل السعر`
  String get bookingPricingBreakdownAction {
    return Intl.message(
      'تفصيل السعر',
      name: 'bookingPricingBreakdownAction',
      desc: '',
      args: [],
    );
  }

  /// `السعر الأساسي`
  String get bookingBasePriceLabel {
    return Intl.message(
      'السعر الأساسي',
      name: 'bookingBasePriceLabel',
      desc: '',
      args: [],
    );
  }

  /// `رسوم المنصة`
  String get bookingPlatformFeeLabel {
    return Intl.message(
      'رسوم المنصة',
      name: 'bookingPlatformFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `رسوم الناقل`
  String get bookingCarrierFeeLabel {
    return Intl.message(
      'رسوم الناقل',
      name: 'bookingCarrierFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `رسوم التأمين`
  String get bookingInsuranceFeeLabel {
    return Intl.message(
      'رسوم التأمين',
      name: 'bookingInsuranceFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `الضريبة`
  String get bookingTaxFeeLabel {
    return Intl.message(
      'الضريبة',
      name: 'bookingTaxFeeLabel',
      desc: '',
      args: [],
    );
  }

  /// `مستحق الناقل`
  String get bookingCarrierPayoutLabel {
    return Intl.message(
      'مستحق الناقل',
      name: 'bookingCarrierPayoutLabel',
      desc: '',
      args: [],
    );
  }

  /// `الإجمالي النهائي`
  String get bookingTotalLabel {
    return Intl.message(
      'الإجمالي النهائي',
      name: 'bookingTotalLabel',
      desc: '',
      args: [],
    );
  }

  /// `مرجع الدفع`
  String get bookingPaymentReferenceLabel {
    return Intl.message(
      'مرجع الدفع',
      name: 'bookingPaymentReferenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `رقم التتبع`
  String get bookingTrackingNumberLabel {
    return Intl.message(
      'رقم التتبع',
      name: 'bookingTrackingNumberLabel',
      desc: '',
      args: [],
    );
  }

  /// `تعليمات الدفع`
  String get paymentInstructionsTitle {
    return Intl.message(
      'تعليمات الدفع',
      name: 'paymentInstructionsTitle',
      desc: '',
      args: [],
    );
  }

  /// `أرسل بالضبط {amount} دج باستخدام مرجع الحجز {reference}، ثم ارفع الإثبات هنا.`
  String paymentFlowExactTransferGuidance(Object amount, Object reference) {
    return Intl.message(
      'أرسل بالضبط $amount دج باستخدام مرجع الحجز $reference، ثم ارفع الإثبات هنا.',
      name: 'paymentFlowExactTransferGuidance',
      desc: '',
      args: [amount, reference],
    );
  }

  /// `تم استلام الإثبات. مراجعة الإدارة ما تزال جارية وسنبلغك فور تأمين الدفع أو الحاجة إلى تصحيح.`
  String get paymentFlowSubmittedGuidance {
    return Intl.message(
      'تم استلام الإثبات. مراجعة الإدارة ما تزال جارية وسنبلغك فور تأمين الدفع أو الحاجة إلى تصحيح.',
      name: 'paymentFlowSubmittedGuidance',
      desc: '',
      args: [],
    );
  }

  /// `تم رفض الإثبات السابق. صحح بيانات الدفع أو ارفع إثباتا أوضح للمتابعة.`
  String get paymentFlowRejectedGuidance {
    return Intl.message(
      'تم رفض الإثبات السابق. صحح بيانات الدفع أو ارفع إثباتا أوضح للمتابعة.',
      name: 'paymentFlowRejectedGuidance',
      desc: '',
      args: [],
    );
  }

  /// `تم رفض الإثبات السابق بسبب: {reason}. صحح المشكلة ثم أعد الإرسال من هذه الشاشة.`
  String paymentFlowRejectedGuidanceWithReason(Object reason) {
    return Intl.message(
      'تم رفض الإثبات السابق بسبب: $reason. صحح المشكلة ثم أعد الإرسال من هذه الشاشة.',
      name: 'paymentFlowRejectedGuidanceWithReason',
      desc: '',
      args: [reason],
    );
  }

  /// `تم تأمين الدفع لهذا الحجز. احتفظ بهذه الشاشة للوصول إلى الإيصالات وسجل الإثبات والمستندات المولدة.`
  String get paymentFlowSecuredGuidance {
    return Intl.message(
      'تم تأمين الدفع لهذا الحجز. احتفظ بهذه الشاشة للوصول إلى الإيصالات وسجل الإثبات والمستندات المولدة.',
      name: 'paymentFlowSecuredGuidance',
      desc: '',
      args: [],
    );
  }

  /// `مراجعة إثباتات الدفع`
  String get adminPaymentProofQueueTitle {
    return Intl.message(
      'مراجعة إثباتات الدفع',
      name: 'adminPaymentProofQueueTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد إثباتات دفع تحتاج إلى مراجعة الآن.`
  String get adminPaymentProofQueueEmptyMessage {
    return Intl.message(
      'لا توجد إثباتات دفع تحتاج إلى مراجعة الآن.',
      name: 'adminPaymentProofQueueEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `إثبات الدفع`
  String get paymentProofSectionTitle {
    return Intl.message(
      'إثبات الدفع',
      name: 'paymentProofSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `آخر إثبات تم إرساله`
  String get paymentProofLatestTitle {
    return Intl.message(
      'آخر إثبات تم إرساله',
      name: 'paymentProofLatestTitle',
      desc: '',
      args: [],
    );
  }

  /// `ارفع إثبات الدفع بعد إتمام الدفع الخارجي.`
  String get paymentProofEmptyMessage {
    return Intl.message(
      'ارفع إثبات الدفع بعد إتمام الدفع الخارجي.',
      name: 'paymentProofEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `رفع إثبات الدفع`
  String get paymentProofUploadAction {
    return Intl.message(
      'رفع إثبات الدفع',
      name: 'paymentProofUploadAction',
      desc: '',
      args: [],
    );
  }

  /// `إعادة إرسال الإثبات`
  String get paymentProofResubmitAction {
    return Intl.message(
      'إعادة إرسال الإثبات',
      name: 'paymentProofResubmitAction',
      desc: '',
      args: [],
    );
  }

  /// `تم استلام إثبات الدفع.`
  String get paymentProofUploadedMessage {
    return Intl.message(
      'تم استلام إثبات الدفع.',
      name: 'paymentProofUploadedMessage',
      desc: '',
      args: [],
    );
  }

  /// `CCP`
  String get paymentRailCcpLabel {
    return Intl.message('CCP', name: 'paymentRailCcpLabel', desc: '', args: []);
  }

  /// `الذهبية`
  String get paymentRailDahabiaLabel {
    return Intl.message(
      'الذهبية',
      name: 'paymentRailDahabiaLabel',
      desc: '',
      args: [],
    );
  }

  /// `بنك`
  String get paymentRailBankLabel {
    return Intl.message(
      'بنك',
      name: 'paymentRailBankLabel',
      desc: '',
      args: [],
    );
  }

  /// `المبلغ المرسل`
  String get paymentProofAmountLabel {
    return Intl.message(
      'المبلغ المرسل',
      name: 'paymentProofAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// `المرجع المرسل`
  String get paymentProofReferenceLabel {
    return Intl.message(
      'المرجع المرسل',
      name: 'paymentProofReferenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `حالة الإثبات`
  String get paymentProofStatusLabel {
    return Intl.message(
      'حالة الإثبات',
      name: 'paymentProofStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `بانتظار المراجعة`
  String get paymentProofStatusPendingLabel {
    return Intl.message(
      'بانتظار المراجعة',
      name: 'paymentProofStatusPendingLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم التحقق منه`
  String get paymentProofStatusVerifiedLabel {
    return Intl.message(
      'تم التحقق منه',
      name: 'paymentProofStatusVerifiedLabel',
      desc: '',
      args: [],
    );
  }

  /// `مرفوض`
  String get paymentProofStatusRejectedLabel {
    return Intl.message(
      'مرفوض',
      name: 'paymentProofStatusRejectedLabel',
      desc: '',
      args: [],
    );
  }

  /// `المبلغ المتحقق منه`
  String get paymentProofVerifiedAmountLabel {
    return Intl.message(
      'المبلغ المتحقق منه',
      name: 'paymentProofVerifiedAmountLabel',
      desc: '',
      args: [],
    );
  }

  /// `المرجع المتحقق منه`
  String get paymentProofVerifiedReferenceLabel {
    return Intl.message(
      'المرجع المتحقق منه',
      name: 'paymentProofVerifiedReferenceLabel',
      desc: '',
      args: [],
    );
  }

  /// `ملاحظة القرار`
  String get paymentProofDecisionNoteLabel {
    return Intl.message(
      'ملاحظة القرار',
      name: 'paymentProofDecisionNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `سبب الرفض`
  String get paymentProofRejectionReasonLabel {
    return Intl.message(
      'سبب الرفض',
      name: 'paymentProofRejectionReasonLabel',
      desc: '',
      args: [],
    );
  }

  /// `سبب الرفض مطلوب.`
  String get paymentProofRejectionReasonRequiredMessage {
    return Intl.message(
      'سبب الرفض مطلوب.',
      name: 'paymentProofRejectionReasonRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم تأكيد الدفع.`
  String get paymentProofApprovedMessage {
    return Intl.message(
      'تم تأكيد الدفع.',
      name: 'paymentProofApprovedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم رفض إثبات الدفع.`
  String get paymentProofRejectedMessage {
    return Intl.message(
      'تم رفض إثبات الدفع.',
      name: 'paymentProofRejectedMessage',
      desc: '',
      args: [],
    );
  }

  /// `المستندات المولدة`
  String get generatedDocumentsTitle {
    return Intl.message(
      'المستندات المولدة',
      name: 'generatedDocumentsTitle',
      desc: '',
      args: [],
    );
  }

  /// `ستظهر الفاتورة والإيصال المولدان هنا عند توفرهما.`
  String get generatedDocumentsEmptyMessage {
    return Intl.message(
      'ستظهر الفاتورة والإيصال المولدان هنا عند توفرهما.',
      name: 'generatedDocumentsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `اضغط على أي مستند جاهز لفتحه بشكل آمن.`
  String get generatedDocumentsTapReadyHint {
    return Intl.message(
      'اضغط على أي مستند جاهز لفتحه بشكل آمن.',
      name: 'generatedDocumentsTapReadyHint',
      desc: '',
      args: [],
    );
  }

  /// `لا يمكن إرسال إثبات الدفع إلا ما دام الدفع ما يزال معلقا.`
  String get paymentProofPendingWindowMessage {
    return Intl.message(
      'لا يمكن إرسال إثبات الدفع إلا ما دام الدفع ما يزال معلقا.',
      name: 'paymentProofPendingWindowMessage',
      desc: '',
      args: [],
    );
  }

  /// `يجب أن يطابق المبلغ المتحقق منه إجمالي الحجز تماما.`
  String get paymentProofExactAmountRequiredMessage {
    return Intl.message(
      'يجب أن يطابق المبلغ المتحقق منه إجمالي الحجز تماما.',
      name: 'paymentProofExactAmountRequiredMessage',
      desc: '',
      args: [],
    );
  }

  /// `تمت مراجعة إثبات الدفع هذا بالفعل.`
  String get paymentProofAlreadyReviewedMessage {
    return Intl.message(
      'تمت مراجعة إثبات الدفع هذا بالفعل.',
      name: 'paymentProofAlreadyReviewedMessage',
      desc: '',
      args: [],
    );
  }

  /// `الخط الزمني للتتبع`
  String get trackingTimelineTitle {
    return Intl.message(
      'الخط الزمني للتتبع',
      name: 'trackingTimelineTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد أحداث تتبع متاحة بعد.`
  String get trackingTimelineEmptyMessage {
    return Intl.message(
      'لا توجد أحداث تتبع متاحة بعد.',
      name: 'trackingTimelineEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `تأكيد التسليم`
  String get deliveryConfirmAction {
    return Intl.message(
      'تأكيد التسليم',
      name: 'deliveryConfirmAction',
      desc: '',
      args: [],
    );
  }

  /// `تم تأكيد التسليم.`
  String get deliveryConfirmedMessage {
    return Intl.message(
      'تم تأكيد التسليم.',
      name: 'deliveryConfirmedMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث مرحلة الحجز.`
  String get carrierMilestoneUpdatedMessage {
    return Intl.message(
      'تم تحديث مرحلة الحجز.',
      name: 'carrierMilestoneUpdatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `ملاحظة المرحلة`
  String get carrierMilestoneNoteLabel {
    return Intl.message(
      'ملاحظة المرحلة',
      name: 'carrierMilestoneNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `الدفع قيد المراجعة`
  String get trackingEventPaymentUnderReviewLabel {
    return Intl.message(
      'الدفع قيد المراجعة',
      name: 'trackingEventPaymentUnderReviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `مؤكد`
  String get trackingEventConfirmedLabel {
    return Intl.message(
      'مؤكد',
      name: 'trackingEventConfirmedLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم الاستلام`
  String get trackingEventPickedUpLabel {
    return Intl.message(
      'تم الاستلام',
      name: 'trackingEventPickedUpLabel',
      desc: '',
      args: [],
    );
  }

  /// `في الطريق`
  String get trackingEventInTransitLabel {
    return Intl.message(
      'في الطريق',
      name: 'trackingEventInTransitLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم التسليم وبانتظار المراجعة`
  String get trackingEventDeliveredPendingReviewLabel {
    return Intl.message(
      'تم التسليم وبانتظار المراجعة',
      name: 'trackingEventDeliveredPendingReviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `مكتمل`
  String get trackingEventCompletedLabel {
    return Intl.message(
      'مكتمل',
      name: 'trackingEventCompletedLabel',
      desc: '',
      args: [],
    );
  }

  /// `ملغى`
  String get trackingEventCancelledLabel {
    return Intl.message(
      'ملغى',
      name: 'trackingEventCancelledLabel',
      desc: '',
      args: [],
    );
  }

  /// `متنازع عليه`
  String get trackingEventDisputedLabel {
    return Intl.message(
      'متنازع عليه',
      name: 'trackingEventDisputedLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم طلب المستحق`
  String get trackingEventPayoutRequestedLabel {
    return Intl.message(
      'تم طلب المستحق',
      name: 'trackingEventPayoutRequestedLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم صرف مستحق الناقل`
  String get trackingEventPayoutReleasedLabel {
    return Intl.message(
      'تم صرف مستحق الناقل',
      name: 'trackingEventPayoutReleasedLabel',
      desc: '',
      args: [],
    );
  }

  /// `تمت معالجة الاسترداد`
  String get trackingEventRefundProcessedLabel {
    return Intl.message(
      'تمت معالجة الاسترداد',
      name: 'trackingEventRefundProcessedLabel',
      desc: '',
      args: [],
    );
  }

  /// `اكتمل الحجز تلقائيا بعد انتهاء نافذة مراجعة التسليم.`
  String get trackingEventAutoCompletedNote {
    return Intl.message(
      'اكتمل الحجز تلقائيا بعد انتهاء نافذة مراجعة التسليم.',
      name: 'trackingEventAutoCompletedNote',
      desc: '',
      args: [],
    );
  }

  /// `الإجراء التالي`
  String get bookingNextActionTitle {
    return Intl.message(
      'الإجراء التالي',
      name: 'bookingNextActionTitle',
      desc: '',
      args: [],
    );
  }

  /// `أرسل أو أعد إرسال إثبات الدفع حتى تتمكن FleetFill من تأمين هذا الحجز.`
  String get shipperNextActionPayment {
    return Intl.message(
      'أرسل أو أعد إرسال إثبات الدفع حتى تتمكن FleetFill من تأمين هذا الحجز.',
      name: 'shipperNextActionPayment',
      desc: '',
      args: [],
    );
  }

  /// `إثبات الدفع قيد المراجعة حاليا. لا يلزمك أي إجراء الآن.`
  String get shipperNextActionReview {
    return Intl.message(
      'إثبات الدفع قيد المراجعة حاليا. لا يلزمك أي إجراء الآن.',
      name: 'shipperNextActionReview',
      desc: '',
      args: [],
    );
  }

  /// `أكد التسليم إذا وصل كل شيء كما هو متوقع، أو افتح نزاعا إذا كانت هناك مشكلة.`
  String get shipperNextActionConfirmDelivery {
    return Intl.message(
      'أكد التسليم إذا وصل كل شيء كما هو متوقع، أو افتح نزاعا إذا كانت هناك مشكلة.',
      name: 'shipperNextActionConfirmDelivery',
      desc: '',
      args: [],
    );
  }

  /// `الاستلام هو الخطوة التشغيلية التالية لهذا الحجز.`
  String get carrierNextActionPickup {
    return Intl.message(
      'الاستلام هو الخطوة التشغيلية التالية لهذا الحجز.',
      name: 'carrierNextActionPickup',
      desc: '',
      args: [],
    );
  }

  /// `حدّث الحجز إلى في الطريق بمجرد تحرك الشحنة.`
  String get carrierNextActionTransit {
    return Intl.message(
      'حدّث الحجز إلى في الطريق بمجرد تحرك الشحنة.',
      name: 'carrierNextActionTransit',
      desc: '',
      args: [],
    );
  }

  /// `سجل التسليم فور تسليم الشحنة للطرف المستلم.`
  String get carrierNextActionDelivery {
    return Intl.message(
      'سجل التسليم فور تسليم الشحنة للطرف المستلم.',
      name: 'carrierNextActionDelivery',
      desc: '',
      args: [],
    );
  }

  /// `أصبح هذا الحجز مؤهلا للمستحق. اطلب مستحقك عندما تكون جاهزا.`
  String get carrierNextActionPayoutRequest {
    return Intl.message(
      'أصبح هذا الحجز مؤهلا للمستحق. اطلب مستحقك عندما تكون جاهزا.',
      name: 'carrierNextActionPayoutRequest',
      desc: '',
      args: [],
    );
  }

  /// `تم طلب المستحق وهو الآن بانتظار صرفه من الإدارة.`
  String get carrierNextActionAwaitingAdminRelease {
    return Intl.message(
      'تم طلب المستحق وهو الآن بانتظار صرفه من الإدارة.',
      name: 'carrierNextActionAwaitingAdminRelease',
      desc: '',
      args: [],
    );
  }

  /// `تمت تسوية هذا الحجز وصُرف مستحق الناقل.`
  String get carrierNextActionReleased {
    return Intl.message(
      'تمت تسوية هذا الحجز وصُرف مستحق الناقل.',
      name: 'carrierNextActionReleased',
      desc: '',
      args: [],
    );
  }

  /// `مستحق الناقل`
  String get carrierPayoutSectionTitle {
    return Intl.message(
      'مستحق الناقل',
      name: 'carrierPayoutSectionTitle',
      desc: '',
      args: [],
    );
  }

  /// `سياسة المستحق`
  String get carrierPayoutGraceWindowLabel {
    return Intl.message(
      'سياسة المستحق',
      name: 'carrierPayoutGraceWindowLabel',
      desc: '',
      args: [],
    );
  }

  /// `يفتح طلب المستحق بعد نافذة سماح مدتها {hours} ساعة بمجرد اكتمال الحجز.`
  String carrierPayoutGraceWindowValue(Object hours) {
    return Intl.message(
      'يفتح طلب المستحق بعد نافذة سماح مدتها $hours ساعة بمجرد اكتمال الحجز.',
      name: 'carrierPayoutGraceWindowValue',
      desc: '',
      args: [hours],
    );
  }

  /// `تاريخ الطلب`
  String get carrierPayoutRequestedAtLabel {
    return Intl.message(
      'تاريخ الطلب',
      name: 'carrierPayoutRequestedAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `تاريخ الصرف`
  String get carrierPayoutReleasedAtLabel {
    return Intl.message(
      'تاريخ الصرف',
      name: 'carrierPayoutReleasedAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `ملاحظة طلب المستحق`
  String get carrierPayoutRequestNoteLabel {
    return Intl.message(
      'ملاحظة طلب المستحق',
      name: 'carrierPayoutRequestNoteLabel',
      desc: '',
      args: [],
    );
  }

  /// `طلب المستحق`
  String get carrierPayoutRequestAction {
    return Intl.message(
      'طلب المستحق',
      name: 'carrierPayoutRequestAction',
      desc: '',
      args: [],
    );
  }

  /// `تم الطلب`
  String get carrierPayoutRequestedLabel {
    return Intl.message(
      'تم الطلب',
      name: 'carrierPayoutRequestedLabel',
      desc: '',
      args: [],
    );
  }

  /// `مؤهل الآن`
  String get carrierPayoutEligibleNowLabel {
    return Intl.message(
      'مؤهل الآن',
      name: 'carrierPayoutEligibleNowLabel',
      desc: '',
      args: [],
    );
  }

  /// `سجل المستحقات`
  String get carrierPayoutHistoryTitle {
    return Intl.message(
      'سجل المستحقات',
      name: 'carrierPayoutHistoryTitle',
      desc: '',
      args: [],
    );
  }

  /// `أصبح هذا الحجز جاهزا لطلب المستحق. أرسل الطلب عندما تريد من الإدارة صرف الأموال.`
  String get carrierPayoutEligibleGuidance {
    return Intl.message(
      'أصبح هذا الحجز جاهزا لطلب المستحق. أرسل الطلب عندما تريد من الإدارة صرف الأموال.',
      name: 'carrierPayoutEligibleGuidance',
      desc: '',
      args: [],
    );
  }

  /// `تم تسجيل طلب المستحق. ستراجعه الإدارة وتصرفه إلى حساب التحويل المسجل لديك.`
  String get carrierPayoutRequestedGuidance {
    return Intl.message(
      'تم تسجيل طلب المستحق. ستراجعه الإدارة وتصرفه إلى حساب التحويل المسجل لديك.',
      name: 'carrierPayoutRequestedGuidance',
      desc: '',
      args: [],
    );
  }

  /// `تم صرف المستحق لهذا الحجز. راجع السجل أدناه للاطلاع على آخر عملية صرف.`
  String get carrierPayoutReleasedGuidance {
    return Intl.message(
      'تم صرف المستحق لهذا الحجز. راجع السجل أدناه للاطلاع على آخر عملية صرف.',
      name: 'carrierPayoutReleasedGuidance',
      desc: '',
      args: [],
    );
  }

  /// `ما يزال هذا الحجز داخل نافذة سياسة المستحق البالغة {hours} ساعة أو بانتظار زوال مانع آخر قبل فتح الطلب.`
  String carrierPayoutPendingGuidance(Object hours) {
    return Intl.message(
      'ما يزال هذا الحجز داخل نافذة سياسة المستحق البالغة $hours ساعة أو بانتظار زوال مانع آخر قبل فتح الطلب.',
      name: 'carrierPayoutPendingGuidance',
      desc: '',
      args: [hours],
    );
  }

  /// `تم إرسال طلب المستحق.`
  String get carrierPayoutRequestSuccessMessage {
    return Intl.message(
      'تم إرسال طلب المستحق.',
      name: 'carrierPayoutRequestSuccessMessage',
      desc: '',
      args: [],
    );
  }

  /// `لا يفتح طلب المستحق إلا بعد وصول الحجز إلى حالة مكتمل.`
  String get carrierPayoutBlockedReasonCompleted {
    return Intl.message(
      'لا يفتح طلب المستحق إلا بعد وصول الحجز إلى حالة مكتمل.',
      name: 'carrierPayoutBlockedReasonCompleted',
      desc: '',
      args: [],
    );
  }

  /// `يبقى طلب المستحق محجوبا حتى يصبح الدفع مؤمنا.`
  String get carrierPayoutBlockedReasonPayment {
    return Intl.message(
      'يبقى طلب المستحق محجوبا حتى يصبح الدفع مؤمنا.',
      name: 'carrierPayoutBlockedReasonPayment',
      desc: '',
      args: [],
    );
  }

  /// `حل النزاع المفتوح قبل طلب المستحق.`
  String get carrierPayoutBlockedReasonDispute {
    return Intl.message(
      'حل النزاع المفتوح قبل طلب المستحق.',
      name: 'carrierPayoutBlockedReasonDispute',
      desc: '',
      args: [],
    );
  }

  /// `أضف حساب تحويل نشطا قبل طلب المستحق.`
  String get carrierPayoutBlockedReasonAccount {
    return Intl.message(
      'أضف حساب تحويل نشطا قبل طلب المستحق.',
      name: 'carrierPayoutBlockedReasonAccount',
      desc: '',
      args: [],
    );
  }

  /// `تم صرف المستحق لهذا الحجز بالفعل.`
  String get carrierPayoutBlockedReasonReleased {
    return Intl.message(
      'تم صرف المستحق لهذا الحجز بالفعل.',
      name: 'carrierPayoutBlockedReasonReleased',
      desc: '',
      args: [],
    );
  }

  /// `النشطة`
  String get operationsActiveLabel {
    return Intl.message(
      'النشطة',
      name: 'operationsActiveLabel',
      desc: '',
      args: [],
    );
  }

  /// `السجل`
  String get operationsHistoryLabel {
    return Intl.message(
      'السجل',
      name: 'operationsHistoryLabel',
      desc: '',
      args: [],
    );
  }

  /// `الحالة الحالية`
  String get bookingTimelineCurrentLabel {
    return Intl.message(
      'الحالة الحالية',
      name: 'bookingTimelineCurrentLabel',
      desc: '',
      args: [],
    );
  }

  /// `الشاحن`
  String get bookingTimelineActorShipperLabel {
    return Intl.message(
      'الشاحن',
      name: 'bookingTimelineActorShipperLabel',
      desc: '',
      args: [],
    );
  }

  /// `الإدارة`
  String get bookingTimelineActorAdminLabel {
    return Intl.message(
      'الإدارة',
      name: 'bookingTimelineActorAdminLabel',
      desc: '',
      args: [],
    );
  }

  /// `الناقل`
  String get bookingTimelineActorCarrierLabel {
    return Intl.message(
      'الناقل',
      name: 'bookingTimelineActorCarrierLabel',
      desc: '',
      args: [],
    );
  }

  /// `النظام`
  String get bookingTimelineActorSystemLabel {
    return Intl.message(
      'النظام',
      name: 'bookingTimelineActorSystemLabel',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد شحنات أو حجوزات نشطة تحتاج إلى إجراء الآن.`
  String get shipperActiveOperationsEmptyMessage {
    return Intl.message(
      'لا توجد شحنات أو حجوزات نشطة تحتاج إلى إجراء الآن.',
      name: 'shipperActiveOperationsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `سيظهر هنا سجل الشحنات المكتملة والملغاة.`
  String get shipperHistoryOperationsEmptyMessage {
    return Intl.message(
      'سيظهر هنا سجل الشحنات المكتملة والملغاة.',
      name: 'shipperHistoryOperationsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد حجوزات نشطة تحتاج إلى إجراء الآن.`
  String get carrierActiveBookingsEmptyMessage {
    return Intl.message(
      'لا توجد حجوزات نشطة تحتاج إلى إجراء الآن.',
      name: 'carrierActiveBookingsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `سيظهر هنا سجل الحجوزات المكتملة والملغاة.`
  String get carrierHistoryBookingsEmptyMessage {
    return Intl.message(
      'سيظهر هنا سجل الحجوزات المكتملة والملغاة.',
      name: 'carrierHistoryBookingsEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `تاريخ الإنشاء`
  String get createdAtLabel {
    return Intl.message(
      'تاريخ الإنشاء',
      name: 'createdAtLabel',
      desc: '',
      args: [],
    );
  }

  /// `السبب`
  String get reasonLabel {
    return Intl.message('السبب', name: 'reasonLabel', desc: '', args: []);
  }

  /// `سبب النزاع`
  String get disputeReasonLabel {
    return Intl.message(
      'سبب النزاع',
      name: 'disputeReasonLabel',
      desc: '',
      args: [],
    );
  }

  /// `اشرح المشكلة`
  String get disputeDescriptionLabel {
    return Intl.message(
      'اشرح المشكلة',
      name: 'disputeDescriptionLabel',
      desc: '',
      args: [],
    );
  }

  /// `معلّق`
  String get statusPendingLabel {
    return Intl.message(
      'معلّق',
      name: 'statusPendingLabel',
      desc: '',
      args: [],
    );
  }

  /// `تحديث متاح`
  String get localizationUnknownLabel {
    return Intl.message(
      'تحديث متاح',
      name: 'localizationUnknownLabel',
      desc: '',
      args: [],
    );
  }

  /// `النزاعات`
  String get adminDisputesQueueTitle {
    return Intl.message(
      'النزاعات',
      name: 'adminDisputesQueueTitle',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد نزاعات بانتظار المراجعة الآن.`
  String get adminDisputesQueueEmptyMessage {
    return Intl.message(
      'لا توجد نزاعات بانتظار المراجعة الآن.',
      name: 'adminDisputesQueueEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `التحويلات`
  String get adminPayoutQueueTitle {
    return Intl.message(
      'التحويلات',
      name: 'adminPayoutQueueTitle',
      desc: '',
      args: [],
    );
  }

  /// `لم يتم تحرير أي تحويلات بعد.`
  String get adminPayoutQueueEmptyMessage {
    return Intl.message(
      'لم يتم تحرير أي تحويلات بعد.',
      name: 'adminPayoutQueueEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `موضوع الدعم`
  String get supportSubjectLabel {
    return Intl.message(
      'موضوع الدعم',
      name: 'supportSubjectLabel',
      desc: '',
      args: [],
    );
  }

  /// `رسالة الدعم`
  String get supportMessageLabel {
    return Intl.message(
      'رسالة الدعم',
      name: 'supportMessageLabel',
      desc: '',
      args: [],
    );
  }

  /// `بريد الدعم: {supportEmail}`
  String supportConfiguredEmailMessage(Object supportEmail) {
    return Intl.message(
      'بريد الدعم: $supportEmail',
      name: 'supportConfiguredEmailMessage',
      desc: '',
      args: [supportEmail],
    );
  }

  /// `أضف أي معرّف حجز أو رقم تتبع أو مرجع دفع يساعد فريق الدعم على التحقيق بسرعة أكبر.`
  String get supportReferenceHintMessage {
    return Intl.message(
      'أضف أي معرّف حجز أو رقم تتبع أو مرجع دفع يساعد فريق الدعم على التحقيق بسرعة أكبر.',
      name: 'supportReferenceHintMessage',
      desc: '',
      args: [],
    );
  }

  /// `إرسال الرسالة`
  String get supportSendAction {
    return Intl.message(
      'إرسال الرسالة',
      name: 'supportSendAction',
      desc: '',
      args: [],
    );
  }

  /// `تم إرسال رسالة الدعم.`
  String get supportMessageSentMessage {
    return Intl.message(
      'تم إرسال رسالة الدعم.',
      name: 'supportMessageSentMessage',
      desc: '',
      args: [],
    );
  }

  /// `تعذّر وضع رسالة الدعم في الطابور الآن. يرجى المحاولة بعد قليل.`
  String get supportUnavailableMessage {
    return Intl.message(
      'تعذّر وضع رسالة الدعم في الطابور الآن. يرجى المحاولة بعد قليل.',
      name: 'supportUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `أرسلت رسائل دعم كثيرة مؤخرا. يرجى المحاولة لاحقا.`
  String get supportRateLimitMessage {
    return Intl.message(
      'أرسلت رسائل دعم كثيرة مؤخرا. يرجى المحاولة لاحقا.',
      name: 'supportRateLimitMessage',
      desc: '',
      args: [],
    );
  }

  /// `السياسات والإفصاحات`
  String get legalPoliciesTitle {
    return Intl.message(
      'السياسات والإفصاحات',
      name: 'legalPoliciesTitle',
      desc: '',
      args: [],
    );
  }

  /// `راجع شروط الخدمة والخصوصية والدفع والنزاعات قبل استخدام FleetFill.`
  String get legalPoliciesDescription {
    return Intl.message(
      'راجع شروط الخدمة والخصوصية والدفع والنزاعات قبل استخدام FleetFill.',
      name: 'legalPoliciesDescription',
      desc: '',
      args: [],
    );
  }

  /// `إذا احتجت إلى توضيح حول هذه السياسات، فتواصل مع دعم FleetFill قبل متابعة الحجز أو الدفع أو النزاع.`
  String get legalPoliciesSupportHint {
    return Intl.message(
      'إذا احتجت إلى توضيح حول هذه السياسات، فتواصل مع دعم FleetFill قبل متابعة الحجز أو الدفع أو النزاع.',
      name: 'legalPoliciesSupportHint',
      desc: '',
      args: [],
    );
  }

  /// `شروط الخدمة`
  String get legalTermsTitle {
    return Intl.message(
      'شروط الخدمة',
      name: 'legalTermsTitle',
      desc: '',
      args: [],
    );
  }

  /// `تستلم FleetFill دفعة المرسل قبل أي تحويل إلى الناقل. يغطي كل حجز شحنة واحدة على مسار أو رحلة مؤكدة واحدة. يبقى المرسل مسؤولا عن دقة تفاصيل الشحنة، ويبقى الناقل مسؤولا عن صلاحية الوثائق والامتثال القانوني للنقل.`
  String get legalTermsBody {
    return Intl.message(
      'تستلم FleetFill دفعة المرسل قبل أي تحويل إلى الناقل. يغطي كل حجز شحنة واحدة على مسار أو رحلة مؤكدة واحدة. يبقى المرسل مسؤولا عن دقة تفاصيل الشحنة، ويبقى الناقل مسؤولا عن صلاحية الوثائق والامتثال القانوني للنقل.',
      name: 'legalTermsBody',
      desc: '',
      args: [],
    );
  }

  /// `الخصوصية والاحتفاظ بالبيانات`
  String get legalPrivacyTitle {
    return Intl.message(
      'الخصوصية والاحتفاظ بالبيانات',
      name: 'legalPrivacyTitle',
      desc: '',
      args: [],
    );
  }

  /// `تحتفظ FleetFill ببيانات الدفع والشحن والدعم والتدقيق فقط عند الحاجة لتشغيل الخدمة والتحقيق في النزاعات والوفاء بالالتزامات القانونية أو المالية. ويظل الوصول محصورا بصاحب الحساب والموظفين المصرح لهم.`
  String get legalPrivacyBody {
    return Intl.message(
      'تحتفظ FleetFill ببيانات الدفع والشحن والدعم والتدقيق فقط عند الحاجة لتشغيل الخدمة والتحقيق في النزاعات والوفاء بالالتزامات القانونية أو المالية. ويظل الوصول محصورا بصاحب الحساب والموظفين المصرح لهم.',
      name: 'legalPrivacyBody',
      desc: '',
      args: [],
    );
  }

  /// `إفصاح الدفع والضمان`
  String get legalPaymentDisclosureTitle {
    return Intl.message(
      'إفصاح الدفع والضمان',
      name: 'legalPaymentDisclosureTitle',
      desc: '',
      args: [],
    );
  }

  /// `يظهر تفصيل السعر ورسوم المنصة والضرائب وخيار التأمين قبل إرسال إثبات الدفع. تتحقق FleetFill من إثبات الدفع مقابل إجمالي الحجز، وتؤمن الأموال قبل اكتمال التسليم، ولا تطلق مستحق الناقل إلا بعد أن يصبح الحجز مؤهلا للتحويل.`
  String get legalPaymentDisclosureBody {
    return Intl.message(
      'يظهر تفصيل السعر ورسوم المنصة والضرائب وخيار التأمين قبل إرسال إثبات الدفع. تتحقق FleetFill من إثبات الدفع مقابل إجمالي الحجز، وتؤمن الأموال قبل اكتمال التسليم، ولا تطلق مستحق الناقل إلا بعد أن يصبح الحجز مؤهلا للتحويل.',
      name: 'legalPaymentDisclosureBody',
      desc: '',
      args: [],
    );
  }

  /// `سياسة النزاعات`
  String get legalDisputePolicyTitle {
    return Intl.message(
      'سياسة النزاعات',
      name: 'legalDisputePolicyTitle',
      desc: '',
      args: [],
    );
  }

  /// `يجب فتح النزاعات خلال نافذة مراجعة التسليم. تراجع FleetFill الشحنة وإثبات الدفع والتتبع والمستندات المرتبطة قبل حسم الحالة. وقد ينتهي النزاع بإكمال الحجز أو إلغائه أو رد المبلغ.`
  String get legalDisputePolicyBody {
    return Intl.message(
      'يجب فتح النزاعات خلال نافذة مراجعة التسليم. تراجع FleetFill الشحنة وإثبات الدفع والتتبع والمستندات المرتبطة قبل حسم الحالة. وقد ينتهي النزاع بإكمال الحجز أو إلغائه أو رد المبلغ.',
      name: 'legalDisputePolicyBody',
      desc: '',
      args: [],
    );
  }

  /// `تقييم الناقل`
  String get searchCarrierRatingLabel {
    return Intl.message(
      'تقييم الناقل',
      name: 'searchCarrierRatingLabel',
      desc: '',
      args: [],
    );
  }

  /// `أفضل توازن بين التوقيت والسعر وسمعة الناقل.`
  String get searchRecommendationBalancedMessage {
    return Intl.message(
      'أفضل توازن بين التوقيت والسعر وسمعة الناقل.',
      name: 'searchRecommendationBalancedMessage',
      desc: '',
      args: [],
    );
  }

  /// `أفضل الناقلين تقييما أولا لتعزيز الثقة.`
  String get searchRecommendationTopRatedMessage {
    return Intl.message(
      'أفضل الناقلين تقييما أولا لتعزيز الثقة.',
      name: 'searchRecommendationTopRatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `أقل إجمالي تقديري أولا لتقليل التكلفة.`
  String get searchRecommendationLowestPriceMessage {
    return Intl.message(
      'أقل إجمالي تقديري أولا لتقليل التكلفة.',
      name: 'searchRecommendationLowestPriceMessage',
      desc: '',
      args: [],
    );
  }

  /// `أقرب مواعيد الانطلاق أولا للتحرك أسرع.`
  String get searchRecommendationNearestMessage {
    return Intl.message(
      'أقرب مواعيد الانطلاق أولا للتحرك أسرع.',
      name: 'searchRecommendationNearestMessage',
      desc: '',
      args: [],
    );
  }

  /// `موصى به للتوازن: التقييم {rating} والانطلاق {departure}.`
  String searchRecommendationBalancedResult(Object rating, Object departure) {
    return Intl.message(
      'موصى به للتوازن: التقييم $rating والانطلاق $departure.',
      name: 'searchRecommendationBalancedResult',
      desc: '',
      args: [rating, departure],
    );
  }

  /// `الخيار الأعلى تقييما بدرجة {rating} من {count} مراجعات.`
  String searchRecommendationTopRatedResult(Object rating, Object count) {
    return Intl.message(
      'الخيار الأعلى تقييما بدرجة $rating من $count مراجعات.',
      name: 'searchRecommendationTopRatedResult',
      desc: '',
      args: [rating, count],
    );
  }

  /// `أقل إجمالي تقديري هو {amount} دج لهذا المسار.`
  String searchRecommendationLowestPriceResult(Object amount) {
    return Intl.message(
      'أقل إجمالي تقديري هو $amount دج لهذا المسار.',
      name: 'searchRecommendationLowestPriceResult',
      desc: '',
      args: [amount],
    );
  }

  /// `أقرب انطلاق سيكون في {departure}.`
  String searchRecommendationNearestResult(Object departure) {
    return Intl.message(
      'أقرب انطلاق سيكون في $departure.',
      name: 'searchRecommendationNearestResult',
      desc: '',
      args: [departure],
    );
  }

  /// `نوع السعة`
  String get searchResultTypeLabel {
    return Intl.message(
      'نوع السعة',
      name: 'searchResultTypeLabel',
      desc: '',
      args: [],
    );
  }

  /// `إرسال التقييم`
  String get ratingSubmitAction {
    return Intl.message(
      'إرسال التقييم',
      name: 'ratingSubmitAction',
      desc: '',
      args: [],
    );
  }

  /// `تعليق التقييم`
  String get ratingCommentLabel {
    return Intl.message(
      'تعليق التقييم',
      name: 'ratingCommentLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم إرسال تقييم الناقل.`
  String get ratingSubmittedMessage {
    return Intl.message(
      'تم إرسال تقييم الناقل.',
      name: 'ratingSubmittedMessage',
      desc: '',
      args: [],
    );
  }

  /// `بانتظار الدفع`
  String get bookingStatusPendingPaymentLabel {
    return Intl.message(
      'بانتظار الدفع',
      name: 'bookingStatusPendingPaymentLabel',
      desc: '',
      args: [],
    );
  }

  /// `الدفع قيد المراجعة`
  String get bookingStatusPaymentUnderReviewLabel {
    return Intl.message(
      'الدفع قيد المراجعة',
      name: 'bookingStatusPaymentUnderReviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `مؤكد`
  String get bookingStatusConfirmedLabel {
    return Intl.message(
      'مؤكد',
      name: 'bookingStatusConfirmedLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم الاستلام`
  String get bookingStatusPickedUpLabel {
    return Intl.message(
      'تم الاستلام',
      name: 'bookingStatusPickedUpLabel',
      desc: '',
      args: [],
    );
  }

  /// `في الطريق`
  String get bookingStatusInTransitLabel {
    return Intl.message(
      'في الطريق',
      name: 'bookingStatusInTransitLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم التسليم وبانتظار المراجعة`
  String get bookingStatusDeliveredPendingReviewLabel {
    return Intl.message(
      'تم التسليم وبانتظار المراجعة',
      name: 'bookingStatusDeliveredPendingReviewLabel',
      desc: '',
      args: [],
    );
  }

  /// `مكتمل`
  String get bookingStatusCompletedLabel {
    return Intl.message(
      'مكتمل',
      name: 'bookingStatusCompletedLabel',
      desc: '',
      args: [],
    );
  }

  /// `ملغى`
  String get bookingStatusCancelledLabel {
    return Intl.message(
      'ملغى',
      name: 'bookingStatusCancelledLabel',
      desc: '',
      args: [],
    );
  }

  /// `متنازع عليه`
  String get bookingStatusDisputedLabel {
    return Intl.message(
      'متنازع عليه',
      name: 'bookingStatusDisputedLabel',
      desc: '',
      args: [],
    );
  }

  /// `غير مدفوع`
  String get paymentStatusUnpaidLabel {
    return Intl.message(
      'غير مدفوع',
      name: 'paymentStatusUnpaidLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم إرسال الإثبات`
  String get paymentStatusProofSubmittedLabel {
    return Intl.message(
      'تم إرسال الإثبات',
      name: 'paymentStatusProofSubmittedLabel',
      desc: '',
      args: [],
    );
  }

  /// `قيد التحقق`
  String get paymentStatusUnderVerificationLabel {
    return Intl.message(
      'قيد التحقق',
      name: 'paymentStatusUnderVerificationLabel',
      desc: '',
      args: [],
    );
  }

  /// `مؤمّن`
  String get paymentStatusSecuredLabel {
    return Intl.message(
      'مؤمّن',
      name: 'paymentStatusSecuredLabel',
      desc: '',
      args: [],
    );
  }

  /// `مرفوض`
  String get paymentStatusRejectedLabel {
    return Intl.message(
      'مرفوض',
      name: 'paymentStatusRejectedLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم رد المبلغ`
  String get paymentStatusRefundedLabel {
    return Intl.message(
      'تم رد المبلغ',
      name: 'paymentStatusRefundedLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم تحويله إلى الناقل`
  String get paymentStatusReleasedToCarrierLabel {
    return Intl.message(
      'تم تحويله إلى الناقل',
      name: 'paymentStatusReleasedToCarrierLabel',
      desc: '',
      args: [],
    );
  }

  /// `معلّق`
  String get transferStatusPendingLabel {
    return Intl.message(
      'معلّق',
      name: 'transferStatusPendingLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم الإرسال`
  String get transferStatusSentLabel {
    return Intl.message(
      'تم الإرسال',
      name: 'transferStatusSentLabel',
      desc: '',
      args: [],
    );
  }

  /// `فشل`
  String get transferStatusFailedLabel {
    return Intl.message(
      'فشل',
      name: 'transferStatusFailedLabel',
      desc: '',
      args: [],
    );
  }

  /// `ملغى`
  String get transferStatusCancelledLabel {
    return Intl.message(
      'ملغى',
      name: 'transferStatusCancelledLabel',
      desc: '',
      args: [],
    );
  }

  /// `التواصل مع الدعم`
  String get contactSupportAction {
    return Intl.message(
      'التواصل مع الدعم',
      name: 'contactSupportAction',
      desc: '',
      args: [],
    );
  }

  /// `رجوع`
  String get goBackAction {
    return Intl.message('رجوع', name: 'goBackAction', desc: '', args: []);
  }

  /// `فتح الإشعارات`
  String get openNotificationsAction {
    return Intl.message(
      'فتح الإشعارات',
      name: 'openNotificationsAction',
      desc: '',
      args: [],
    );
  }

  /// `المعاينة غير متاحة لهذا الملف. افتحه في تطبيق آخر.`
  String get documentPreviewUnavailableMessage {
    return Intl.message(
      'المعاينة غير متاحة لهذا الملف. افتحه في تطبيق آخر.',
      name: 'documentPreviewUnavailableMessage',
      desc: '',
      args: [],
    );
  }

  /// `طلبات الدعم الخاصة بك`
  String get supportInboxTitle {
    return Intl.message(
      'طلبات الدعم الخاصة بك',
      name: 'supportInboxTitle',
      desc: '',
      args: [],
    );
  }

  /// `لم تفتح أي طلب دعم بعد.`
  String get supportInboxEmptyMessage {
    return Intl.message(
      'لم تفتح أي طلب دعم بعد.',
      name: 'supportInboxEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `تم إنشاء طلب الدعم بنجاح.`
  String get supportRequestCreatedMessage {
    return Intl.message(
      'تم إنشاء طلب الدعم بنجاح.',
      name: 'supportRequestCreatedMessage',
      desc: '',
      args: [],
    );
  }

  /// `محادثة الدعم`
  String get supportThreadTitle {
    return Intl.message(
      'محادثة الدعم',
      name: 'supportThreadTitle',
      desc: '',
      args: [],
    );
  }

  /// `تفاصيل الطلب`
  String get supportThreadDetailsTitle {
    return Intl.message(
      'تفاصيل الطلب',
      name: 'supportThreadDetailsTitle',
      desc: '',
      args: [],
    );
  }

  /// `الحالة`
  String get supportStatusLabel {
    return Intl.message(
      'الحالة',
      name: 'supportStatusLabel',
      desc: '',
      args: [],
    );
  }

  /// `الأولوية`
  String get supportPriorityLabel {
    return Intl.message(
      'الأولوية',
      name: 'supportPriorityLabel',
      desc: '',
      args: [],
    );
  }

  /// `آخر تحديث`
  String get supportLastUpdatedLabel {
    return Intl.message(
      'آخر تحديث',
      name: 'supportLastUpdatedLabel',
      desc: '',
      args: [],
    );
  }

  /// `الرد`
  String get supportReplyLabel {
    return Intl.message('الرد', name: 'supportReplyLabel', desc: '', args: []);
  }

  /// `إرسال الرد`
  String get supportReplyAction {
    return Intl.message(
      'إرسال الرد',
      name: 'supportReplyAction',
      desc: '',
      args: [],
    );
  }

  /// `تم إرسال الرد.`
  String get supportReplySentMessage {
    return Intl.message(
      'تم إرسال الرد.',
      name: 'supportReplySentMessage',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد رسائل في هذا الطلب حتى الآن.`
  String get supportThreadNoMessagesMessage {
    return Intl.message(
      'لا توجد رسائل في هذا الطلب حتى الآن.',
      name: 'supportThreadNoMessagesMessage',
      desc: '',
      args: [],
    );
  }

  /// `فتح الحجز`
  String get supportLinkedBookingAction {
    return Intl.message(
      'فتح الحجز',
      name: 'supportLinkedBookingAction',
      desc: '',
      args: [],
    );
  }

  /// `فتح إثبات الدفع`
  String get supportLinkedPaymentProofAction {
    return Intl.message(
      'فتح إثبات الدفع',
      name: 'supportLinkedPaymentProofAction',
      desc: '',
      args: [],
    );
  }

  /// `فتح النزاع`
  String get supportLinkedDisputeAction {
    return Intl.message(
      'فتح النزاع',
      name: 'supportLinkedDisputeAction',
      desc: '',
      args: [],
    );
  }

  /// `فتح المحادثة`
  String get supportThreadOpenAction {
    return Intl.message(
      'فتح المحادثة',
      name: 'supportThreadOpenAction',
      desc: '',
      args: [],
    );
  }

  /// `مفتوح`
  String get supportStatusOpenLabel {
    return Intl.message(
      'مفتوح',
      name: 'supportStatusOpenLabel',
      desc: '',
      args: [],
    );
  }

  /// `قيد المعالجة`
  String get supportStatusInProgressLabel {
    return Intl.message(
      'قيد المعالجة',
      name: 'supportStatusInProgressLabel',
      desc: '',
      args: [],
    );
  }

  /// `بانتظار المستخدم`
  String get supportStatusWaitingForUserLabel {
    return Intl.message(
      'بانتظار المستخدم',
      name: 'supportStatusWaitingForUserLabel',
      desc: '',
      args: [],
    );
  }

  /// `تم الحل`
  String get supportStatusResolvedLabel {
    return Intl.message(
      'تم الحل',
      name: 'supportStatusResolvedLabel',
      desc: '',
      args: [],
    );
  }

  /// `مغلق`
  String get supportStatusClosedLabel {
    return Intl.message(
      'مغلق',
      name: 'supportStatusClosedLabel',
      desc: '',
      args: [],
    );
  }

  /// `عادية`
  String get supportPriorityNormalLabel {
    return Intl.message(
      'عادية',
      name: 'supportPriorityNormalLabel',
      desc: '',
      args: [],
    );
  }

  /// `مرتفعة`
  String get supportPriorityHighLabel {
    return Intl.message(
      'مرتفعة',
      name: 'supportPriorityHighLabel',
      desc: '',
      args: [],
    );
  }

  /// `عاجلة`
  String get supportPriorityUrgentLabel {
    return Intl.message(
      'عاجلة',
      name: 'supportPriorityUrgentLabel',
      desc: '',
      args: [],
    );
  }

  /// `أنت`
  String get supportMessageSenderUserLabel {
    return Intl.message(
      'أنت',
      name: 'supportMessageSenderUserLabel',
      desc: '',
      args: [],
    );
  }

  /// `دعم FleetFill`
  String get supportMessageSenderAdminLabel {
    return Intl.message(
      'دعم FleetFill',
      name: 'supportMessageSenderAdminLabel',
      desc: '',
      args: [],
    );
  }

  /// `النظام`
  String get supportMessageSenderSystemLabel {
    return Intl.message(
      'النظام',
      name: 'supportMessageSenderSystemLabel',
      desc: '',
      args: [],
    );
  }

  /// `قائمة الدعم`
  String get adminSupportQueueTitle {
    return Intl.message(
      'قائمة الدعم',
      name: 'adminSupportQueueTitle',
      desc: '',
      args: [],
    );
  }

  /// `الدعم`
  String get adminQueueSupportTabLabel {
    return Intl.message(
      'الدعم',
      name: 'adminQueueSupportTabLabel',
      desc: '',
      args: [],
    );
  }

  /// `البحث في طلبات الدعم`
  String get adminSupportSearchLabel {
    return Intl.message(
      'البحث في طلبات الدعم',
      name: 'adminSupportSearchLabel',
      desc: '',
      args: [],
    );
  }

  /// `كل الحالات`
  String get adminSupportStatusAllLabel {
    return Intl.message(
      'كل الحالات',
      name: 'adminSupportStatusAllLabel',
      desc: '',
      args: [],
    );
  }

  /// `لا توجد طلبات دعم تحتاج إلى معالجة الآن.`
  String get adminSupportQueueEmptyMessage {
    return Intl.message(
      'لا توجد طلبات دعم تحتاج إلى معالجة الآن.',
      name: 'adminSupportQueueEmptyMessage',
      desc: '',
      args: [],
    );
  }

  /// `عناصر تحكم الدعم`
  String get adminSupportControlsTitle {
    return Intl.message(
      'عناصر تحكم الدعم',
      name: 'adminSupportControlsTitle',
      desc: '',
      args: [],
    );
  }

  /// `إسناد إليّ`
  String get adminSupportAssignToMeAction {
    return Intl.message(
      'إسناد إليّ',
      name: 'adminSupportAssignToMeAction',
      desc: '',
      args: [],
    );
  }

  /// `إزالة الإسناد`
  String get adminSupportUnassignAction {
    return Intl.message(
      'إزالة الإسناد',
      name: 'adminSupportUnassignAction',
      desc: '',
      args: [],
    );
  }

  /// `طلب دعم جديد`
  String get notificationSupportRequestCreatedTitle {
    return Intl.message(
      'طلب دعم جديد',
      name: 'notificationSupportRequestCreatedTitle',
      desc: '',
      args: [],
    );
  }

  /// `فتح مستخدم طلب دعم جديد يحتاج إلى مراجعة.`
  String get notificationSupportRequestCreatedBody {
    return Intl.message(
      'فتح مستخدم طلب دعم جديد يحتاج إلى مراجعة.',
      name: 'notificationSupportRequestCreatedBody',
      desc: '',
      args: [],
    );
  }

  /// `تم الرد من الدعم`
  String get notificationSupportReplyReceivedTitle {
    return Intl.message(
      'تم الرد من الدعم',
      name: 'notificationSupportReplyReceivedTitle',
      desc: '',
      args: [],
    );
  }

  /// `ردّ فريق دعم FleetFill على طلبك.`
  String get notificationSupportReplyReceivedBody {
    return Intl.message(
      'ردّ فريق دعم FleetFill على طلبك.',
      name: 'notificationSupportReplyReceivedBody',
      desc: '',
      args: [],
    );
  }

  /// `قام المستخدم بالرد`
  String get notificationSupportUserRepliedTitle {
    return Intl.message(
      'قام المستخدم بالرد',
      name: 'notificationSupportUserRepliedTitle',
      desc: '',
      args: [],
    );
  }

  /// `ردّ مستخدم على طلب دعم قائم.`
  String get notificationSupportUserRepliedBody {
    return Intl.message(
      'ردّ مستخدم على طلب دعم قائم.',
      name: 'notificationSupportUserRepliedBody',
      desc: '',
      args: [],
    );
  }

  /// `تم تحديث حالة الدعم`
  String get notificationSupportStatusChangedTitle {
    return Intl.message(
      'تم تحديث حالة الدعم',
      name: 'notificationSupportStatusChangedTitle',
      desc: '',
      args: [],
    );
  }

  /// `أصبحت حالة طلب الدعم الآن {status}.`
  String notificationSupportStatusChangedBody(Object status) {
    return Intl.message(
      'أصبحت حالة طلب الدعم الآن $status.',
      name: 'notificationSupportStatusChangedBody',
      desc: '',
      args: [status],
    );
  }

  /// `ولاية الانطلاق`
  String get routeOriginWilayaLabel {
    return Intl.message(
      'ولاية الانطلاق',
      name: 'routeOriginWilayaLabel',
      desc: '',
      args: [],
    );
  }

  /// `ولاية الوصول`
  String get routeDestinationWilayaLabel {
    return Intl.message(
      'ولاية الوصول',
      name: 'routeDestinationWilayaLabel',
      desc: '',
      args: [],
    );
  }

  /// `الموقع غير متاح`
  String get locationUnavailableLabel {
    return Intl.message(
      'الموقع غير متاح',
      name: 'locationUnavailableLabel',
      desc: '',
      args: [],
    );
  }

  /// `تعذر على FleetFill الوصول إلى الخادم المحلي للتطوير. استخدم إعداد تشغيل المحاكي مع محاكيات Android، واستخدم عنوان الشبكة المحلية للكمبيوتر على الأجهزة الحقيقية.`
  String get localBackendUnavailableMessage {
    return Intl.message(
      'تعذر على FleetFill الوصول إلى الخادم المحلي للتطوير. استخدم إعداد تشغيل المحاكي مع محاكيات Android، واستخدم عنوان الشبكة المحلية للكمبيوتر على الأجهزة الحقيقية.',
      name: 'localBackendUnavailableMessage',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'ar'),
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'fr'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
