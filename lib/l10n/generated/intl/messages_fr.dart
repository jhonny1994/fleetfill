// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a fr locale. All the
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
  String get localeName => 'fr';

  static String m0(documentCount, vehicleCount) =>
      "${documentCount} documents en attente sur ${vehicleCount} véhicules";

  static String m1(bookingId) => "Réservation ${bookingId}";

  static String m2(carrierId) => "Transporteur ${carrierId}";

  static String m3(reason) =>
      "La vérification requiert votre attention : ${reason}";

  static String m4(count) => "Fichiers selectionnes : ${count}";

  static String m5(documentId) => "Document ${documentId}";

  static String m6(documentId) => "Document généré ${documentId}";

  static String m7(languageCode) =>
      "Langue actuelle de l\'application : ${languageCode}";

  static String m8(milestoneLabel) => "Statut actuel : ${milestoneLabel}";

  static String m9(notificationId) => "Notification ${notificationId}";

  static String m10(documentType) =>
      "Votre ${documentType} est pret a etre consulte en toute securite.";

  static String m11(status) =>
      "Le statut de votre demande de support est maintenant ${status}.";

  static String m12(documentType, reason) =>
      "Votre ${documentType} a ete rejete. Motif : ${reason}";

  static String m13(tripId) => "Trajet ponctuel ${tripId}";

  static String m14(proofId) => "Preuve ${proofId}";

  static String m15(routeId) => "Route ${routeId}";

  static String m16(dates) =>
      "Aucun resultat exact le même jour. Dates exactes les plus proches : ${dates}";

  static String m17(count) => "Resultats de recherche (${count})";

  static String m18(shipmentId) => "Expedition ${shipmentId}";

  static String m19(supportEmail) => "E-mail du support : ${supportEmail}";

  static String m20(bookingId) => "Suivi ${bookingId}";

  static String m21(reason) =>
      "La vérification du véhicule requiert votre attention : ${reason}";

  static String m22(reason) => "Rejete : ${reason}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "adminAuditLogDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez les dernieres actions admin sensibles et leur resultat.",
    ),
    "adminAuditLogEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun evenement d\'audit admin n\'a encore ete enregistre.",
    ),
    "adminAuditLogTitle": MessageLookupByLibrary.simpleMessage(
      "Journal d\'audit admin",
    ),
    "adminDashboardAutomationTitle": MessageLookupByLibrary.simpleMessage(
      "Tâches prioritaires",
    ),
    "adminDashboardBacklogHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Travail en attente",
    ),
    "adminDashboardDeadLetterLabel": MessageLookupByLibrary.simpleMessage(
      "E-mails en échec",
    ),
    "adminDashboardDescription": MessageLookupByLibrary.simpleMessage(
      "La sante du backlog operationnel, les alertes et les compteurs rapides apparaissent ici.",
    ),
    "adminDashboardEmailBacklogLabel": MessageLookupByLibrary.simpleMessage(
      "E-mails en attente",
    ),
    "adminDashboardEmailHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Distribution des e-mails",
    ),
    "adminDashboardNavLabel": MessageLookupByLibrary.simpleMessage(
      "Tableau de bord",
    ),
    "adminDashboardOverdueDeliveryReviewsLabel":
        MessageLookupByLibrary.simpleMessage("Revues de livraison en retard"),
    "adminDashboardOverduePaymentResubmissionsLabel":
        MessageLookupByLibrary.simpleMessage(
          "Re-soumissions de paiement en retard",
        ),
    "adminDashboardTitle": MessageLookupByLibrary.simpleMessage(
      "Tableau de bord admin",
    ),
    "adminDisputesQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun litige n\'attend de revue pour le moment.",
    ),
    "adminDisputesQueueTitle": MessageLookupByLibrary.simpleMessage("Litiges"),
    "adminEligiblePayoutsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun versement n\'est pret a etre libéré pour le moment.",
    ),
    "adminEmailDeadLetterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun e-mail en échec ne demande d\'action.",
    ),
    "adminEmailDeadLetterTitle": MessageLookupByLibrary.simpleMessage(
      "E-mails en échec",
    ),
    "adminEmailErrorCodeLabel": MessageLookupByLibrary.simpleMessage(
      "Code d\'erreur",
    ),
    "adminEmailErrorMessageLabel": MessageLookupByLibrary.simpleMessage(
      "Message d\'erreur",
    ),
    "adminEmailLocaleLabel": MessageLookupByLibrary.simpleMessage(
      "Langue demandee",
    ),
    "adminEmailPayloadSnapshotLabel": MessageLookupByLibrary.simpleMessage(
      "Instantane de charge utile",
    ),
    "adminEmailProviderLabel": MessageLookupByLibrary.simpleMessage(
      "Fournisseur",
    ),
    "adminEmailQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun log e-mail ne correspond aux filtres actuels.",
    ),
    "adminEmailQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Distribution des e-mails",
    ),
    "adminEmailResendAction": MessageLookupByLibrary.simpleMessage("Renvoyer"),
    "adminEmailResendSuccess": MessageLookupByLibrary.simpleMessage(
      "Le renvoi de l\'e-mail a été mis en file.",
    ),
    "adminEmailSearchLabel": MessageLookupByLibrary.simpleMessage(
      "Rechercher dans les logs e-mail",
    ),
    "adminEmailStatusAllLabel": MessageLookupByLibrary.simpleMessage(
      "Tous les statuts",
    ),
    "adminEmailStatusBouncedLabel": MessageLookupByLibrary.simpleMessage(
      "Rejete",
    ),
    "adminEmailStatusDeadLetterLabel": MessageLookupByLibrary.simpleMessage(
      "En échec",
    ),
    "adminEmailStatusDeliveredLabel": MessageLookupByLibrary.simpleMessage(
      "Livre",
    ),
    "adminEmailStatusFilterLabel": MessageLookupByLibrary.simpleMessage(
      "Statut e-mail",
    ),
    "adminEmailStatusHardFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Échec definitif",
    ),
    "adminEmailStatusQueuedLabel": MessageLookupByLibrary.simpleMessage(
      "En file",
    ),
    "adminEmailStatusRenderFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Echec de rendu",
    ),
    "adminEmailStatusSentLabel": MessageLookupByLibrary.simpleMessage("Envoye"),
    "adminEmailStatusSoftFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Échec temporaire",
    ),
    "adminEmailStatusSuppressedLabel": MessageLookupByLibrary.simpleMessage(
      "Supprime",
    ),
    "adminEmailSubjectPreviewLabel": MessageLookupByLibrary.simpleMessage(
      "Apercu de l\'objet",
    ),
    "adminEmailTemplateKeyLabel": MessageLookupByLibrary.simpleMessage(
      "Cle du modele",
    ),
    "adminEmailTemplateLanguageLabel": MessageLookupByLibrary.simpleMessage(
      "Langue du modele",
    ),
    "adminPaymentProofQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune preuve de paiement a revoir pour le moment.",
    ),
    "adminPaymentProofQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Revue des preuves de paiement",
    ),
    "adminPayoutEligibleTitle": MessageLookupByLibrary.simpleMessage(
      "Paiements eligibles",
    ),
    "adminPayoutQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun versement n\'a encore ete libéré.",
    ),
    "adminPayoutQueueTitle": MessageLookupByLibrary.simpleMessage("Versements"),
    "adminPayoutReleaseAction": MessageLookupByLibrary.simpleMessage(
      "Lancer le paiement",
    ),
    "adminQueueDisputesTabLabel": MessageLookupByLibrary.simpleMessage(
      "Litiges",
    ),
    "adminQueueEmailTabLabel": MessageLookupByLibrary.simpleMessage("E-mail"),
    "adminQueuePaymentsTabLabel": MessageLookupByLibrary.simpleMessage(
      "Paiements",
    ),
    "adminQueuePayoutsTabLabel": MessageLookupByLibrary.simpleMessage(
      "Paiements transporteur",
    ),
    "adminQueueSupportTabLabel": MessageLookupByLibrary.simpleMessage(
      "Support",
    ),
    "adminQueueVerificationTabLabel": MessageLookupByLibrary.simpleMessage(
      "Vérification",
    ),
    "adminQueuesDescription": MessageLookupByLibrary.simpleMessage(
      "Les files de paiements, de vérification, de litiges, de versements et d\'e-mails sont regroupees sur une seule page.",
    ),
    "adminQueuesNavLabel": MessageLookupByLibrary.simpleMessage("Opérations"),
    "adminQueuesTitle": MessageLookupByLibrary.simpleMessage("Opérations"),
    "adminSettingsDeliveryGraceLabel": MessageLookupByLibrary.simpleMessage(
      "Fenetre de grace de livraison (heures)",
    ),
    "adminSettingsDeliverySectionTitle": MessageLookupByLibrary.simpleMessage(
      "Politique de revue de livraison",
    ),
    "adminSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "Gerez l\'accès a l\'application, les règles tarifaires, le mode maintenance et les outils e-mail.",
    ),
    "adminSettingsEmailResendEnabledLabel":
        MessageLookupByLibrary.simpleMessage(
          "Activer le renvoi admin des e-mails",
        ),
    "adminSettingsEnabledLocalesLabel": MessageLookupByLibrary.simpleMessage(
      "Langues actives",
    ),
    "adminSettingsFallbackLocaleLabel": MessageLookupByLibrary.simpleMessage(
      "Langue de secours",
    ),
    "adminSettingsFeatureFlagsSectionTitle":
        MessageLookupByLibrary.simpleMessage("Fonctionnalites optionnelles"),
    "adminSettingsForceUpdateLabel": MessageLookupByLibrary.simpleMessage(
      "Mise a jour obligatoire",
    ),
    "adminSettingsInsuranceMinimumLabel": MessageLookupByLibrary.simpleMessage(
      "Minimum assurance",
    ),
    "adminSettingsInsuranceRateLabel": MessageLookupByLibrary.simpleMessage(
      "Taux d\'assurance",
    ),
    "adminSettingsLocalizationSectionTitle":
        MessageLookupByLibrary.simpleMessage("Politique de langue"),
    "adminSettingsMaintenanceModeLabel": MessageLookupByLibrary.simpleMessage(
      "Mode maintenance",
    ),
    "adminSettingsMinimumAndroidVersionLabel":
        MessageLookupByLibrary.simpleMessage("Version Android minimale"),
    "adminSettingsMinimumIosVersionLabel": MessageLookupByLibrary.simpleMessage(
      "Version iOS minimale",
    ),
    "adminSettingsMonitoringSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume du service",
    ),
    "adminSettingsNavLabel": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "adminSettingsPaymentDeadlineLabel": MessageLookupByLibrary.simpleMessage(
      "Delai de re-soumission du paiement (heures)",
    ),
    "adminSettingsPlatformFeeRateLabel": MessageLookupByLibrary.simpleMessage(
      "Taux de frais plateforme",
    ),
    "adminSettingsPricingSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Politique tarifaire",
    ),
    "adminSettingsRuntimeSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Accès a l\'application",
    ),
    "adminSettingsSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer",
    ),
    "adminSettingsSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Les paramètres admin ont ete mis a jour.",
    ),
    "adminSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Paramètres admin",
    ),
    "adminSupportAssignToMeAction": MessageLookupByLibrary.simpleMessage(
      "M\'assigner",
    ),
    "adminSupportControlsTitle": MessageLookupByLibrary.simpleMessage(
      "Commandes support",
    ),
    "adminSupportQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune demande de support ne requiert d\'action pour le moment.",
    ),
    "adminSupportQueueTitle": MessageLookupByLibrary.simpleMessage(
      "File de support",
    ),
    "adminSupportSearchLabel": MessageLookupByLibrary.simpleMessage(
      "Rechercher des demandes de support",
    ),
    "adminSupportStatusAllLabel": MessageLookupByLibrary.simpleMessage(
      "Tous les statuts",
    ),
    "adminSupportUnassignAction": MessageLookupByLibrary.simpleMessage(
      "Retirer l\'assignation",
    ),
    "adminUserAccountSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Vue du compte",
    ),
    "adminUserBookingsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune réservation n\'est liée a cet utilisateur.",
    ),
    "adminUserBookingsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Réservations liées",
    ),
    "adminUserDocumentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun document de vérification disponible pour cet utilisateur.",
    ),
    "adminUserDocumentsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Documents de vérification",
    ),
    "adminUserEmailEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun log e-mail recent pour cet utilisateur.",
    ),
    "adminUserEmailSectionTitle": MessageLookupByLibrary.simpleMessage(
      "E-mails recents",
    ),
    "adminUserReactivateAction": MessageLookupByLibrary.simpleMessage(
      "Reactiver l\'utilisateur",
    ),
    "adminUserReactivateSuccess": MessageLookupByLibrary.simpleMessage(
      "Utilisateur reactive.",
    ),
    "adminUserReasonHint": MessageLookupByLibrary.simpleMessage(
      "Ajoutez une raison operationnelle pour ce changement.",
    ),
    "adminUserRoleAdminLabel": MessageLookupByLibrary.simpleMessage(
      "Administrateur",
    ),
    "adminUserRoleCarrierLabel": MessageLookupByLibrary.simpleMessage(
      "Transporteur",
    ),
    "adminUserRoleLabel": MessageLookupByLibrary.simpleMessage("Rôle"),
    "adminUserRoleShipperLabel": MessageLookupByLibrary.simpleMessage(
      "Expéditeur",
    ),
    "adminUserStatusActiveLabel": MessageLookupByLibrary.simpleMessage("Actif"),
    "adminUserStatusLabel": MessageLookupByLibrary.simpleMessage(
      "Statut du compte",
    ),
    "adminUserStatusSuspendedLabel": MessageLookupByLibrary.simpleMessage(
      "Suspendu",
    ),
    "adminUserSuspendAction": MessageLookupByLibrary.simpleMessage(
      "Suspendre l\'utilisateur",
    ),
    "adminUserSuspendSuccess": MessageLookupByLibrary.simpleMessage(
      "Utilisateur suspendu.",
    ),
    "adminUserVehiclesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun véhicule n\'est lie a cet utilisateur.",
    ),
    "adminUserVehiclesSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Véhicules",
    ),
    "adminUsersDescription": MessageLookupByLibrary.simpleMessage(
      "Recherchez des utilisateurs et consultez leurs comptes, réservations et documents.",
    ),
    "adminUsersEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun utilisateur ne correspond a cette recherche.",
    ),
    "adminUsersNavLabel": MessageLookupByLibrary.simpleMessage("Utilisateurs"),
    "adminUsersSearchLabel": MessageLookupByLibrary.simpleMessage(
      "Rechercher des utilisateurs",
    ),
    "adminUsersTitle": MessageLookupByLibrary.simpleMessage("Utilisateurs"),
    "adminVerificationApproveAction": MessageLookupByLibrary.simpleMessage(
      "Approuver",
    ),
    "adminVerificationApproveAllAction": MessageLookupByLibrary.simpleMessage(
      "Tout approuver",
    ),
    "adminVerificationApproveAllSuccess": MessageLookupByLibrary.simpleMessage(
      "Le dossier de vérification a été approuve.",
    ),
    "adminVerificationApprovedMessage": MessageLookupByLibrary.simpleMessage(
      "Le document de vérification a été approuve.",
    ),
    "adminVerificationAuditEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun element d\'audit de vérification recent.",
    ),
    "adminVerificationAuditTitle": MessageLookupByLibrary.simpleMessage(
      "Audit de vérification",
    ),
    "adminVerificationMissingDocumentsMessage":
        MessageLookupByLibrary.simpleMessage(
          "Aucun document de vérification n\'a encore ete soumis.",
        ),
    "adminVerificationPacketDescription": MessageLookupByLibrary.simpleMessage(
      "Vérifiez les documents de profil et de véhicule avant d\'ouvrir l\'accès opérationnel.",
    ),
    "adminVerificationPacketTitle": MessageLookupByLibrary.simpleMessage(
      "Dossier de vérification",
    ),
    "adminVerificationPendingDocumentsLabel":
        MessageLookupByLibrary.simpleMessage("Documents en attente"),
    "adminVerificationQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun dossier de vérification transporteur n\'attend une revue.",
    ),
    "adminVerificationQueueItemSubtitle": m0,
    "adminVerificationQueueSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume de la file de vérification",
    ),
    "adminVerificationQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Verifications transporteur",
    ),
    "adminVerificationRejectAction": MessageLookupByLibrary.simpleMessage(
      "Rejeter",
    ),
    "adminVerificationRejectReasonHint": MessageLookupByLibrary.simpleMessage(
      "Ajoutez la raison que le transporteur doit voir.",
    ),
    "adminVerificationRejectReasonTitle": MessageLookupByLibrary.simpleMessage(
      "Motif du rejet",
    ),
    "adminVerificationRejectedMessage": MessageLookupByLibrary.simpleMessage(
      "Le document de vérification a été rejete.",
    ),
    "appGenericErrorMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill ne peut pas terminer cette action pour le moment.",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("FleetFill"),
    "authAccountCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Votre compte a été créé. Continuez en vous connectant.",
    ),
    "authAuthenticationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous pour continuer cette action.",
    ),
    "authCancelledMessage": MessageLookupByLibrary.simpleMessage(
      "Connexion annulee.",
    ),
    "authConfirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Repetez votre mot de passe",
    ),
    "authConfirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmer le mot de passe",
    ),
    "authContinueWithLabel": MessageLookupByLibrary.simpleMessage(
      "ou continuer avec",
    ),
    "authCreateAccountAction": MessageLookupByLibrary.simpleMessage(
      "Creer un compte",
    ),
    "authCreateAccountCta": MessageLookupByLibrary.simpleMessage(
      "Creer un nouveau compte",
    ),
    "authCreatePasswordHint": MessageLookupByLibrary.simpleMessage(
      "Creez un mot de passe fort",
    ),
    "authEmailDeliveryIssueMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill n\'a pas pu envoyer l\'e-mail de confirmation pour le moment. Verifiez la redirection et le fournisseur e-mail puis reessayez.",
    ),
    "authEmailHint": MessageLookupByLibrary.simpleMessage("vous@exemple.com"),
    "authEmailLabel": MessageLookupByLibrary.simpleMessage("Adresse e-mail"),
    "authEmailNotConfirmedMessage": MessageLookupByLibrary.simpleMessage(
      "Confirmez votre e-mail avant de vous connecter.",
    ),
    "authForgotPasswordCta": MessageLookupByLibrary.simpleMessage(
      "Mot de passe oublie ?",
    ),
    "authForgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "La gestion des demandes de reinitialisation du mot de passe se fait dans l\'espace d\'authentification.",
    ),
    "authForgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Mot de passe oublie",
    ),
    "authGenericErrorMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill n\'a pas pu terminer cette action d\'authentification.",
    ),
    "authGoogleAction": MessageLookupByLibrary.simpleMessage(
      "Continuer avec Google",
    ),
    "authGoogleUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "La connexion Google n\'est pas disponible dans cet environnement.",
    ),
    "authHaveAccountCta": MessageLookupByLibrary.simpleMessage(
      "Vous avez déjà un compte ? Connectez-vous",
    ),
    "authHidePasswordAction": MessageLookupByLibrary.simpleMessage(
      "Masquer le mot de passe",
    ),
    "authInvalidCredentialsMessage": MessageLookupByLibrary.simpleMessage(
      "Verifiez votre e-mail et votre mot de passe, puis reessayez.",
    ),
    "authInvalidEmailMessage": MessageLookupByLibrary.simpleMessage(
      "Saisissez une adresse e-mail valide.",
    ),
    "authKeepSignedInLabel": MessageLookupByLibrary.simpleMessage(
      "Rester connecte",
    ),
    "authNetworkErrorMessage": MessageLookupByLibrary.simpleMessage(
      "Probleme reseau detecte. Reessayez dans un instant.",
    ),
    "authNewPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Nouveau mot de passe",
    ),
    "authPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Entrez votre mot de passe",
    ),
    "authPasswordLabel": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "authPasswordMinLengthMessage": MessageLookupByLibrary.simpleMessage(
      "Utilisez au moins 8 caracteres.",
    ),
    "authPasswordMismatchMessage": MessageLookupByLibrary.simpleMessage(
      "Les mots de passe ne correspondent pas.",
    ),
    "authPasswordResetInfoMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill enverra un lien de reinitialisation a l\'adresse e-mail du compte.",
    ),
    "authPasswordUpdatedMessage": MessageLookupByLibrary.simpleMessage(
      "Votre mot de passe a été mis a jour.",
    ),
    "authRateLimitedMessage": MessageLookupByLibrary.simpleMessage(
      "Trop de tentatives d\'authentification. Attendez un instant puis reessayez.",
    ),
    "authRequiredFieldMessage": MessageLookupByLibrary.simpleMessage(
      "Ce champ est obligatoire.",
    ),
    "authResetEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "Les instructions de reinitialisation ont ete envoyees.",
    ),
    "authResetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Definissez un nouveau mot de passe apres ouverture du lien de recuperation sécurisé.",
    ),
    "authResetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reinitialiser le mot de passe",
    ),
    "authResetPasswordUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "Ouvrez cet ecran depuis le lien de recuperation pour definir un nouveau mot de passe.",
    ),
    "authRoleAlreadyAssignedMessage": MessageLookupByLibrary.simpleMessage(
      "Le role de ce compte est déjà defini et ne peut pas etre change ici.",
    ),
    "authSendResetAction": MessageLookupByLibrary.simpleMessage(
      "Envoyer le lien de reinitialisation",
    ),
    "authSessionExpiredAction": MessageLookupByLibrary.simpleMessage(
      "Se reconnecter",
    ),
    "authSessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "Votre session a pris fin. Reconnectez-vous pour continuer en toute securite.",
    ),
    "authSessionExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Session expiree",
    ),
    "authShowPasswordAction": MessageLookupByLibrary.simpleMessage(
      "Afficher le mot de passe",
    ),
    "authSignInAction": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "authSignInDescription": MessageLookupByLibrary.simpleMessage(
      "Les points d\'entree de connexion par e-mail/mot de passe et Google se trouvent ici.",
    ),
    "authSignInSuccess": MessageLookupByLibrary.simpleMessage(
      "Connexion réussie.",
    ),
    "authSignInTitle": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "authSignUpDescription": MessageLookupByLibrary.simpleMessage(
      "Creez votre compte FleetFill pour expedier ou publier de la capacité.",
    ),
    "authSignUpTitle": MessageLookupByLibrary.simpleMessage("Creer un compte"),
    "authSignUpUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "La creation de compte par e-mail n\'est pas disponible pour le moment.",
    ),
    "authUpdatePasswordAction": MessageLookupByLibrary.simpleMessage(
      "Mettre a jour le mot de passe",
    ),
    "authUserAlreadyRegisteredMessage": MessageLookupByLibrary.simpleMessage(
      "Un compte existe déjà pour cet e-mail.",
    ),
    "authVerificationEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "Verifiez votre e-mail pour confirmer le compte avant de vous connecter.",
    ),
    "authWeakPasswordMessage": MessageLookupByLibrary.simpleMessage(
      "Utilisez un mot de passe plus robuste puis reessayez.",
    ),
    "bookingBasePriceLabel": MessageLookupByLibrary.simpleMessage(
      "Prix de base",
    ),
    "bookingCarrierFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Frais transporteur",
    ),
    "bookingCarrierPayoutLabel": MessageLookupByLibrary.simpleMessage(
      "Versement transporteur",
    ),
    "bookingConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Confirmer la réservation",
    ),
    "bookingCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Réservation créée. Continuez vers le paiement.",
    ),
    "bookingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez le statut de la réservation, les détails du paiement et le recapitulatif du prix.",
    ),
    "bookingDetailPageTitle": MessageLookupByLibrary.simpleMessage(
      "Détails de la réservation",
    ),
    "bookingDetailTitle": m1,
    "bookingInsuranceAction": MessageLookupByLibrary.simpleMessage(
      "Option d\'assurance",
    ),
    "bookingInsuranceDescription": MessageLookupByLibrary.simpleMessage(
      "L\'assurance est facultative et calculee en pourcentage avec un minimum.",
    ),
    "bookingInsuranceFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Frais d\'assurance",
    ),
    "bookingInsuranceIncludedLabel": MessageLookupByLibrary.simpleMessage(
      "Incluse",
    ),
    "bookingInsuranceLabel": MessageLookupByLibrary.simpleMessage("Assurance"),
    "bookingInsuranceNotIncludedLabel": MessageLookupByLibrary.simpleMessage(
      "Non incluse",
    ),
    "bookingPaymentReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "Reference de paiement",
    ),
    "bookingPlatformFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Frais plateforme",
    ),
    "bookingPricingBreakdownAction": MessageLookupByLibrary.simpleMessage(
      "Detail du prix",
    ),
    "bookingReviewDescription": MessageLookupByLibrary.simpleMessage(
      "La reputation du transporteur, le detail du trajet et la revue du prix apparaissent ici avant le paiement.",
    ),
    "bookingReviewTitle": MessageLookupByLibrary.simpleMessage(
      "Revue de la réservation",
    ),
    "bookingStatusCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Annulee",
    ),
    "bookingStatusCompletedLabel": MessageLookupByLibrary.simpleMessage(
      "Terminee",
    ),
    "bookingStatusConfirmedLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmee",
    ),
    "bookingStatusDeliveredPendingReviewLabel":
        MessageLookupByLibrary.simpleMessage("Livree en attente de revue"),
    "bookingStatusDisputedLabel": MessageLookupByLibrary.simpleMessage(
      "Contestee",
    ),
    "bookingStatusInTransitLabel": MessageLookupByLibrary.simpleMessage(
      "En transit",
    ),
    "bookingStatusPaymentUnderReviewLabel":
        MessageLookupByLibrary.simpleMessage("Paiement en vérification"),
    "bookingStatusPendingPaymentLabel": MessageLookupByLibrary.simpleMessage(
      "En attente de paiement",
    ),
    "bookingStatusPickedUpLabel": MessageLookupByLibrary.simpleMessage(
      "Ramassee",
    ),
    "bookingTaxFeeLabel": MessageLookupByLibrary.simpleMessage("Taxe"),
    "bookingTotalLabel": MessageLookupByLibrary.simpleMessage("Total final"),
    "bookingTrackingNumberLabel": MessageLookupByLibrary.simpleMessage(
      "Numéro de suivi",
    ),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "carrierBookingsDescription": MessageLookupByLibrary.simpleMessage(
      "Suivez les réservations en cours, l\'avancement des livraisons et les missions terminees.",
    ),
    "carrierBookingsNavLabel": MessageLookupByLibrary.simpleMessage(
      "Réservations",
    ),
    "carrierBookingsTitle": MessageLookupByLibrary.simpleMessage(
      "Réservations transporteur",
    ),
    "carrierGatePayoutMessage": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un compte de paiement avant d\'ouvrir les réservations transporteur afin que les courses terminées puissent être réglées correctement.",
    ),
    "carrierGatePayoutTitle": MessageLookupByLibrary.simpleMessage(
      "Compte de paiement requis",
    ),
    "carrierGatePhoneMessage": MessageLookupByLibrary.simpleMessage(
      "Ajoutez votre numéro de telephone avant d\'ouvrir cet espace transporteur afin de recevoir les mises a jour opérationnelles et de réservation.",
    ),
    "carrierGatePhoneTitle": MessageLookupByLibrary.simpleMessage(
      "Numéro de telephone requis",
    ),
    "carrierGateVerificationMessage": MessageLookupByLibrary.simpleMessage(
      "Terminez la vérification transporteur avant d\'ouvrir cet espace pour publier des trajets ou gérer des réservations.",
    ),
    "carrierGateVerificationTitle": MessageLookupByLibrary.simpleMessage(
      "Vérification requise",
    ),
    "carrierHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez votre statut de vérification, l\'etat de votre flotte et vos prochaines tâches.",
    ),
    "carrierHomeNavLabel": MessageLookupByLibrary.simpleMessage("Accueil"),
    "carrierHomeTitle": MessageLookupByLibrary.simpleMessage(
      "Accueil transporteur",
    ),
    "carrierMilestoneUpdatedMessage": MessageLookupByLibrary.simpleMessage(
      "Etape de réservation mise a jour.",
    ),
    "carrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Gerez les informations de votre entreprise, la vérification, les comptes de versement et les véhicules.",
    ),
    "carrierProfileNavLabel": MessageLookupByLibrary.simpleMessage("Profil"),
    "carrierProfileSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Détails du transporteur",
    ),
    "carrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Profil transporteur",
    ),
    "carrierProfileVerificationLabel": MessageLookupByLibrary.simpleMessage(
      "Vérification",
    ),
    "carrierProfileVerificationPending": MessageLookupByLibrary.simpleMessage(
      "En attente",
    ),
    "carrierProfileVerificationRejected": MessageLookupByLibrary.simpleMessage(
      "Rejetee",
    ),
    "carrierProfileVerificationVerified": MessageLookupByLibrary.simpleMessage(
      "Verifiee",
    ),
    "carrierPublicProfileCommentsTitle": MessageLookupByLibrary.simpleMessage(
      "Commentaires recents",
    ),
    "carrierPublicProfileDescription": MessageLookupByLibrary.simpleMessage(
      "La reputation publique du transporteur et les indicateurs de confiance apparaissent ici.",
    ),
    "carrierPublicProfileNoCommentsMessage":
        MessageLookupByLibrary.simpleMessage(
          "Aucun commentaire d\'avis n\'est encore visible.",
        ),
    "carrierPublicProfilePageTitle": MessageLookupByLibrary.simpleMessage(
      "Profil du transporteur",
    ),
    "carrierPublicProfileRatingLabel": MessageLookupByLibrary.simpleMessage(
      "Note moyenne",
    ),
    "carrierPublicProfileReviewCountLabel":
        MessageLookupByLibrary.simpleMessage("Nombre d\'avis"),
    "carrierPublicProfileSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume du transporteur",
    ),
    "carrierPublicProfileTitle": m2,
    "carrierVehiclesShortcutDescription": MessageLookupByLibrary.simpleMessage(
      "Gerez les camions, telechargez les documents manquants et resolvez les blocages de vérification.",
    ),
    "carrierVerificationCenterDescription": MessageLookupByLibrary.simpleMessage(
      "Gerez la vérification transporteur depuis un seul endroit en déposant les documents du conducteur et du véhicule requis.",
    ),
    "carrierVerificationCenterTitle": MessageLookupByLibrary.simpleMessage(
      "Vérification transporteur",
    ),
    "carrierVerificationPendingBanner": MessageLookupByLibrary.simpleMessage(
      "Votre dossier de vérification est en cours de revue. Telechargez les documents manquants pour accelerer l\'approbation.",
    ),
    "carrierVerificationQueueHint": MessageLookupByLibrary.simpleMessage(
      "Terminez les etapes de vérification restantes depuis votre profil.",
    ),
    "carrierVerificationRejectedBanner": m3,
    "carrierVerificationSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume de vérification",
    ),
    "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirmer"),
    "contactSupportAction": MessageLookupByLibrary.simpleMessage(
      "Contacter le support",
    ),
    "deliveryConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Confirmer la livraison",
    ),
    "deliveryConfirmedMessage": MessageLookupByLibrary.simpleMessage(
      "Livraison confirmee.",
    ),
    "disputeEvidenceAddAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter des fichiers de preuve",
    ),
    "disputeEvidenceEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun fichier de preuve n\'a encore ete joint a ce litige.",
    ),
    "disputeEvidenceSelectedCount": m4,
    "disputeEvidenceTitle": MessageLookupByLibrary.simpleMessage(
      "Pieces du litige",
    ),
    "documentPreviewUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "L\'apercu n\'est pas disponible pour ce fichier. Ouvrez-le dans une autre application.",
    ),
    "documentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez ce document ici ou ouvrez-le dans une autre application.",
    ),
    "documentViewerOpenAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir le document",
    ),
    "documentViewerPageTitle": MessageLookupByLibrary.simpleMessage("Document"),
    "documentViewerTitle": m5,
    "documentViewerUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "L\'accès sécurisé au document est temporairement indisponible.",
    ),
    "editCarrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez a jour vos coordonnées et informations transporteur.",
    ),
    "editCarrierProfileSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Profil transporteur mis a jour.",
    ),
    "editCarrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le profil transporteur",
    ),
    "editShipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez a jour vos coordonnées expéditeur.",
    ),
    "editShipperProfileSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Profil expéditeur mis a jour.",
    ),
    "editShipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le profil expéditeur",
    ),
    "errorTitle": MessageLookupByLibrary.simpleMessage(
      "Un probleme est survenu",
    ),
    "forbiddenAdminStepUpMessage": MessageLookupByLibrary.simpleMessage(
      "Re-authentifiez-vous recemment avant d\'ouvrir cette surface admin sensible.",
    ),
    "forbiddenMessage": MessageLookupByLibrary.simpleMessage(
      "Cette section n\'est pas accessible pour votre compte.",
    ),
    "forbiddenTitle": MessageLookupByLibrary.simpleMessage("Accès restreint"),
    "generatedDocumentAvailableAtLabel": MessageLookupByLibrary.simpleMessage(
      "Disponible le",
    ),
    "generatedDocumentDownloadAction": MessageLookupByLibrary.simpleMessage(
      "Telecharger le PDF",
    ),
    "generatedDocumentFailedMessage": MessageLookupByLibrary.simpleMessage(
      "Ce document n\'a pas encore pu etre généré. Reessayez plus tard ou contactez le support si le probleme persiste.",
    ),
    "generatedDocumentFailureReasonLabel": MessageLookupByLibrary.simpleMessage(
      "Probleme",
    ),
    "generatedDocumentOpenInBrowserAction":
        MessageLookupByLibrary.simpleMessage("Ouvrir dans le navigateur"),
    "generatedDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "Ce document est encore en cours de generation. Revenez dans un instant.",
    ),
    "generatedDocumentStatusFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Regeneration requise",
    ),
    "generatedDocumentStatusPendingLabel": MessageLookupByLibrary.simpleMessage(
      "En generation",
    ),
    "generatedDocumentTypePaymentReceipt": MessageLookupByLibrary.simpleMessage(
      "Recu de paiement",
    ),
    "generatedDocumentTypePayoutReceipt": MessageLookupByLibrary.simpleMessage(
      "Recu de versement",
    ),
    "generatedDocumentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez ou telechargez votre facture ou votre reçu.",
    ),
    "generatedDocumentViewerPageTitle": MessageLookupByLibrary.simpleMessage(
      "Document généré",
    ),
    "generatedDocumentViewerTitle": m6,
    "generatedDocumentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Les factures et reçus générés apparaitront ici lorsqu\'ils seront disponibles.",
    ),
    "generatedDocumentsTapReadyHint": MessageLookupByLibrary.simpleMessage(
      "Touchez un document pret pour l\'ouvrir de maniere sécurisée.",
    ),
    "generatedDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Documents générés",
    ),
    "goBackAction": MessageLookupByLibrary.simpleMessage("Retour"),
    "languageOptionArabic": MessageLookupByLibrary.simpleMessage("Arabe"),
    "languageOptionEnglish": MessageLookupByLibrary.simpleMessage("Anglais"),
    "languageOptionFrench": MessageLookupByLibrary.simpleMessage("Francais"),
    "languageSelectionCurrentMessage": m7,
    "languageSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez la langue a utiliser dans FleetFill.",
    ),
    "languageSelectionTitle": MessageLookupByLibrary.simpleMessage(
      "Choix de la langue",
    ),
    "legalDisputePolicyBody": MessageLookupByLibrary.simpleMessage(
      "Les litiges doivent etre ouverts pendant la fenêtre de revue de livraison. FleetFill examine l\'expedition, la preuve de paiement, le suivi et les documents lies avant de resoudre le dossier. Le litige peut se terminer par une réservation finalisee, une annulation ou un remboursement.",
    ),
    "legalDisputePolicyTitle": MessageLookupByLibrary.simpleMessage(
      "Politique de litige",
    ),
    "legalPaymentDisclosureBody": MessageLookupByLibrary.simpleMessage(
      "Le detail du prix, les frais plateforme, les taxes et l\'assurance facultative sont affiches avant l\'envoi de la preuve. FleetFill verifie la preuve de paiement par rapport au total de la réservation, sécurisé les fonds avant la fin de livraison et ne libéré le versement transporteur qu\'une fois la réservation eligible.",
    ),
    "legalPaymentDisclosureTitle": MessageLookupByLibrary.simpleMessage(
      "Information paiement et sequestre",
    ),
    "legalPoliciesDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez les règles sur les conditions, la confidentialite, le paiement et les litiges avant d\'utiliser FleetFill.",
    ),
    "legalPoliciesSupportHint": MessageLookupByLibrary.simpleMessage(
      "Si vous avez besoin d\'une clarification sur ces politiques, contactez le support FleetFill avant de poursuivre une réservation, un paiement ou un litige.",
    ),
    "legalPoliciesTitle": MessageLookupByLibrary.simpleMessage(
      "Politiques et informations",
    ),
    "legalPrivacyBody": MessageLookupByLibrary.simpleMessage(
      "FleetFill conserve les donnees de paiement, d\'expedition, de support et d\'audit uniquement pendant la duree necessaire pour exploiter le service, traiter les litiges et respecter les obligations legales ou financieres. L\'accès reste limite au titulaire du compte et au personnel autorise.",
    ),
    "legalPrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Confidentialite et retention",
    ),
    "legalTermsBody": MessageLookupByLibrary.simpleMessage(
      "FleetFill recoit le paiement de l\'expéditeur avant tout versement au transporteur. Chaque réservation couvre une expedition sur une seule ligne ou un seul trajet confirme. L\'expéditeur reste responsable de l\'exactitude des détails d\'expedition et le transporteur reste responsable de documents valides et du respect des obligations de transport.",
    ),
    "legalTermsTitle": MessageLookupByLibrary.simpleMessage(
      "Conditions d\'utilisation",
    ),
    "loadMoreLabel": MessageLookupByLibrary.simpleMessage("Charger plus"),
    "loadingMessage": MessageLookupByLibrary.simpleMessage(
      "Preparation de votre experience.",
    ),
    "loadingTitle": MessageLookupByLibrary.simpleMessage("Chargement"),
    "localBackendUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill ne peut pas joindre le backend local de développement. Utilisez le profil de lancement émulateur pour les émulateurs Android, et l\'adresse IP locale de votre ordinateur pour les appareils réels.",
    ),
    "locationUnavailableLabel": MessageLookupByLibrary.simpleMessage(
      "Lieu indisponible",
    ),
    "maintenanceDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill est temporairement indisponible pendant une intervention. Reessayez bientot.",
    ),
    "maintenanceTitle": MessageLookupByLibrary.simpleMessage(
      "Nous revenons bientot",
    ),
    "mediaUploadPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Autorisez l\'accès aux photos et aux fichiers pour televerser une preuve de paiement et des documents.",
    ),
    "mediaUploadPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Autoriser les photos et les fichiers",
    ),
    "moneySummaryTitle": MessageLookupByLibrary.simpleMessage("Resume du prix"),
    "myRoutesActiveRoutesLabel": MessageLookupByLibrary.simpleMessage(
      "Lignes recurrentes actives",
    ),
    "myRoutesActiveTripsLabel": MessageLookupByLibrary.simpleMessage(
      "Trajets ponctuels actifs",
    ),
    "myRoutesAddAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter de la capacité",
    ),
    "myRoutesCreateRouteAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter une ligne recurrente",
    ),
    "myRoutesCreateTripAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter un trajet ponctuel",
    ),
    "myRoutesDescription": MessageLookupByLibrary.simpleMessage(
      "Gerez vos lignes recurrentes et vos trajets ponctuels.",
    ),
    "myRoutesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Publiez une ligne recurrente ou un trajet ponctuel pour proposer de la capacité.",
    ),
    "myRoutesNavLabel": MessageLookupByLibrary.simpleMessage("Lignes"),
    "myRoutesOneOffTab": MessageLookupByLibrary.simpleMessage(
      "Trajets ponctuels",
    ),
    "myRoutesPublishedCapacityLabel": MessageLookupByLibrary.simpleMessage(
      "Capacité publiee",
    ),
    "myRoutesRecurringTab": MessageLookupByLibrary.simpleMessage(
      "Lignes recurrentes",
    ),
    "myRoutesReservedCapacityLabel": MessageLookupByLibrary.simpleMessage(
      "Capacité reservee",
    ),
    "myRoutesRouteListTitle": MessageLookupByLibrary.simpleMessage(
      "Lignes recurrentes",
    ),
    "myRoutesSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume de publication",
    ),
    "myRoutesTitle": MessageLookupByLibrary.simpleMessage("Mes lignes"),
    "myRoutesTripListTitle": MessageLookupByLibrary.simpleMessage(
      "Trajets ponctuels",
    ),
    "myRoutesUpcomingDeparturesLabel": MessageLookupByLibrary.simpleMessage(
      "Departs a venir",
    ),
    "myRoutesUtilizationLabel": MessageLookupByLibrary.simpleMessage(
      "Utilisation",
    ),
    "myShipmentsDescription": MessageLookupByLibrary.simpleMessage(
      "Creez des expeditions, relisez vos brouillons et suivez les chargements reserves.",
    ),
    "myShipmentsNavLabel": MessageLookupByLibrary.simpleMessage("Expeditions"),
    "myShipmentsTitle": MessageLookupByLibrary.simpleMessage("Mes expeditions"),
    "noExactResultsMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune ligne exacte n\'est encore disponible pour cette recherche.",
    ),
    "noExactResultsTitle": MessageLookupByLibrary.simpleMessage(
      "Aucune ligne exacte trouvee",
    ),
    "notFoundMessage": MessageLookupByLibrary.simpleMessage(
      "La page ou l\'entite demandee est introuvable.",
    ),
    "notFoundTitle": MessageLookupByLibrary.simpleMessage("Introuvable"),
    "notificationBookingConfirmedBody": MessageLookupByLibrary.simpleMessage(
      "Votre réservation est confirmee. Suivez les etapes de paiement pour la maintenir sur la bonne voie.",
    ),
    "notificationBookingConfirmedTitle": MessageLookupByLibrary.simpleMessage(
      "Réservation confirmee",
    ),
    "notificationBookingMilestoneUpdatedBody": m8,
    "notificationBookingMilestoneUpdatedTitle":
        MessageLookupByLibrary.simpleMessage(
          "Etape de réservation mise a jour",
        ),
    "notificationCarrierReviewSubmittedBody":
        MessageLookupByLibrary.simpleMessage(
          "Un nouvel avis a été ajoute a votre profil.",
        ),
    "notificationCarrierReviewSubmittedTitle":
        MessageLookupByLibrary.simpleMessage("Avis transporteur reçu"),
    "notificationDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez le detail complet de cette notification.",
    ),
    "notificationDetailPageTitle": MessageLookupByLibrary.simpleMessage(
      "Notification",
    ),
    "notificationDetailTitle": m9,
    "notificationDisputeOpenedBody": MessageLookupByLibrary.simpleMessage(
      "Votre litige a été ouvert et est en attente d\'examen.",
    ),
    "notificationDisputeOpenedTitle": MessageLookupByLibrary.simpleMessage(
      "Litige ouvert",
    ),
    "notificationDisputeResolvedBody": MessageLookupByLibrary.simpleMessage(
      "Votre litige a été resolu. Consultez la derniere mise a jour de la réservation et du paiement.",
    ),
    "notificationDisputeResolvedTitle": MessageLookupByLibrary.simpleMessage(
      "Litige resolu",
    ),
    "notificationGeneratedDocumentReadyBody": m10,
    "notificationGeneratedDocumentReadyTitle":
        MessageLookupByLibrary.simpleMessage("Document pret"),
    "notificationNewLabel": MessageLookupByLibrary.simpleMessage("Nouveau"),
    "notificationPaymentProofSubmittedBody": MessageLookupByLibrary.simpleMessage(
      "Nous avons reçu votre preuve de paiement. Nous allons la verifier sous peu.",
    ),
    "notificationPaymentProofSubmittedTitle":
        MessageLookupByLibrary.simpleMessage("Preuve de paiement envoyee"),
    "notificationPaymentRejectedBody": MessageLookupByLibrary.simpleMessage(
      "Votre preuve de paiement a été rejetee. Verifiez le motif et envoyez-en une nouvelle avant l\'echeance.",
    ),
    "notificationPaymentRejectedTitle": MessageLookupByLibrary.simpleMessage(
      "Preuve de paiement rejetee",
    ),
    "notificationPaymentSecuredBody": MessageLookupByLibrary.simpleMessage(
      "Votre paiement est sécurisé et la réservation est confirmee.",
    ),
    "notificationPaymentSecuredTitle": MessageLookupByLibrary.simpleMessage(
      "Paiement sécurisé",
    ),
    "notificationPayoutReleasedBody": MessageLookupByLibrary.simpleMessage(
      "Le paiement du transporteur a été libéré pour cette réservation.",
    ),
    "notificationPayoutReleasedTitle": MessageLookupByLibrary.simpleMessage(
      "Paiement transporteur libéré",
    ),
    "notificationSeenLabel": MessageLookupByLibrary.simpleMessage("Vu"),
    "notificationSupportReplyReceivedBody":
        MessageLookupByLibrary.simpleMessage(
          "Le support FleetFill a repondu a votre demande.",
        ),
    "notificationSupportReplyReceivedTitle":
        MessageLookupByLibrary.simpleMessage("Le support a repondu"),
    "notificationSupportRequestCreatedBody":
        MessageLookupByLibrary.simpleMessage(
          "Un utilisateur a ouvert une nouvelle demande de support a examiner.",
        ),
    "notificationSupportRequestCreatedTitle":
        MessageLookupByLibrary.simpleMessage("Nouvelle demande de support"),
    "notificationSupportStatusChangedBody": m11,
    "notificationSupportStatusChangedTitle":
        MessageLookupByLibrary.simpleMessage("Statut de support mis a jour"),
    "notificationSupportUserRepliedBody": MessageLookupByLibrary.simpleMessage(
      "Un utilisateur a repondu a une demande de support existante.",
    ),
    "notificationSupportUserRepliedTitle": MessageLookupByLibrary.simpleMessage(
      "L\'utilisateur a repondu",
    ),
    "notificationVerificationDocumentRejectedBody": m12,
    "notificationVerificationDocumentRejectedTitle":
        MessageLookupByLibrary.simpleMessage("Document de verification rejete"),
    "notificationVerificationPacketApprovedBody":
        MessageLookupByLibrary.simpleMessage(
          "Votre dossier de verification a ete approuve. Vous pouvez maintenant poursuivre les operations transporteur.",
        ),
    "notificationVerificationPacketApprovedTitle":
        MessageLookupByLibrary.simpleMessage("Verification approuvee"),
    "notificationsCenterDescription": MessageLookupByLibrary.simpleMessage(
      "Restez informe des réservations, paiements, etapes de livraison et alertes du compte.",
    ),
    "notificationsCenterTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "notificationsOnboardingEnableAction": MessageLookupByLibrary.simpleMessage(
      "Activer les notifications",
    ),
    "notificationsOnboardingSkipAction": MessageLookupByLibrary.simpleMessage(
      "Passer pour le moment",
    ),
    "notificationsOnboardingValueMessage": MessageLookupByLibrary.simpleMessage(
      "Activez les notifications pour suivre les confirmations de réservation, les vérifications de paiement, les étapes de livraison et les alertes du compte sans ambiguite.",
    ),
    "notificationsPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Activez les notifications pour recevoir les mises a jour de réservation, de livraison et de paiement.",
    ),
    "notificationsPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Activer les notifications",
    ),
    "notificationsSettingsDisabledMessage": MessageLookupByLibrary.simpleMessage(
      "Les notifications restent désactivées pour le moment. Vous pourrez les activer plus tard depuis les paramètres.",
    ),
    "notificationsSettingsEnabledMessage": MessageLookupByLibrary.simpleMessage(
      "Les notifications sont activées sur cet appareil.",
    ),
    "notificationsSettingsEntryDescription":
        MessageLookupByLibrary.simpleMessage(
          "Gerez l\'autorisation et ouvrez votre centre de notifications.",
        ),
    "offlineMessage": MessageLookupByLibrary.simpleMessage(
      "Vous êtes hors ligne. Certaines actions sont temporairement indisponibles.",
    ),
    "oneOffTripActivateAction": MessageLookupByLibrary.simpleMessage(
      "Activer le trajet",
    ),
    "oneOffTripActivateConfirmationMessage":
        MessageLookupByLibrary.simpleMessage(
          "Activer ce trajet pour de nouvelles réservations ?",
        ),
    "oneOffTripActivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel active.",
    ),
    "oneOffTripCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Ajouter un trajet ponctuel",
    ),
    "oneOffTripCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel ajoute.",
    ),
    "oneOffTripDeactivateAction": MessageLookupByLibrary.simpleMessage(
      "Desactiver le trajet",
    ),
    "oneOffTripDeactivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Desactiver ce trajet pour de nouvelles réservations ? Les réservations existantes restent inchangees.",
    ),
    "oneOffTripDeactivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel desactive.",
    ),
    "oneOffTripDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer le trajet",
    ),
    "oneOffTripDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "Ce trajet ne peut pas etre supprime car il a déjà des réservations.",
    ),
    "oneOffTripDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer ce trajet ponctuel de FleetFill ?",
    ),
    "oneOffTripDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel supprime.",
    ),
    "oneOffTripDepartureLabel": MessageLookupByLibrary.simpleMessage("Depart"),
    "oneOffTripDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez ce trajet avant de reserver.",
    ),
    "oneOffTripDetailPageTitle": MessageLookupByLibrary.simpleMessage(
      "Détails du trajet ponctuel",
    ),
    "oneOffTripDetailTitle": m13,
    "oneOffTripEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le trajet ponctuel",
    ),
    "oneOffTripEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Publiez un trajet date avec véhicule, ligne, depart et capacité.",
    ),
    "oneOffTripSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le trajet",
    ),
    "oneOffTripSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel mis a jour.",
    ),
    "openNotificationsAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir les notifications",
    ),
    "paymentFlowDescription": MessageLookupByLibrary.simpleMessage(
      "Suivez les etapes de paiement, televersez la preuve et consultez le statut de vérification.",
    ),
    "paymentFlowTitle": MessageLookupByLibrary.simpleMessage("Paiement"),
    "paymentInstructionsTitle": MessageLookupByLibrary.simpleMessage(
      "Instructions de paiement",
    ),
    "paymentProofAlreadyReviewedMessage": MessageLookupByLibrary.simpleMessage(
      "Cette preuve de paiement a déjà ete revue.",
    ),
    "paymentProofAmountLabel": MessageLookupByLibrary.simpleMessage(
      "Montant soumis",
    ),
    "paymentProofApprovedMessage": MessageLookupByLibrary.simpleMessage(
      "Paiement confirme.",
    ),
    "paymentProofDecisionNoteLabel": MessageLookupByLibrary.simpleMessage(
      "Note de decision",
    ),
    "paymentProofEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Televersez une preuve de paiement apres avoir paye en externe.",
    ),
    "paymentProofExactAmountRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Le montant verifie doit correspondre exactement au total de la réservation.",
    ),
    "paymentProofLatestTitle": MessageLookupByLibrary.simpleMessage(
      "Derniere preuve soumise",
    ),
    "paymentProofPendingWindowMessage": MessageLookupByLibrary.simpleMessage(
      "La preuve de paiement ne peut etre soumise que tant que le paiement est en attente.",
    ),
    "paymentProofReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "Reference soumise",
    ),
    "paymentProofRejectedMessage": MessageLookupByLibrary.simpleMessage(
      "Preuve de paiement rejetee.",
    ),
    "paymentProofRejectionReasonLabel": MessageLookupByLibrary.simpleMessage(
      "Motif du rejet",
    ),
    "paymentProofRejectionReasonRequiredMessage":
        MessageLookupByLibrary.simpleMessage("Un motif de rejet est requis."),
    "paymentProofResubmitAction": MessageLookupByLibrary.simpleMessage(
      "Renvoyer la preuve",
    ),
    "paymentProofSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Preuve de paiement",
    ),
    "paymentProofStatusLabel": MessageLookupByLibrary.simpleMessage(
      "Statut de la preuve",
    ),
    "paymentProofStatusPendingLabel": MessageLookupByLibrary.simpleMessage(
      "En attente de revue",
    ),
    "paymentProofStatusRejectedLabel": MessageLookupByLibrary.simpleMessage(
      "Rejetee",
    ),
    "paymentProofStatusVerifiedLabel": MessageLookupByLibrary.simpleMessage(
      "Verifiee",
    ),
    "paymentProofUploadAction": MessageLookupByLibrary.simpleMessage(
      "Televerser la preuve",
    ),
    "paymentProofUploadedMessage": MessageLookupByLibrary.simpleMessage(
      "Preuve de paiement recue.",
    ),
    "paymentProofVerifiedAmountLabel": MessageLookupByLibrary.simpleMessage(
      "Montant verifie",
    ),
    "paymentProofVerifiedReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "Reference verifiee",
    ),
    "paymentRailBankLabel": MessageLookupByLibrary.simpleMessage("Banque"),
    "paymentRailCcpLabel": MessageLookupByLibrary.simpleMessage("CCP"),
    "paymentRailDahabiaLabel": MessageLookupByLibrary.simpleMessage("Dahabia"),
    "paymentStatusProofSubmittedLabel": MessageLookupByLibrary.simpleMessage(
      "Preuve soumise",
    ),
    "paymentStatusRefundedLabel": MessageLookupByLibrary.simpleMessage(
      "Rembourse",
    ),
    "paymentStatusRejectedLabel": MessageLookupByLibrary.simpleMessage(
      "Rejete",
    ),
    "paymentStatusReleasedToCarrierLabel": MessageLookupByLibrary.simpleMessage(
      "Verse au transporteur",
    ),
    "paymentStatusSecuredLabel": MessageLookupByLibrary.simpleMessage(
      "Sécurisé",
    ),
    "paymentStatusUnderVerificationLabel": MessageLookupByLibrary.simpleMessage(
      "En vérification",
    ),
    "paymentStatusUnpaidLabel": MessageLookupByLibrary.simpleMessage(
      "Non paye",
    ),
    "payoutAccountAddAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter un compte de versement",
    ),
    "payoutAccountDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer le compte",
    ),
    "payoutAccountDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "Ce compte ne peut pas etre supprime pour le moment.",
    ),
    "payoutAccountDeleteConfirmationMessage":
        MessageLookupByLibrary.simpleMessage(
          "Supprimer ce compte de versement de FleetFill ?",
        ),
    "payoutAccountDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Compte de versement supprime.",
    ),
    "payoutAccountEditAction": MessageLookupByLibrary.simpleMessage(
      "Modifier le compte",
    ),
    "payoutAccountHolderLabel": MessageLookupByLibrary.simpleMessage(
      "Nom du titulaire",
    ),
    "payoutAccountIdentifierLabel": MessageLookupByLibrary.simpleMessage(
      "Numéro ou identifiant du compte",
    ),
    "payoutAccountInstitutionLabel": MessageLookupByLibrary.simpleMessage(
      "Banque ou nom CCP",
    ),
    "payoutAccountSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le compte",
    ),
    "payoutAccountSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Compte de versement enregistre.",
    ),
    "payoutAccountTypeBankLabel": MessageLookupByLibrary.simpleMessage(
      "Virement bancaire",
    ),
    "payoutAccountTypeCcpLabel": MessageLookupByLibrary.simpleMessage("CCP"),
    "payoutAccountTypeDahabiaLabel": MessageLookupByLibrary.simpleMessage(
      "Dahabia",
    ),
    "payoutAccountTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Rail de versement",
    ),
    "payoutAccountsDescription": MessageLookupByLibrary.simpleMessage(
      "Ajoutez et gerez les comptes sur lesquels vous recevez vos versements.",
    ),
    "payoutAccountsTitle": MessageLookupByLibrary.simpleMessage(
      "Comptes de versement",
    ),
    "phoneCompletionDescription": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un numéro de telephone pour continuer a utiliser FleetFill.",
    ),
    "phoneCompletionSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le numéro",
    ),
    "phoneCompletionSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Numéro de telephone enregistre.",
    ),
    "phoneCompletionTitle": MessageLookupByLibrary.simpleMessage(
      "Ajout du numéro de telephone",
    ),
    "priceCurrencyLabel": MessageLookupByLibrary.simpleMessage("DZD"),
    "pricePerKgUnitLabel": MessageLookupByLibrary.simpleMessage("DZD/kg"),
    "profileCarrierVerificationHint": MessageLookupByLibrary.simpleMessage(
      "Renseignez d\'abord vos informations transporteur, puis deposez les documents de vérification requis depuis votre profil.",
    ),
    "profileCompanyNameLabel": MessageLookupByLibrary.simpleMessage(
      "Nom de l\'entreprise",
    ),
    "profileFullNameLabel": MessageLookupByLibrary.simpleMessage("Nom complet"),
    "profileInvalidAlgerianPhoneMessage": MessageLookupByLibrary.simpleMessage(
      "Saisissez un numéro de téléphone algérien valide.",
    ),
    "profileInvalidCompanyNameMessage": MessageLookupByLibrary.simpleMessage(
      "Saisissez un nom d\'entreprise valide.",
    ),
    "profileInvalidNameMessage": MessageLookupByLibrary.simpleMessage(
      "Saisissez un nom complet valide avec des lettres arabes ou latines.",
    ),
    "profilePhoneLabel": MessageLookupByLibrary.simpleMessage(
      "Numéro de telephone",
    ),
    "profileSetupDescription": MessageLookupByLibrary.simpleMessage(
      "Ajoutez vos coordonnées pour que les clients, les transporteurs et le support puissent vous joindre.",
    ),
    "profileSetupSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le profil",
    ),
    "profileSetupSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Les informations du profil ont ete enregistrees.",
    ),
    "profileSetupTitle": MessageLookupByLibrary.simpleMessage(
      "Configuration du profil",
    ),
    "profileVerificationDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Documents du conducteur",
    ),
    "proofViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez ici la preuve de paiement de cette réservation ou ouvrez-la dans une autre application.",
    ),
    "proofViewerPageTitle": MessageLookupByLibrary.simpleMessage(
      "Preuve de paiement",
    ),
    "proofViewerTitle": m14,
    "publicationActiveLabel": MessageLookupByLibrary.simpleMessage("Actif"),
    "publicationEffectiveDateFutureMessage": MessageLookupByLibrary.simpleMessage(
      "Choisissez une date et une heure d\'effet egales ou posterieures a maintenant.",
    ),
    "publicationInactiveLabel": MessageLookupByLibrary.simpleMessage("Inactif"),
    "publicationNoRevisionsMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune revision de ligne n\'est encore enregistree.",
    ),
    "publicationRevisionHistoryTitle": MessageLookupByLibrary.simpleMessage(
      "Historique des revisions",
    ),
    "publicationSameLaneErrorMessage": MessageLookupByLibrary.simpleMessage(
      "L\'origine et la destination doivent être différentes.",
    ),
    "publicationSearchCommunesHint": MessageLookupByLibrary.simpleMessage(
      "Rechercher une commune",
    ),
    "publicationSelectValueAction": MessageLookupByLibrary.simpleMessage(
      "Selectionner",
    ),
    "publicationVehicleUnavailableMessage":
        MessageLookupByLibrary.simpleMessage(
          "Choisissez un de vos véhicules disponibles pour cette publication.",
        ),
    "publicationVerifiedCarrierRequiredMessage":
        MessageLookupByLibrary.simpleMessage(
          "Terminez la vérification transporteur avant de publier de la capacité.",
        ),
    "publicationVerifiedVehicleRequiredMessage":
        MessageLookupByLibrary.simpleMessage(
          "Choisissez un véhicule verifie avant de publier de la capacité.",
        ),
    "publicationWeekdaysRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Selectionnez au moins un jour de depart.",
    ),
    "ratingCommentLabel": MessageLookupByLibrary.simpleMessage("Commentaire"),
    "ratingSubmitAction": MessageLookupByLibrary.simpleMessage(
      "Envoyer un avis",
    ),
    "ratingSubmittedMessage": MessageLookupByLibrary.simpleMessage(
      "Avis transporteur envoye.",
    ),
    "retryLabel": MessageLookupByLibrary.simpleMessage("Reessayer"),
    "roleSelectionCarrierDescription": MessageLookupByLibrary.simpleMessage(
      "Publiez des trajets, gerez les réservations et suivez la vérification.",
    ),
    "roleSelectionCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "Continuer comme transporteur",
    ),
    "roleSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez comment vous souhaitez utiliser FleetFill. Cela prepare les bons outils pour votre compte.",
    ),
    "roleSelectionShipperDescription": MessageLookupByLibrary.simpleMessage(
      "Creez des expeditions, comparez les trajets exacts et suivez la livraison.",
    ),
    "roleSelectionShipperTitle": MessageLookupByLibrary.simpleMessage(
      "Continuer comme expéditeur",
    ),
    "roleSelectionTitle": MessageLookupByLibrary.simpleMessage("Choix du role"),
    "routeActivateAction": MessageLookupByLibrary.simpleMessage(
      "Activer la ligne",
    ),
    "routeActivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Activer cette ligne pour de nouvelles réservations ?",
    ),
    "routeActivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne activee.",
    ),
    "routeCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Ajouter un itinéraire",
    ),
    "routeCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne recurrente ajoutee.",
    ),
    "routeDeactivateAction": MessageLookupByLibrary.simpleMessage(
      "Desactiver la ligne",
    ),
    "routeDeactivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Desactiver cette ligne pour de nouvelles réservations ? Les réservations existantes restent inchangées.",
    ),
    "routeDeactivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne desactivee.",
    ),
    "routeDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer la ligne",
    ),
    "routeDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "Cette ligne ne peut pas etre supprimee car elle a déjà des réservations.",
    ),
    "routeDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer cette ligne recurrente de FleetFill ?",
    ),
    "routeDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne recurrente supprimee.",
    ),
    "routeDepartureTimeLabel": MessageLookupByLibrary.simpleMessage(
      "Heure de depart par defaut",
    ),
    "routeDestinationLabel": MessageLookupByLibrary.simpleMessage(
      "Commune d\'arrivee",
    ),
    "routeDestinationWilayaLabel": MessageLookupByLibrary.simpleMessage(
      "Wilaya d\'arrivee",
    ),
    "routeDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez ce trajet avant de reserver.",
    ),
    "routeDetailPageTitle": MessageLookupByLibrary.simpleMessage(
      "Détails de l\'itinéraire",
    ),
    "routeDetailTitle": m15,
    "routeEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier la ligne recurrente",
    ),
    "routeEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Publiez une ligne recurrente avec véhicule, horaire et capacité.",
    ),
    "routeEffectiveFromLabel": MessageLookupByLibrary.simpleMessage(
      "Effective a partir du",
    ),
    "routeErrorMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill n\'a pas pu ouvrir cet ecran.",
    ),
    "routeOriginLabel": MessageLookupByLibrary.simpleMessage(
      "Commune de depart",
    ),
    "routeOriginWilayaLabel": MessageLookupByLibrary.simpleMessage(
      "Wilaya de depart",
    ),
    "routePricePerKgLabel": MessageLookupByLibrary.simpleMessage(
      "Prix par kg (DZD)",
    ),
    "routeRecurringDaysLabel": MessageLookupByLibrary.simpleMessage(
      "Jours recurrents",
    ),
    "routeSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer la ligne",
    ),
    "routeSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne recurrente mise a jour.",
    ),
    "routeStatusLabel": MessageLookupByLibrary.simpleMessage(
      "Statut de publication",
    ),
    "routeVehicleLabel": MessageLookupByLibrary.simpleMessage(
      "Véhicule assigne",
    ),
    "sampleBasePriceAmount": MessageLookupByLibrary.simpleMessage("DZD 12,500"),
    "sampleBasePriceLabel": MessageLookupByLibrary.simpleMessage(
      "Prix de base",
    ),
    "samplePlatformFeeAmount": MessageLookupByLibrary.simpleMessage(
      "DZD 1,200",
    ),
    "samplePlatformFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Frais de plateforme",
    ),
    "sampleTotalAmount": MessageLookupByLibrary.simpleMessage("DZD 13,700"),
    "sampleTotalLabel": MessageLookupByLibrary.simpleMessage("Total"),
    "searchCarrierLabel": MessageLookupByLibrary.simpleMessage("Transporteur"),
    "searchCarrierRatingLabel": MessageLookupByLibrary.simpleMessage(
      "Note du transporteur",
    ),
    "searchDepartureLabel": MessageLookupByLibrary.simpleMessage("Depart"),
    "searchEstimatedPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Total estime",
    ),
    "searchRequestedDateLabel": MessageLookupByLibrary.simpleMessage(
      "Date de depart souhaitee",
    ),
    "searchResultTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Type de capacité",
    ),
    "searchShipmentSelectorLabel": MessageLookupByLibrary.simpleMessage(
      "Brouillon d\'expedition",
    ),
    "searchShipmentSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume de l\'expedition",
    ),
    "searchSortLowestPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Prix le plus bas",
    ),
    "searchSortNearestDepartureLabel": MessageLookupByLibrary.simpleMessage(
      "Depart le plus proche",
    ),
    "searchSortRecommendedLabel": MessageLookupByLibrary.simpleMessage(
      "Recommande",
    ),
    "searchSortTopRatedLabel": MessageLookupByLibrary.simpleMessage(
      "Mieux notes",
    ),
    "searchTripsAction": MessageLookupByLibrary.simpleMessage(
      "Rechercher une capacité exacte",
    ),
    "searchTripsControlsAction": MessageLookupByLibrary.simpleMessage(
      "Tri et filtres",
    ),
    "searchTripsDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez une expedition et une date pour trouver des trajets compatibles.",
    ),
    "searchTripsFilterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun resultat ne correspond au tri et aux filtres actuels.",
    ),
    "searchTripsNavLabel": MessageLookupByLibrary.simpleMessage("Recherche"),
    "searchTripsNearestDateMessage": m16,
    "searchTripsNearestDateTitle": MessageLookupByLibrary.simpleMessage(
      "Dates exactes les plus proches",
    ),
    "searchTripsNoRouteMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun trajet exact n\'existe pour cet axe dans la fenêtre proche.",
    ),
    "searchTripsNoRouteTitle": MessageLookupByLibrary.simpleMessage(
      "Redefinissez votre recherche",
    ),
    "searchTripsOneOffLabel": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel",
    ),
    "searchTripsRecurringLabel": MessageLookupByLibrary.simpleMessage(
      "Ligne recurrente",
    ),
    "searchTripsRequiresDraftMessage": MessageLookupByLibrary.simpleMessage(
      "Creez une expedition avant de rechercher des trajets compatibles.",
    ),
    "searchTripsResultsTitle": m17,
    "searchTripsTitle": MessageLookupByLibrary.simpleMessage(
      "Rechercher un trajet",
    ),
    "settingsAccountSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Compte",
    ),
    "settingsDescription": MessageLookupByLibrary.simpleMessage(
      "Gerez la langue, l\'apparence, les notifications et les options de support.",
    ),
    "settingsSignOutAction": MessageLookupByLibrary.simpleMessage(
      "Se deconnecter",
    ),
    "settingsSignedOutMessage": MessageLookupByLibrary.simpleMessage(
      "Votre session a été fermee.",
    ),
    "settingsThemeModeDarkLabel": MessageLookupByLibrary.simpleMessage(
      "Sombre",
    ),
    "settingsThemeModeLightLabel": MessageLookupByLibrary.simpleMessage(
      "Clair",
    ),
    "settingsThemeModeSystemLabel": MessageLookupByLibrary.simpleMessage(
      "Système",
    ),
    "settingsThemeModeTitle": MessageLookupByLibrary.simpleMessage("Theme"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "sharedScaffoldPreviewMessage": MessageLookupByLibrary.simpleMessage(
      "Cette fonctionnalite arrive bientot.",
    ),
    "sharedScaffoldPreviewTitle": MessageLookupByLibrary.simpleMessage(
      "Bientot disponible",
    ),
    "shipmentCreateAction": MessageLookupByLibrary.simpleMessage(
      "Creer une expedition",
    ),
    "shipmentCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Creer une expedition",
    ),
    "shipmentDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer l\'expedition",
    ),
    "shipmentDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer cette expedition ?",
    ),
    "shipmentDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Expedition supprimee.",
    ),
    "shipmentDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "Details de l\'expedition",
    ),
    "shipmentDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez le trajet, le poids, le volume et les details de l\'expedition.",
    ),
    "shipmentDetailPageTitle": MessageLookupByLibrary.simpleMessage(
      "Details de l\'expedition",
    ),
    "shipmentDetailTitle": m18,
    "shipmentEditAction": MessageLookupByLibrary.simpleMessage(
      "Modifier l\'expedition",
    ),
    "shipmentEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier l\'expedition",
    ),
    "shipmentSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer l\'expedition",
    ),
    "shipmentSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Expedition enregistree.",
    ),
    "shipmentStatusBookedLabel": MessageLookupByLibrary.simpleMessage(
      "Reserve",
    ),
    "shipmentStatusCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Annule",
    ),
    "shipmentStatusDraftLabel": MessageLookupByLibrary.simpleMessage(
      "Brouillon",
    ),
    "shipmentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Creez un brouillon d\'expedition avant de rechercher une capacité exacte.",
    ),
    "shipperHomeActiveBookingsLabel": MessageLookupByLibrary.simpleMessage(
      "Réservations actives",
    ),
    "shipperHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Suivez vos réservations actives, consultez les mises a jour et accedez rapidement aux actions importantes.",
    ),
    "shipperHomeNavLabel": MessageLookupByLibrary.simpleMessage("Accueil"),
    "shipperHomeNoRecentNotificationMessage":
        MessageLookupByLibrary.simpleMessage(
          "Vos dernieres mises a jour apparaitront ici.",
        ),
    "shipperHomeQuickActionsTitle": MessageLookupByLibrary.simpleMessage(
      "Actions rapides",
    ),
    "shipperHomeTitle": MessageLookupByLibrary.simpleMessage(
      "Accueil expéditeur",
    ),
    "shipperHomeUnreadNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Notifications non lues",
    ),
    "shipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Gerez vos coordonnées, vos reglages et vos options de support.",
    ),
    "shipperProfileNavLabel": MessageLookupByLibrary.simpleMessage("Profil"),
    "shipperProfileSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Détails expéditeur",
    ),
    "shipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Profil expéditeur",
    ),
    "splashDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill se prepare pour vous.",
    ),
    "splashTitle": MessageLookupByLibrary.simpleMessage("Preparation"),
    "startupConfigurationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill n\'est pas disponible pour le moment. Reessayez plus tard.",
    ),
    "startupConfigurationRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "FleetFill est indisponible",
    ),
    "statusNeedsReviewLabel": MessageLookupByLibrary.simpleMessage("A revoir"),
    "statusReadyLabel": MessageLookupByLibrary.simpleMessage("Pret"),
    "statusSetupRequiredLabel": MessageLookupByLibrary.simpleMessage(
      "Configuration requise",
    ),
    "supportConfiguredEmailMessage": m19,
    "supportDescription": MessageLookupByLibrary.simpleMessage(
      "Posez une question, signalez un probleme ou demandez de l\'aide pour une réservation ou un paiement.",
    ),
    "supportInboxEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez encore ouvert aucune demande de support.",
    ),
    "supportInboxTitle": MessageLookupByLibrary.simpleMessage(
      "Vos demandes de support",
    ),
    "supportLastUpdatedLabel": MessageLookupByLibrary.simpleMessage(
      "Derniere mise a jour",
    ),
    "supportLinkedBookingAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir la reservation",
    ),
    "supportLinkedDisputeAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir le litige",
    ),
    "supportLinkedPaymentProofAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir la preuve de paiement",
    ),
    "supportMessageLabel": MessageLookupByLibrary.simpleMessage(
      "Message au support",
    ),
    "supportMessageSenderAdminLabel": MessageLookupByLibrary.simpleMessage(
      "Support FleetFill",
    ),
    "supportMessageSenderSystemLabel": MessageLookupByLibrary.simpleMessage(
      "Systeme",
    ),
    "supportMessageSenderUserLabel": MessageLookupByLibrary.simpleMessage(
      "Vous",
    ),
    "supportMessageSentMessage": MessageLookupByLibrary.simpleMessage(
      "Message de support envoye.",
    ),
    "supportPriorityHighLabel": MessageLookupByLibrary.simpleMessage("Haute"),
    "supportPriorityLabel": MessageLookupByLibrary.simpleMessage("Priorite"),
    "supportPriorityNormalLabel": MessageLookupByLibrary.simpleMessage(
      "Normale",
    ),
    "supportPriorityUrgentLabel": MessageLookupByLibrary.simpleMessage(
      "Urgente",
    ),
    "supportRateLimitMessage": MessageLookupByLibrary.simpleMessage(
      "Vous avez envoye trop de messages de support recemment. Reessayez plus tard.",
    ),
    "supportReferenceHintMessage": MessageLookupByLibrary.simpleMessage(
      "Ajoutez tout identifiant de réservation, numéro de suivi ou reference de paiement qui aidera le support a enqueter plus vite.",
    ),
    "supportReplyAction": MessageLookupByLibrary.simpleMessage(
      "Envoyer la reponse",
    ),
    "supportReplyLabel": MessageLookupByLibrary.simpleMessage("Reponse"),
    "supportReplySentMessage": MessageLookupByLibrary.simpleMessage(
      "Votre reponse a ete envoyee.",
    ),
    "supportRequestCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Votre demande de support a ete creee.",
    ),
    "supportSendAction": MessageLookupByLibrary.simpleMessage(
      "Envoyer le message",
    ),
    "supportStatusClosedLabel": MessageLookupByLibrary.simpleMessage("Fermee"),
    "supportStatusInProgressLabel": MessageLookupByLibrary.simpleMessage(
      "En cours",
    ),
    "supportStatusLabel": MessageLookupByLibrary.simpleMessage("Statut"),
    "supportStatusOpenLabel": MessageLookupByLibrary.simpleMessage("Ouverte"),
    "supportStatusResolvedLabel": MessageLookupByLibrary.simpleMessage(
      "Resolue",
    ),
    "supportStatusWaitingForUserLabel": MessageLookupByLibrary.simpleMessage(
      "En attente de l\'utilisateur",
    ),
    "supportSubjectLabel": MessageLookupByLibrary.simpleMessage(
      "Sujet du support",
    ),
    "supportThreadDetailsTitle": MessageLookupByLibrary.simpleMessage(
      "Details de la demande",
    ),
    "supportThreadNoMessagesMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun message n\'a encore ete ajoute a cette demande.",
    ),
    "supportThreadOpenAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir la conversation",
    ),
    "supportThreadTitle": MessageLookupByLibrary.simpleMessage(
      "Conversation de support",
    ),
    "supportTitle": MessageLookupByLibrary.simpleMessage("Support"),
    "supportUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "Le message de support n\'a pas pu être mis en file d\'attente pour le moment. Reessayez sous peu.",
    ),
    "suspendedMessage": MessageLookupByLibrary.simpleMessage(
      "Votre compte est actuellement suspendu. Contactez le support FleetFill par e-mail.",
    ),
    "suspendedTitle": MessageLookupByLibrary.simpleMessage("Compte suspendu"),
    "trackingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Suivez la livraison, confirmez la reception, ouvrez un litige ou laissez un avis.",
    ),
    "trackingDetailPageTitle": MessageLookupByLibrary.simpleMessage("Suivi"),
    "trackingDetailTitle": m20,
    "trackingEventAutoCompletedNote": MessageLookupByLibrary.simpleMessage(
      "Reservation terminee automatiquement apres la fin de la fenetre de revue de livraison.",
    ),
    "trackingEventCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Annulee",
    ),
    "trackingEventCompletedLabel": MessageLookupByLibrary.simpleMessage(
      "Terminee",
    ),
    "trackingEventConfirmedLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmee",
    ),
    "trackingEventDeliveredPendingReviewLabel":
        MessageLookupByLibrary.simpleMessage("Livree en attente de revue"),
    "trackingEventDisputedLabel": MessageLookupByLibrary.simpleMessage(
      "Contestee",
    ),
    "trackingEventInTransitLabel": MessageLookupByLibrary.simpleMessage(
      "En transit",
    ),
    "trackingEventPaymentUnderReviewLabel":
        MessageLookupByLibrary.simpleMessage("Paiement en vérification"),
    "trackingEventPickedUpLabel": MessageLookupByLibrary.simpleMessage(
      "Ramassee",
    ),
    "trackingTimelineEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun evenement de suivi n\'est encore disponible.",
    ),
    "trackingTimelineTitle": MessageLookupByLibrary.simpleMessage(
      "Chronologie du suivi",
    ),
    "updateRequiredDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez FleetFill a jour pour continuer avec la derniere version prise en charge.",
    ),
    "updateRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Mise a jour requise",
    ),
    "userDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Les informations expéditeur et transporteur restent organisees par sections dans une seule vue detail.",
    ),
    "userDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Detail utilisateur",
    ),
    "vehicleCapacityVolumeLabel": MessageLookupByLibrary.simpleMessage(
      "Volume de capacité (m3)",
    ),
    "vehicleCapacityWeightLabel": MessageLookupByLibrary.simpleMessage(
      "Capacité de poids (kg)",
    ),
    "vehicleCreateAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter un véhicule",
    ),
    "vehicleCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Ajouter un véhicule",
    ),
    "vehicleCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Véhicule ajoute.",
    ),
    "vehicleDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer le véhicule",
    ),
    "vehicleDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer ce véhicule de FleetFill ?",
    ),
    "vehicleDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Véhicule supprime.",
    ),
    "vehicleDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Les détails du véhicule, les documents et le statut de vérification apparaissent ici.",
    ),
    "vehicleDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Detail véhicule",
    ),
    "vehicleEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le véhicule",
    ),
    "vehicleEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Gardez les donnees du véhicule a jour pour conserver des flux de route et de vérification valides.",
    ),
    "vehiclePlateLabel": MessageLookupByLibrary.simpleMessage(
      "Numéro d\'immatriculation",
    ),
    "vehiclePositiveNumberMessage": MessageLookupByLibrary.simpleMessage(
      "Entrez un nombre supérieur a zero.",
    ),
    "vehicleSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le véhicule",
    ),
    "vehicleSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Véhicule mis a jour.",
    ),
    "vehicleSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume du véhicule",
    ),
    "vehicleTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Type de véhicule",
    ),
    "vehicleVerificationDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Documents du véhicule",
    ),
    "vehicleVerificationRejectedBanner": m21,
    "vehiclesDescription": MessageLookupByLibrary.simpleMessage(
      "Ajoutez et gerez les véhicules utilises pour le transport.",
    ),
    "vehiclesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un véhicule avant de publier de la capacité ou de terminer la vérification complete.",
    ),
    "vehiclesTitle": MessageLookupByLibrary.simpleMessage("Véhicules"),
    "verificationDocumentDriverIdentityLabel":
        MessageLookupByLibrary.simpleMessage("Permis de conduire"),
    "verificationDocumentMissingMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun fichier téléversé pour le moment.",
    ),
    "verificationDocumentNeedsAttentionMessage":
        MessageLookupByLibrary.simpleMessage(
          "Consultez le motif du rejet puis telechargez un remplacement.",
        ),
    "verificationDocumentOpenPreparedMessage":
        MessageLookupByLibrary.simpleMessage(
          "Votre document est prêt à être consulté.",
        ),
    "verificationDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "Téléchargé et en attente d\'une revue admin.",
    ),
    "verificationDocumentRejectedFallbackReason":
        MessageLookupByLibrary.simpleMessage(
          "Veuillez revoir les exigences du document et televerser un fichier plus lisible.",
        ),
    "verificationDocumentRejectedMessage": m22,
    "verificationDocumentReplacedMessage": MessageLookupByLibrary.simpleMessage(
      "Document de vérification remplace.",
    ),
    "verificationDocumentTransportLicenseLabel":
        MessageLookupByLibrary.simpleMessage("Licence de transport (héritée)"),
    "verificationDocumentTruckInspectionLabel":
        MessageLookupByLibrary.simpleMessage("Controle technique du camion"),
    "verificationDocumentTruckInsuranceLabel":
        MessageLookupByLibrary.simpleMessage("Assurance du camion"),
    "verificationDocumentTruckRegistrationLabel":
        MessageLookupByLibrary.simpleMessage("Carte grise"),
    "verificationDocumentUploadedMessage": MessageLookupByLibrary.simpleMessage(
      "Document de vérification téléchargé.",
    ),
    "verificationDocumentVerifiedMessage": MessageLookupByLibrary.simpleMessage(
      "Verifie et accepte.",
    ),
    "verificationDocumentViewerTitle": MessageLookupByLibrary.simpleMessage(
      "Document de vérification",
    ),
    "verificationReplaceAction": MessageLookupByLibrary.simpleMessage(
      "Remplacer",
    ),
    "verificationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Terminez les etapes de vérification requises avant de continuer.",
    ),
    "verificationRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Vérification requise",
    ),
    "verificationUploadAction": MessageLookupByLibrary.simpleMessage(
      "Telecharger",
    ),
    "welcomeBackAction": MessageLookupByLibrary.simpleMessage("Retour"),
    "welcomeCarrierDescription": MessageLookupByLibrary.simpleMessage(
      "Publiez vos disponibilites et consultez les expeditions compatibles.",
    ),
    "welcomeCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "Vous avez une capacité de transport",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill met en relation les expeditions et la capacité disponible.",
    ),
    "welcomeExactMatchDescription": MessageLookupByLibrary.simpleMessage(
      "Les outils de recherche et de publication relient la bonne ligne et la bonne date.",
    ),
    "welcomeExactMatchTitle": MessageLookupByLibrary.simpleMessage(
      "Faire correspondre expedition et transport",
    ),
    "welcomeHighlightsMessage": MessageLookupByLibrary.simpleMessage(
      "Retrouvez la mise en relation, la preuve de paiement et les mises a jour de livraison au même endroit.",
    ),
    "welcomeLanguageAction": MessageLookupByLibrary.simpleMessage(
      "Choisir la langue",
    ),
    "welcomeLanguageDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez la langue de l\'application pour votre compte. Vous pourrez la modifier plus tard dans les reglages.",
    ),
    "welcomeLanguageTitle": MessageLookupByLibrary.simpleMessage(
      "Choisissez votre langue",
    ),
    "welcomeNextAction": MessageLookupByLibrary.simpleMessage("Suivant"),
    "welcomePaymentDescription": MessageLookupByLibrary.simpleMessage(
      "La preuve de paiement et les mises a jour restent visibles du debut a la livraison.",
    ),
    "welcomePaymentTitle": MessageLookupByLibrary.simpleMessage(
      "Gardez chaque réservation claire",
    ),
    "welcomeShipperDescription": MessageLookupByLibrary.simpleMessage(
      "Creez une expedition et consultez les options de transport compatibles.",
    ),
    "welcomeShipperTitle": MessageLookupByLibrary.simpleMessage(
      "Vous avez des marchandises a expedier",
    ),
    "welcomeSkipAction": MessageLookupByLibrary.simpleMessage("Passer"),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Expediez ou proposez un transport",
    ),
    "welcomeTrackingDescription": MessageLookupByLibrary.simpleMessage(
      "Suivez les mises à jour claires du statut entre la commande et la livraison, sans fausses cartes en temps réel.",
    ),
    "welcomeTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "Suivi simple par etapes",
    ),
    "welcomeTrustDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill garde la mise en relation et les mises a jour de réservation claires pour les deux parties.",
    ),
    "welcomeTrustTitle": MessageLookupByLibrary.simpleMessage(
      "Comment ca marche",
    ),
  };
}
