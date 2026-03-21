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
      "${documentCount} documents en attente sur ${vehicleCount} vehicules";

  static String m1(bookingId) => "Reservation ${bookingId}";

  static String m2(carrierId) => "Transporteur ${carrierId}";

  static String m3(reason) => "La verification demande une action : ${reason}";

  static String m4(count) => "Fichiers selectionnes : ${count}";

  static String m5(documentId) => "Document ${documentId}";

  static String m6(documentId) => "Document genere ${documentId}";

  static String m7(languageCode) => "Langue actuelle : ${languageCode}";

  static String m8(milestoneLabel) => "Derniere etape : ${milestoneLabel}";

  static String m9(notificationId) => "Notification ${notificationId}";

  static String m10(documentType) =>
      "Votre ${documentType} est pret a etre consulte en toute securite.";

  static String m11(tripId) => "Trajet ponctuel ${tripId}";

  static String m12(proofId) => "Preuve ${proofId}";

  static String m13(routeId) => "Route ${routeId}";

  static String m14(dates) =>
      "Aucun resultat exact le meme jour. Dates exactes les plus proches : ${dates}";

  static String m15(count) => "Resultats de recherche (${count})";

  static String m16(shipmentId) => "Expedition ${shipmentId}";

  static String m17(index) => "Article ${index}";

  static String m18(supportEmail) => "E-mail du support : ${supportEmail}";

  static String m19(bookingId) => "Suivi ${bookingId}";

  static String m20(reason) =>
      "La verification du vehicule demande une action : ${reason}";

  static String m21(reason) => "Rejete : ${reason}";

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
      "Sante des automatisations",
    ),
    "adminDashboardBacklogHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Sante du backlog",
    ),
    "adminDashboardDeadLetterLabel": MessageLookupByLibrary.simpleMessage(
      "E-mails dead-letter",
    ),
    "adminDashboardDescription": MessageLookupByLibrary.simpleMessage(
      "La sante du backlog operationnel, les alertes et les compteurs rapides apparaissent ici.",
    ),
    "adminDashboardEmailBacklogLabel": MessageLookupByLibrary.simpleMessage(
      "Backlog e-mail",
    ),
    "adminDashboardEmailHealthTitle": MessageLookupByLibrary.simpleMessage(
      "Sante des e-mails",
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
    "adminDisputesQueueTitle": MessageLookupByLibrary.simpleMessage(
      "File des litiges",
    ),
    "adminEligiblePayoutsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun paiement transporteur n\'est eligible pour diffusion pour le moment.",
    ),
    "adminEmailDeadLetterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun job e-mail dead-letter ne demande d\'action.",
    ),
    "adminEmailDeadLetterTitle": MessageLookupByLibrary.simpleMessage(
      "File dead-letter",
    ),
    "adminEmailQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun log e-mail ne correspond aux filtres actuels.",
    ),
    "adminEmailQueueTitle": MessageLookupByLibrary.simpleMessage(
      "Suivi des e-mails transactionnels",
    ),
    "adminEmailResendAction": MessageLookupByLibrary.simpleMessage("Renvoyer"),
    "adminEmailResendSuccess": MessageLookupByLibrary.simpleMessage(
      "Le renvoi de l\'e-mail a ete mis en file.",
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
      "Dead letter",
    ),
    "adminEmailStatusDeliveredLabel": MessageLookupByLibrary.simpleMessage(
      "Livre",
    ),
    "adminEmailStatusFilterLabel": MessageLookupByLibrary.simpleMessage(
      "Statut e-mail",
    ),
    "adminEmailStatusHardFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Echec definitif",
    ),
    "adminEmailStatusQueuedLabel": MessageLookupByLibrary.simpleMessage(
      "En file",
    ),
    "adminEmailStatusSentLabel": MessageLookupByLibrary.simpleMessage("Envoye"),
    "adminEmailStatusSoftFailedLabel": MessageLookupByLibrary.simpleMessage(
      "Echec temporaire",
    ),
    "adminEmailStatusSuppressedLabel": MessageLookupByLibrary.simpleMessage(
      "Supprime",
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
      "Aucun versement n\'a encore ete libere.",
    ),
    "adminPayoutQueueTitle": MessageLookupByLibrary.simpleMessage(
      "File des versements",
    ),
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
    "adminQueueVerificationTabLabel": MessageLookupByLibrary.simpleMessage(
      "Verification",
    ),
    "adminQueuesDescription": MessageLookupByLibrary.simpleMessage(
      "Les files de paiements, de verification, de litiges, de versements et d\'e-mails sont regroupees sur une seule page.",
    ),
    "adminQueuesNavLabel": MessageLookupByLibrary.simpleMessage("Files"),
    "adminQueuesTitle": MessageLookupByLibrary.simpleMessage("Files admin"),
    "adminSettingsDeliveryGraceLabel": MessageLookupByLibrary.simpleMessage(
      "Fenetre de grace de livraison (heures)",
    ),
    "adminSettingsDeliverySectionTitle": MessageLookupByLibrary.simpleMessage(
      "Politique de revue de livraison",
    ),
    "adminSettingsDescription": MessageLookupByLibrary.simpleMessage(
      "Les parametres de la plateforme, le mode maintenance, la politique de version et le resume du monitoring apparaissent ici.",
    ),
    "adminSettingsEmailResendEnabledLabel":
        MessageLookupByLibrary.simpleMessage(
          "Activer le renvoi admin des e-mails",
        ),
    "adminSettingsFeatureFlagsSectionTitle":
        MessageLookupByLibrary.simpleMessage("Feature flags"),
    "adminSettingsForceUpdateLabel": MessageLookupByLibrary.simpleMessage(
      "Mise a jour obligatoire",
    ),
    "adminSettingsInsuranceMinimumLabel": MessageLookupByLibrary.simpleMessage(
      "Minimum assurance",
    ),
    "adminSettingsInsuranceRateLabel": MessageLookupByLibrary.simpleMessage(
      "Taux d\'assurance",
    ),
    "adminSettingsMaintenanceModeLabel": MessageLookupByLibrary.simpleMessage(
      "Mode maintenance",
    ),
    "adminSettingsMinimumAndroidVersionLabel":
        MessageLookupByLibrary.simpleMessage("Version Android minimale"),
    "adminSettingsMinimumIosVersionLabel": MessageLookupByLibrary.simpleMessage(
      "Version iOS minimale",
    ),
    "adminSettingsMonitoringSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume du monitoring",
    ),
    "adminSettingsNavLabel": MessageLookupByLibrary.simpleMessage("Parametres"),
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
      "Politique runtime",
    ),
    "adminSettingsSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer",
    ),
    "adminSettingsSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Les parametres admin ont ete mis a jour.",
    ),
    "adminSettingsTitle": MessageLookupByLibrary.simpleMessage(
      "Parametres admin",
    ),
    "adminUserAccountSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Vue du compte",
    ),
    "adminUserBookingsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune reservation n\'est liee a cet utilisateur.",
    ),
    "adminUserBookingsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Reservations liees",
    ),
    "adminUserDocumentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun document de verification disponible pour cet utilisateur.",
    ),
    "adminUserDocumentsSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Documents de verification",
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
    "adminUserRoleAdminLabel": MessageLookupByLibrary.simpleMessage("Admin"),
    "adminUserRoleCarrierLabel": MessageLookupByLibrary.simpleMessage(
      "Transporteur",
    ),
    "adminUserRoleLabel": MessageLookupByLibrary.simpleMessage("Role"),
    "adminUserRoleShipperLabel": MessageLookupByLibrary.simpleMessage(
      "Expediteur",
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
      "Aucun vehicule n\'est lie a cet utilisateur.",
    ),
    "adminUserVehiclesSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Vehicules",
    ),
    "adminUsersDescription": MessageLookupByLibrary.simpleMessage(
      "La recherche et l\'investigation des utilisateurs se font ici.",
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
      "Le dossier de verification a ete approuve.",
    ),
    "adminVerificationApprovedMessage": MessageLookupByLibrary.simpleMessage(
      "Le document de verification a ete approuve.",
    ),
    "adminVerificationAuditEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun element d\'audit de verification recent.",
    ),
    "adminVerificationAuditTitle": MessageLookupByLibrary.simpleMessage(
      "Audit de verification",
    ),
    "adminVerificationMissingDocumentsMessage":
        MessageLookupByLibrary.simpleMessage(
          "Aucun document de verification n\'a encore ete soumis.",
        ),
    "adminVerificationPacketDescription": MessageLookupByLibrary.simpleMessage(
      "Revisez ensemble les documents de profil et de vehicule avant d\'ouvrir l\'acces operationnel.",
    ),
    "adminVerificationPacketTitle": MessageLookupByLibrary.simpleMessage(
      "Dossier de verification",
    ),
    "adminVerificationPendingDocumentsLabel":
        MessageLookupByLibrary.simpleMessage("Documents en attente"),
    "adminVerificationQueueEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun dossier de verification transporteur n\'attend une revue.",
    ),
    "adminVerificationQueueItemSubtitle": m0,
    "adminVerificationQueueSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume de la file de verification",
    ),
    "adminVerificationQueueTitle": MessageLookupByLibrary.simpleMessage(
      "File de verification transporteur",
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
      "Le document de verification a ete rejete.",
    ),
    "appGenericErrorMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill ne peut pas terminer cette action pour le moment.",
    ),
    "appTitle": MessageLookupByLibrary.simpleMessage("FleetFill"),
    "authAccountCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Votre compte a ete cree. Continuez en vous connectant.",
    ),
    "authAuthenticationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Connectez-vous pour continuer cette action.",
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
    "authGoogleStartedMessage": MessageLookupByLibrary.simpleMessage(
      "La connexion Google a commence. Revenez ici apres validation.",
    ),
    "authGoogleUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "La connexion Google n\'est pas disponible dans cet environnement.",
    ),
    "authHaveAccountCta": MessageLookupByLibrary.simpleMessage(
      "Vous avez deja un compte ? Connectez-vous",
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
      "Votre mot de passe a ete mis a jour.",
    ),
    "authRequiredFieldMessage": MessageLookupByLibrary.simpleMessage(
      "Ce champ est obligatoire.",
    ),
    "authResetEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "Les instructions de reinitialisation ont ete envoyees.",
    ),
    "authResetPasswordDescription": MessageLookupByLibrary.simpleMessage(
      "Definissez un nouveau mot de passe apres ouverture du lien de recuperation securise.",
    ),
    "authResetPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Reinitialiser le mot de passe",
    ),
    "authResetPasswordUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "Ouvrez cet ecran depuis le lien de recuperation pour definir un nouveau mot de passe.",
    ),
    "authRoleAlreadyAssignedMessage": MessageLookupByLibrary.simpleMessage(
      "Le role de ce compte est deja defini et ne peut pas etre change ici.",
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
      "Connexion reussie.",
    ),
    "authSignInTitle": MessageLookupByLibrary.simpleMessage("Se connecter"),
    "authSignUpDescription": MessageLookupByLibrary.simpleMessage(
      "Creez votre compte FleetFill pour expedier ou publier de la capacite.",
    ),
    "authSignUpTitle": MessageLookupByLibrary.simpleMessage("Creer un compte"),
    "authUpdatePasswordAction": MessageLookupByLibrary.simpleMessage(
      "Mettre a jour le mot de passe",
    ),
    "authUserAlreadyRegisteredMessage": MessageLookupByLibrary.simpleMessage(
      "Un compte existe deja pour cet e-mail.",
    ),
    "authVerificationEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "Verifiez votre e-mail pour confirmer le compte avant de vous connecter.",
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
      "Confirmer la reservation",
    ),
    "bookingCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Reservation creee. Continuez vers les instructions de paiement.",
    ),
    "bookingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Les details de reservation partages se trouvent au-dessus des espaces par role.",
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
      "Revue de la reservation",
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
        MessageLookupByLibrary.simpleMessage("Paiement en verification"),
    "bookingStatusPendingPaymentLabel": MessageLookupByLibrary.simpleMessage(
      "En attente de paiement",
    ),
    "bookingStatusPickedUpLabel": MessageLookupByLibrary.simpleMessage(
      "Ramassee",
    ),
    "bookingTaxFeeLabel": MessageLookupByLibrary.simpleMessage("Taxe"),
    "bookingTotalLabel": MessageLookupByLibrary.simpleMessage("Total final"),
    "bookingTrackingNumberLabel": MessageLookupByLibrary.simpleMessage(
      "Numero de suivi",
    ),
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Annuler"),
    "carrierBookingsDescription": MessageLookupByLibrary.simpleMessage(
      "Les listes de reservations actives et passees se trouvent dans cette section.",
    ),
    "carrierBookingsNavLabel": MessageLookupByLibrary.simpleMessage(
      "Reservations",
    ),
    "carrierBookingsTitle": MessageLookupByLibrary.simpleMessage(
      "Reservations transporteur",
    ),
    "carrierHomeDescription": MessageLookupByLibrary.simpleMessage(
      "La verification, les trajets, les actions sur les reservations et les rappels de versement apparaissent ici.",
    ),
    "carrierHomeNavLabel": MessageLookupByLibrary.simpleMessage("Accueil"),
    "carrierHomeTitle": MessageLookupByLibrary.simpleMessage(
      "Accueil transporteur",
    ),
    "carrierMilestoneUpdatedMessage": MessageLookupByLibrary.simpleMessage(
      "Etape de reservation mise a jour.",
    ),
    "carrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Le statut de verification transporteur, les rappels de versement et les outils de profil apparaissent ici.",
    ),
    "carrierProfileNavLabel": MessageLookupByLibrary.simpleMessage("Profil"),
    "carrierProfileSectionTitle": MessageLookupByLibrary.simpleMessage(
      "Details du transporteur",
    ),
    "carrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Profil transporteur",
    ),
    "carrierProfileVerificationLabel": MessageLookupByLibrary.simpleMessage(
      "Verification",
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
    "carrierPublicProfileDescription": MessageLookupByLibrary.simpleMessage(
      "La reputation publique du transporteur et les indicateurs de confiance apparaissent ici.",
    ),
    "carrierPublicProfileTitle": m2,
    "carrierVehiclesShortcutDescription": MessageLookupByLibrary.simpleMessage(
      "Gerez les camions, telechargez les documents manquants et resolvez les blocages de verification.",
    ),
    "carrierVerificationCenterDescription": MessageLookupByLibrary.simpleMessage(
      "Telechargez et remplacez les documents de verification du profil ou du vehicule depuis un seul endroit.",
    ),
    "carrierVerificationCenterTitle": MessageLookupByLibrary.simpleMessage(
      "Centre de verification",
    ),
    "carrierVerificationPendingBanner": MessageLookupByLibrary.simpleMessage(
      "Votre dossier de verification est en cours de revue. Telechargez les documents manquants pour accelerer l\'approbation.",
    ),
    "carrierVerificationQueueHint": MessageLookupByLibrary.simpleMessage(
      "Les exigences de verification et les documents manquants restent regroupes dans votre branche profil.",
    ),
    "carrierVerificationRejectedBanner": m3,
    "carrierVerificationSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume de verification",
    ),
    "confirmLabel": MessageLookupByLibrary.simpleMessage("Confirmer"),
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
    "documentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Ouvrez ce document dans un visualiseur securise lorsque l\'acces est pret.",
    ),
    "documentViewerOpenAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir le document",
    ),
    "documentViewerTitle": m5,
    "documentViewerUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "L\'acces securise au document est temporairement indisponible.",
    ),
    "editCarrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez a jour vos coordonnees et informations transporteur.",
    ),
    "editCarrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le profil transporteur",
    ),
    "editShipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez a jour vos coordonnees expediteur.",
    ),
    "editShipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le profil expediteur",
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
    "forbiddenTitle": MessageLookupByLibrary.simpleMessage("Acces restreint"),
    "generatedDocumentAvailableAtLabel": MessageLookupByLibrary.simpleMessage(
      "Disponible le",
    ),
    "generatedDocumentDownloadAction": MessageLookupByLibrary.simpleMessage(
      "Telecharger le PDF",
    ),
    "generatedDocumentFailedMessage": MessageLookupByLibrary.simpleMessage(
      "Ce document n\'a pas encore pu etre genere. Reessayez plus tard ou contactez le support si le probleme persiste.",
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
    "generatedDocumentTypeBookingInvoice": MessageLookupByLibrary.simpleMessage(
      "Facture de reservation",
    ),
    "generatedDocumentTypePaymentReceipt": MessageLookupByLibrary.simpleMessage(
      "Recu de paiement",
    ),
    "generatedDocumentTypePayoutReceipt": MessageLookupByLibrary.simpleMessage(
      "Recu de versement",
    ),
    "generatedDocumentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Ouvrez les factures et recus generes depuis une route partagee securisee.",
    ),
    "generatedDocumentViewerTitle": m6,
    "generatedDocumentsEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Les factures et recus generes apparaitront ici lorsqu\'ils seront disponibles.",
    ),
    "generatedDocumentsTapReadyHint": MessageLookupByLibrary.simpleMessage(
      "Touchez un document pret pour l\'ouvrir de maniere securisee.",
    ),
    "generatedDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Documents generes",
    ),
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
      "Les litiges doivent etre ouverts pendant la fenetre de revue de livraison. FleetFill examine les enregistrements d\'expedition, de preuve, de suivi et de finance avant de resoudre le dossier. La resolution peut finaliser la reservation, l\'annuler ou emettre un remboursement selon l\'issue operationnelle documentee.",
    ),
    "legalDisputePolicyTitle": MessageLookupByLibrary.simpleMessage(
      "Politique de litige",
    ),
    "legalPaymentDisclosureBody": MessageLookupByLibrary.simpleMessage(
      "Le detail du prix, les frais plateforme, les taxes et l\'assurance facultative sont affiches avant l\'envoi de la preuve. FleetFill verifie la preuve de paiement par rapport au total de la reservation, securise les fonds avant la fin de livraison et ne libere le versement transporteur qu\'une fois la reservation eligible.",
    ),
    "legalPaymentDisclosureTitle": MessageLookupByLibrary.simpleMessage(
      "Information paiement et sequestre",
    ),
    "legalPoliciesDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez les regles sur les conditions, la confidentialite, le paiement et les litiges avant un usage en production.",
    ),
    "legalPoliciesSupportHint": MessageLookupByLibrary.simpleMessage(
      "Si vous avez besoin d\'une clarification sur ces politiques, contactez le support FleetFill avant de poursuivre une reservation, un paiement ou un litige.",
    ),
    "legalPoliciesTitle": MessageLookupByLibrary.simpleMessage(
      "Politiques et informations",
    ),
    "legalPrivacyBody": MessageLookupByLibrary.simpleMessage(
      "FleetFill conserve les donnees operationnelles, de paiement, de preuve, de finance, de support et d\'audit uniquement pendant la duree necessaire pour exploiter le service, traiter les litiges et satisfaire les obligations financieres ou de conformite. L\'acces reste limite au role utilisateur et au personnel operationnel autorise.",
    ),
    "legalPrivacyTitle": MessageLookupByLibrary.simpleMessage(
      "Confidentialite et retention",
    ),
    "legalTermsBody": MessageLookupByLibrary.simpleMessage(
      "FleetFill recoit le paiement de l\'expediteur avant tout versement au transporteur. Chaque reservation couvre une expedition sur une seule ligne ou un seul trajet confirme. L\'expediteur reste responsable de l\'exactitude des details d\'expedition et le transporteur reste responsable de documents valides et du respect des obligations de transport.",
    ),
    "legalTermsTitle": MessageLookupByLibrary.simpleMessage(
      "Conditions d\'utilisation",
    ),
    "loadMoreLabel": MessageLookupByLibrary.simpleMessage("Charger plus"),
    "loadingMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill prepare votre espace de travail.",
    ),
    "loadingTitle": MessageLookupByLibrary.simpleMessage("Chargement"),
    "maintenanceDescription": MessageLookupByLibrary.simpleMessage(
      "FleetFill est temporairement indisponible pendant la maintenance.",
    ),
    "maintenanceTitle": MessageLookupByLibrary.simpleMessage(
      "Mode maintenance",
    ),
    "mediaUploadPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Indiquez a l\'utilisateur comment retrouver l\'acces aux medias lorsqu\'il doit televerser une preuve ou des documents.",
    ),
    "mediaUploadPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Autorisation d\'acces aux medias",
    ),
    "moneySummaryTitle": MessageLookupByLibrary.simpleMessage("Resume du prix"),
    "myRoutesActiveRoutesLabel": MessageLookupByLibrary.simpleMessage(
      "Lignes recurrentes actives",
    ),
    "myRoutesActiveTripsLabel": MessageLookupByLibrary.simpleMessage(
      "Trajets ponctuels actifs",
    ),
    "myRoutesAddAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter de la capacite",
    ),
    "myRoutesCreateRouteAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter une ligne recurrente",
    ),
    "myRoutesCreateTripAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter un trajet ponctuel",
    ),
    "myRoutesDescription": MessageLookupByLibrary.simpleMessage(
      "Les lignes recurrentes et les trajets ponctuels sont regroupes dans une seule section.",
    ),
    "myRoutesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Publiez une ligne recurrente ou un trajet ponctuel pour proposer de la capacite.",
    ),
    "myRoutesNavLabel": MessageLookupByLibrary.simpleMessage("Lignes"),
    "myRoutesOneOffTab": MessageLookupByLibrary.simpleMessage(
      "Trajets ponctuels",
    ),
    "myRoutesPublishedCapacityLabel": MessageLookupByLibrary.simpleMessage(
      "Capacite publiee",
    ),
    "myRoutesRecurringTab": MessageLookupByLibrary.simpleMessage(
      "Lignes recurrentes",
    ),
    "myRoutesReservedCapacityLabel": MessageLookupByLibrary.simpleMessage(
      "Capacite reservee",
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
      "Les expeditions actives, passees et en brouillon sont regroupees dans cette section.",
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
      "Votre reservation est enregistree. Continuez vers les instructions de paiement pour la faire avancer.",
    ),
    "notificationBookingConfirmedTitle": MessageLookupByLibrary.simpleMessage(
      "Reservation confirmee",
    ),
    "notificationBookingMilestoneUpdatedBody": m8,
    "notificationBookingMilestoneUpdatedTitle":
        MessageLookupByLibrary.simpleMessage(
          "Etape de reservation mise a jour",
        ),
    "notificationCarrierReviewSubmittedBody":
        MessageLookupByLibrary.simpleMessage(
          "Un nouvel avis expediteur a ete ajoute a votre profil.",
        ),
    "notificationCarrierReviewSubmittedTitle":
        MessageLookupByLibrary.simpleMessage("Avis transporteur recu"),
    "notificationDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez le detail complet de cette notification.",
    ),
    "notificationDetailTitle": m9,
    "notificationDisputeOpenedBody": MessageLookupByLibrary.simpleMessage(
      "Un litige a ete ouvert pour cette reservation et attend une revue admin.",
    ),
    "notificationDisputeOpenedTitle": MessageLookupByLibrary.simpleMessage(
      "Litige ouvert",
    ),
    "notificationDisputeResolvedBody": MessageLookupByLibrary.simpleMessage(
      "Le litige pour cette reservation a ete resolu. Consultez le dernier resultat de reservation et de paiement.",
    ),
    "notificationDisputeResolvedTitle": MessageLookupByLibrary.simpleMessage(
      "Litige resolu",
    ),
    "notificationGeneratedDocumentReadyBody": m10,
    "notificationGeneratedDocumentReadyTitle":
        MessageLookupByLibrary.simpleMessage("Document pret"),
    "notificationPaymentProofSubmittedBody":
        MessageLookupByLibrary.simpleMessage(
          "Votre preuve de paiement attend une revue.",
        ),
    "notificationPaymentProofSubmittedTitle":
        MessageLookupByLibrary.simpleMessage("Preuve de paiement envoyee"),
    "notificationPaymentRejectedBody": MessageLookupByLibrary.simpleMessage(
      "Votre preuve de paiement a ete rejetee. Revisez le motif et renvoyez-la avant l\'echeance.",
    ),
    "notificationPaymentRejectedTitle": MessageLookupByLibrary.simpleMessage(
      "Preuve de paiement rejetee",
    ),
    "notificationPaymentSecuredBody": MessageLookupByLibrary.simpleMessage(
      "Votre paiement est securise et la reservation est confirmee.",
    ),
    "notificationPaymentSecuredTitle": MessageLookupByLibrary.simpleMessage(
      "Paiement securise",
    ),
    "notificationPayoutReleasedBody": MessageLookupByLibrary.simpleMessage(
      "Le paiement du transporteur a ete libere pour cette reservation.",
    ),
    "notificationPayoutReleasedTitle": MessageLookupByLibrary.simpleMessage(
      "Paiement transporteur libere",
    ),
    "notificationsCenterDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez les alertes recentes, les mises a jour de reservation et les rappels utiles.",
    ),
    "notificationsCenterTitle": MessageLookupByLibrary.simpleMessage(
      "Notifications",
    ),
    "notificationsPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Expliquez pourquoi le suivi et les mises a jour de reservation comptent avant d\'ouvrir les parametres systeme.",
    ),
    "notificationsPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Autorisation des notifications",
    ),
    "offlineMessage": MessageLookupByLibrary.simpleMessage(
      "Vous etes hors ligne. Certaines actions sont temporairement indisponibles.",
    ),
    "oneOffTripActivateAction": MessageLookupByLibrary.simpleMessage(
      "Activer le trajet",
    ),
    "oneOffTripActivateConfirmationMessage":
        MessageLookupByLibrary.simpleMessage(
          "Activer ce trajet pour de nouvelles reservations ?",
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
      "Desactiver ce trajet pour de nouvelles reservations ? Les reservations existantes restent inchangees.",
    ),
    "oneOffTripDeactivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel desactive.",
    ),
    "oneOffTripDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer le trajet",
    ),
    "oneOffTripDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "Ce trajet ne peut pas etre supprime car il a deja des reservations.",
    ),
    "oneOffTripDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer ce trajet ponctuel de FleetFill ?",
    ),
    "oneOffTripDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel supprime.",
    ),
    "oneOffTripDepartureLabel": MessageLookupByLibrary.simpleMessage("Depart"),
    "oneOffTripDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez ce trajet ponctuel avant reservation ou suivi operationnel.",
    ),
    "oneOffTripDetailTitle": m11,
    "oneOffTripEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le trajet ponctuel",
    ),
    "oneOffTripEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Publiez un trajet date avec vehicule, ligne, depart et capacite.",
    ),
    "oneOffTripSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le trajet",
    ),
    "oneOffTripSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Trajet ponctuel mis a jour.",
    ),
    "paymentFlowDescription": MessageLookupByLibrary.simpleMessage(
      "Les instructions, la reference, le televersement de preuve et le statut du paiement restent dans un flux coherent.",
    ),
    "paymentFlowTitle": MessageLookupByLibrary.simpleMessage(
      "Parcours de paiement",
    ),
    "paymentInstructionsTitle": MessageLookupByLibrary.simpleMessage(
      "Instructions de paiement",
    ),
    "paymentProofAlreadyReviewedMessage": MessageLookupByLibrary.simpleMessage(
      "Cette preuve de paiement a deja ete revue.",
    ),
    "paymentProofAmountLabel": MessageLookupByLibrary.simpleMessage(
      "Montant soumis",
    ),
    "paymentProofApprovedMessage": MessageLookupByLibrary.simpleMessage(
      "Preuve de paiement approuvee.",
    ),
    "paymentProofDecisionNoteLabel": MessageLookupByLibrary.simpleMessage(
      "Note de decision",
    ),
    "paymentProofEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Televersez une preuve de paiement apres avoir paye en externe.",
    ),
    "paymentProofExactAmountRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Le montant verifie doit correspondre exactement au total de la reservation.",
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
      "Preuve de paiement televersee.",
    ),
    "paymentProofVerifiedAmountLabel": MessageLookupByLibrary.simpleMessage(
      "Montant verifie",
    ),
    "paymentProofVerifiedReferenceLabel": MessageLookupByLibrary.simpleMessage(
      "Reference verifiee",
    ),
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
      "Securise",
    ),
    "paymentStatusUnderVerificationLabel": MessageLookupByLibrary.simpleMessage(
      "En verification",
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
      "Numero ou identifiant du compte",
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
      "Les comptes de versement transporteur sont regroupes dans la section profil.",
    ),
    "payoutAccountsTitle": MessageLookupByLibrary.simpleMessage(
      "Comptes de versement",
    ),
    "phoneCompletionDescription": MessageLookupByLibrary.simpleMessage(
      "Les actions operationnelles restent bloquees tant qu\'un numero de telephone n\'est pas renseigne.",
    ),
    "phoneCompletionSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le numero",
    ),
    "phoneCompletionSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Numero de telephone enregistre.",
    ),
    "phoneCompletionTitle": MessageLookupByLibrary.simpleMessage(
      "Ajout du numero de telephone",
    ),
    "priceCurrencyLabel": MessageLookupByLibrary.simpleMessage("DZD"),
    "pricePerKgUnitLabel": MessageLookupByLibrary.simpleMessage("DZD/kg"),
    "profileCarrierVerificationHint": MessageLookupByLibrary.simpleMessage(
      "Renseignez d\'abord vos informations transporteur, puis deposez les documents de verification requis depuis votre profil.",
    ),
    "profileCompanyNameLabel": MessageLookupByLibrary.simpleMessage(
      "Nom de l\'entreprise",
    ),
    "profileFullNameLabel": MessageLookupByLibrary.simpleMessage("Nom complet"),
    "profilePhoneLabel": MessageLookupByLibrary.simpleMessage(
      "Numero de telephone",
    ),
    "profileSetupDescription": MessageLookupByLibrary.simpleMessage(
      "Completez les informations requises du profil avant d\'utiliser les fonctions operationnelles.",
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
      "Documents de verification du profil",
    ),
    "proofViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Ouvrez cette preuve depuis une route partagee securisee lorsque l\'acces est pret.",
    ),
    "proofViewerTitle": m12,
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
      "L\'origine et la destination doivent etre differentes.",
    ),
    "publicationSearchCommunesHint": MessageLookupByLibrary.simpleMessage(
      "Rechercher une commune",
    ),
    "publicationSelectValueAction": MessageLookupByLibrary.simpleMessage(
      "Selectionner",
    ),
    "publicationVehicleUnavailableMessage":
        MessageLookupByLibrary.simpleMessage(
          "Choisissez un de vos vehicules disponibles pour cette publication.",
        ),
    "publicationVerifiedCarrierRequiredMessage":
        MessageLookupByLibrary.simpleMessage(
          "Terminez la verification transporteur avant de publier de la capacite.",
        ),
    "publicationVerifiedVehicleRequiredMessage":
        MessageLookupByLibrary.simpleMessage(
          "Choisissez un vehicule verifie avant de publier de la capacite.",
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
      "Publiez des trajets, gerez les reservations et suivez la verification.",
    ),
    "roleSelectionCarrierTitle": MessageLookupByLibrary.simpleMessage(
      "Continuer comme transporteur",
    ),
    "roleSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez un seul role pour ce compte avant de commencer les operations.",
    ),
    "roleSelectionShipperDescription": MessageLookupByLibrary.simpleMessage(
      "Creez des expeditions, comparez les trajets exacts et suivez la livraison.",
    ),
    "roleSelectionShipperTitle": MessageLookupByLibrary.simpleMessage(
      "Continuer comme expediteur",
    ),
    "roleSelectionTitle": MessageLookupByLibrary.simpleMessage("Choix du role"),
    "routeActivateAction": MessageLookupByLibrary.simpleMessage(
      "Activer la ligne",
    ),
    "routeActivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Activer cette ligne pour de nouvelles reservations ?",
    ),
    "routeActivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne activee.",
    ),
    "routeCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Ajouter une ligne recurrente",
    ),
    "routeCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne recurrente ajoutee.",
    ),
    "routeDeactivateAction": MessageLookupByLibrary.simpleMessage(
      "Desactiver la ligne",
    ),
    "routeDeactivateConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Desactiver cette ligne pour de nouvelles reservations ? Les reservations existantes restent inchangées.",
    ),
    "routeDeactivatedMessage": MessageLookupByLibrary.simpleMessage(
      "Ligne desactivee.",
    ),
    "routeDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer la ligne",
    ),
    "routeDeleteBlockedMessage": MessageLookupByLibrary.simpleMessage(
      "Cette ligne ne peut pas etre supprimee car elle a deja des reservations.",
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
      "Commune de destination",
    ),
    "routeDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez les details de cette ligne avant reservation ou suivi.",
    ),
    "routeDetailTitle": m13,
    "routeEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier la ligne recurrente",
    ),
    "routeEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Publiez une ligne recurrente avec vehicule, horaire et capacite.",
    ),
    "routeEffectiveFromLabel": MessageLookupByLibrary.simpleMessage(
      "Effective a partir du",
    ),
    "routeErrorMessage": MessageLookupByLibrary.simpleMessage(
      "FleetFill n\'a pas pu ouvrir cet ecran.",
    ),
    "routeOriginLabel": MessageLookupByLibrary.simpleMessage(
      "Commune d\'origine",
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
      "Vehicule assigne",
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
      "Type de capacite",
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
      "Rechercher une capacite exacte",
    ),
    "searchTripsControlsAction": MessageLookupByLibrary.simpleMessage(
      "Tri et filtres",
    ),
    "searchTripsDescription": MessageLookupByLibrary.simpleMessage(
      "Le formulaire de recherche et les resultats de ligne exacte restent sur une seule page avec des etats integres.",
    ),
    "searchTripsFilterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun resultat ne correspond au tri et aux filtres actuels.",
    ),
    "searchTripsNavLabel": MessageLookupByLibrary.simpleMessage("Recherche"),
    "searchTripsNearestDateMessage": m14,
    "searchTripsNearestDateTitle": MessageLookupByLibrary.simpleMessage(
      "Dates exactes les plus proches",
    ),
    "searchTripsNoRouteMessage": MessageLookupByLibrary.simpleMessage(
      "Aucune ligne exacte n\'existe pour ce couloir dans la fenetre proche.",
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
      "Creez au moins un brouillon d\'expedition pour rechercher une capacite exacte.",
    ),
    "searchTripsResultsTitle": m15,
    "searchTripsTitle": MessageLookupByLibrary.simpleMessage(
      "Rechercher un trajet",
    ),
    "settingsDescription": MessageLookupByLibrary.simpleMessage(
      "Gerez la langue, le theme, le support et les preferences de notification.",
    ),
    "settingsSignedOutMessage": MessageLookupByLibrary.simpleMessage(
      "Votre session a ete fermee.",
    ),
    "settingsThemeModeDarkLabel": MessageLookupByLibrary.simpleMessage(
      "Sombre",
    ),
    "settingsThemeModeLightLabel": MessageLookupByLibrary.simpleMessage(
      "Clair",
    ),
    "settingsThemeModeSystemLabel": MessageLookupByLibrary.simpleMessage(
      "Systeme",
    ),
    "settingsThemeModeTitle": MessageLookupByLibrary.simpleMessage("Theme"),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Parametres"),
    "sharedScaffoldPreviewMessage": MessageLookupByLibrary.simpleMessage(
      "Les cartes et structures partagees restent coherentes entre les espaces par role.",
    ),
    "sharedScaffoldPreviewTitle": MessageLookupByLibrary.simpleMessage(
      "Apercu de la base partagee",
    ),
    "shipmentAddItemAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter un article",
    ),
    "shipmentCategoryLabel": MessageLookupByLibrary.simpleMessage("Categorie"),
    "shipmentCreateAction": MessageLookupByLibrary.simpleMessage(
      "Creer une expedition",
    ),
    "shipmentCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Creer un brouillon d\'expedition",
    ),
    "shipmentDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer l\'expedition",
    ),
    "shipmentDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer ce brouillon d\'expedition de FleetFill ?",
    ),
    "shipmentDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Brouillon d\'expedition supprime.",
    ),
    "shipmentDescriptionLabel": MessageLookupByLibrary.simpleMessage(
      "Description",
    ),
    "shipmentDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez le resume de l\'expedition, son contenu et la reservation associee.",
    ),
    "shipmentDetailTitle": m16,
    "shipmentEditAction": MessageLookupByLibrary.simpleMessage(
      "Modifier l\'expedition",
    ),
    "shipmentEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le brouillon d\'expedition",
    ),
    "shipmentItemLabelField": MessageLookupByLibrary.simpleMessage(
      "Libelle de l\'article",
    ),
    "shipmentItemNotesLabel": MessageLookupByLibrary.simpleMessage(
      "Notes de l\'article",
    ),
    "shipmentItemQuantityLabel": MessageLookupByLibrary.simpleMessage(
      "Quantite",
    ),
    "shipmentItemTitle": m17,
    "shipmentItemVolumeLabel": MessageLookupByLibrary.simpleMessage(
      "Volume de l\'article (m3)",
    ),
    "shipmentItemWeightLabel": MessageLookupByLibrary.simpleMessage(
      "Poids de l\'article (kg)",
    ),
    "shipmentItemsTitle": MessageLookupByLibrary.simpleMessage(
      "Articles de l\'expedition",
    ),
    "shipmentPickupEndLabel": MessageLookupByLibrary.simpleMessage(
      "Fin de fenetre d\'enlevement",
    ),
    "shipmentPickupStartLabel": MessageLookupByLibrary.simpleMessage(
      "Debut de fenetre d\'enlevement",
    ),
    "shipmentPickupWindowOrderMessage": MessageLookupByLibrary.simpleMessage(
      "La fin de fenetre doit etre posterieure au debut.",
    ),
    "shipmentRemoveItemAction": MessageLookupByLibrary.simpleMessage(
      "Retirer l\'article",
    ),
    "shipmentSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer l\'expedition",
    ),
    "shipmentSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Brouillon d\'expedition enregistre.",
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
      "Creez un brouillon d\'expedition avant de rechercher une capacite exacte.",
    ),
    "shipperHomeActiveBookingsLabel": MessageLookupByLibrary.simpleMessage(
      "Reservations actives",
    ),
    "shipperHomeDescription": MessageLookupByLibrary.simpleMessage(
      "Les reservations actives, les notifications recentes, les actions rapides et le raccourci support se trouvent ici.",
    ),
    "shipperHomeNavLabel": MessageLookupByLibrary.simpleMessage("Accueil"),
    "shipperHomeNoRecentNotificationMessage":
        MessageLookupByLibrary.simpleMessage(
          "Vos dernieres mises a jour operationnelles apparaitront ici.",
        ),
    "shipperHomeQuickActionsTitle": MessageLookupByLibrary.simpleMessage(
      "Actions rapides",
    ),
    "shipperHomeRecentNotificationTitle": MessageLookupByLibrary.simpleMessage(
      "Notification recente",
    ),
    "shipperHomeTitle": MessageLookupByLibrary.simpleMessage(
      "Accueil expediteur",
    ),
    "shipperHomeUnreadNotificationsLabel": MessageLookupByLibrary.simpleMessage(
      "Notifications non lues",
    ),
    "shipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Le profil, le telephone, les preferences et les raccourcis support restent dans une seule branche.",
    ),
    "shipperProfileNavLabel": MessageLookupByLibrary.simpleMessage("Profil"),
    "shipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Profil expediteur",
    ),
    "splashDescription": MessageLookupByLibrary.simpleMessage(
      "Le bootstrap et les etats bloquants commencent ici.",
    ),
    "splashTitle": MessageLookupByLibrary.simpleMessage("Demarrage"),
    "statusNeedsReviewLabel": MessageLookupByLibrary.simpleMessage("A revoir"),
    "statusReadyLabel": MessageLookupByLibrary.simpleMessage("Pret"),
    "supportConfiguredEmailMessage": m18,
    "supportDescription": MessageLookupByLibrary.simpleMessage(
      "Le support commence avec des consignes claires par e-mail et des details de probleme structures.",
    ),
    "supportMessageLabel": MessageLookupByLibrary.simpleMessage(
      "Message au support",
    ),
    "supportMessageSentMessage": MessageLookupByLibrary.simpleMessage(
      "Message de support envoye.",
    ),
    "supportReferenceHintMessage": MessageLookupByLibrary.simpleMessage(
      "Ajoutez tout identifiant de reservation, numero de suivi ou reference de paiement qui aidera le support a enqueter plus vite.",
    ),
    "supportSendAction": MessageLookupByLibrary.simpleMessage(
      "Envoyer l\'email au support",
    ),
    "supportSubjectLabel": MessageLookupByLibrary.simpleMessage(
      "Sujet du support",
    ),
    "supportTitle": MessageLookupByLibrary.simpleMessage("Support"),
    "suspendedMessage": MessageLookupByLibrary.simpleMessage(
      "Votre compte est actuellement suspendu. Contactez le support FleetFill par e-mail.",
    ),
    "suspendedTitle": MessageLookupByLibrary.simpleMessage("Compte suspendu"),
    "trackingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "La chronologie de suivi, la confirmation de livraison, le litige et la notation restent regroupes ici.",
    ),
    "trackingDetailTitle": m19,
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
        MessageLookupByLibrary.simpleMessage("Paiement en verification"),
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
      "Mettez FleetFill a jour pour continuer avec la version prise en charge.",
    ),
    "updateRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Mise a jour requise",
    ),
    "userDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Les informations expediteur et transporteur restent organisees par sections dans une seule vue detail.",
    ),
    "userDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Detail utilisateur",
    ),
    "vehicleCapacityVolumeLabel": MessageLookupByLibrary.simpleMessage(
      "Volume de capacite (m3)",
    ),
    "vehicleCapacityWeightLabel": MessageLookupByLibrary.simpleMessage(
      "Capacite de poids (kg)",
    ),
    "vehicleCreateAction": MessageLookupByLibrary.simpleMessage(
      "Ajouter un vehicule",
    ),
    "vehicleCreateTitle": MessageLookupByLibrary.simpleMessage(
      "Ajouter un vehicule",
    ),
    "vehicleCreatedMessage": MessageLookupByLibrary.simpleMessage(
      "Vehicule ajoute.",
    ),
    "vehicleDeleteAction": MessageLookupByLibrary.simpleMessage(
      "Supprimer le vehicule",
    ),
    "vehicleDeleteConfirmationMessage": MessageLookupByLibrary.simpleMessage(
      "Supprimer ce vehicule de FleetFill ?",
    ),
    "vehicleDeletedMessage": MessageLookupByLibrary.simpleMessage(
      "Vehicule supprime.",
    ),
    "vehicleDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Les details du vehicule, les documents et le statut de verification apparaissent ici.",
    ),
    "vehicleDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Detail vehicule",
    ),
    "vehicleEditTitle": MessageLookupByLibrary.simpleMessage(
      "Modifier le vehicule",
    ),
    "vehicleEditorDescription": MessageLookupByLibrary.simpleMessage(
      "Gardez les donnees du vehicule a jour pour conserver des flux de route et de verification valides.",
    ),
    "vehiclePlateLabel": MessageLookupByLibrary.simpleMessage(
      "Numero d\'immatriculation",
    ),
    "vehiclePositiveNumberMessage": MessageLookupByLibrary.simpleMessage(
      "Entrez un nombre superieur a zero.",
    ),
    "vehicleSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le vehicule",
    ),
    "vehicleSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Vehicule mis a jour.",
    ),
    "vehicleSummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Resume du vehicule",
    ),
    "vehicleTypeLabel": MessageLookupByLibrary.simpleMessage(
      "Type de vehicule",
    ),
    "vehicleVerificationDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Documents de verification du vehicule",
    ),
    "vehicleVerificationRejectedBanner": m20,
    "vehiclesDescription": MessageLookupByLibrary.simpleMessage(
      "Les vehicules restent sous la branche profil transporteur.",
    ),
    "vehiclesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un vehicule avant de publier de la capacite ou de terminer la verification complete.",
    ),
    "vehiclesTitle": MessageLookupByLibrary.simpleMessage("Vehicules"),
    "verificationDocumentDriverIdentityLabel":
        MessageLookupByLibrary.simpleMessage(
          "Identite ou permis du conducteur",
        ),
    "verificationDocumentMissingMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun fichier telecharge pour le moment.",
    ),
    "verificationDocumentNeedsAttentionMessage":
        MessageLookupByLibrary.simpleMessage(
          "Consultez le motif du rejet puis telechargez un remplacement.",
        ),
    "verificationDocumentOpenPreparedMessage":
        MessageLookupByLibrary.simpleMessage(
          "L\'acces securise au document est pret.",
        ),
    "verificationDocumentPendingMessage": MessageLookupByLibrary.simpleMessage(
      "Telecharge et en attente d\'une revue admin.",
    ),
    "verificationDocumentRejectedMessage": m21,
    "verificationDocumentReplacedMessage": MessageLookupByLibrary.simpleMessage(
      "Document de verification remplace.",
    ),
    "verificationDocumentTransportLicenseLabel":
        MessageLookupByLibrary.simpleMessage("Licence de transport"),
    "verificationDocumentTruckInspectionLabel":
        MessageLookupByLibrary.simpleMessage("Controle technique du camion"),
    "verificationDocumentTruckInsuranceLabel":
        MessageLookupByLibrary.simpleMessage("Assurance du camion"),
    "verificationDocumentTruckRegistrationLabel":
        MessageLookupByLibrary.simpleMessage("Carte grise du camion"),
    "verificationDocumentUploadedMessage": MessageLookupByLibrary.simpleMessage(
      "Document de verification telecharge.",
    ),
    "verificationDocumentVerifiedMessage": MessageLookupByLibrary.simpleMessage(
      "Verifie et accepte.",
    ),
    "verificationReplaceAction": MessageLookupByLibrary.simpleMessage(
      "Remplacer",
    ),
    "verificationRequiredMessage": MessageLookupByLibrary.simpleMessage(
      "Terminez les etapes de verification requises avant de continuer.",
    ),
    "verificationRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Verification requise",
    ),
    "verificationUploadAction": MessageLookupByLibrary.simpleMessage(
      "Telecharger",
    ),
  };
}
