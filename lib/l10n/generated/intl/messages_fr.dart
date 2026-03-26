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

  static String m2(hours) =>
      "La demande s\'ouvre après une fenêtre de grâce de ${hours} heures une fois la réservation terminée.";

  static String m3(hours) =>
      "Cette réservation est encore dans la fenêtre de politique de versement de ${hours} heures ou attend un autre déblocage avant l\'ouverture de la demande.";

  static String m4(carrierId) => "Transporteur ${carrierId}";

  static String m5(reason) =>
      "La vérification requiert votre attention : ${reason}";

  static String m6(count) => "Fichiers sélectionnés : ${count}";

  static String m7(documentId) => "Document ${documentId}";

  static String m8(documentId) => "Document généré ${documentId}";

  static String m9(languageCode) =>
      "Langue actuelle de l\'application : ${languageCode}";

  static String m10(milestoneLabel) => "Statut actuel : ${milestoneLabel}";

  static String m11(notificationId) => "Notification ${notificationId}";

  static String m12(documentType) =>
      "Votre ${documentType} est prêt à être consulté en toute sécurité.";

  static String m13(status) =>
      "Le statut de votre demande de support est maintenant ${status}.";

  static String m14(documentType, reason) =>
      "Votre ${documentType} a été rejeté. Motif : ${reason}";

  static String m15(tripId) => "Trajet ponctuel ${tripId}";

  static String m16(amount, reference) =>
      "Envoyez exactement ${amount} DZD avec la référence de réservation ${reference}, puis téléversez la preuve ici.";

  static String m17(reason) =>
      "Votre preuve précédente a été rejetée pour la raison suivante : ${reason}. Corrigez-la puis renvoyez-la depuis cet écran.";

  static String m18(proofId) => "Preuve ${proofId}";

  static String m19(routeId) => "Route ${routeId}";

  static String m20(rating, departure) =>
      "Recommandé pour l\'équilibre : note ${rating}, départ ${departure}.";

  static String m21(amount) =>
      "Total estimé le plus bas à ${amount} DZD pour cet axe.";

  static String m22(departure) =>
      "Le départ le plus proche est prévu le ${departure}.";

  static String m23(rating, count) =>
      "Option la mieux notée avec une note de ${rating} sur ${count} avis.";

  static String m24(dates) =>
      "Aucun résultat exact le même jour. Dates exactes les plus proches : ${dates}";

  static String m25(count) => "Résultats de recherche (${count})";

  static String m26(shipmentId) => "Expédition ${shipmentId}";

  static String m27(supportEmail) => "E-mail du support : ${supportEmail}";

  static String m28(bookingId) => "Suivi ${bookingId}";

  static String m29(reason) =>
      "La vérification du véhicule requiert votre attention : ${reason}";

  static String m30(reason) => "Rejeté : ${reason}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "adminAuditLogDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez les dernières actions admin sensibles et leur résultat.",
    ),
    "adminAuditLogEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun évènement d\'audit admin n\'a encore été enregistré.",
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
      "La santé du backlog opérationnel, les alertes et les compteurs rapides apparaissent ici.",
    ),
    "adminDashboardEmailBacklogLabel": MessageLookupByLibrary.simpleMessage(
      "E-mails en attente",
    ),
    "adminDashboardEmailHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Distribution des e-mails transactionnels",
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
      "Aucun versement n\'est prêt à être libéré pour le moment.",
    ),
    "adminEmailDeadLetterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun e-mail en échec ne demande d\'action.",
    ),
    "adminEmailDeadLetterTitle": MessageLookupByLibrary.simpleMessage(
      "E-mails transactionnels en échec",
    ),
    "adminEmailErrorCodeLabel": MessageLookupByLibrary.simpleMessage(
      "Code d\'erreur",
    ),
    "adminEmailErrorMessageLabel": MessageLookupByLibrary.simpleMessage(
      "Message d\'erreur",
    ),
    "adminEmailLocaleLabel": MessageLookupByLibrary.simpleMessage(
      "Langue demandée",
    ),
    "adminEmailPayloadSnapshotLabel": MessageLookupByLibrary.simpleMessage(
      "Instantané de charge utile",
    ),
    "adminEmailProviderLabel": MessageLookupByLibrary.simpleMessage(
      "Fournisseur",
    ),
    "adminEmailQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun log e-mail ne correspond aux filtres actuels.",
    ),
    "adminEmailQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Distribution des e-mails transactionnels",
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
      "Rejeté",
    ),
    "adminEmailStatusDeadLetterLabel": MessageLookupByLibrary.simpleMessage(
      "En échec",
    ),
    "adminEmailStatusDeliveredLabel": MessageLookupByLibrary.simpleMessage(
      "Livré",
    ),
    "adminEmailStatusFilterLabel": MessageLookupByLibrary.simpleMessage(
      "Statut e-mail",
    ),
    "adminEmailStatusHardFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Échec définitif",
    ),
    "adminEmailStatusQueuedLabel": MessageLookupByLibrary.simpleMessage(
      "En file",
    ),
    "adminEmailStatusRenderFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Échec de rendu",
    ),
    "adminEmailStatusSentLabel": MessageLookupByLibrary.simpleMessage("Envoyé"),
    "adminEmailStatusSoftFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Échec temporaire",
    ),
    "adminEmailStatusSuppressedLabel": MessageLookupByLibrary.simpleMessage(
      "Supprimé",
    ),
    "adminEmailSubjectPreviewLabel": MessageLookupByLibrary.simpleMessage(
      "Aperçu de l\'objet",
    ),
    "adminEmailTemplateKeyLabel": MessageLookupByLibrary.simpleMessage(
      "Clé du modèle",
    ),
    "adminEmailTemplateLanguageLabel": MessageLookupByLibrary.simpleMessage(
      "Langue du modèle",
    ),
    "adminPaymentProofQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune preuve de paiement à revoir pour le moment.",
    ),
    "adminPaymentProofQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Revue des preuves de paiement",
    ),
    "adminPayoutEligibleTitle": MessageLookupByLibrary.simpleMessage(
      "Paiements éligibles",
    ),
    "adminPayoutQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun versement n\'a encore été libéré.",
    ),
    "adminPayoutQueueTitle": MessageLookupByLibrary.simpleMessage("Versements"),
    "adminPayoutReleaseAction": MessageLookupByLibrary.simpleMessage(
      "Lancer le paiement",
    ),
    "adminQueueDisputesTabLabel": MessageLookupByLibrary.simpleMessage(
      "Litiges",
    ),
    "adminQueueEmailTabLabel": MessageLookupByLibrary.simpleMessage(
      "E-mail transactionnel",
    ),
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
      "Les files de paiements, de vérification, de litiges, de versements et d\'e-mails sont regroupées sur une seule page.",
    ),
    "adminQueuesNavLabel": MessageLookupByLibrary.simpleMessage("Opérations"),
    "adminQueuesTitle": MessageLookupByLibrary.simpleMessage("Opérations"),
    "adminSettingsDeliveryGraceLabel": MessageLookupByLibrary.simpleMessage(
      "Fenêtre de grâce de livraison (heures)",
    ),
    "adminSettingsDeliverySectionTitle": MessageLookupByLibrary.simpleMessage(
      "Politique de revue de livraison",
    ),
    "adminSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "Gérez l\'accès à l\'application, les règles tarifaires, le mode maintenance et les outils e-mail.",
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
        MessageLookupByLibrary.simpleMessage("Fonctionnalités optionnelles"),
    "adminSettingsForceUpdateLabel": MessageLookupByLibrary.simpleMessage(
      "Mise à jour obligatoire",
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
      "Résumé du service",
    ),
    "adminSettingsNavLabel": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "adminSettingsPaymentDeadlineLabel": MessageLookupByLibrary.simpleMessage(
      "Délai de re-soumission du paiement (heures)",
    ),
    "adminSettingsPlatformFeeRateLabel": MessageLookupByLibrary.simpleMessage(
      "Taux de frais plateforme",
    ),
    "adminSettingsPricingSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Politique tarifaire",
    ),
    "adminSettingsRuntimeSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Accès à l\'application",
    ),
    "adminSettingsSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer",
    ),
    "adminSettingsSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Les paramètres admin ont été mis à jour.",
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
      "Aucune réservation n\'est liée à cet utilisateur.",
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
      "E-mails transactionnels recents",
    ),
    "adminUserReactivateAction": MessageLookupByLibrary.simpleMessage(
      "Réactiver l\'utilisateur",
    ),
    "adminUserReactivateSuccess": MessageLookupByLibrary.simpleMessage(
      "Utilisateur réactivé.",
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
      "Aucun véhicule n\'est lié à cet utilisateur.",
    ),
    "adminUserVehiclesSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Véhicules",
    ),
    "adminUsersDescription": MessageLookupByLibrary.simpleMessage(
      "Recherchez des utilisateurs et consultez leurs comptes, réservations et documents.",
    ),
    "adminUsersEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun utilisateur ne correspond à cette recherche.",
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
      "Le dossier de vérification a été approuvé.",
    ),
    "adminVerificationApprovedMessage": MessageLookupByLibrary.simpleMessage(
      "Le document de vérification a été approuvé.",
    ),
    "adminVerificationAuditEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun élément d\'audit de vérification récent.",
    ),
    "adminVerificationAuditTitle": MessageLookupByLibrary.simpleMessage(
      "Audit de vérification",
    ),
    "adminVerificationMissingDocumentsMessage":
        MessageLookupByLibrary.simpleMessage(
          "Aucun document de vérification n\'a encore été soumis.",
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
      "Résumé de la file de vérification",
    ),
    "adminVerificationQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Vérifications transporteur",
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
      "Le document de vérification a été rejeté.",
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
    "authBackToSignInAction": MessageLookupByLibrary.simpleMessage(
      "Retour à la connexion",
    ),
    "authCancelledMessage": MessageLookupByLibrary.simpleMessage(
      "Connexion annulée.",
    ),
    "authConfirmEmailDescription": MessageLookupByLibrary.simpleMessage(
      "Ouvrez le lien de confirmation dans votre boîte de réception pour activer ce compte et continuer dans FleetFill.",
    ),
    "authConfirmEmailMissingAddressMessage": MessageLookupByLibrary.simpleMessage(
      "Ouvrez cet écran juste après l\'inscription ou une tentative de connexion pour que FleetFill sache quelle boîte de réception doit recevoir le lien de confirmation.",
    ),
    "authConfirmEmailTitle": MessageLookupByLibrary.simpleMessage(
      "Confirmez votre e-mail",
    ),
    "authConfirmPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Répétez votre mot de passe",
    ),
    "authConfirmPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmer le mot de passe",
    ),
    "authContinueWithLabel": MessageLookupByLibrary.simpleMessage(
      "ou continuer avec",
    ),
    "authCreateAccountAction": MessageLookupByLibrary.simpleMessage(
      "Créer un compte",
    ),
    "authCreateAccountCta": MessageLookupByLibrary.simpleMessage(
      "Créer un nouveau compte",
    ),
    "authCreatePasswordHint": MessageLookupByLibrary.simpleMessage(
      "Créez un mot de passe fort",
    ),
    "authEmailDeliveryIssueMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill n\'a pas pu envoyer l\'e-mail de confirmation pour le moment. Vérifiez la redirection et le fournisseur e-mail puis réessayez.",
    ),
    "authEmailHint": MessageLookupByLibrary.simpleMessage("vous@exemple.com"),
    "authEmailLabel": MessageLookupByLibrary.simpleMessage("Adresse e-mail"),
    "authEmailNotConfirmedMessage": MessageLookupByLibrary.simpleMessage(
      "Confirmez votre e-mail avant de vous connecter.",
    ),
    "authForgotPasswordCta": MessageLookupByLibrary.simpleMessage(
      "Mot de passe oublié ?",
    ),
    "authForgotPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "La gestion des demandes de réinitialisation du mot de passe se fait dans l\'espace d\'authentification.",
    ),
    "authForgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Mot de passe oublié",
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
      "Vérifiez votre e-mail et votre mot de passe, puis réessayez.",
    ),
    "authInvalidEmailMessage": MessageLookupByLibrary.simpleMessage(
      "Saisissez une adresse e-mail valide.",
    ),
    "authKeepSignedInLabel": MessageLookupByLibrary.simpleMessage(
      "Rester connecté",
    ),
    "authNetworkErrorMessage": MessageLookupByLibrary.simpleMessage(
      "Problème réseau détecté. Réessayez dans un instant.",
    ),
    "authNewPasswordLabel": MessageLookupByLibrary.simpleMessage(
      "Nouveau mot de passe",
    ),
    "authOpenSignInAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir la connexion",
    ),
    "authPasswordHint": MessageLookupByLibrary.simpleMessage(
      "Entrez votre mot de passe",
    ),
    "authPasswordLabel": MessageLookupByLibrary.simpleMessage("Mot de passe"),
    "authPasswordMinLengthMessage": MessageLookupByLibrary.simpleMessage(
      "Utilisez au moins 8 caractères.",
    ),
    "authPasswordMismatchMessage": MessageLookupByLibrary.simpleMessage(
      "Les mots de passe ne correspondent pas.",
    ),
    "authPasswordResetInfoMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill enverra un lien de réinitialisation à l\'adresse e-mail du compte.",
    ),
    "authPasswordResetSentDescription": MessageLookupByLibrary.simpleMessage(
      "Ouvrez le lien de récupération reçu dans votre boîte de réception pour choisir un nouveau mot de passe.",
    ),
    "authPasswordResetSentTitle": MessageLookupByLibrary.simpleMessage(
      "Vérifiez votre e-mail",
    ),
    "authPasswordUpdatedMessage": MessageLookupByLibrary.simpleMessage(
      "Votre mot de passe a été mis à jour.",
    ),
    "authRateLimitedMessage": MessageLookupByLibrary.simpleMessage(
      "Trop de tentatives d\'authentification. Attendez un instant puis réessayez.",
    ),
    "authRequestAnotherLinkAction": MessageLookupByLibrary.simpleMessage(
      "Demander un nouveau lien",
    ),
    "authRequiredFieldMessage": MessageLookupByLibrary.simpleMessage(
      "Ce champ est obligatoire.",
    ),
    "authResendConfirmationAction": MessageLookupByLibrary.simpleMessage(
      "Renvoyer l\'e-mail de confirmation",
    ),
    "authResendResetEmailAction": MessageLookupByLibrary.simpleMessage(
      "Renvoyer l\'e-mail de réinitialisation",
    ),
    "authResetEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "Les instructions de réinitialisation ont été envoyées.",
    ),
    "authResetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Définissez un nouveau mot de passe après ouverture du lien de récupération sécurisé.",
    ),
    "authResetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Réinitialiser le mot de passe",
    ),
    "authResetPasswordUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "Ouvrez cet écran depuis le lien de récupération pour définir un nouveau mot de passe.",
    ),
    "authRoleAlreadyAssignedMessage": MessageLookupByLibrary.simpleMessage(
      "Le rôle de ce compte est déjà défini et ne peut pas être changé ici.",
    ),
    "authSendResetAction": MessageLookupByLibrary.simpleMessage(
      "Envoyer le lien de réinitialisation",
    ),
    "authSessionExpiredAction": MessageLookupByLibrary.simpleMessage(
      "Se reconnecter",
    ),
    "authSessionExpiredMessage": MessageLookupByLibrary.simpleMessage(
      "Votre session a pris fin. Reconnectez-vous pour continuer en toute sécurité.",
    ),
    "authSessionExpiredTitle": MessageLookupByLibrary.simpleMessage(
      "Session expirée",
    ),
    "authShowPasswordAction": MessageLookupByLibrary.simpleMessage(
      "Afficher le mot de passe",
    ),
    "authSignInAction": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "authSignInDescription": MessageLookupByLibrary.simpleMessage(
      "Les points d\'entrée de connexion par e-mail/mot de passe et Google se trouvent ici.",
    ),
    "authSignInSuccess": MessageLookupByLibrary.simpleMessage(
      "Connexion réussie.",
    ),
    "authSignInTitle": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "authSignUpDescription": MessageLookupByLibrary.simpleMessage(
      "Créez votre compte FleetFill pour expédier ou publier de la capacité.",
    ),
    "authSignUpTitle": MessageLookupByLibrary.simpleMessage("Créer un compte"),
    "authSignUpUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "La création de compte par e-mail n\'est pas disponible pour le moment.",
    ),
    "authUpdatePasswordAction": MessageLookupByLibrary.simpleMessage(
      "Mettre à jour le mot de passe",
    ),
    "authUseDifferentEmailAction": MessageLookupByLibrary.simpleMessage(
      "Utiliser un autre e-mail",
    ),
    "authUserAlreadyRegisteredMessage": MessageLookupByLibrary.simpleMessage(
      "Un compte existe déjà pour cet e-mail.",
    ),
    "authVerificationEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "Vérifiez votre e-mail pour confirmer le compte avant de vous connecter.",
    ),
    "authWeakPasswordMessage": MessageLookupByLibrary.simpleMessage(
      "Utilisez un mot de passe plus robuste puis réessayez.",
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
      "Consultez le statut de la réservation, les détails du paiement et le récapitulatif du prix.",
    ),
    "bookingDetailPageTitle": MessageLookupByLibrary.simpleMessage(
      "Détails de la réservation",
    ),
    "bookingDetailTitle": m1,
    "bookingInsuranceAction": MessageLookupByLibrary.simpleMessage(
      "Option d\'assurance",
    ),
    "bookingInsuranceDescription": MessageLookupByLibrary.simpleMessage(
      "L\'assurance est facultative et calculée en pourcentage avec un minimum.",
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
    "bookingNextActionTitle": MessageLookupByLibrary.simpleMessage(
      "Prochaine action",
    ),
    "bookingPaymentReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "Référence de paiement",
    ),
    "bookingPlatformFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Frais plateforme",
    ),
    "bookingPricingBreakdownAction": MessageLookupByLibrary.simpleMessage(
      "Détail du prix",
    ),
    "bookingReviewDescription": MessageLookupByLibrary.simpleMessage(
      "La reputation du transporteur, le detail du trajet et la revue du prix apparaissent ici avant le paiement.",
    ),
    "bookingReviewTitle": MessageLookupByLibrary.simpleMessage(
      "Revue de la réservation",
    ),
    "bookingStatusCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Annulée",
    ),
    "bookingStatusCompletedLabel": MessageLookupByLibrary.simpleMessage(
      "Terminée",
    ),
    "bookingStatusConfirmedLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmée",
    ),
    "bookingStatusDeliveredPendingReviewLabel":
        MessageLookupByLibrary.simpleMessage("Livrée en attente de revue"),
    "bookingStatusDisputedLabel": MessageLookupByLibrary.simpleMessage(
      "Contestée",
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
      "Ramassée",
    ),
    "bookingTaxFeeLabel": MessageLookupByLibrary.simpleMessage("Taxe"),
    "bookingTimelineActorAdminLabel": MessageLookupByLibrary.simpleMessage(
      "Admin",
    ),
    "bookingTimelineActorCarrierLabel": MessageLookupByLibrary.simpleMessage(
      "Transporteur",
    ),
    "bookingTimelineActorShipperLabel": MessageLookupByLibrary.simpleMessage(
      "Chargeur",
    ),
    "bookingTimelineActorSystemLabel": MessageLookupByLibrary.simpleMessage(
      "Système",
    ),
    "bookingTimelineCurrentLabel": MessageLookupByLibrary.simpleMessage(
      "État actuel",
    ),
    "bookingTotalLabel": MessageLookupByLibrary.simpleMessage("Total final"),
    "bookingTrackingNumberLabel": MessageLookupByLibrary.simpleMessage(
      "Numéro de suivi",
    ),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "carrierActiveBookingsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune réservation active ne demande votre attention pour le moment.",
    ),
    "carrierBookingsDescription": MessageLookupByLibrary.simpleMessage(
      "Suivez les réservations en cours, l\'avancement des livraisons et les missions terminées.",
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
      "Ajoutez votre numéro de téléphone avant d\'ouvrir cet espace transporteur afin de recevoir les mises à jour opérationnelles et de réservation.",
    ),
    "carrierGatePhoneTitle": MessageLookupByLibrary.simpleMessage(
      "Numéro de téléphone requis",
    ),
    "carrierGateVerificationMessage": MessageLookupByLibrary.simpleMessage(
      "Terminez la vérification transporteur avant d\'ouvrir cet espace pour publier des trajets ou gérer des réservations.",
    ),
    "carrierGateVerificationTitle": MessageLookupByLibrary.simpleMessage(
      "Vérification requise",
    ),
    "carrierHistoryBookingsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "L\'historique des réservations terminées et annulées apparaîtra ici.",
    ),
    "carrierHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez votre statut de vérification, l\'état de votre flotte et vos prochaines tâches.",
    ),
    "carrierHomeNavLabel": MessageLookupByLibrary.simpleMessage("Accueil"),
    "carrierHomeTitle": MessageLookupByLibrary.simpleMessage(
      "Accueil transporteur",
    ),
    "carrierMilestoneNoteLabel": MessageLookupByLibrary.simpleMessage(
      "Note d\'étape",
    ),
    "carrierMilestoneUpdatedMessage": MessageLookupByLibrary.simpleMessage(
      "Étape de réservation mise à jour.",
    ),
    "carrierNextActionAwaitingAdminRelease": MessageLookupByLibrary.simpleMessage(
      "Le versement a été demandé et attend la libération par l\'administration.",
    ),
    "carrierNextActionDelivery": MessageLookupByLibrary.simpleMessage(
      "Enregistrez la livraison dès que l\'envoi est remis.",
    ),
    "carrierNextActionPayoutRequest": MessageLookupByLibrary.simpleMessage(
      "Cette réservation est éligible au versement. Demandez votre versement quand vous êtes prêt.",
    ),
    "carrierNextActionPickup": MessageLookupByLibrary.simpleMessage(
      "Le ramassage est la prochaine étape opérationnelle pour cette réservation.",
    ),
    "carrierNextActionReleased": MessageLookupByLibrary.simpleMessage(
      "Cette réservation est réglée et le versement transporteur a été libéré.",
    ),
    "carrierNextActionTransit": MessageLookupByLibrary.simpleMessage(
      "Passez la réservation en transit dès que le chargement est en route.",
    ),
    "carrierPayoutBlockedReasonAccount": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un compte de versement actif avant de demander le versement.",
    ),
    "carrierPayoutBlockedReasonCompleted": MessageLookupByLibrary.simpleMessage(
      "La demande de versement ne s\'ouvre qu\'une fois la réservation terminée.",
    ),
    "carrierPayoutBlockedReasonDispute": MessageLookupByLibrary.simpleMessage(
      "Résolvez le litige ouvert avant de demander le versement.",
    ),
    "carrierPayoutBlockedReasonPayment": MessageLookupByLibrary.simpleMessage(
      "La demande de versement reste bloquée tant que le paiement n\'est pas sécurisé.",
    ),
    "carrierPayoutBlockedReasonReleased": MessageLookupByLibrary.simpleMessage(
      "Le versement a déjà été libéré pour cette réservation.",
    ),
    "carrierPayoutEligibleGuidance": MessageLookupByLibrary.simpleMessage(
      "Cette réservation est prête pour une demande de versement. Envoyez-la quand vous souhaitez que les opérations libèrent les fonds.",
    ),
    "carrierPayoutEligibleNowLabel": MessageLookupByLibrary.simpleMessage(
      "Éligible maintenant",
    ),
    "carrierPayoutGraceWindowLabel": MessageLookupByLibrary.simpleMessage(
      "Politique de versement",
    ),
    "carrierPayoutGraceWindowValue": m2,
    "carrierPayoutHistoryTitle": MessageLookupByLibrary.simpleMessage(
      "Historique des versements",
    ),
    "carrierPayoutPendingGuidance": m3,
    "carrierPayoutReleasedAtLabel": MessageLookupByLibrary.simpleMessage(
      "Versé le",
    ),
    "carrierPayoutReleasedGuidance": MessageLookupByLibrary.simpleMessage(
      "Le versement a été libéré pour cette réservation. Consultez l\'historique ci-dessous pour le dernier enregistrement.",
    ),
    "carrierPayoutRequestAction": MessageLookupByLibrary.simpleMessage(
      "Demander le versement",
    ),
    "carrierPayoutRequestNoteLabel": MessageLookupByLibrary.simpleMessage(
      "Note de demande de versement",
    ),
    "carrierPayoutRequestSuccessMessage": MessageLookupByLibrary.simpleMessage(
      "Demande de versement envoyée.",
    ),
    "carrierPayoutRequestedAtLabel": MessageLookupByLibrary.simpleMessage(
      "Demandé le",
    ),
    "carrierPayoutRequestedGuidance": MessageLookupByLibrary.simpleMessage(
      "Votre demande de versement est enregistrée. Les opérations admin vont la revoir puis la libérer vers votre compte de versement enregistré.",
    ),
    "carrierPayoutRequestedLabel": MessageLookupByLibrary.simpleMessage(
      "Demandé",
    ),
    "carrierPayoutSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Versement transporteur",
    ),
    "carrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Gérez les informations de votre entreprise, la vérification, les comptes de versement et les véhicules.",
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
      "Rejetée",
    ),
    "carrierProfileVerificationVerified": MessageLookupByLibrary.simpleMessage(
      "Vérifiée",
    ),
    "carrierPublicProfileCommentsTitle": MessageLookupByLibrary.simpleMessage(
      "Commentaires récents",
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
      "Résumé du transporteur",
    ),
    "carrierPublicProfileTitle": m4,
    "carrierVehiclesShortcutDescription": MessageLookupByLibrary.simpleMessage(
      "Gérez les camions, téléchargez les documents manquants et résolvez les blocages de vérification.",
    ),
    "carrierVerificationCenterDescription": MessageLookupByLibrary.simpleMessage(
      "Gérez la vérification transporteur depuis un seul endroit en déposant les documents du conducteur et du véhicule requis.",
    ),
    "carrierVerificationCenterTitle": MessageLookupByLibrary.simpleMessage(
      "Vérification transporteur",
    ),
    "carrierVerificationPendingBanner": MessageLookupByLibrary.simpleMessage(
      "Votre dossier de vérification est en cours de revue. Téléchargez les documents manquants pour accélérer l\'approbation.",
    ),
    "carrierVerificationQueueHint": MessageLookupByLibrary.simpleMessage(
      "Terminez les étapes de vérification restantes depuis votre profil.",
    ),
    "carrierVerificationRejectedBanner": m5,
    "carrierVerificationSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Résumé de vérification",
    ),
    "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirmer"),
    "contactSupportAction": MessageLookupByLibrary.simpleMessage(
      "Contacter le support",
    ),
    "createdAtLabel": MessageLookupByLibrary.simpleMessage("Créé le"),
    "deliveryConfirmAction": MessageLookupByLibrary.simpleMessage(
      "Confirmer la livraison",
    ),
    "deliveryConfirmedMessage": MessageLookupByLibrary.simpleMessage(
      "Livraison confirmée.",
    ),
    "disputeDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "Décrivez le problème",
    ),
    "disputeEvidenceAddAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter des fichiers de preuve",
    ),
    "disputeEvidenceEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun fichier de preuve n\'a encore ete joint a ce litige.",
    ),
    "disputeEvidenceSelectedCount": m6,
    "disputeEvidenceTitle": MessageLookupByLibrary.simpleMessage(
      "Pièces du litige",
    ),
    "disputeReasonLabel": MessageLookupByLibrary.simpleMessage(
      "Motif du litige",
    ),
    "documentPreviewUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "L\'aperçu n\'est pas disponible pour ce fichier. Ouvrez-le dans une autre application.",
    ),
    "documentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez ce document ici ou ouvrez-le dans une autre application.",
    ),
    "documentViewerOpenAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir le document",
    ),
    "documentViewerPageTitle": MessageLookupByLibrary.simpleMessage("Document"),
    "documentViewerTitle": m7,
    "documentViewerUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "L\'accès sécurisé au document est temporairement indisponible.",
    ),
    "editCarrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez à jour vos coordonnées et informations transporteur.",
    ),
    "editCarrierProfileSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Profil transporteur mis à jour.",
    ),
    "editCarrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le profil transporteur",
    ),
    "editShipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez à jour vos coordonnées expéditeur.",
    ),
    "editShipperProfileSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Profil expéditeur mis à jour.",
    ),
    "editShipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le profil expéditeur",
    ),
    "errorTitle": MessageLookupByLibrary.simpleMessage(
      "Un probleme est survenu",
    ),
    "forbiddenAdminStepUpMessage": MessageLookupByLibrary.simpleMessage(
      "Ré-authentifiez-vous récemment avant d\'ouvrir cette surface admin sensible.",
    ),
    "forbiddenMessage": MessageLookupByLibrary.simpleMessage(
      "Cette section n\'est pas accessible pour votre compte.",
    ),
    "forbiddenTitle": MessageLookupByLibrary.simpleMessage("Accès restreint"),
    "generatedDocumentAvailableAtLabel": MessageLookupByLibrary.simpleMessage(
      "Disponible le",
    ),
    "generatedDocumentDownloadAction": MessageLookupByLibrary.simpleMessage(
      "Télécharger le PDF",
    ),
    "generatedDocumentFailedMessage": MessageLookupByLibrary.simpleMessage(
      "Ce document n\'a pas encore pu être généré. Réessayez plus tard ou contactez le support si le problème persiste.",
    ),
    "generatedDocumentFailureReasonLabel": MessageLookupByLibrary.simpleMessage(
      "Probleme",
    ),
    "generatedDocumentOpenInBrowserAction":
        MessageLookupByLibrary.simpleMessage("Ouvrir dans le navigateur"),
    "generatedDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "Ce document est encore en cours de génération. Revenez dans un instant.",
    ),
    "generatedDocumentStatusFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Régénération requise",
    ),
    "generatedDocumentStatusPendingLabel": MessageLookupByLibrary.simpleMessage(
      "En génération",
    ),
    "generatedDocumentTypePaymentReceipt": MessageLookupByLibrary.simpleMessage(
      "Reçu de paiement",
    ),
    "generatedDocumentTypePayoutReceipt": MessageLookupByLibrary.simpleMessage(
      "Reçu de versement",
    ),
    "generatedDocumentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez ou téléchargez votre facture ou votre reçu.",
    ),
    "generatedDocumentViewerPageTitle": MessageLookupByLibrary.simpleMessage(
      "Document généré",
    ),
    "generatedDocumentViewerTitle": m8,
    "generatedDocumentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Les factures et reçus générés apparaîtront ici lorsqu\'ils seront disponibles.",
    ),
    "generatedDocumentsTapReadyHint": MessageLookupByLibrary.simpleMessage(
      "Touchez un document prêt pour l\'ouvrir de manière sécurisée.",
    ),
    "generatedDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Documents générés",
    ),
    "goBackAction": MessageLookupByLibrary.simpleMessage("Retour"),
    "languageOptionArabic": MessageLookupByLibrary.simpleMessage("Arabe"),
    "languageOptionEnglish": MessageLookupByLibrary.simpleMessage("Anglais"),
    "languageOptionFrench": MessageLookupByLibrary.simpleMessage("Français"),
    "languageSelectionCurrentMessage": m9,
    "languageSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez la langue à utiliser dans FleetFill.",
    ),
    "languageSelectionTitle": MessageLookupByLibrary.simpleMessage(
      "Choix de la langue",
    ),
    "legalDisputePolicyBody": MessageLookupByLibrary.simpleMessage(
      "Les litiges doivent être ouverts pendant la fenêtre de revue de livraison. FleetFill examine l\'expédition, la preuve de paiement, le suivi et les documents liés avant de résoudre le dossier. Le litige peut se terminer par une réservation finalisée, une annulation ou un remboursement.",
    ),
    "legalDisputePolicyTitle": MessageLookupByLibrary.simpleMessage(
      "Politique de litige",
    ),
    "legalPaymentDisclosureBody": MessageLookupByLibrary.simpleMessage(
      "Le détail du prix, les frais plateforme, les taxes et l\'assurance facultative sont affichés avant l\'envoi de la preuve. FleetFill vérifie la preuve de paiement par rapport au total de la réservation, sécurise les fonds avant la fin de livraison et ne libère le versement transporteur qu\'une fois la réservation éligible.",
    ),
    "legalPaymentDisclosureTitle": MessageLookupByLibrary.simpleMessage(
      "Information paiement et séquestre",
    ),
    "legalPoliciesDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez les règles sur les conditions, la confidentialité, le paiement et les litiges avant d\'utiliser FleetFill.",
    ),
    "legalPoliciesSupportHint": MessageLookupByLibrary.simpleMessage(
      "Si vous avez besoin d\'une clarification sur ces politiques, contactez le support FleetFill avant de poursuivre une réservation, un paiement ou un litige.",
    ),
    "legalPoliciesTitle": MessageLookupByLibrary.simpleMessage(
      "Politiques et informations",
    ),
    "legalPrivacyBody": MessageLookupByLibrary.simpleMessage(
      "FleetFill conserve les données de paiement, d\'expédition, de support et d\'audit uniquement pendant la durée nécessaire pour exploiter le service, traiter les litiges et respecter les obligations légales ou financières. L\'accès reste limité au titulaire du compte et au personnel autorisé.",
    ),
    "legalPrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Confidentialite et retention",
    ),
    "legalTermsBody": MessageLookupByLibrary.simpleMessage(
      "FleetFill reçoit le paiement de l\'expéditeur avant tout versement au transporteur. Chaque réservation couvre une expédition sur une seule ligne ou un seul trajet confirmé. L\'expéditeur reste responsable de l\'exactitude des détails d\'expédition et le transporteur reste responsable de documents valides et du respect des obligations de transport.",
    ),
    "legalTermsTitle": MessageLookupByLibrary.simpleMessage(
      "Conditions d\'utilisation",
    ),
    "loadMoreLabel": MessageLookupByLibrary.simpleMessage("Charger plus"),
    "loadingMessage": MessageLookupByLibrary.simpleMessage(
      "Préparation de votre expérience.",
    ),
    "loadingTitle": MessageLookupByLibrary.simpleMessage("Chargement"),
    "localBackendUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill ne peut pas joindre le backend local de développement. Utilisez le profil de lancement émulateur pour les émulateurs Android, et l\'adresse IP locale de votre ordinateur pour les appareils réels.",
    ),
    "localizationUnknownLabel": MessageLookupByLibrary.simpleMessage(
      "Mise à jour disponible",
    ),
    "locationUnavailableLabel": MessageLookupByLibrary.simpleMessage(
      "Lieu indisponible",
    ),
    "maintenanceDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill est temporairement indisponible pendant une intervention. Réessayez bientôt.",
    ),
    "maintenanceTitle": MessageLookupByLibrary.simpleMessage(
      "Nous revenons bientôt",
    ),
    "mediaUploadPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Autorisez l\'accès aux photos et aux fichiers pour téléverser une preuve de paiement et des documents.",
    ),
    "mediaUploadPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Autoriser les photos et les fichiers",
    ),
    "moneySummaryTitle": MessageLookupByLibrary.simpleMessage("Résumé du prix"),
    "myRoutesActiveRoutesLabel": MessageLookupByLibrary.simpleMessage(
      "Lignes récurrentes actives",
    ),
    "myRoutesActiveTripsLabel": MessageLookupByLibrary.simpleMessage(
      "Trajets ponctuels actifs",
    ),
    "myRoutesAddAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter de la capacité",
    ),
    "myRoutesCreateRouteAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter une ligne récurrente",
    ),
    "myRoutesCreateTripAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter un trajet ponctuel",
    ),
    "myRoutesDescription": MessageLookupByLibrary.simpleMessage(
      "Gérez vos lignes récurrentes et vos trajets ponctuels.",
    ),
    "myRoutesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Publiez une ligne récurrente ou un trajet ponctuel pour proposer de la capacité.",
    ),
    "myRoutesNavLabel": MessageLookupByLibrary.simpleMessage("Lignes"),
    "myRoutesOneOffTab": MessageLookupByLibrary.simpleMessage(
      "Trajets ponctuels",
    ),
    "myRoutesPublishedCapacityLabel": MessageLookupByLibrary.simpleMessage(
      "Capacité publiée",
    ),
    "myRoutesRecurringTab": MessageLookupByLibrary.simpleMessage(
      "Lignes récurrentes",
    ),
    "myRoutesReservedCapacityLabel": MessageLookupByLibrary.simpleMessage(
      "Capacité réservée",
    ),
    "myRoutesRouteListTitle": MessageLookupByLibrary.simpleMessage(
      "Lignes récurrentes",
    ),
    "myRoutesSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Résumé de publication",
    ),
    "myRoutesTitle": MessageLookupByLibrary.simpleMessage("Mes lignes"),
    "myRoutesTripListTitle": MessageLookupByLibrary.simpleMessage(
      "Trajets ponctuels",
    ),
    "myRoutesUpcomingDeparturesLabel": MessageLookupByLibrary.simpleMessage(
      "Départs à venir",
    ),
    "myRoutesUtilizationLabel": MessageLookupByLibrary.simpleMessage(
      "Utilisation",
    ),
    "myShipmentsDescription": MessageLookupByLibrary.simpleMessage(
      "Créez des expéditions, relisez vos brouillons et suivez les chargements réservés.",
    ),
    "myShipmentsNavLabel": MessageLookupByLibrary.simpleMessage("Expéditions"),
    "myShipmentsTitle": MessageLookupByLibrary.simpleMessage("Mes expéditions"),
    "noExactResultsMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune ligne exacte n\'est encore disponible pour cette recherche.",
    ),
    "noExactResultsTitle": MessageLookupByLibrary.simpleMessage(
      "Aucune ligne exacte trouvée",
    ),
    "notFoundMessage": MessageLookupByLibrary.simpleMessage(
      "La page ou l\'entité demandée est introuvable.",
    ),
    "notFoundTitle": MessageLookupByLibrary.simpleMessage("Introuvable"),
    "notificationBookingConfirmedBody": MessageLookupByLibrary.simpleMessage(
      "Votre réservation est confirmée. Suivez les étapes de paiement pour la maintenir sur la bonne voie.",
    ),
    "notificationBookingConfirmedTitle": MessageLookupByLibrary.simpleMessage(
      "Réservation confirmée",
    ),
    "notificationBookingMilestoneUpdatedBody": m10,
    "notificationBookingMilestoneUpdatedTitle":
        MessageLookupByLibrary.simpleMessage(
          "Étape de réservation mise à jour",
        ),
    "notificationCarrierReviewSubmittedBody":
        MessageLookupByLibrary.simpleMessage(
          "Un nouvel avis a été ajouté à votre profil.",
        ),
    "notificationCarrierReviewSubmittedTitle":
        MessageLookupByLibrary.simpleMessage("Avis transporteur reçu"),
    "notificationDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez le détail complet de cette notification.",
    ),
    "notificationDetailPageTitle": MessageLookupByLibrary.simpleMessage(
      "Notification",
    ),
    "notificationDetailTitle": m11,
    "notificationDisputeOpenedBody": MessageLookupByLibrary.simpleMessage(
      "Votre litige a été ouvert et est en attente d\'examen.",
    ),
    "notificationDisputeOpenedTitle": MessageLookupByLibrary.simpleMessage(
      "Litige ouvert",
    ),
    "notificationDisputeResolvedBody": MessageLookupByLibrary.simpleMessage(
      "Votre litige a été résolu. Consultez la dernière mise à jour de la réservation et du paiement.",
    ),
    "notificationDisputeResolvedTitle": MessageLookupByLibrary.simpleMessage(
      "Litige résolu",
    ),
    "notificationGeneratedDocumentReadyBody": m12,
    "notificationGeneratedDocumentReadyTitle":
        MessageLookupByLibrary.simpleMessage("Document prêt"),
    "notificationNewLabel": MessageLookupByLibrary.simpleMessage("Nouveau"),
    "notificationPaymentProofSubmittedBody": MessageLookupByLibrary.simpleMessage(
      "Nous avons reçu votre preuve de paiement. Nous allons la vérifier sous peu.",
    ),
    "notificationPaymentProofSubmittedTitle":
        MessageLookupByLibrary.simpleMessage("Preuve de paiement envoyée"),
    "notificationPaymentRejectedBody": MessageLookupByLibrary.simpleMessage(
      "Votre preuve de paiement a été rejetée. Vérifiez le motif et envoyez-en une nouvelle avant l\'échéance.",
    ),
    "notificationPaymentRejectedTitle": MessageLookupByLibrary.simpleMessage(
      "Preuve de paiement rejetée",
    ),
    "notificationPaymentSecuredBody": MessageLookupByLibrary.simpleMessage(
      "Votre paiement est sécurisé et la réservation est confirmée.",
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
          "Le support FleetFill a répondu à votre demande.",
        ),
    "notificationSupportReplyReceivedTitle":
        MessageLookupByLibrary.simpleMessage("Le support a répondu"),
    "notificationSupportRequestCreatedBody":
        MessageLookupByLibrary.simpleMessage(
          "Un utilisateur a ouvert une nouvelle demande de support à examiner.",
        ),
    "notificationSupportRequestCreatedTitle":
        MessageLookupByLibrary.simpleMessage("Nouvelle demande de support"),
    "notificationSupportStatusChangedBody": m13,
    "notificationSupportStatusChangedTitle":
        MessageLookupByLibrary.simpleMessage("Statut de support mis à jour"),
    "notificationSupportUserRepliedBody": MessageLookupByLibrary.simpleMessage(
      "Un utilisateur a répondu à une demande de support existante.",
    ),
    "notificationSupportUserRepliedTitle": MessageLookupByLibrary.simpleMessage(
      "L\'utilisateur a répondu",
    ),
    "notificationVerificationDocumentRejectedBody": m14,
    "notificationVerificationDocumentRejectedTitle":
        MessageLookupByLibrary.simpleMessage("Document de vérification rejeté"),
    "notificationVerificationPacketApprovedBody":
        MessageLookupByLibrary.simpleMessage(
          "Votre dossier de vérification a été approuvé. Vous pouvez maintenant poursuivre les opérations transporteur.",
        ),
    "notificationVerificationPacketApprovedTitle":
        MessageLookupByLibrary.simpleMessage("Vérification approuvée"),
    "notificationsCenterDescription": MessageLookupByLibrary.simpleMessage(
      "Restez informé des réservations, paiements, étapes de livraison et alertes du compte.",
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
      "Activez les notifications pour suivre les confirmations de réservation, les vérifications de paiement, les étapes de livraison et les alertes du compte sans ambiguïté.",
    ),
    "notificationsPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Activez les notifications pour recevoir les mises à jour de réservation, de livraison et de paiement.",
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
          "Gérez l\'autorisation et ouvrez votre centre de notifications.",
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
      "Trajet ponctuel activé.",
    ),
    "oneOffTripCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Ajouter un trajet ponctuel",
    ),
    "oneOffTripCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel ajouté.",
    ),
    "oneOffTripDeactivateAction": MessageLookupByLibrary.simpleMessage(
      "Désactiver le trajet",
    ),
    "oneOffTripDeactivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Désactiver ce trajet pour de nouvelles réservations ? Les réservations existantes restent inchangées.",
    ),
    "oneOffTripDeactivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel désactivé.",
    ),
    "oneOffTripDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer le trajet",
    ),
    "oneOffTripDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "Ce trajet ne peut pas être supprimé car il a déjà des réservations.",
    ),
    "oneOffTripDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer ce trajet ponctuel de FleetFill ?",
    ),
    "oneOffTripDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel supprimé.",
    ),
    "oneOffTripDepartureLabel": MessageLookupByLibrary.simpleMessage("Départ"),
    "oneOffTripDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez ce trajet avant de réserver.",
    ),
    "oneOffTripDetailPageTitle": MessageLookupByLibrary.simpleMessage(
      "Détails du trajet ponctuel",
    ),
    "oneOffTripDetailTitle": m15,
    "oneOffTripEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le trajet ponctuel",
    ),
    "oneOffTripEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Publiez un trajet daté avec véhicule, ligne, départ et capacité.",
    ),
    "oneOffTripSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le trajet",
    ),
    "oneOffTripSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel mis à jour.",
    ),
    "openNotificationsAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir les notifications",
    ),
    "operationsActiveLabel": MessageLookupByLibrary.simpleMessage("Actif"),
    "operationsHistoryLabel": MessageLookupByLibrary.simpleMessage(
      "Historique",
    ),
    "paymentFlowDescription": MessageLookupByLibrary.simpleMessage(
      "Suivez les étapes de paiement, téléversez la preuve et consultez le statut de vérification.",
    ),
<<<<<<< HEAD
=======
    "paymentFlowExactTransferGuidance": m16,
    "paymentFlowOpenAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir les détails du paiement",
    ),
    "paymentFlowRejectedGuidance": MessageLookupByLibrary.simpleMessage(
      "Votre preuve précédente a été rejetée. Corrigez les détails de paiement ou téléversez une preuve plus claire pour continuer.",
    ),
    "paymentFlowRejectedGuidanceWithReason": m17,
    "paymentFlowSecuredGuidance": MessageLookupByLibrary.simpleMessage(
      "Le paiement est sécurisé pour cette réservation. Conservez cet écran pour les reçus, l\'historique des preuves et les documents générés.",
    ),
    "paymentFlowSubmittedGuidance": MessageLookupByLibrary.simpleMessage(
      "Preuve reçue. La revue admin est en attente. Nous vous notifierons dès que le paiement sera sécurisé ou s\'il faut corriger quelque chose.",
    ),
>>>>>>> 7e581ab (Strengthen lifecycle workspaces and production integration)
    "paymentFlowTitle": MessageLookupByLibrary.simpleMessage("Paiement"),
    "paymentInstructionsTitle": MessageLookupByLibrary.simpleMessage(
      "Instructions de paiement",
    ),
    "paymentProofAlreadyReviewedMessage": MessageLookupByLibrary.simpleMessage(
      "Cette preuve de paiement a déjà été revue.",
    ),
    "paymentProofAmountLabel": MessageLookupByLibrary.simpleMessage(
      "Montant soumis",
    ),
    "paymentProofApprovedMessage": MessageLookupByLibrary.simpleMessage(
      "Paiement confirmé.",
    ),
    "paymentProofDecisionNoteLabel": MessageLookupByLibrary.simpleMessage(
      "Note de décision",
    ),
    "paymentProofEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Téléversez une preuve de paiement après avoir payé en externe.",
    ),
    "paymentProofExactAmountRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Le montant vérifié doit correspondre exactement au total de la réservation.",
    ),
    "paymentProofLatestTitle": MessageLookupByLibrary.simpleMessage(
      "Dernière preuve soumise",
    ),
    "paymentProofPendingWindowMessage": MessageLookupByLibrary.simpleMessage(
      "La preuve de paiement ne peut être soumise que tant que le paiement est en attente.",
    ),
    "paymentProofReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "Référence soumise",
    ),
    "paymentProofRejectedMessage": MessageLookupByLibrary.simpleMessage(
      "Preuve de paiement rejetée.",
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
      "Rejetée",
    ),
    "paymentProofStatusVerifiedLabel": MessageLookupByLibrary.simpleMessage(
      "Vérifiée",
    ),
    "paymentProofUploadAction": MessageLookupByLibrary.simpleMessage(
      "Téléverser la preuve",
    ),
    "paymentProofUploadedMessage": MessageLookupByLibrary.simpleMessage(
      "Preuve de paiement reçue.",
    ),
    "paymentProofVerifiedAmountLabel": MessageLookupByLibrary.simpleMessage(
      "Montant vérifié",
    ),
    "paymentProofVerifiedReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "Référence vérifiée",
    ),
    "paymentRailBankLabel": MessageLookupByLibrary.simpleMessage("Banque"),
    "paymentRailCcpLabel": MessageLookupByLibrary.simpleMessage("CCP"),
    "paymentRailDahabiaLabel": MessageLookupByLibrary.simpleMessage("Dahabia"),
    "paymentStatusProofSubmittedLabel": MessageLookupByLibrary.simpleMessage(
      "Preuve soumise",
    ),
    "paymentStatusRefundedLabel": MessageLookupByLibrary.simpleMessage(
      "Remboursé",
    ),
    "paymentStatusRejectedLabel": MessageLookupByLibrary.simpleMessage(
      "Rejeté",
    ),
    "paymentStatusReleasedToCarrierLabel": MessageLookupByLibrary.simpleMessage(
      "Versé au transporteur",
    ),
    "paymentStatusSecuredLabel": MessageLookupByLibrary.simpleMessage(
      "Sécurisé",
    ),
    "paymentStatusUnderVerificationLabel": MessageLookupByLibrary.simpleMessage(
      "En vérification",
    ),
    "paymentStatusUnpaidLabel": MessageLookupByLibrary.simpleMessage(
      "Non payé",
    ),
    "payoutAccountAddAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter un compte de versement",
    ),
    "payoutAccountDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer le compte",
    ),
    "payoutAccountDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "Ce compte ne peut pas être supprimé pour le moment.",
    ),
    "payoutAccountDeleteConfirmationMessage":
        MessageLookupByLibrary.simpleMessage(
          "Supprimer ce compte de versement de FleetFill ?",
        ),
    "payoutAccountDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Compte de versement supprimé.",
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
      "Compte de versement enregistré.",
    ),
    "payoutAccountTypeBankLabel": MessageLookupByLibrary.simpleMessage(
      "Virement bancaire",
    ),
    "payoutAccountTypeCcpLabel": MessageLookupByLibrary.simpleMessage("CCP"),
    "payoutAccountTypeDahabiaLabel": MessageLookupByLibrary.simpleMessage(
      "Dahabia",
    ),
    "payoutAccountTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Mode de versement",
    ),
    "payoutAccountsDescription": MessageLookupByLibrary.simpleMessage(
      "Ajoutez et gérez les comptes sur lesquels vous recevez vos versements.",
    ),
    "payoutAccountsTitle": MessageLookupByLibrary.simpleMessage(
      "Comptes de versement",
    ),
    "phoneCompletionDescription": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un numéro de téléphone pour continuer à utiliser FleetFill.",
    ),
    "phoneCompletionSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le numéro",
    ),
    "phoneCompletionSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Numéro de téléphone enregistré.",
    ),
    "phoneCompletionTitle": MessageLookupByLibrary.simpleMessage(
      "Ajout du numéro de téléphone",
    ),
    "priceCurrencyLabel": MessageLookupByLibrary.simpleMessage("DZD"),
    "pricePerKgUnitLabel": MessageLookupByLibrary.simpleMessage("DZD/kg"),
    "profileCarrierVerificationHint": MessageLookupByLibrary.simpleMessage(
      "Renseignez d\'abord vos informations transporteur, puis déposez les documents de vérification requis depuis votre profil.",
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
      "Numéro de téléphone",
    ),
    "profileSetupDescription": MessageLookupByLibrary.simpleMessage(
      "Ajoutez vos coordonnées pour que les clients, les transporteurs et le support puissent vous joindre.",
    ),
    "profileSetupSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le profil",
    ),
    "profileSetupSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Les informations du profil ont été enregistrées.",
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
    "proofViewerTitle": m18,
    "publicationActiveLabel": MessageLookupByLibrary.simpleMessage("Actif"),
    "publicationEffectiveDateFutureMessage": MessageLookupByLibrary.simpleMessage(
      "Choisissez une date et une heure d\'effet égales ou postérieures à maintenant.",
    ),
    "publicationInactiveLabel": MessageLookupByLibrary.simpleMessage("Inactif"),
    "publicationNoRevisionsMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune révision de ligne n\'est encore enregistrée.",
    ),
    "publicationRevisionHistoryTitle": MessageLookupByLibrary.simpleMessage(
      "Historique des révisions",
    ),
    "publicationSameLaneErrorMessage": MessageLookupByLibrary.simpleMessage(
      "L\'origine et la destination doivent être différentes.",
    ),
    "publicationSearchCommunesHint": MessageLookupByLibrary.simpleMessage(
      "Rechercher une commune",
    ),
    "publicationSelectValueAction": MessageLookupByLibrary.simpleMessage(
      "Sélectionner",
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
          "Choisissez un véhicule vérifié avant de publier de la capacité.",
        ),
    "publicationWeekdaysRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Sélectionnez au moins un jour de départ.",
    ),
    "ratingCommentLabel": MessageLookupByLibrary.simpleMessage("Commentaire"),
    "ratingSubmitAction": MessageLookupByLibrary.simpleMessage(
      "Envoyer un avis",
    ),
    "ratingSubmittedMessage": MessageLookupByLibrary.simpleMessage(
      "Avis transporteur envoyé.",
    ),
    "reasonLabel": MessageLookupByLibrary.simpleMessage("Motif"),
    "retryLabel": MessageLookupByLibrary.simpleMessage("Réessayer"),
    "roleSelectionCarrierDescription": MessageLookupByLibrary.simpleMessage(
      "Publiez des trajets, gérez les réservations et suivez la vérification.",
    ),
    "roleSelectionCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "Continuer comme transporteur",
    ),
    "roleSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez comment vous souhaitez utiliser FleetFill. Cela prépare les bons outils pour votre compte.",
    ),
    "roleSelectionShipperDescription": MessageLookupByLibrary.simpleMessage(
      "Créez des expéditions, comparez les trajets exacts et suivez la livraison.",
    ),
    "roleSelectionShipperTitle": MessageLookupByLibrary.simpleMessage(
      "Continuer comme expéditeur",
    ),
    "roleSelectionTitle": MessageLookupByLibrary.simpleMessage("Choix du rôle"),
    "routeActivateAction": MessageLookupByLibrary.simpleMessage(
      "Activer la ligne",
    ),
    "routeActivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Activer cette ligne pour de nouvelles réservations ?",
    ),
    "routeActivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne activée.",
    ),
    "routeCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Ajouter une ligne récurrente",
    ),
    "routeCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne récurrente ajoutée.",
    ),
    "routeDeactivateAction": MessageLookupByLibrary.simpleMessage(
      "Désactiver la ligne",
    ),
    "routeDeactivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Désactiver cette ligne pour de nouvelles réservations ? Les réservations existantes restent inchangées.",
    ),
    "routeDeactivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne désactivée.",
    ),
    "routeDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer la ligne",
    ),
    "routeDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "Cette ligne ne peut pas être supprimée car elle a déjà des réservations.",
    ),
    "routeDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer cette ligne récurrente de FleetFill ?",
    ),
    "routeDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne récurrente supprimée.",
    ),
    "routeDepartureTimeLabel": MessageLookupByLibrary.simpleMessage(
      "Heure de départ par défaut",
    ),
    "routeDestinationLabel": MessageLookupByLibrary.simpleMessage(
      "Commune d\'arrivée",
    ),
    "routeDestinationWilayaLabel": MessageLookupByLibrary.simpleMessage(
      "Wilaya d\'arrivée",
    ),
    "routeDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez ce trajet avant de réserver.",
    ),
    "routeDetailPageTitle": MessageLookupByLibrary.simpleMessage(
      "Détails de l\'itinéraire",
    ),
    "routeDetailTitle": m19,
    "routeEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier la ligne récurrente",
    ),
    "routeEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Publiez une ligne récurrente avec véhicule, horaire et capacité.",
    ),
    "routeEffectiveFromLabel": MessageLookupByLibrary.simpleMessage(
      "Effective à partir du",
    ),
    "routeErrorMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill n\'a pas pu ouvrir cet écran.",
    ),
    "routeOriginLabel": MessageLookupByLibrary.simpleMessage(
      "Commune de départ",
    ),
    "routeOriginWilayaLabel": MessageLookupByLibrary.simpleMessage(
      "Wilaya de départ",
    ),
    "routePricePerKgLabel": MessageLookupByLibrary.simpleMessage(
      "Prix par kg (DZD)",
    ),
    "routeRecurringDaysLabel": MessageLookupByLibrary.simpleMessage(
      "Jours récurrents",
    ),
    "routeSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer la ligne",
    ),
    "routeSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne récurrente mise à jour.",
    ),
    "routeStatusLabel": MessageLookupByLibrary.simpleMessage(
      "Statut de publication",
    ),
    "routeVehicleLabel": MessageLookupByLibrary.simpleMessage(
      "Véhicule assigné",
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
    "searchDepartureLabel": MessageLookupByLibrary.simpleMessage("Départ"),
    "searchEstimatedPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Total estimé",
    ),
    "searchRecommendationBalancedMessage": MessageLookupByLibrary.simpleMessage(
      "Meilleur équilibre entre timing, prix et réputation du transporteur.",
    ),
    "searchRecommendationBalancedResult": m20,
    "searchRecommendationLowestPriceMessage":
        MessageLookupByLibrary.simpleMessage(
          "Les totaux estimés les plus bas d\'abord pour réduire le coût.",
        ),
    "searchRecommendationLowestPriceResult": m21,
    "searchRecommendationNearestMessage": MessageLookupByLibrary.simpleMessage(
      "Les départs les plus proches d\'abord pour expédier plus vite.",
    ),
    "searchRecommendationNearestResult": m22,
    "searchRecommendationTopRatedMessage": MessageLookupByLibrary.simpleMessage(
      "Les transporteurs les mieux notés d\'abord pour maximiser la confiance.",
    ),
    "searchRecommendationTopRatedResult": m23,
    "searchRequestedDateLabel": MessageLookupByLibrary.simpleMessage(
      "Date de départ souhaitée",
    ),
    "searchResultTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Type de capacité",
    ),
    "searchShipmentSelectorLabel": MessageLookupByLibrary.simpleMessage(
      "Brouillon d\'expédition",
    ),
    "searchShipmentSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Résumé de l\'expédition",
    ),
    "searchSortLowestPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Prix le plus bas",
    ),
    "searchSortNearestDepartureLabel": MessageLookupByLibrary.simpleMessage(
      "Départ le plus proche",
    ),
    "searchSortRecommendedLabel": MessageLookupByLibrary.simpleMessage(
      "Recommandé",
    ),
    "searchSortTopRatedLabel": MessageLookupByLibrary.simpleMessage(
      "Mieux notés",
    ),
    "searchTripsAction": MessageLookupByLibrary.simpleMessage(
      "Rechercher une capacité exacte",
    ),
    "searchTripsControlsAction": MessageLookupByLibrary.simpleMessage(
      "Tri et filtres",
    ),
    "searchTripsDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez une expédition et une date pour trouver des trajets compatibles.",
    ),
    "searchTripsFilterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun résultat ne correspond au tri et aux filtres actuels.",
    ),
    "searchTripsNavLabel": MessageLookupByLibrary.simpleMessage("Recherche"),
    "searchTripsNearestDateMessage": m24,
    "searchTripsNearestDateTitle": MessageLookupByLibrary.simpleMessage(
      "Dates exactes les plus proches",
    ),
    "searchTripsNoRouteMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun trajet exact n\'existe pour cet axe dans la fenêtre proche.",
    ),
    "searchTripsNoRouteTitle": MessageLookupByLibrary.simpleMessage(
      "Redéfinissez votre recherche",
    ),
    "searchTripsOneOffLabel": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel",
    ),
    "searchTripsRecurringLabel": MessageLookupByLibrary.simpleMessage(
      "Ligne récurrente",
    ),
    "searchTripsRequiresDraftMessage": MessageLookupByLibrary.simpleMessage(
      "Créez une expédition avant de rechercher des trajets compatibles.",
    ),
    "searchTripsResultsTitle": m25,
    "searchTripsTitle": MessageLookupByLibrary.simpleMessage(
      "Rechercher un trajet",
    ),
    "settingsAccountSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Compte",
    ),
    "settingsDescription": MessageLookupByLibrary.simpleMessage(
      "Gérez la langue, l\'apparence, les notifications et les options de support.",
    ),
    "settingsSignOutAction": MessageLookupByLibrary.simpleMessage(
      "Se déconnecter",
    ),
    "settingsSignedOutMessage": MessageLookupByLibrary.simpleMessage(
      "Votre session a été fermée.",
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
    "settingsThemeModeTitle": MessageLookupByLibrary.simpleMessage("Thème"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Paramètres"),
    "sharedScaffoldPreviewMessage": MessageLookupByLibrary.simpleMessage(
      "Cette fonctionnalité arrive bientôt.",
    ),
    "sharedScaffoldPreviewTitle": MessageLookupByLibrary.simpleMessage(
      "Bientot disponible",
    ),
    "shipmentCreateAction": MessageLookupByLibrary.simpleMessage(
      "Créer une expédition",
    ),
    "shipmentCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Créer une expédition",
    ),
    "shipmentDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer l\'expédition",
    ),
    "shipmentDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer cette expedition ?",
    ),
    "shipmentDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Expédition supprimée.",
    ),
    "shipmentDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "Détails de l\'expédition",
    ),
    "shipmentDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez le trajet, le poids, le volume et les détails de l\'expédition.",
    ),
    "shipmentDetailPageTitle": MessageLookupByLibrary.simpleMessage(
      "Détails de l\'expédition",
    ),
    "shipmentDetailTitle": m26,
    "shipmentEditAction": MessageLookupByLibrary.simpleMessage(
      "Modifier l\'expédition",
    ),
    "shipmentEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier l\'expédition",
    ),
    "shipmentSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer l\'expédition",
    ),
    "shipmentSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Expédition enregistrée.",
    ),
    "shipmentStatusBookedLabel": MessageLookupByLibrary.simpleMessage(
      "Réservé",
    ),
    "shipmentStatusCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Annulé",
    ),
    "shipmentStatusDraftLabel": MessageLookupByLibrary.simpleMessage(
      "Brouillon",
    ),
    "shipmentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Créez un brouillon d\'expédition avant de rechercher une capacité exacte.",
    ),
    "shipperActiveOperationsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune expédition ou réservation active ne demande votre attention pour le moment.",
    ),
    "shipperHistoryOperationsEmptyMessage":
        MessageLookupByLibrary.simpleMessage(
          "L\'historique des expéditions terminées et annulées apparaîtra ici.",
        ),
    "shipperHomeActiveBookingsLabel": MessageLookupByLibrary.simpleMessage(
      "Réservations actives",
    ),
    "shipperHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Suivez vos réservations actives, consultez les mises à jour et accédez rapidement aux actions importantes.",
    ),
    "shipperHomeNavLabel": MessageLookupByLibrary.simpleMessage("Accueil"),
    "shipperHomeNoRecentNotificationMessage":
        MessageLookupByLibrary.simpleMessage(
          "Vos dernières mises à jour apparaîtront ici.",
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
    "shipperNextActionConfirmDelivery": MessageLookupByLibrary.simpleMessage(
      "Confirmez la livraison si tout est bien arrivé, ou ouvrez un litige si quelque chose ne va pas.",
    ),
    "shipperNextActionPayment": MessageLookupByLibrary.simpleMessage(
      "Envoyez ou renvoyez la preuve de paiement afin que FleetFill puisse sécuriser cette réservation.",
    ),
    "shipperNextActionReview": MessageLookupByLibrary.simpleMessage(
      "La preuve de paiement est en cours de revue. Aucune action n\'est requise de votre part pour le moment.",
    ),
    "shipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Gérez vos coordonnées, vos réglages et vos options de support.",
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
    "splashTitle": MessageLookupByLibrary.simpleMessage("Préparation"),
    "startupConfigurationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill n\'est pas disponible pour le moment. Réessayez plus tard.",
    ),
    "startupConfigurationRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "FleetFill est indisponible",
    ),
    "statusNeedsReviewLabel": MessageLookupByLibrary.simpleMessage("À revoir"),
    "statusPendingLabel": MessageLookupByLibrary.simpleMessage("En attente"),
    "statusReadyLabel": MessageLookupByLibrary.simpleMessage("Prêt"),
    "statusSetupRequiredLabel": MessageLookupByLibrary.simpleMessage(
      "Configuration requise",
    ),
    "supportConfiguredEmailMessage": m27,
    "supportDescription": MessageLookupByLibrary.simpleMessage(
      "Posez une question, signalez un problème ou demandez de l\'aide pour une réservation ou un paiement.",
    ),
    "supportInboxEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Vous n\'avez encore ouvert aucune demande de support.",
    ),
    "supportInboxTitle": MessageLookupByLibrary.simpleMessage(
      "Vos demandes de support",
    ),
    "supportLastUpdatedLabel": MessageLookupByLibrary.simpleMessage(
      "Dernière mise à jour",
    ),
    "supportLinkedBookingAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir la réservation",
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
      "Système",
    ),
    "supportMessageSenderUserLabel": MessageLookupByLibrary.simpleMessage(
      "Vous",
    ),
    "supportMessageSentMessage": MessageLookupByLibrary.simpleMessage(
      "Message de support envoyé.",
    ),
    "supportPriorityHighLabel": MessageLookupByLibrary.simpleMessage("Haute"),
    "supportPriorityLabel": MessageLookupByLibrary.simpleMessage("Priorité"),
    "supportPriorityNormalLabel": MessageLookupByLibrary.simpleMessage(
      "Normale",
    ),
    "supportPriorityUrgentLabel": MessageLookupByLibrary.simpleMessage(
      "Urgente",
    ),
    "supportRateLimitMessage": MessageLookupByLibrary.simpleMessage(
      "Vous avez envoyé trop de messages de support récemment. Réessayez plus tard.",
    ),
    "supportReferenceHintMessage": MessageLookupByLibrary.simpleMessage(
      "Ajoutez tout identifiant de réservation, numéro de suivi ou référence de paiement qui aidera le support à enquêter plus vite.",
    ),
    "supportReplyAction": MessageLookupByLibrary.simpleMessage(
      "Envoyer la réponse",
    ),
    "supportReplyLabel": MessageLookupByLibrary.simpleMessage("Réponse"),
    "supportReplySentMessage": MessageLookupByLibrary.simpleMessage(
      "Votre réponse a été envoyée.",
    ),
    "supportRequestCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Votre demande de support a été créée.",
    ),
    "supportSendAction": MessageLookupByLibrary.simpleMessage(
      "Envoyer le message",
    ),
    "supportStatusClosedLabel": MessageLookupByLibrary.simpleMessage("Fermée"),
    "supportStatusInProgressLabel": MessageLookupByLibrary.simpleMessage(
      "En cours",
    ),
    "supportStatusLabel": MessageLookupByLibrary.simpleMessage("Statut"),
    "supportStatusOpenLabel": MessageLookupByLibrary.simpleMessage("Ouverte"),
    "supportStatusResolvedLabel": MessageLookupByLibrary.simpleMessage(
      "Résolue",
    ),
    "supportStatusWaitingForUserLabel": MessageLookupByLibrary.simpleMessage(
      "En attente de l\'utilisateur",
    ),
    "supportSubjectLabel": MessageLookupByLibrary.simpleMessage(
      "Sujet du support",
    ),
    "supportThreadDetailsTitle": MessageLookupByLibrary.simpleMessage(
      "Détails de la demande",
    ),
    "supportThreadNoMessagesMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun message n\'a encore été ajouté à cette demande.",
    ),
    "supportThreadOpenAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir la conversation",
    ),
    "supportThreadTitle": MessageLookupByLibrary.simpleMessage(
      "Conversation de support",
    ),
    "supportTitle": MessageLookupByLibrary.simpleMessage("Support"),
    "supportUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "Le message de support n\'a pas pu être mis en file d\'attente pour le moment. Réessayez sous peu.",
    ),
    "suspendedMessage": MessageLookupByLibrary.simpleMessage(
      "Votre compte est actuellement suspendu. Contactez le support FleetFill par e-mail.",
    ),
    "suspendedTitle": MessageLookupByLibrary.simpleMessage("Compte suspendu"),
    "trackingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Suivez la livraison, confirmez la réception, ouvrez un litige ou laissez un avis.",
    ),
    "trackingDetailPageTitle": MessageLookupByLibrary.simpleMessage("Suivi"),
    "trackingDetailTitle": m28,
    "trackingEventAutoCompletedNote": MessageLookupByLibrary.simpleMessage(
      "Réservation terminée automatiquement après la fin de la fenêtre de revue de livraison.",
    ),
    "trackingEventCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Annulée",
    ),
    "trackingEventCompletedLabel": MessageLookupByLibrary.simpleMessage(
      "Terminée",
    ),
    "trackingEventConfirmedLabel": MessageLookupByLibrary.simpleMessage(
      "Confirmée",
    ),
    "trackingEventDeliveredPendingReviewLabel":
        MessageLookupByLibrary.simpleMessage("Livrée en attente de revue"),
    "trackingEventDisputedLabel": MessageLookupByLibrary.simpleMessage(
      "Contestée",
    ),
    "trackingEventInTransitLabel": MessageLookupByLibrary.simpleMessage(
      "En transit",
    ),
    "trackingEventPaymentUnderReviewLabel":
        MessageLookupByLibrary.simpleMessage("Paiement en vérification"),
    "trackingEventPayoutReleasedLabel": MessageLookupByLibrary.simpleMessage(
      "Versement libéré",
    ),
    "trackingEventPayoutRequestedLabel": MessageLookupByLibrary.simpleMessage(
      "Versement demandé",
    ),
    "trackingEventPickedUpLabel": MessageLookupByLibrary.simpleMessage(
      "Ramassée",
    ),
    "trackingEventRefundProcessedLabel": MessageLookupByLibrary.simpleMessage(
      "Remboursement traité",
    ),
    "trackingTimelineEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun évènement de suivi n\'est encore disponible.",
    ),
    "trackingTimelineTitle": MessageLookupByLibrary.simpleMessage(
      "Chronologie du suivi",
    ),
    "transferStatusCancelledLabel": MessageLookupByLibrary.simpleMessage(
      "Annulé",
    ),
    "transferStatusFailedLabel": MessageLookupByLibrary.simpleMessage("Échoué"),
    "transferStatusPendingLabel": MessageLookupByLibrary.simpleMessage(
      "En attente",
    ),
    "transferStatusSentLabel": MessageLookupByLibrary.simpleMessage("Envoyé"),
    "updateRequiredDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez FleetFill à jour pour continuer avec la dernière version prise en charge.",
    ),
    "updateRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Mise à jour requise",
    ),
    "userDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Les informations expéditeur et transporteur restent organisées par sections dans une seule vue détail.",
    ),
    "userDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Détail utilisateur",
    ),
    "vehicleCapacityVolumeLabel": MessageLookupByLibrary.simpleMessage(
      "Volume de capacité (m³)",
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
      "Véhicule ajouté.",
    ),
    "vehicleDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer le véhicule",
    ),
    "vehicleDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer ce véhicule de FleetFill ?",
    ),
    "vehicleDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Véhicule supprimé.",
    ),
    "vehicleDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Les détails du véhicule, les documents et le statut de vérification apparaissent ici.",
    ),
    "vehicleDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Détail véhicule",
    ),
    "vehicleEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le véhicule",
    ),
    "vehicleEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Gardez les données du véhicule à jour pour conserver des flux de route et de vérification valides.",
    ),
    "vehiclePlateLabel": MessageLookupByLibrary.simpleMessage(
      "Numéro d\'immatriculation",
    ),
    "vehiclePositiveNumberMessage": MessageLookupByLibrary.simpleMessage(
      "Entrez un nombre supérieur à zéro.",
    ),
    "vehicleSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le véhicule",
    ),
    "vehicleSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Véhicule mis à jour.",
    ),
    "vehicleSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Résumé du véhicule",
    ),
    "vehicleTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Type de véhicule",
    ),
    "vehicleVerificationDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Documents du véhicule",
    ),
    "vehicleVerificationRejectedBanner": m29,
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
          "Consultez le motif du rejet puis téléchargez un remplacement.",
        ),
    "verificationDocumentOpenPreparedMessage":
        MessageLookupByLibrary.simpleMessage(
          "Votre document est prêt à être consulté.",
        ),
    "verificationDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "Téléversé et en attente d\'une revue admin.",
    ),
    "verificationDocumentRejectedFallbackReason":
        MessageLookupByLibrary.simpleMessage(
          "Veuillez revoir les exigences du document et téléverser un fichier plus lisible.",
        ),
    "verificationDocumentRejectedMessage": m30,
    "verificationDocumentReplacedMessage": MessageLookupByLibrary.simpleMessage(
      "Document de vérification remplacé.",
    ),
    "verificationDocumentTransportLicenseLabel":
        MessageLookupByLibrary.simpleMessage("Licence de transport (héritée)"),
    "verificationDocumentTruckInspectionLabel":
        MessageLookupByLibrary.simpleMessage("Contrôle technique du camion"),
    "verificationDocumentTruckInsuranceLabel":
        MessageLookupByLibrary.simpleMessage("Assurance du camion"),
    "verificationDocumentTruckRegistrationLabel":
        MessageLookupByLibrary.simpleMessage("Carte grise"),
    "verificationDocumentUploadedMessage": MessageLookupByLibrary.simpleMessage(
      "Document de vérification téléversé.",
    ),
    "verificationDocumentVerifiedMessage": MessageLookupByLibrary.simpleMessage(
      "Vérifié et accepté.",
    ),
    "verificationDocumentViewerTitle": MessageLookupByLibrary.simpleMessage(
      "Document de vérification",
    ),
    "verificationReplaceAction": MessageLookupByLibrary.simpleMessage(
      "Remplacer",
    ),
    "verificationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Terminez les étapes de vérification requises avant de continuer.",
    ),
    "verificationRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Vérification requise",
    ),
    "verificationUploadAction": MessageLookupByLibrary.simpleMessage(
      "Téléverser",
    ),
    "welcomeBackAction": MessageLookupByLibrary.simpleMessage("Retour"),
    "welcomeCarrierDescription": MessageLookupByLibrary.simpleMessage(
      "Publiez vos disponibilités et consultez les expéditions compatibles.",
    ),
    "welcomeCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "Vous avez une capacité de transport",
    ),
    "welcomeDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill met en relation les expéditions et la capacité disponible.",
    ),
    "welcomeExactMatchDescription": MessageLookupByLibrary.simpleMessage(
      "Les outils de recherche et de publication relient la bonne ligne et la bonne date.",
    ),
    "welcomeExactMatchTitle": MessageLookupByLibrary.simpleMessage(
      "Faire correspondre expédition et transport",
    ),
    "welcomeHighlightsMessage": MessageLookupByLibrary.simpleMessage(
      "Retrouvez la mise en relation, la preuve de paiement et les mises à jour de livraison au même endroit.",
    ),
    "welcomeLanguageAction": MessageLookupByLibrary.simpleMessage(
      "Choisir la langue",
    ),
    "welcomeLanguageDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez la langue de l\'application pour votre compte. Vous pourrez la modifier plus tard dans les réglages.",
    ),
    "welcomeLanguageTitle": MessageLookupByLibrary.simpleMessage(
      "Choisissez votre langue",
    ),
    "welcomeNextAction": MessageLookupByLibrary.simpleMessage("Suivant"),
    "welcomePaymentDescription": MessageLookupByLibrary.simpleMessage(
      "La preuve de paiement et les mises à jour restent visibles du début à la livraison.",
    ),
    "welcomePaymentTitle": MessageLookupByLibrary.simpleMessage(
      "Gardez chaque réservation claire",
    ),
    "welcomeShipperDescription": MessageLookupByLibrary.simpleMessage(
      "Créez une expédition et consultez les options de transport compatibles.",
    ),
    "welcomeShipperTitle": MessageLookupByLibrary.simpleMessage(
      "Vous avez des marchandises à expédier",
    ),
    "welcomeSkipAction": MessageLookupByLibrary.simpleMessage("Passer"),
    "welcomeTitle": MessageLookupByLibrary.simpleMessage(
      "Expédiez ou proposez un transport",
    ),
    "welcomeTrackingDescription": MessageLookupByLibrary.simpleMessage(
      "Suivez les mises à jour claires du statut entre la commande et la livraison, sans fausses cartes en temps réel.",
    ),
    "welcomeTrackingTitle": MessageLookupByLibrary.simpleMessage(
      "Suivi simple par étapes",
    ),
    "welcomeTrustDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill garde la mise en relation et les mises à jour de réservation claires pour les deux parties.",
    ),
    "welcomeTrustTitle": MessageLookupByLibrary.simpleMessage(
      "Comment ça marche",
    ),
  };
}
