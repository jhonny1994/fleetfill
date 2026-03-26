import type { AppLocale } from "@/lib/i18n/config";
import { defaultLocale, isSupportedLocale } from "@/lib/i18n/config";

function localeOf(locale: string | AppLocale): AppLocale {
  return isSupportedLocale(locale) ? locale : defaultLocale;
}

function humanize(value: string) {
  return value.replace(/_/g, " ").replace(/\b\w/g, (letter) => letter.toUpperCase());
}

const ui = {
  ar: {
    pages: {
      admins: { eyebrow: "المشرفون", title: "الحسابات الإدارية النشطة", listBody: "عرض مُوجَز للحسابات الإدارية يوضِّح الحالة والدور وتاريخ آخر تحديث، مع إمكانية الانتقال إلى صفحة التفاصيل لإدارة الصلاحيات والتفعيل.", detailBody: "مساحة عمل إدارية مُركَّزة تجمع حالة الحساب وسجلّ الدعوات ومسار التدقيق في واجهة واحدة متوازنة.", accountOverview: "نظرة عامة على الحساب الإداري", accountOverviewBody: "تعرض هذه البطاقة أهمّ بيانات الحساب قبل تنفيذ أيّ تغيير في الحوكمة أو التشغيل.", invitations: "سجلّ الدعوات الإدارية", invitationHistoryBody: "راجِع الدعوات السابقة لهذا الحساب، وحالة كلّ دعوة، وما إذا كانت لا تزال صالحة للاستخدام.", governanceActions: "إجراءات الحوكمة", governanceActionsBody: "استخدِم هذه الإجراءات لتحديث الدور أو تعطيل الوصول الإداري مع تسجيل السبب في سجلّ التدقيق.", inviteTitle: "دعوة مشرف جديد", inviteBody: "لا يُنشأ المشرفون إلّا عبر الدعوة. يظهر الرمز مرة واحدة هنا ليُرسَل عبر قناة داخلية آمنة.", invitationCreatedFor: "أُنشئت دعوة إلى {email}", invitationMeta: "الدور {role} · تنتهي في {date}", accountMeta: "بدعوة من {actor} · آخر تحديث {date}", notFound: "لم يُعثَر على الحساب الإداري." },
      audit: { eyebrow: "التدقيق وسلامة النظام", title: "سجلّ التشغيل وسلامة التسليم", body: "تعرض هذه الصفحة سجلّ التشغيل وسلامة مسار البريد التشغيلي حصرًا. تظلّ رسائل تأكيد الحساب وإعادة تعيين كلمة المرور مُدارة من Supabase Auth خارج هذا السجلّ.", auditTrail: "سجلّ تدقيق المشرفين", auditTrailBody: "يُسجَّل هنا كلّ إجراء إداري حساس للحفاظ على تسلسل تشغيلي واضح وقابل للمراجعة.", emailLogs: "سجلّ تسليم البريد", emailLogsBody: "تغطي هذه السجلّات البريد التشغيلي المارّ عبر صندوق الإرسال وعُمّال الإيفاد والخطّاف العكسي للمزوِّد، ولا تشمل رسائل Supabase Auth.", deadLetters: "تراكم الرسائل الميتة", deadLettersBody: "راجِع رسائل البريد التشغيلي أو الإشعارات التي استنفدت محاولاتها وأعِد تشغيلها من هنا عند الحاجة." },
      payments: { eyebrow: "المدفوعات", title: "طابور مراجعة إثباتات الدفع", notFound: "لم يُعثَر على تفاصيل الدفع.", actions: "إجراءات الدفع", preview: "معاينة الإثبات" },
      verification: { eyebrow: "التحقُّق", title: "مراجعة ملف الناقل", notFound: "لم يُعثَر على ملف التحقُّق.", actions: "إجراءات التحقُّق", preview: "معاينة أحدث مستند", packetDocs: "المستندات داخل الملف" },
      disputes: { eyebrow: "النزاعات", title: "طابور النزاعات المفتوحة", notFound: "لم يُعثَر على تفاصيل النزاع.", actions: "إجراءات النزاع", preview: "معاينة الأدلة" },
      payouts: { eyebrow: "التحويلات", title: "عمليات تحويل مستحقات الناقلين", notFound: "لم يُعثَر على تفاصيل التحويل.", actions: "إجراءات التحويل", account: "حساب التحويل النشط" },
      support: { eyebrow: "الدعم", title: "صندوق الدعم", notFound: "لم يُعثَر على محادثة الدعم.", actions: "إجراءات الدعم", conversation: "المحادثة" },
      users: { eyebrow: "المستخدمون", title: "إدارة المستخدمين ودورة حياة الحسابات", listBody: "قائمة تشغيلية مُوجَزة تعرض حالة الحساب، والتحقُّق، وآخر نشاط، مع الانتقال إلى صفحة التفاصيل عند الحاجة إلى إجراء أو مراجعة أعمق.", searchPlaceholder: "ابحث بالاسم أو البريد أو الهاتف أو معرِّف الملف", userLabel: "المستخدم", bookingsLabel: "حجوزات", notFound: "لم يُعثَر على المستخدم.", controls: "ضوابط الحساب" },
      bookings: { eyebrow: "الحجوزات", notFound: "لم يُعثَر على تفاصيل الحجز.", linkedOps: "العمليات المرتبطة", references: "المراجع" },
      settings: { eyebrow: "الإعدادات", title: "عناصر التحكم التشغيلية للمنصة" },
      shipments: { eyebrow: "الشحنات", notFound: "لم يُعثَر على تفاصيل الشحنة.", routeContext: "سياق المسار", linkedEntities: "الكيانات المرتبطة", linkedBooking: "الحجز المرتبط", noBookingYet: "لم يُنشأ حجز لهذه الشحنة بعد.", shipperProfile: "ملف الشاحن" },
      userDetail: { profileAndVerification: "الملف الشخصي والتحقُّق", vehicles: "المركبات", payoutAccounts: "حسابات التحويل", recentShipments: "أحدث الشحنات", recentBookings: "أحدث الحجوزات", supportThreads: "محادثات الدعم", verificationDocuments: "مستندات التحقُّق", noVehicles: "لا توجد مركبات مرتبطة بهذا المستخدم.", noPayoutAccounts: "لا توجد حسابات تحويل مسجَّلة.", noShipments: "لا توجد شحنات أنشأها هذا المستخدم.", noBookings: "لا توجد حجوزات مرتبطة بهذا المستخدم.", noSupportThreads: "لا توجد محادثات دعم لهذا المستخدم.", noVerificationDocuments: "لا توجد مستندات تحقُّق لهذا المستخدم." },
    },
    labels: {
      role: "الدور",
      adminAccount: "الحساب الإداري",
      state: "الحالة",
      email: "البريد الإلكتروني",
      updated: "آخر تحديث",
      context: "السياق",
      operationalContext: "السياق التشغيلي",
      request: "الطلب",
      priority: "الأولوية",
      linkedBooking: "الحجز المرتبط",
      workflow: "مسار العمل",
      readState: "حالة القراءة",
      latestMessage: "أحدث رسالة",
      latestActivity: "آخر نشاط",
      amount: "المبلغ",
      age: "العمر الزمني",
      subject: "الموضوع",
      reason: "السبب",
      verification: "التحقُّق",
      accountState: "حالة الحساب",
      preferredLocale: "اللغة المفضَّلة",
      carrier: "الناقل",
      documents: "المستندات",
      queue: "طابور",
      timeline: "الخط الزمني",
      none: "لا يوجد",
      allRoles: "جميع الأدوار",
      allAccountStates: "جميع حالات الحساب",
      allVerificationStates: "جميع حالات التحقُّق",
      unknown: "غير معروف",
      notApplicable: "غير مُنطبِق",
      noNote: "لا توجد ملاحظة",
      noReasonProvided: "لم يُسجَّل سبب",
      noProviderMessage: "لا توجد رسالة من المزوِّد",
      noSignedPreview: "لا تتوفر معاينة موقَّعة لهذا الملف بعد.",
      previewUnavailable: "المعاينة المضمَّنة غير متاحة لهذا النوع من الملفات.",
      openFile: "فتح الملف",
      noTimeline: "لا توجد أحداث زمنية متاحة بعد.",
      current: "الحالي",
      new: "جديد",
      seen: "تمّت المراجعة",
      noLinkedEntity: "لا يوجد كيان مرتبط",
      profileDocsComplete: "مستندات الملف الشخصي مكتملة",
      vehicleDocsComplete: "مستندات المركبة مكتملة",
      noVehiclesYet: "لا توجد مركبات بعد",
      noTransferNote: "لا توجد ملاحظة تحويل",
      noInstitution: "لا توجد مؤسسة مالية مسجَّلة",
      noExternalReference: "لا يوجد مرجع خارجي",
      noSubmittedReference: "لا يوجد مرجع تحويل مُسجَّل",
      booking: "الحجز",
      bookingState: "حالة الحجز",
      paymentState: "حالة الدفع",
      shipperTotal: "إجمالي الشاحن",
      carrierPayout: "مستحقّ الناقل",
      created: "تاريخ الإنشاء",
      weight: "الوزن",
      volume: "الحجم",
      noActivePayoutAccount: "لا يوجد حساب تحويل نشط لهذا الناقل.",
      resolutionNote: "ملاحظة المعالجة",
      refundAmount: "مبلغ الاسترداد (دج)",
      refundReason: "سبب الاسترداد",
      externalReference: "المرجع الخارجي",
      evidenceItems: "عدد الأدلة",
      missingOrBlocked: "ناقص / مُعلَّق",
      vehiclesSummary: "{count} مركبات",
      noCarrierPacketsWaiting: "لا توجد ملفات ناقلين بانتظار المراجعة.",
      noCarrierPacketsWaitingBody:
        "عند رفع مستندات التحقُّق أو إعادة إرسالها، سيظهر الملف هنا ليُراجَع من فريق التشغيل.",
    },
    actions: {
      confirm: "تأكيد",
      cancel: "إلغاء",
      openDetail: "فتح التفاصيل",
      working: "جارٍ التنفيذ…",
      retry: "إعادة المحاولة",
      revoke: "إلغاء الدعوة",
      revokeTitle: "إلغاء هذه الدعوة؟",
      revokeBody: "سيتوقف رمز الدعوة عن العمل فورًا وستُسجَّل الدعوة على أنها ملغاة.",
      revokeReason: "أُلغيت من لوحة التحكم",
      createInvitation: "إنشاء الدعوة",
      creatingInvitation: "جارٍ إنشاء الدعوة…",
      copyToken: "نسخ الرمز",
      expiryHours: "مدة الصلاحية (بالساعات)",
      viewAccount: "فتح التفاصيل",
      changeRole: "تغيير الدور",
      changeRoleBody: "استخدِم هذا الإجراء عندما يحتاج الحساب إلى تغيير دائم في مستوى الصلاحية الإدارية.",
      changeRoleTitle: "تأكيد تغيير الدور؟",
      changeRoleConfirmBody: "سيُحدَّث الدور الإداري لهذا الحساب فورًا مع تسجيل السبب في سجلّ التدقيق.",
      updateRole: "تحديث الدور",
      deactivateAdmin: "تعطيل المشرف",
      reactivateAdmin: "إعادة تفعيل المشرف",
      deactivateAdminBody: "أوقِف الوصول الإداري عندما يستلزم الحساب تعليقًا تشغيليًّا أو أمنيًّا ريثما تُستكمَل المراجعة.",
      reactivateAdminBody: "أعِد الوصول الإداري بعد انتهاء سبب التعليق أو اكتمال المراجعة.",
      deactivateAdminTitle: "تعطيل هذا المشرف؟",
      deactivateAdminConfirmBody: "سيُمنَع هذا الحساب من الوصول إلى لوحة التحكم إلى أن يُعاد تفعيله من مشرف آخر.",
      reactivateAdminTitle: "إعادة تفعيل هذا المشرف؟",
      reactivateAdminConfirmBody: "سيستعيد هذا الحساب إمكانية الوصول إلى لوحة التحكم فورًا.",
      suspendBody: "استخدِم هذا الإجراء عندما يجب منع الحساب من ممارسة أيّ نشاط على المنصة ريثما يُعالِج المشرف المشكلة.",
      reactivateBody: "استخدِم هذا الإجراء لإعادة الوصول بعد تعليق أو إيقاف إشرافي.",
      suspendTitle: "تعليق هذا المستخدم؟",
      suspendConfirmBody: "سيُمنَع الحساب من الوصول المعتاد إلى التطبيق حتى يُعيد أحد المشرفين تفعيله.",
      reactivateTitle: "إعادة تفعيل هذا المستخدم؟",
      reactivateConfirmBody: "سيُعاد تفعيل الحساب ويُسمَح للمستخدم بالعودة إلى المنصة.",
      approveProof: "اعتماد الإثبات",
      rejectProof: "رفض الإثبات",
      verifiedAmount: "المبلغ المعتمَد (دج)",
      verifiedReference: "المرجع المعتمَد",
      decisionNote: "ملاحظة القرار",
      rejectionReason: "سبب الرفض",
      approveTitle: "اعتماد إثبات الدفع؟",
      approveBody: "سيؤدي هذا إلى اعتماد الإثبات ونقل الحجز إلى حالة الدفع المضمون.",
      rejectTitle: "رفض إثبات الدفع؟",
      rejectBody: "سيؤدي هذا إلى رفض الإثبات وإعادة الحجز إلى مسار إعادة إرسال الدفع.",
      approvePacket: "اعتماد الملف بالكامل",
      approvePacketBody: "استخدِم هذا الإجراء عندما يكتمل ملف السائق والمركبة ويصبح جاهزًا للاعتماد دفعة واحدة.",
      document: "المستند",
      decision: "القرار",
      approveDocument: "اعتماد المستند",
      rejectDocument: "رفض المستند",
      reasonRequired: "السبب (إلزامي عند الرفض)",
      approvePacketTitle: "اعتماد ملف التحقُّق بالكامل؟",
      approvePacketConfirmBody: "سيؤدي هذا إلى اعتماد الملف وإرسال إشعار الاعتماد عند اكتمال التحقُّق.",
      submitReviewTitle: "إرسال مراجعة المستند؟",
      submitReviewBody: "ستُحدَّث حالة مراجعة المستند فورًا مع تحديث ملف الناقل.",
      reviewDocument: "مراجعة المستند",
      resolveWithoutRefund: "إغلاق دون استرداد",
      issueRefund: "إصدار استرداد",
      releasePayout: "صرف التحويل",
      replyLabel: "الرد",
      sendReplyTitle: "إرسال رد إداري؟",
      sendReplyBody: "سيُنشَر ردك داخل المحادثة وسيُشعَر المستخدم.",
      updateStatusTitle: "تحديث حالة الدعم؟",
      updateStatusBody: "سيُغيِّر هذا حالة مسار العمل والأولوية لهذه المحادثة.",
      reply: "إرسال الرد",
      updateStatus: "تحديث الحالة",
      retryEmailDelivery: "إعادة محاولة تسليم البريد",
      retryEmailDeliveryTitle: "إعادة محاولة تسليم هذه الرسالة؟",
      retryEmailDeliveryBody:
        "سيؤدي هذا إلى إنشاء مهمة بريد إلكتروني جديدة عالية الأولوية انطلاقًا من سجلّ التسليم الذي أخفق.",
      retryDeadLetter: "إعادة محاولة الرسالة الميتة",
      retryDeadLetterTitle: "إعادة محاولة هذه الرسالة الميتة؟",
      retryDeadLetterBody:
        "سيؤدي هذا إلى إنشاء مهمة جديدة في صندوق البريد الصادر اعتمادًا على البيانات الموجودة في قائمة الرسائل الميتة.",
      suspendUser: "تعليق المستخدم",
      reactivateUser: "إعادة تفعيل المستخدم",
      paymentReview: "مراجعة الدفع",
      payoutDetail: "تفاصيل التحويل",
      disputeDetail: "تفاصيل النزاع",
      shipmentDetail: "تفاصيل الشحنة",
      resolveDispute: "تسوية النزاع",
      createRefund: "إنشاء استرداد",
      resolveNoRefundTitle: "تسوية النزاع دون استرداد؟",
      resolveNoRefundBody: "سيؤدي هذا إلى إغلاق النزاع مع الإبقاء على النتيجة المالية الحالية كما هي.",
      resolveWithRefundTitle: "تسوية النزاع مع استرداد؟",
      resolveWithRefundBody: "سيؤدي هذا إلى إنشاء مسار الاسترداد وإقفال النزاع بنتيجة استرداد.",
      saveSettingTitle: "حفظ إعداد المنصة؟",
      saveSettingBody: "سيُكتَب هذا مباشرةً في مخزن الإعدادات الخاضع للتدقيق وسيؤثِّر في السلوك التشغيلي اللاحق للمنصة.",
      saveSetting: "حفظ الإعداد",
    },
    enums: {
      adminRoles: { super_admin: "مشرف عام", ops_admin: "مشرف عمليات" },
      userRoles: { shipper: "شاحن", carrier: "ناقل", admin: "مشرف" },
      activity: { active: "نشط", inactive: "غير نشط", suspended: "مُعلَّق" },
      verification: { pending: "قيد المراجعة", verified: "مُعتمَد", rejected: "مرفوض", incomplete: "غير مكتمل" },
      invitations: { pending: "معلَّقة", accepted: "مقبولة", revoked: "ملغاة", expired: "منتهية الصلاحية" },
      supportStatus: { open: "مفتوح", in_progress: "قيد المعالجة", waiting_for_user: "بانتظار المستخدم", resolved: "تمّت التسوية", closed: "مُغلَق" },
      supportPriority: { normal: "عادية", high: "مرتفعة", urgent: "عاجلة" },
      payment: { pending: "معلَّق", unpaid: "غير مدفوع", submitted: "تم الإرسال", proof_submitted: "تم إرسال الإثبات", under_review: "قيد المراجعة", under_verification: "قيد التحقُّق", rejected: "مرفوض", secured: "مضمون", refunded: "مُستردّ", released: "مصروف", released_to_carrier: "حُوِّل إلى الناقل" },
      booking: { pending: "معلَّق", pending_payment: "بانتظار الدفع", payment_under_review: "الدفع قيد المراجعة", confirmed: "مؤكَّد", picked_up: "تم الاستلام", in_transit: "قيد النقل", delivered_pending_review: "مُسلَّم بانتظار المراجعة", completed: "مكتمل", canceled: "ملغى", cancelled: "ملغى", disputed: "متنازَع عليه" },
      shipment: { draft: "مسوّدة", booked: "محجوزة", cancelled: "ملغاة", canceled: "ملغاة" },
      dispute: { open: "مفتوح", resolved: "تمّت التسوية", refunded: "مُستردّ", closed: "مُغلَق" },
      payout: { pending: "معلَّق", released: "مصروف", sent: "تم الإرسال", failed: "أخفق", processing: "قيد التنفيذ", cancelled: "ملغى", canceled: "ملغى" },
      entity: { profile: "ملف شخصي", vehicle: "مركبة" },
      sender: { user: "المستخدم", admin: "المشرف", system: "النظام" },
      email: { delivered: "تم التسليم", soft_failed: "إخفاق مؤقت", failed: "أخفق", dead_letter: "رسائل ميتة" },
      locale: { ar: "العربية", fr: "الفرنسية", en: "الإنجليزية" },
      document: { driver_identity_or_license: "رخصة القيادة", truck_registration: "البطاقة الرمادية", truck_insurance: "تأمين المركبة", truck_technical_inspection: "الفحص التقني", transport_license: "رخصة النقل" },
    },
  },
  fr: {
    pages: { admins: { eyebrow: "Admins", title: "Comptes admin actifs", listBody: "Vue compacte des comptes admin avec rôle, statut et dernier changement, puis ouverture de la fiche detail pour les actions de gouvernance.", detailBody: "Espace de travail admin equilibre qui rassemble l'état du compte, l'historique des invitations et la chronologie d'audit.", accountOverview: "Resume du compte admin", accountOverviewBody: "Cette section regroupe les informations essentielles à vérifier avant toute action de rôle ou d'activation.", invitations: "Historique des invitations admin", invitationHistoryBody: "Consultez les invitations liees a ce compte, leur statut et leur date d'expiration.", governanceActions: "Actions de gouvernance", governanceActionsBody: "Utilisez ces actions pour changer le rôle ou couper l'accès admin avec une raison enregistrée.", inviteTitle: "Inviter un admin", inviteBody: "Les admins sont créés uniquement par invitation. Le jeton n'est visible qu'une seule fois ici.", invitationCreatedFor: "Invitation créée pour {email}", invitationMeta: "Rôle {role} • expire le {date}", accountMeta: "Invité par {actor} • mis à jour {date}", notFound: "Compte admin introuvable." }, audit: { eyebrow: "Audit et sante", title: "Audit operationnel et sante de livraison", body: "Cette page suit l'audit operationnel ainsi que la sante du pipeline email transactionnel uniquement. Les e-mails de confirmation de compte et de reinitialisation de mot de passe restent geres par Supabase Auth en dehors de ces journaux.", auditTrail: "Journal d'audit admin", auditTrailBody: "Chaque action admin sensible est enregistree ici pour garder un historique operable et verifiable.", emailLogs: "Logs de livraison email", emailLogsBody: "Ces logs couvrent l'email transactionnel passant par la file d'attente FleetFill, le worker de dispatch et le webhook fournisseur, pas les e-mails Auth Supabase.", deadLetters: "Backlog dead-letter", deadLettersBody: "Relancez ici les jobs transactionnels ou push qui ont epuise leurs tentatives automatiques." }, payments: { eyebrow: "Paiements", title: "File de revue des preuves de paiement", notFound: "Détail paiement introuvable.", actions: "Actions paiement", preview: "Aperçu de la preuve" }, verification: { eyebrow: "Vérification", title: "Revue du dossier transporteur", notFound: "Dossier de vérification introuvable.", actions: "Actions vérification", preview: "Aperçu du dernier document", packetDocs: "Documents du dossier" }, disputes: { eyebrow: "Litiges", title: "File des litiges ouverts", notFound: "Détail litige introuvable.", actions: "Actions litige", preview: "Aperçu des preuves" }, payouts: { eyebrow: "Versements", title: "Opérations de versement transporteur", notFound: "Détail versement introuvable.", actions: "Actions versement", account: "Compte de versement actif" }, support: { eyebrow: "Support", title: "Boite support", notFound: "Ticket support introuvable.", actions: "Actions support", conversation: "Conversation" }, users: { eyebrow: "Utilisateurs", title: "Opérations et cycle de vie utilisateur", listBody: "Liste compacte des utilisateurs avec état du compte, vérification et dernière activité, puis ouverture de la fiche detail uniquement quand une action ou une revue plus profonde est nécessaire.", searchPlaceholder: "Rechercher par nom, email, téléphone ou identifiant profil", userLabel: "Utilisateur", bookingsLabel: "bookings", notFound: "Utilisateur introuvable.", controls: "Controle du compte" }, bookings: { eyebrow: "Bookings", notFound: "Detail booking introuvable.", linkedOps: "Operations liees", references: "References" }, settings: { eyebrow: "Parametres", title: "Controles runtime de la plateforme" }, shipments: { eyebrow: "Expeditions", notFound: "Détail expédition introuvable.", routeContext: "Contexte de trajet", linkedEntities: "Entités liées", linkedBooking: "Booking lié", noBookingYet: "Aucun booking n'a encore été créé pour cette expédition.", shipperProfile: "Profil chargeur" }, userDetail: { profileAndVerification: "Profil et vérification", vehicles: "Véhicules", payoutAccounts: "Comptes de versement", recentShipments: "Expéditions récentes", recentBookings: "Bookings récents", supportThreads: "Fils support", verificationDocuments: "Documents de vérification", noVehicles: "Aucun véhicule lié à cet utilisateur.", noPayoutAccounts: "Aucun compte de versement enregistré.", noShipments: "Aucune expédition créée par cet utilisateur.", noBookings: "Aucun booking lié à cet utilisateur.", noSupportThreads: "Aucun fil support pour cet utilisateur.", noVerificationDocuments: "Aucun document de vérification pour cet utilisateur." } },
    labels: { role: "Rôle", adminAccount: "Compte admin", state: "État", email: "Email", updated: "Mis à jour", context: "Contexte", operationalContext: "Contexte opérationnel", request: "Demande", priority: "Priorité", linkedBooking: "Booking lié", workflow: "Workflow", readState: "État de lecture", latestMessage: "Dernier message", latestActivity: "Dernière activité", amount: "Montant", age: "Âge", subject: "Sujet", reason: "Raison", verification: "Vérification", accountState: "État du compte", preferredLocale: "Langue préférée", carrier: "Transporteur", documents: "Documents", queue: "File", timeline: "Chronologie", current: "Actuel", none: "Aucun", allRoles: "Tous les rôles", allAccountStates: "Tous les états de compte", allVerificationStates: "Tous les états de vérification", unknown: "Inconnu", notApplicable: "Non applicable", noNote: "Aucune note", noReasonProvided: "Aucune raison fournie", noProviderMessage: "Aucun message fournisseur", noSignedPreview: "Aucun aperçu signé disponible.", previewUnavailable: "L'aperçu intégré n'est pas disponible pour ce type de fichier.", openFile: "Ouvrir le fichier", noTimeline: "Aucun événement de chronologie n'est encore disponible.", new: "Nouveau", seen: "Vu", noLinkedEntity: "Aucune entité liée", profileDocsComplete: "Documents profil complets", vehicleDocsComplete: "Documents véhicule complets", noVehiclesYet: "Aucun véhicule pour l'instant", noTransferNote: "Aucune note de transfert", noInstitution: "Aucun établissement renseigné", noExternalReference: "Aucune référence externe", noSubmittedReference: "Aucune référence soumise", booking: "Booking", bookingState: "État booking", paymentState: "État paiement", shipperTotal: "Total chargeur", carrierPayout: "Versement transporteur", created: "Créé le", weight: "Poids", volume: "Volume", noActivePayoutAccount: "Aucun compte de versement actif pour ce transporteur.", resolutionNote: "Note de résolution", refundAmount: "Montant du remboursement (DZD)", refundReason: "Motif du remboursement", externalReference: "Référence externe", evidenceItems: "Pièces de preuve", missingOrBlocked: "Manquant / bloquant", vehiclesSummary: "{count} véhicules", noCarrierPacketsWaiting: "Aucun dossier transporteur en attente de revue.", noCarrierPacketsWaitingBody: "Quand un transporteur soumet ou renvoie des documents de vérification, le dossier apparaît ici." },
    actions: { confirm: "Confirmer", cancel: "Annuler", openDetail: "Ouvrir le détail", working: "Traitement...", retry: "Relancer", revoke: "Révoquer l'invitation", revokeTitle: "Révoquer cette invitation ?", revokeBody: "Le jeton cessera de fonctionner immédiatement et l'invitation sera marquée comme révoquée.", revokeReason: "Révoquée depuis la console admin", createInvitation: "Créer l'invitation", creatingInvitation: "Création en cours...", copyToken: "Copier le jeton", expiryHours: "Expiration (heures)", viewAccount: "Ouvrir la fiche", changeRole: "Changer le rôle", changeRoleBody: "À utiliser lorsqu'un compte doit changer durablement de niveau de permission admin.", changeRoleTitle: "Confirmer le changement de rôle ?", changeRoleConfirmBody: "Le rôle admin de ce compte sera mis à jour immédiatement et la raison sera enregistrée dans l'audit.", updateRole: "Mettre à jour le rôle", deactivateAdmin: "Désactiver l'admin", reactivateAdmin: "Réactiver l'admin", deactivateAdminBody: "Coupe l'accès au back-office tant qu'un autre super admin n'a pas restauré ce compte.", reactivateAdminBody: "Rend l'accès admin à nouveau disponible après vérification ou suspension.", deactivateAdminTitle: "Désactiver cet admin ?", deactivateAdminConfirmBody: "Ce compte perdra immédiatement l'accès à la console admin jusqu'à réactivation.", reactivateAdminTitle: "Réactiver cet admin ?", reactivateAdminConfirmBody: "Ce compte retrouvera immédiatement l'accès à la console admin.", suspendBody: "Utilisez ceci lorsqu'un compte doit être bloqué des activités plateforme jusqu'à résolution.", reactivateBody: "Utilisez ceci pour restaurer l'accès après suspension.", suspendTitle: "Suspendre cet utilisateur ?", suspendConfirmBody: "Le compte sera bloqué jusqu'à réactivation par un admin.", reactivateTitle: "Réactiver cet utilisateur ?", reactivateConfirmBody: "Le compte sera restauré et l'utilisateur pourra revenir sur la plateforme.", approveProof: "Approuver la preuve", rejectProof: "Rejeter la preuve", verifiedAmount: "Montant vérifié (DZD)", verifiedReference: "Référence vérifiée", decisionNote: "Note de décision", rejectionReason: "Motif de rejet", approveTitle: "Approuver la preuve de paiement ?", approveBody: "Cela vérifiera la preuve et débloquera l'état de paiement sécurisé du booking.", rejectTitle: "Rejeter la preuve de paiement ?", rejectBody: "Cela rejettera la preuve et renverra le booking vers la resoumission.", approvePacket: "Approuver le dossier complet", approvePacketBody: "Utilisez ceci quand tout le dossier conducteur + véhicule est complet.", document: "Document", decision: "Décision", approveDocument: "Approuver le document", rejectDocument: "Rejeter le document", reasonRequired: "Raison (obligatoire si rejet)", approvePacketTitle: "Approuver le dossier complet ?", approvePacketConfirmBody: "Cela approuvera le dossier et enverra la notification associée.", submitReviewTitle: "Soumettre cette revue ?", submitReviewBody: "L'état du document sera mis à jour immédiatement.", reviewDocument: "Revoir le document", resolveWithoutRefund: "Clore sans remboursement", issueRefund: "Créer le remboursement", releasePayout: "Déclencher le versement", replyLabel: "Réponse", sendReplyTitle: "Envoyer une réponse admin ?", sendReplyBody: "Votre réponse sera publiée dans le fil et l'utilisateur sera notifié.", updateStatusTitle: "Mettre à jour le statut support ?", updateStatusBody: "Cela changera l'état et la priorité du fil.", reply: "Envoyer la réponse", updateStatus: "Mettre à jour le statut", retryEmailDelivery: "Relancer la livraison email", retryEmailDeliveryTitle: "Relancer cette livraison email ?", retryEmailDeliveryBody: "Une nouvelle tentative email prioritaire sera créée à partir du log de livraison en échec.", retryDeadLetter: "Relancer le dead-letter", retryDeadLetterTitle: "Relancer cet email dead-letter ?", retryDeadLetterBody: "Un nouveau job de file email sera créé à partir de la charge utile actuellement en dead-letter.", suspendUser: "Suspendre l'utilisateur", reactivateUser: "Réactiver l'utilisateur", paymentReview: "Revue paiement", payoutDetail: "Détail versement", disputeDetail: "Détail litige", shipmentDetail: "Détail expédition", resolveDispute: "Résoudre le litige", createRefund: "Créer le remboursement", resolveNoRefundTitle: "Résoudre sans remboursement ?", resolveNoRefundBody: "Cela clôturera le litige en conservant le résultat financier actuel.", resolveWithRefundTitle: "Résoudre avec remboursement ?", resolveWithRefundBody: "Cela déclenchera le flux de remboursement et clôturera le litige avec une issue remboursée.", saveSettingTitle: "Enregistrer ce paramètre ?", saveSettingBody: "Cela écrit directement dans le magasin de paramètres audité et affecte le comportement futur de la plateforme.", saveSetting: "Enregistrer le paramètre" },
    enums: { adminRoles: { super_admin: "Super admin", ops_admin: "Admin opérations" }, userRoles: { shipper: "Chargeur", carrier: "Transporteur", admin: "Admin" }, activity: { active: "Actif", inactive: "Inactif", suspended: "Suspendu" }, verification: { pending: "En revue", verified: "Vérifié", rejected: "Rejeté", incomplete: "Incomplet" }, invitations: { pending: "En attente", accepted: "Acceptée", revoked: "Révoquée", expired: "Expirée" }, supportStatus: { open: "Ouvert", in_progress: "En cours", waiting_for_user: "En attente utilisateur", resolved: "Résolu", closed: "Fermé" }, supportPriority: { normal: "Normale", high: "Haute", urgent: "Urgente" }, payment: { pending: "En attente", unpaid: "Non payé", submitted: "Soumise", proof_submitted: "Preuve soumise", under_review: "En revue", under_verification: "En vérification", rejected: "Rejetée", secured: "Sécurisée", refunded: "Remboursé", released: "Versée", released_to_carrier: "Versée au transporteur" }, booking: { pending: "En attente", pending_payment: "En attente de paiement", payment_under_review: "Paiement en revue", confirmed: "Confirmé", picked_up: "Ramassé", in_transit: "En transit", delivered_pending_review: "Livré en attente de revue", completed: "Terminé", canceled: "Annulé", cancelled: "Annulé", disputed: "En litige" }, shipment: { draft: "Brouillon", booked: "Réservée", cancelled: "Annulée", canceled: "Annulée" }, dispute: { open: "Ouvert", resolved: "Résolu", refunded: "Remboursé", closed: "Fermé" }, payout: { pending: "En attente", released: "Versé", sent: "Envoyé", failed: "Échoué", processing: "En cours", cancelled: "Annulé", canceled: "Annulé" }, entity: { profile: "Profil", vehicle: "Véhicule" }, sender: { user: "Utilisateur", admin: "Admin", system: "Système" }, email: { delivered: "Livré", soft_failed: "Échec temporaire", failed: "Échoué", dead_letter: "Dead-letter" }, locale: { ar: "Arabe", fr: "Français", en: "Anglais" }, document: { driver_identity_or_license: "Permis de conduire", truck_registration: "Carte grise", truck_insurance: "Assurance véhicule", truck_technical_inspection: "Contrôle technique", transport_license: "Licence de transport" } },
  },
  en: {
    pages: { admins: { eyebrow: "Admins", title: "Active admin accounts", listBody: "Compact admin roster showing role, status, and latest activity, with detail pages handling the actual governance work.", detailBody: "Balanced admin workspace for account state, invitation history, and audit context without wasting the page on oversized forms.", accountOverview: "Admin account overview", accountOverviewBody: "Use this summary to confirm the account state before changing role access or disabling console access.", invitations: "Admin invitation history", invitationHistoryBody: "Review all invitations associated with this account, their status, and whether they are still usable.", governanceActions: "Governance actions", governanceActionsBody: "Use these actions to update admin role or remove access, with every change captured in audit logs.", inviteTitle: "Invite a new admin", inviteBody: "Admins are created by invitation only. The raw token is shown once here so it can be delivered through a secure internal channel.", invitationCreatedFor: "Invitation created for {email}", invitationMeta: "Role {role} • expires {date}", accountMeta: "Invited by {actor} • updated {date}", notFound: "Admin account not found." }, audit: { eyebrow: "Audit & health", title: "Operational audit and delivery health", body: "This page tracks operational audit history plus the transactional email pipeline only. Account-confirmation and password-reset emails remain managed by Supabase Auth outside these logs.", auditTrail: "Admin audit trail", auditTrailBody: "Every sensitive admin action is recorded here so operators can reconstruct what changed and why.", emailLogs: "Email delivery logs", emailLogsBody: "These logs cover transactional mail flowing through FleetFill outbox jobs, dispatch workers, and provider webhooks, not Supabase Auth email.", deadLetters: "Dead-letter backlog", deadLettersBody: "Retry transactional email or push jobs from here after they exhaust their automatic delivery attempts." }, payments: { eyebrow: "Payments", title: "Payment-proof review queue", notFound: "Payment detail not found.", actions: "Payment actions", preview: "Proof preview" }, verification: { eyebrow: "Verification", title: "Carrier packet review", notFound: "Verification packet not found.", actions: "Verification actions", preview: "Latest document preview", packetDocs: "Documents in packet" }, disputes: { eyebrow: "Disputes", title: "Open dispute queue", notFound: "Dispute detail not found.", actions: "Dispute actions", preview: "Evidence preview" }, payouts: { eyebrow: "Payouts", title: "Carrier payout operations", notFound: "Payout detail not found.", actions: "Payout actions", account: "Active payout account" }, support: { eyebrow: "Support", title: "Support inbox", notFound: "Support thread not found.", actions: "Support actions", conversation: "Conversation" }, users: { eyebrow: "Users", title: "User operations and lifecycle", listBody: "Compact roster of account state, verification, and recent activity, with the detail page reserved for deeper review or lifecycle actions.", searchPlaceholder: "Search by name, email, phone, or profile ID", userLabel: "User", bookingsLabel: "bookings", notFound: "User detail not found.", controls: "Account controls" }, bookings: { eyebrow: "Bookings", notFound: "Booking detail not found.", linkedOps: "Linked operations", references: "References" }, settings: { eyebrow: "Settings", title: "Runtime platform controls" }, shipments: { eyebrow: "Shipments", notFound: "Shipment detail not found.", routeContext: "Route context", linkedEntities: "Linked entities", linkedBooking: "Linked booking", noBookingYet: "No booking has been created yet for this shipment.", shipperProfile: "Shipper profile" }, userDetail: { profileAndVerification: "Profile and verification", vehicles: "Vehicles", payoutAccounts: "Payout accounts", recentShipments: "Recent shipments", recentBookings: "Recent bookings", supportThreads: "Support threads", verificationDocuments: "Verification documents", noVehicles: "No vehicles linked to this user.", noPayoutAccounts: "No payout accounts on file.", noShipments: "No shipments created by this user.", noBookings: "No bookings linked to this user.", noSupportThreads: "No support threads for this user.", noVerificationDocuments: "No verification documents for this user." } },
    labels: { role: "Role", adminAccount: "Admin account", state: "State", email: "Email", updated: "Updated", context: "Context", operationalContext: "Operational context", request: "Request", priority: "Priority", linkedBooking: "Linked booking", workflow: "Workflow", readState: "Read state", latestMessage: "Latest message", latestActivity: "Latest activity", amount: "Amount", age: "Age", subject: "Subject", reason: "Reason", verification: "Verification", accountState: "Account state", preferredLocale: "Preferred locale", carrier: "Carrier", documents: "Documents", queue: "Queue", timeline: "Timeline", current: "Current", none: "None", allRoles: "All roles", allAccountStates: "All account states", allVerificationStates: "All verification states", unknown: "Unknown", notApplicable: "Not applicable", noNote: "No note", noReasonProvided: "No reason provided", noProviderMessage: "No provider message", noSignedPreview: "No signed preview is available yet.", previewUnavailable: "Inline preview is not available for this file type.", openFile: "Open file", noTimeline: "No timeline events are available yet.", new: "New", seen: "Seen", noLinkedEntity: "No linked entity", profileDocsComplete: "Profile docs complete", vehicleDocsComplete: "Vehicle docs complete", noVehiclesYet: "No vehicles yet", noTransferNote: "No transfer note", noInstitution: "No institution name", noExternalReference: "No external reference", noSubmittedReference: "No submitted reference", booking: "Booking", bookingState: "Booking state", paymentState: "Payment state", shipperTotal: "Shipper total", carrierPayout: "Carrier payout", created: "Created", weight: "Weight", volume: "Volume", noActivePayoutAccount: "No active payout account is available for this carrier.", resolutionNote: "Resolution note", refundAmount: "Refund amount (DZD)", refundReason: "Refund reason", externalReference: "External reference", evidenceItems: "Evidence items", missingOrBlocked: "Missing / blocked", vehiclesSummary: "{count} vehicles", noCarrierPacketsWaiting: "No carrier packets are waiting on review.", noCarrierPacketsWaitingBody: "When a carrier uploads or resubmits verification documents, the packet will appear here." },
    actions: { confirm: "Confirm", cancel: "Cancel", openDetail: "Open detail", working: "Working...", retry: "Retry", revoke: "Revoke invitation", revokeTitle: "Revoke this invitation?", revokeBody: "The invite token will stop working immediately and the invitation will be marked as revoked.", revokeReason: "Revoked from admin console", createInvitation: "Create invitation", creatingInvitation: "Creating invitation...", copyToken: "Copy token", expiryHours: "Expiry (hours)", viewAccount: "Open detail", changeRole: "Change role", changeRoleBody: "Use this when the account needs a durable change in admin permission level.", changeRoleTitle: "Confirm role change?", changeRoleConfirmBody: "This admin role will be updated immediately and the reason will be recorded in the audit trail.", updateRole: "Update role", deactivateAdmin: "Deactivate admin", reactivateAdmin: "Reactivate admin", deactivateAdminBody: "Disable console access until another super admin restores this account.", reactivateAdminBody: "Restore console access after review or an operational hold.", deactivateAdminTitle: "Deactivate this admin?", deactivateAdminConfirmBody: "This account will immediately lose access to the admin console until it is reactivated.", reactivateAdminTitle: "Reactivate this admin?", reactivateAdminConfirmBody: "This account will immediately regain access to the admin console.", suspendBody: "Use this when the account should be blocked from platform activity until an operator resolves the issue.", reactivateBody: "Use this to restore account access after a suspension or moderation hold.", suspendTitle: "Suspend this user?", suspendConfirmBody: "This will block the account from normal app access until an admin reactivates it.", reactivateTitle: "Reactivate this user?", reactivateConfirmBody: "This will restore the account and allow the user back into the platform.", approveProof: "Approve proof", rejectProof: "Reject proof", verifiedAmount: "Verified amount (DZD)", verifiedReference: "Verified reference", decisionNote: "Decision note", rejectionReason: "Rejection reason", approveTitle: "Approve payment proof?", approveBody: "This will verify the payment proof and unblock the secured payment state for the booking.", rejectTitle: "Reject payment proof?", rejectBody: "This will reject the submitted proof and push the booking back into payment resubmission flow.", approvePacket: "Approve packet", approvePacketBody: "Use this when the full driver and vehicle packet is complete and ready to verify in one action.", document: "Document", decision: "Decision", approveDocument: "Approve document", rejectDocument: "Reject document", reasonRequired: "Reason (required on rejection)", approvePacketTitle: "Approve the full verification packet?", approvePacketConfirmBody: "This will mark the packet approved and send the approval notification when it becomes fully verified.", submitReviewTitle: "Submit document review?", submitReviewBody: "This will update the document review state immediately and refresh the carrier packet.", reviewDocument: "Review document", resolveWithoutRefund: "Resolve without refund", issueRefund: "Issue refund", releasePayout: "Release payout", replyLabel: "Reply", sendReplyTitle: "Send admin reply?", sendReplyBody: "This will post your reply into the support thread and notify the user.", updateStatusTitle: "Update support status?", updateStatusBody: "This will change the support workflow state and priority for the thread.", reply: "Send reply", updateStatus: "Update status", retryEmailDelivery: "Retry email delivery", retryEmailDeliveryTitle: "Retry this email delivery?", retryEmailDeliveryBody: "This queues a fresh high-priority email job from the failed delivery log.", retryDeadLetter: "Retry dead-letter email", retryDeadLetterTitle: "Retry this dead-letter email?", retryDeadLetterBody: "This creates a new queued email outbox job from the dead-letter payload.", suspendUser: "Suspend user", reactivateUser: "Reactivate user", paymentReview: "Payment review", payoutDetail: "Payout detail", disputeDetail: "Dispute detail", shipmentDetail: "Shipment detail", resolveDispute: "Resolve dispute", createRefund: "Create refund", resolveNoRefundTitle: "Resolve dispute without refund?", resolveNoRefundBody: "This will close the dispute and preserve the current financial outcome.", resolveWithRefundTitle: "Resolve dispute with refund?", resolveWithRefundBody: "This will create the refund workflow and close the dispute with a refund outcome.", saveSettingTitle: "Save platform setting?", saveSettingBody: "This writes directly to the audited runtime settings store and takes effect for future platform behavior.", saveSetting: "Save setting" },
    enums: { adminRoles: { super_admin: "Super admin", ops_admin: "Ops admin" }, userRoles: { shipper: "Shipper", carrier: "Carrier", admin: "Admin" }, activity: { active: "Active", inactive: "Inactive", suspended: "Suspended" }, verification: { pending: "Pending review", verified: "Verified", rejected: "Rejected", incomplete: "Incomplete" }, invitations: { pending: "Pending", accepted: "Accepted", revoked: "Revoked", expired: "Expired" }, supportStatus: { open: "Open", in_progress: "In progress", waiting_for_user: "Waiting for user", resolved: "Resolved", closed: "Closed" }, supportPriority: { normal: "Normal", high: "High", urgent: "Urgent" }, payment: { pending: "Pending", unpaid: "Unpaid", submitted: "Submitted", proof_submitted: "Proof submitted", under_review: "Under review", under_verification: "Under verification", rejected: "Rejected", secured: "Secured", refunded: "Refunded", released: "Released", released_to_carrier: "Released to carrier" }, booking: { pending: "Pending", pending_payment: "Pending payment", payment_under_review: "Payment under review", confirmed: "Confirmed", picked_up: "Picked up", in_transit: "In transit", delivered_pending_review: "Delivered, pending review", completed: "Completed", canceled: "Canceled", cancelled: "Cancelled", disputed: "Disputed" }, shipment: { draft: "Draft", booked: "Booked", cancelled: "Cancelled", canceled: "Canceled" }, dispute: { open: "Open", resolved: "Resolved", refunded: "Refunded", closed: "Closed" }, payout: { pending: "Pending", released: "Released", sent: "Sent", failed: "Failed", processing: "Processing", cancelled: "Cancelled", canceled: "Canceled" }, entity: { profile: "Profile", vehicle: "Vehicle" }, sender: { user: "User", admin: "Admin", system: "System" }, email: { delivered: "Delivered", soft_failed: "Soft failed", failed: "Failed", dead_letter: "Dead letter" }, locale: { ar: "Arabic", fr: "French", en: "English" }, document: { driver_identity_or_license: "Driver's license", truck_registration: "Vehicle registration card", truck_insurance: "Vehicle insurance", truck_technical_inspection: "Technical inspection", transport_license: "Transport license" } },
  },
} as const;

const detailCopy = {
  ar: {
    bookings: {
      description:
        "مساحة العمل المرجعية للحجز داخل لوحة التحكم، تجمع سياق الشحنة والدفع والنزاع والتحويل في مكان واحد.",
      bookingStateLabel: "حالة الحجز",
      paymentStateLabel: "حالة الدفع",
      shipperTotalLabel: "إجمالي الشاحن",
      carrierPayoutLabel: "مستحقّ الناقل",
      paymentProofCount: "{count} إثباتات دفع",
      disputeBadge: "النزاع {state}",
      payoutBadge: "التحويل {state}",
      shipmentSummary: "الشحنة {origin} -> {destination}",
      paymentReference: "مرجع الدفع {reference}",
      createdAt: "أُنشئ في {date}",
    },
    payments: {
      title: "مراجعة إثبات الحجز {trackingNumber}",
      description:
        "راجِع أحدث إثبات دفع تم رفعه مقابل إجماليات الحجز المتوقَّعة، ثم اعتمِد الإثبات أو ارفضه عبر إجراءات الدفع الخاضعة للتدقيق.",
      submittedAmountLabel: "المبلغ المُرسَل",
      expectedTotalLabel: "الإجمالي المتوقَّع",
      proofLabel: "{rail} – إثبات",
      submittedTitle: "تم رفع الإثبات",
      paymentActionsBody:
        "يستدعي كلّ قرار في هذا القسم إجراءات مراجعة إثباتات الدفع ذاتها الخاضعة للتدقيق في المنصة.",
    },
    verification: {
      title: "ملف التحقُّق للناقل {name}",
      description:
        "راجِع ملف السائق والمركبة الموحَّد، واطّلع على أحدث المرفوعات، ثم اعتمِد الملف بالكامل أو راجِع المستندات فرديًّا عبر مسارات التشغيل الموثَّقة.",
      carrierIdLabel: "معرِّف الناقل",
      profileStateLabel: "حالة الملف",
      packetDocumentsLabel: "عدد المستندات",
      packetActionsBody:
        "اعتمِد الملف عندما يكون مكتملًا، أو راجِع المستندات فرديًّا إذا استلزم الأمر تصحيحًا أو رفضًا مُسبَّبًا.",
      packetDocumentStatus: "{entity} · {date}",
    },
    disputes: {
      description:
        "راجِع سبب النزاع والأدلة المرتبطة وسجلّ الاسترداد قبل تسوية الحالة باسترداد أو من دونه.",
      bookingLabel: "الحجز",
      disputeStateLabel: "حالة النزاع",
      evidenceItemsLabel: "عدد الأدلة",
      opened: "تم فتح النزاع",
      refundEntry: "استرداد {state}",
    },
    payouts: {
      title: "صرف التحويل للحجز {trackingNumber}",
      description: "تحقَّق من حساب التحويل وحالة الصرف قبل إنشاء سجلّ التحويل الخاص بالحجز.",
      payoutState: "حالة التحويل الحالية",
      notReleased: "لم يُصرَف بعد",
      payoutEntry: "التحويل {state}",
    },
    shipments: {
      eyebrow: "الشحنات",
      notFound: "لم يُعثَر على تفاصيل الشحنة.",
      description: "مساحة العمل المرجعية للشحنة داخل لوحة التحكم، تُستخدَم للتدقيق التشغيلي والبحث العابر للطوابير.",
      weightLabel: "الوزن",
      volumeLabel: "الحجم",
      createdLabel: "تاريخ الإنشاء",
      routeContext: "سياق المسار",
      linkedEntities: "الكيانات المرتبطة",
      linkedBooking: "الحجز المرتبط",
      noBookingYet: "لم يُنشأ حجز لهذه الشحنة بعد.",
      shipperProfile: "ملف الشاحن",
    },
    users: {
      description:
        "سياق تشغيلي شامل للمستخدم يتضمّن التحقُّق والمستندات وآخر الحجوزات والشحنات وإجراءات دورة حياة الحساب.",
      controls: "ضوابط الحساب",
      profileAndVerification: "الملف الشخصي والتحقُّق",
      vehicles: "المركبات",
      payoutAccounts: "حسابات التحويل",
      recentShipments: "أحدث الشحنات",
      recentBookings: "أحدث الحجوزات",
      supportThreads: "محادثات الدعم",
      verificationDocuments: "مستندات التحقُّق",
      noVehicles: "لا توجد مركبات مرتبطة بهذا المستخدم.",
      noPayoutAccounts: "لا توجد حسابات تحويل مسجَّلة.",
      noShipments: "لا توجد شحنات أنشأها هذا المستخدم.",
      noBookings: "لا توجد حجوزات مرتبطة بهذا المستخدم.",
      noSupportThreads: "لا توجد محادثات دعم لهذا المستخدم.",
      noVerificationDocuments: "لا توجد مستندات تحقُّق لهذا المستخدم.",
    },
    settings: {
      description:
        "تتحكم هذه الإعدادات في سياسات التشغيل داخل التطبيق، وحواجز التسعير، واللغات، وعناصر الأمان التشغيلي.",
      runtimeTitle: "سياسة التشغيل",
      runtimeBody: "يؤثِّر وضع الصيانة والحدّ الأدنى لإصدارات التطبيق المدعومة تأثيرًا مباشرًا في جاهزية المنصة.",
      pricingTitle: "حواجز التسعير",
      pricingBody: "تحدِّد هذه القيم مكوِّنات التسعير ومهلة إعادة إرسال إثباتات الدفع للحجوزات الجديدة.",
      reviewTitle: "مراجعة التسليم",
      reviewBody: "تحدِّد نافذة السماح متى تصبح الحجوزات المُسلَّمة متأخرة عن المراجعة التشغيلية.",
      featureTitle: "الرايات التشغيلية",
      featureBody: "احتفِظ بهذه الرايات صغيرة وواضحة الأثر التشغيلي، ولا تستخدمها كمستودع لمنطق المنتج.",
      localizationTitle: "سياسة اللغات",
      localizationBody: "تتحكم هذه القيم في اللغة الافتراضية واللغات المُفعَّلة عبر المنصة.",
      maintenanceMode: "وضع الصيانة",
      forceUpdateRequired: "إلزام التحديث",
      minimumAndroidVersion: "الحدّ الأدنى لإصدار Android",
      minimumIosVersion: "الحدّ الأدنى لإصدار iOS",
      saveRuntimePolicy: "حفظ سياسة التشغيل",
      platformFeeRate: "نسبة عمولة المنصة",
      carrierFeeRate: "نسبة عمولة الناقل",
      insuranceRate: "نسبة التأمين",
      insuranceMinFee: "الحدّ الأدنى لرسوم التأمين (دج)",
      taxRate: "نسبة الضريبة",
      paymentResubmissionDeadline: "مهلة إعادة إرسال الدفع (بالساعات)",
      savePricingPolicy: "حفظ سياسة التسعير",
      graceWindow: "نافذة السماح (بالساعات)",
      saveReviewPolicy: "حفظ سياسة المراجعة",
      adminEmailResendEnabled: "تفعيل إعادة إرسال البريد من لوحة التحكم",
      saveFeatureFlags: "حفظ الرايات التشغيلية",
      fallbackLocale: "اللغة الافتراضية",
      enabledLocales: "اللغات المُفعَّلة",
      saveLocalizationPolicy: "حفظ سياسة اللغات",
      superAdminOnly:
        "إعدادات التشغيل مرئية لمشرفي العمليات، لكن تعديلها محصور بالمشرف العام.",
    },
  },
  fr: {
    bookings: {
      description:
        "Espace de travail canonique du booking reliant expédition, paiement, litige et versement.",
      bookingStateLabel: "État booking",
      paymentStateLabel: "État paiement",
      shipperTotalLabel: "Total chargeur",
      carrierPayoutLabel: "Versement transporteur",
      paymentProofCount: "{count} preuves de paiement",
      disputeBadge: "Litige {state}",
      payoutBadge: "Versement {state}",
      shipmentSummary: "Expedition {origin} -> {destination}",
      paymentReference: "Reference paiement {reference}",
      createdAt: "Créé le {date}",
    },
    payments: {
      title: "Revue de preuve pour le booking {trackingNumber}",
      description:
        "Revoyez la dernière preuve de paiement soumise face aux totaux attendus du booking, puis approuvez ou rejetez via les workflows admin audités.",
      submittedAmountLabel: "Montant soumis",
      expectedTotalLabel: "Total attendu",
      proofLabel: "Preuve {rail}",
      submittedTitle: "Preuve soumise",
      paymentActionsBody:
        "Toutes les décisions de ce panneau appellent les mêmes RPC audités de revue des preuves de paiement.",
    },
    verification: {
      title: "Dossier de verification pour {name}",
      description:
        "Revoyez le dossier unifié chauffeur + véhicule, prévisualisez les derniers uploads, puis approuvez le dossier complet ou des documents individuels via les workflows backend audités.",
      carrierIdLabel: "ID transporteur",
      profileStateLabel: "État du profil",
      packetDocumentsLabel: "Documents",
      packetActionsBody:
        "Approuvez le dossier quand tout est conforme, ou revoyez les documents individuels si une correction ou un rejet est nécessaire.",
      packetDocumentStatus: "{entity} • {date}",
    },
    disputes: {
      description:
        "Revoyez motif, preuves et historique des remboursements avant de clôturer le litige avec ou sans remboursement.",
      bookingLabel: "Booking",
      disputeStateLabel: "État litige",
      evidenceItemsLabel: "Pièces de preuve",
      opened: "Litige ouvert",
      refundEntry: "Remboursement {state}",
    },
    payouts: {
      title: "Versement du booking {trackingNumber}",
      description: "Confirmez le compte de versement et l'état de release avant de créer le versement du booking.",
      payoutState: "État actuel du versement",
      notReleased: "Pas encore versé",
      payoutEntry: "Versement {state}",
    },
    shipments: {
      eyebrow: "Expeditions",
      notFound: "Detail expedition introuvable.",
      description: "Espace canonique de l'expédition pour les contrôles opératoires et le passage inter-files.",
      weightLabel: "Poids",
      volumeLabel: "Volume",
      createdLabel: "Créé le",
      routeContext: "Contexte de trajet",
      linkedEntities: "Entites liees",
      linkedBooking: "Booking lie",
      noBookingYet: "Aucun booking n'a encore été créé pour cette expédition.",
      shipperProfile: "Profil chargeur",
    },
    users: {
      description:
        "Contexte utilisateur complet avec vérification, documents, derniers bookings et actions de cycle de vie du compte.",
      controls: "Contrôle du compte",
      profileAndVerification: "Profil et vérification",
      vehicles: "Véhicules",
      payoutAccounts: "Comptes de versement",
      recentShipments: "Expéditions récentes",
      recentBookings: "Bookings récents",
      supportThreads: "Fils support",
      verificationDocuments: "Documents de vérification",
      noVehicles: "Aucun véhicule lié à cet utilisateur.",
      noPayoutAccounts: "Aucun compte de versement enregistré.",
      noShipments: "Aucune expédition créée par cet utilisateur.",
      noBookings: "Aucun booking lié à cet utilisateur.",
      noSupportThreads: "Aucun fil support pour cet utilisateur.",
      noVerificationDocuments: "Aucun document de vérification pour cet utilisateur.",
    },
    settings: {
      description:
        "Ces réglages pilotent la politique runtime mobile, les garde-fous tarifaires, la localisation et la sécurité opérationnelle.",
      runtimeTitle: "Politique runtime",
      runtimeBody: "Le mode maintenance et les versions mobiles minimales ont l'impact le plus fort sur la disponibilité plateforme.",
      pricingTitle: "Garde-fous tarifaires",
      pricingBody: "Ces valeurs pilotent la composition du prix et les délais de resoumission des preuves de paiement.",
      reviewTitle: "Revue livraison",
      reviewBody: "La fenêtre de grâce détermine quand les bookings livrés deviennent en retard de revue opérationnelle.",
      featureTitle: "Flags opérationnels",
      featureBody: "Gardez ces flags petits et utiles pour l'exploitation, pas comme dépôt de logique produit.",
      localizationTitle: "Politique de localisation",
      localizationBody: "Ces valeurs contrôlent la langue de repli et les langues actives de la plateforme.",
      maintenanceMode: "Mode maintenance",
      forceUpdateRequired: "Mise à jour obligatoire",
      minimumAndroidVersion: "Version Android minimale",
      minimumIosVersion: "Version iOS minimale",
      saveRuntimePolicy: "Enregistrer la politique runtime",
      platformFeeRate: "Taux de frais plateforme",
      carrierFeeRate: "Taux de frais transporteur",
      insuranceRate: "Taux d'assurance",
      insuranceMinFee: "Frais minimum assurance (DZD)",
      taxRate: "Taux de taxe",
      paymentResubmissionDeadline: "Délai de resoumission paiement (heures)",
      savePricingPolicy: "Enregistrer la politique tarifaire",
      graceWindow: "Fenêtre de grâce (heures)",
      saveReviewPolicy: "Enregistrer la politique de revue",
      adminEmailResendEnabled: "Activer le renvoi email admin",
      saveFeatureFlags: "Enregistrer les flags",
      fallbackLocale: "Langue de repli",
      enabledLocales: "Langues actives",
      saveLocalizationPolicy: "Enregistrer la politique de localisation",
      superAdminOnly:
        "Les réglages runtime sont visibles pour les ops admins, mais seuls les super admins peuvent les modifier.",
    },
  },
  en: {
    bookings: {
      description:
        "Canonical booking workspace that ties shipment, payment, dispute, and payout context together for operators.",
      bookingStateLabel: "Booking state",
      paymentStateLabel: "Payment state",
      shipperTotalLabel: "Shipper total",
      carrierPayoutLabel: "Carrier payout",
      paymentProofCount: "{count} payment proofs",
      disputeBadge: "Dispute {state}",
      payoutBadge: "Payout {state}",
      shipmentSummary: "Shipment {origin} -> {destination}",
      paymentReference: "Payment reference {reference}",
      createdAt: "Created {date}",
    },
    payments: {
      title: "Proof review for {trackingNumber}",
      description:
        "Review the latest submitted payment proof against the expected booking totals, then approve or reject using the controlled admin workflows.",
      submittedAmountLabel: "Submitted amount",
      expectedTotalLabel: "Expected total",
      proofLabel: "{rail} proof",
      submittedTitle: "Proof submitted",
      paymentActionsBody:
        "All decisions here call the same audited payment-proof RPCs used by the platform.",
    },
    verification: {
      title: "Verification packet for {name}",
      description:
        "Review the unified driver and vehicle packet, preview the latest uploads, and approve the packet or individual documents using audited backend workflows.",
      carrierIdLabel: "Carrier ID",
      profileStateLabel: "Profile state",
      packetDocumentsLabel: "Documents",
      packetActionsBody:
        "Approve the packet when everything is in order, or review individual documents when a correction or rejection is needed.",
      packetDocumentStatus: "{entity} • {date}",
    },
    disputes: {
      description:
        "Review the dispute reason, evidence, and refund history before resolving the dispute with or without a refund.",
      bookingLabel: "Booking",
      disputeStateLabel: "Dispute state",
      evidenceItemsLabel: "Evidence items",
      opened: "Dispute opened",
      refundEntry: "Refund {state}",
    },
    payouts: {
      title: "Payout release for {trackingNumber}",
      description: "Confirm the carrier payout account and release state before creating the payout record for the booking.",
      payoutState: "Current payout",
      notReleased: "Not released",
      payoutEntry: "Payout {state}",
    },
    shipments: {
      eyebrow: "Shipments",
      notFound: "Shipment detail not found.",
      description: "Canonical shipment workspace for admin search and operational cross-checks.",
      weightLabel: "Weight",
      volumeLabel: "Volume",
      createdLabel: "Created",
      routeContext: "Route context",
      linkedEntities: "Linked entities",
      linkedBooking: "Linked booking",
      noBookingYet: "No booking has been created yet for this shipment.",
      shipperProfile: "Shipper profile",
    },
    users: {
      description:
        "Operational user context, verification artifacts, recent bookings, and controlled account lifecycle actions.",
      controls: "Account controls",
      profileAndVerification: "Profile and verification",
      vehicles: "Vehicles",
      payoutAccounts: "Payout accounts",
      recentShipments: "Recent shipments",
      recentBookings: "Recent bookings",
      supportThreads: "Support threads",
      verificationDocuments: "Verification documents",
      noVehicles: "No vehicles linked to this user.",
      noPayoutAccounts: "No payout accounts on file.",
      noShipments: "No shipments created by this user.",
      noBookings: "No bookings linked to this user.",
      noSupportThreads: "No support threads for this user.",
      noVerificationDocuments: "No verification documents for this user.",
    },
    settings: {
      description:
        "These settings control mobile runtime policy, pricing guardrails, localization, and operational safety flags.",
      runtimeTitle: "Runtime policy",
      runtimeBody: "Maintenance mode and minimum supported mobile versions are the highest-impact platform controls.",
      pricingTitle: "Pricing guardrails",
      pricingBody: "These values shape price composition and payment review deadlines for all new bookings.",
      reviewTitle: "Delivery review",
      reviewBody: "The grace window determines when delivered bookings become overdue for operational review.",
      featureTitle: "Feature flags",
      featureBody: "Keep these small and operationally meaningful. This is not a dumping ground for product logic.",
      localizationTitle: "Localization policy",
      localizationBody: "These values control the fallback locale and the set of enabled locales used across the platform.",
      maintenanceMode: "Maintenance mode",
      forceUpdateRequired: "Force update required",
      minimumAndroidVersion: "Minimum Android version",
      minimumIosVersion: "Minimum iOS version",
      saveRuntimePolicy: "Save runtime policy",
      platformFeeRate: "Platform fee rate",
      carrierFeeRate: "Carrier fee rate",
      insuranceRate: "Insurance rate",
      insuranceMinFee: "Insurance min fee (DZD)",
      taxRate: "Tax rate",
      paymentResubmissionDeadline: "Payment resubmission deadline (hours)",
      savePricingPolicy: "Save pricing policy",
      graceWindow: "Grace window (hours)",
      saveReviewPolicy: "Save review policy",
      adminEmailResendEnabled: "Enable admin email resend actions",
      saveFeatureFlags: "Save feature flags",
      fallbackLocale: "Fallback locale",
      enabledLocales: "Enabled locales",
      saveLocalizationPolicy: "Save localization policy",
      superAdminOnly:
        "Runtime settings are visible to ops admins, but only super admins can change them.",
    },
  },
} as const;

const actionLabels = {
  ar: {
    admin_account_activated: "أُعيد تفعيل الحساب الإداري",
    admin_invitation_created: "أُنشئت دعوة إدارية",
    admin_invitation_accepted: "قُبِلت الدعوة الإدارية",
    admin_invitation_revoked: "أُلغيت الدعوة الإدارية",
    admin_bootstrap_completed: "اكتملت تهيئة المشرف الأول",
    admin_role_updated: "حُدِّث الدور الإداري",
    admin_account_deactivated: "عُطِّل الحساب الإداري",
    admin_account_reactivated: "أُعيد تفعيل الحساب الإداري",
    admin_profile_suspended: "عُلِّق الحساب",
    admin_profile_reactivated: "أُعيد تفعيل الحساب",
    payment_proof_approved: "اعتُمِد إثبات الدفع",
    payment_proof_rejected: "رُفِض إثبات الدفع",
    admin_payment_proof_approved: "اعتُمِد إثبات الدفع",
    admin_payment_proof_rejected: "رُفِض إثبات الدفع",
    verification_packet_approved: "اعتُمِد ملف التحقُّق",
    verification_document_approved: "اعتُمِد مستند التحقُّق",
    verification_document_rejected: "رُفِض مستند التحقُّق",
    admin_verification_packet_approved: "اعتُمِد ملف التحقُّق",
    admin_verification_document_reviewed: "رُوجِع مستند التحقُّق",
    dispute_resolved_complete: "سُوِّي النزاع دون استرداد",
    dispute_resolved_refund: "سُوِّي النزاع مع استرداد",
    admin_dispute_resolved: "سُوِّي النزاع",
    payout_released: "صُرِف التحويل",
    admin_payout_released: "صُرِف التحويل",
    support_request_replied: "أُرسِل ردّ على طلب الدعم",
    support_request_status_updated: "حُدِّثت حالة طلب الدعم",
    support_request_assigned: "عُيِّن طلب الدعم",
    admin_support_status_updated: "حُدِّثت حالة الدعم",
    admin_support_reply_sent: "أُرسِل ردّ إداري",
    platform_setting_updated: "حُدِّث إعداد المنصة",
    profile_suspended: "عُلِّق الحساب",
    profile_reactivated: "أُعيد تفعيل الحساب",
    email_delivery_resent: "أُعيد إرسال البريد الإلكتروني",
    dead_letter_email_resent: "أُعيدت محاولة إرسال الرسالة الميتة",
  },
  fr: {
    admin_account_activated: "Compte admin réactivé",
    admin_invitation_created: "Invitation admin créée",
    admin_invitation_accepted: "Invitation admin acceptée",
    admin_invitation_revoked: "Invitation admin révoquée",
    admin_bootstrap_completed: "Amorçage du premier admin terminé",
    admin_role_updated: "Rôle admin mis à jour",
    admin_account_deactivated: "Compte admin désactivé",
    admin_account_reactivated: "Compte admin réactivé",
    admin_profile_suspended: "Compte suspendu",
    admin_profile_reactivated: "Compte réactivé",
    payment_proof_approved: "Preuve de paiement approuvée",
    payment_proof_rejected: "Preuve de paiement rejetée",
    admin_payment_proof_approved: "Preuve de paiement approuvée",
    admin_payment_proof_rejected: "Preuve de paiement rejetée",
    verification_packet_approved: "Dossier de vérification approuvé",
    verification_document_approved: "Document de vérification approuvé",
    verification_document_rejected: "Document de vérification rejeté",
    admin_verification_packet_approved: "Dossier de vérification approuvé",
    admin_verification_document_reviewed: "Document de vérification revu",
    dispute_resolved_complete: "Litige résolu sans remboursement",
    dispute_resolved_refund: "Litige résolu avec remboursement",
    admin_dispute_resolved: "Litige résolu",
    payout_released: "Versement déclenché",
    admin_payout_released: "Versement déclenché",
    support_request_replied: "Réponse envoyée sur la demande support",
    support_request_status_updated: "Statut de la demande support mis à jour",
    support_request_assigned: "Demande support assignée",
    admin_support_status_updated: "Statut support mis à jour",
    admin_support_reply_sent: "Réponse admin envoyée",
    platform_setting_updated: "Paramètre plateforme mis à jour",
    profile_suspended: "Compte suspendu",
    profile_reactivated: "Compte réactivé",
    email_delivery_resent: "Email renvoyé",
    dead_letter_email_resent: "Email dead-letter relancé",
  },
  en: {
    admin_account_activated: "Admin account activated",
    admin_invitation_created: "Admin invitation created",
    admin_invitation_accepted: "Admin invitation accepted",
    admin_invitation_revoked: "Admin invitation revoked",
    admin_bootstrap_completed: "First admin bootstrap completed",
    admin_role_updated: "Admin role updated",
    admin_account_deactivated: "Admin account deactivated",
    admin_account_reactivated: "Admin account reactivated",
    admin_profile_suspended: "Account suspended",
    admin_profile_reactivated: "Account reactivated",
    payment_proof_approved: "Payment proof approved",
    payment_proof_rejected: "Payment proof rejected",
    admin_payment_proof_approved: "Payment proof approved",
    admin_payment_proof_rejected: "Payment proof rejected",
    verification_packet_approved: "Verification packet approved",
    verification_document_approved: "Verification document approved",
    verification_document_rejected: "Verification document rejected",
    admin_verification_packet_approved: "Verification packet approved",
    admin_verification_document_reviewed: "Verification document reviewed",
    dispute_resolved_complete: "Dispute resolved without refund",
    dispute_resolved_refund: "Dispute resolved with refund",
    admin_dispute_resolved: "Dispute resolved",
    payout_released: "Payout released",
    admin_payout_released: "Payout released",
    support_request_replied: "Support request replied to",
    support_request_status_updated: "Support request status updated",
    support_request_assigned: "Support request assigned",
    admin_support_status_updated: "Support status updated",
    admin_support_reply_sent: "Admin reply sent",
    platform_setting_updated: "Platform setting updated",
    profile_suspended: "Account suspended",
    profile_reactivated: "Account reactivated",
    email_delivery_resent: "Email delivery resent",
    dead_letter_email_resent: "Dead-letter email retried",
  },
} as const;

const supportLabels = {
  ar: {
    messageTitle: "رسالة من {sender}",
    loading: "جارٍ تحميل لوحة تحكم FleetFill…",
    globalErrorTitle: "واجهت لوحة التحكم خطأً غير قابل للاستعادة.",
    tryAgain: "إعادة المحاولة",
    notFoundTitle: "هذه الصفحة الإدارية غير موجودة.",
    notFoundBody: "تحقَّق من المسار أو ارجع إلى برج المراقبة.",
    routeErrorTitle: "تعذَّر تحميل هذا المسار الإداري.",
    routeRetry: "إعادة تحميل الصفحة",
    globalErrorEyebrow: "لوحة تحكم FleetFill",
    notFoundEyebrow: "لوحة تحكم FleetFill",
    reloadPageHint: "أعِد تحميل الصفحة أو حاول مرةً أخرى بعد لحظات.",
  },
  fr: {
    messageTitle: "Message {sender}",
    loading: "Chargement de la console FleetFill...",
    globalErrorTitle: "La console admin a rencontré une erreur irrécupérable.",
    tryAgain: "Réessayer",
    notFoundTitle: "Cette page admin n'existe pas.",
    notFoundBody: "Vérifiez l'URL ou revenez à la tour de contrôle.",
    routeErrorTitle: "Cette route admin n'a pas pu se charger.",
    routeRetry: "Recharger la page",
    globalErrorEyebrow: "Console FleetFill",
    notFoundEyebrow: "Console FleetFill",
    reloadPageHint: "Rechargez la page ou réessayez dans quelques instants.",
  },
  en: {
    messageTitle: "{sender} message",
    loading: "Loading FleetFill admin...",
    globalErrorTitle: "The admin console hit an unrecoverable error.",
    tryAgain: "Try again",
    notFoundTitle: "This admin page does not exist.",
    notFoundBody: "Check the route or go back to the control tower.",
    routeErrorTitle: "This admin route failed to load.",
    routeRetry: "Retry route",
    globalErrorEyebrow: "FleetFill Admin",
    notFoundEyebrow: "FleetFill Admin",
    reloadPageHint: "Please reload the page or try again in a moment.",
  },
} as const;

export function getAdminUi(locale: string | AppLocale) {
  return ui[localeOf(locale)];
}

export function formatTemplate(template: string, values: Record<string, string | number | null | undefined>) {
  return template.replace(/\{(\w+)\}/g, (_, key: string) => String(values[key] ?? ""));
}

export function getEnumLabel(locale: string | AppLocale, group: keyof (typeof ui)["en"]["enums"], value: string | null | undefined) {
  if (!value) {
    return getAdminUi(locale).labels.none;
  }
  const labels = getAdminUi(locale).enums[group] as Record<string, string>;
  return labels[value.toLowerCase()] ?? humanize(value);
}

const timelineEventLabels = {
  ar: {
    payment_proof_submitted: "تم إرسال إثبات الدفع",
    payment_under_review: "الدفع قيد المراجعة",
    confirmed: "مؤكد",
    picked_up: "تم الاستلام",
    in_transit: "في الطريق",
    delivered_pending_review: "تم التسليم وبانتظار المراجعة",
    completed: "مكتمل",
    canceled: "ملغى",
    cancelled: "ملغى",
    disputed: "متنازع عليه",
    payout_requested: "تم طلب المستحق",
    payout_released: "تم صرف مستحق الناقل",
    refund_processed: "تمت معالجة الاسترداد",
  },
  fr: {
    payment_proof_submitted: "Preuve de paiement soumise",
    payment_under_review: "Paiement en vérification",
    confirmed: "Confirmée",
    picked_up: "Ramassée",
    in_transit: "En transit",
    delivered_pending_review: "Livrée en attente de revue",
    completed: "Terminée",
    canceled: "Annulée",
    cancelled: "Annulée",
    disputed: "Contestée",
    payout_requested: "Versement demandé",
    payout_released: "Versement libéré",
    refund_processed: "Remboursement traité",
  },
  en: {
    payment_proof_submitted: "Payment proof submitted",
    payment_under_review: "Payment under review",
    confirmed: "Confirmed",
    picked_up: "Picked up",
    in_transit: "In transit",
    delivered_pending_review: "Delivered pending review",
    completed: "Completed",
    canceled: "Canceled",
    cancelled: "Cancelled",
    disputed: "Disputed",
    payout_requested: "Payout requested",
    payout_released: "Payout released",
    refund_processed: "Refund processed",
  },
} as const;

const payoutRequestLabels = {
  ar: {
    requested: "تم الطلب",
    fulfilled: "تم الصرف",
    cancelled: "ملغى",
    booking_not_completed: "لا يُفتَح طلب المستحقّ إلّا بعد اكتمال الحجز.",
    payment_not_secured: "يظلّ المستحقّ محجوبًا حتى يصبح الدفع مضمونًا.",
    open_dispute: "لا يمكن صرف المستحقّ في وجود نزاع مفتوح.",
    payout_account_required: "أضِف حساب تحويل نشطًا قبل طلب المستحقّ.",
    payout_already_released: "صُرِف المستحقّ لهذا الحجز بالفعل.",
    not_requested: "لم يُطلَب بعد",
  },
  fr: {
    requested: "Demandé",
    fulfilled: "Libéré",
    cancelled: "Annulé",
    booking_not_completed: "La demande de versement ne s'ouvre qu'une fois la réservation terminée.",
    payment_not_secured: "Le versement reste bloqué tant que le paiement n'est pas sécurisé.",
    open_dispute: "Le versement reste bloqué tant qu'un litige est ouvert.",
    payout_account_required: "Ajoutez un compte de versement actif avant de demander le versement.",
    payout_already_released: "Le versement a déjà été libéré pour cette réservation.",
    not_requested: "Pas encore demandé",
  },
  en: {
    requested: "Requested",
    fulfilled: "Released",
    cancelled: "Cancelled",
    booking_not_completed: "Payout requests open only after the booking is completed.",
    payment_not_secured: "Payout remains blocked until payment is secured.",
    open_dispute: "Payout is blocked while an open dispute exists.",
    payout_account_required: "Add an active payout account before requesting payout.",
    payout_already_released: "Payout has already been released for this booking.",
    not_requested: "Not requested",
  },
} as const;

const notificationTemplateLabels = {
  ar: {
    delivered_pending_review: "تم التسليم وبانتظار المراجعة",
    generated_document_available: "المستند المُنشأ أصبح جاهزًا",
    generated_document_ready: "المستند المُنشأ أصبح جاهزًا",
    payment_secured: "تم تأمين الدفع",
    payment_proof_received: "تم استلام إثبات الدفع",
    payment_proof_submitted: "تم إرسال إثبات الدفع",
    verification_packet_approved: "تم اعتماد ملف التحقق",
    booking_milestone_updated: "تم تحديث مرحلة الحجز",
    booking_milestone_updated_title: "تحديث في مرحلة الحجز",
    generated_document_ready_title: "المستند الجاهز",
    payment_secured_title: "تم تأمين الدفع",
    payment_proof_submitted_title: "تم إرسال إثبات الدفع",
    verification_packet_approved_title: "تم اعتماد ملف التحقق",
  },
  fr: {
    delivered_pending_review: "Livré en attente de revue",
    generated_document_available: "Document généré disponible",
    generated_document_ready: "Document généré prêt",
    payment_secured: "Paiement sécurisé",
    payment_proof_received: "Preuve de paiement reçue",
    payment_proof_submitted: "Preuve de paiement soumise",
    verification_packet_approved: "Dossier de vérification approuvé",
    booking_milestone_updated: "Étape du booking mise à jour",
    booking_milestone_updated_title: "Mise à jour d'étape du booking",
    generated_document_ready_title: "Document prêt",
    payment_secured_title: "Paiement sécurisé",
    payment_proof_submitted_title: "Preuve de paiement soumise",
    verification_packet_approved_title: "Dossier de vérification approuvé",
  },
  en: {
    delivered_pending_review: "Delivered pending review",
    generated_document_available: "Generated document available",
    generated_document_ready: "Generated document ready",
    payment_secured: "Payment secured",
    payment_proof_received: "Payment proof received",
    payment_proof_submitted: "Payment proof submitted",
    verification_packet_approved: "Verification packet approved",
    booking_milestone_updated: "Booking milestone updated",
    booking_milestone_updated_title: "Booking milestone updated",
    generated_document_ready_title: "Generated document ready",
    payment_secured_title: "Payment secured",
    payment_proof_submitted_title: "Payment proof submitted",
    verification_packet_approved_title: "Verification packet approved",
  },
} as const;

const healthErrorLabels = {
  ar: {
    unknown_push_error: "تعذَّر إرسال الإشعار بسبب خلل في إعدادات الإشعارات أو Firebase.",
    firebase_service_account_invalid: "إعداد حساب خدمة Firebase الخاص بالإشعارات غير صالح ويجب تصحيحه.",
  },
  fr: {
    unknown_push_error: "L'envoi push a échoué à cause de la configuration push ou Firebase.",
    firebase_service_account_invalid: "La configuration Firebase des notifications push est invalide et doit être corrigée.",
  },
  en: {
    unknown_push_error: "Push delivery failed because the push/Firebase configuration is invalid.",
    firebase_service_account_invalid: "The Firebase push service account is invalid and needs to be corrected.",
  },
} as const;

export function getTimelineEventLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return getAdminUi(locale).labels.none;
  }
  const language = localeOf(locale);
  return timelineEventLabels[language][value.toLowerCase() as keyof (typeof timelineEventLabels)["en"]] ?? humanize(value);
}

export function getPayoutRequestLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return payoutRequestLabels[localeOf(locale)].not_requested;
  }
  const language = localeOf(locale);
  return payoutRequestLabels[language][value.toLowerCase() as keyof (typeof payoutRequestLabels)["en"]] ?? humanize(value);
}

export function getPayoutRequestBlockedReasonLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return null;
  }
  const language = localeOf(locale);
  return payoutRequestLabels[language][value.toLowerCase() as keyof (typeof payoutRequestLabels)["en"]] ?? humanize(value);
}

export function getAdminRoleLabel(locale: string | AppLocale, value: string | null | undefined) {
  return getEnumLabel(locale, "adminRoles", value);
}

export function getDocumentLabel(locale: string | AppLocale, value: string | null | undefined) {
  return getEnumLabel(locale, "document", value);
}

export function getUserVerificationLabel(
  locale: string | AppLocale,
  role: string | null | undefined,
  value: string | null | undefined,
) {
  if (!role || role.toLowerCase() !== "carrier") {
    return getAdminUi(locale).labels.notApplicable;
  }
  return getEnumLabel(locale, "verification", value);
}

export function getAdminDetailCopy(locale: string | AppLocale) {
  return detailCopy[localeOf(locale)];
}

export function getAdminActionLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return getAdminUi(locale).labels.none;
  }
  return actionLabels[localeOf(locale)][value as keyof (typeof actionLabels)["en"]] ?? humanize(value);
}

export function getNotificationTemplateLabel(locale: string | AppLocale, value: string | null | undefined) {
  if (!value) {
    return getAdminUi(locale).labels.none;
  }
  const language = localeOf(locale);
  return notificationTemplateLabels[language][value.toLowerCase() as keyof (typeof notificationTemplateLabels)["en"]] ?? humanize(value);
}

export function getAuditHealthErrorLabel(
  locale: string | AppLocale,
  errorCode: string | null | undefined,
  errorMessage: string | null | undefined,
) {
  const language = localeOf(locale);
  const normalizedCode = errorCode?.toLowerCase() ?? "";
  const normalizedMessage = errorMessage?.toLowerCase() ?? "";

  if (normalizedMessage.includes("firebase_service_account_json is not valid json")) {
    return healthErrorLabels[language].firebase_service_account_invalid;
  }

  if (normalizedCode === "unknown_push_error") {
    return healthErrorLabels[language].unknown_push_error;
  }

  return errorMessage ?? errorCode ?? getAdminUi(locale).labels.noProviderMessage;
}

export function getSupportMessageTitle(locale: string | AppLocale, sender: string | null | undefined) {
  return formatTemplate(supportLabels[localeOf(locale)].messageTitle, {
    sender: getEnumLabel(locale, "sender", sender),
  });
}

export function getSupportUiCopy(locale: string | AppLocale) {
  return supportLabels[localeOf(locale)];
}
