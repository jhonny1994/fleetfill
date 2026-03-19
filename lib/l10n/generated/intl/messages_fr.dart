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

  static String m1(bookingId) => "Booking ${bookingId}";

  static String m2(carrierId) => "Carrier ${carrierId}";

  static String m3(reason) => "La verification demande une action : ${reason}";

  static String m4(documentId) => "Document ${documentId}";

  static String m5(documentId) => "Generated document ${documentId}";

  static String m6(languageCode) => "Langue actuelle : ${languageCode}";

  static String m7(notificationId) => "Notification ${notificationId}";

  static String m8(tripId) => "One-off trip ${tripId}";

  static String m9(proofId) => "Proof ${proofId}";

  static String m10(routeId) => "Route ${routeId}";

  static String m11(dates) =>
      "Aucun resultat exact le meme jour. Dates exactes les plus proches : ${dates}";

  static String m12(count) => "Resultats de recherche (${count})";

  static String m13(shipmentId) => "Shipment ${shipmentId}";

  static String m14(index) => "Article ${index}";

  static String m15(bookingId) => "Tracking ${bookingId}";

  static String m16(reason) =>
      "La verification du vehicule demande une action : ${reason}";

  static String m17(reason) => "Rejete : ${reason}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "adminAuditLogDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez les dernieres actions admin sensibles et leur resultat.",
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
      "FleetFill n\'a pas pu terminer cette action pour le moment.",
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
      "Password reset request handling belongs in the auth shell.",
    ),
    "authForgotPasswordTitle": MessageLookupByLibrary.simpleMessage(
      "Forgot password",
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
      "Reset password",
    ),
    "authResetPasswordUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "Ouvrez cet ecran depuis le lien de recuperation pour definir un nouveau mot de passe.",
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
      "Email/password and Google sign-in entry points live here.",
    ),
    "authSignInSuccess": MessageLookupByLibrary.simpleMessage(
      "Connexion reussie.",
    ),
    "authSignInTitle": MessageLookupByLibrary.simpleMessage("Sign in"),
    "authSignUpDescription": MessageLookupByLibrary.simpleMessage(
      "Creez votre compte FleetFill pour expedier ou publier de la capacite.",
    ),
    "authSignUpTitle": MessageLookupByLibrary.simpleMessage("Create account"),
    "authUpdatePasswordAction": MessageLookupByLibrary.simpleMessage(
      "Mettre a jour le mot de passe",
    ),
    "authUserAlreadyRegisteredMessage": MessageLookupByLibrary.simpleMessage(
      "Un compte existe deja pour cet e-mail.",
    ),
    "authVerificationEmailSentMessage": MessageLookupByLibrary.simpleMessage(
      "Verifiez votre e-mail pour confirmer le compte avant de vous connecter.",
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
    "cancelLabel": MessageLookupByLibrary.simpleMessage("Annuler"),
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
    "documentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Ouvrez ce document dans un visualiseur securise lorsque l\'acces est pret.",
    ),
    "documentViewerOpenAction": MessageLookupByLibrary.simpleMessage(
      "Ouvrir le document",
    ),
    "documentViewerTitle": m4,
    "documentViewerUnavailableMessage": MessageLookupByLibrary.simpleMessage(
      "L\'acces securise au document est temporairement indisponible.",
    ),
    "editCarrierProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez a jour vos coordonnees et informations transporteur.",
    ),
    "editCarrierProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Edit carrier profile",
    ),
    "editShipperProfileDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez a jour vos coordonnees expediteur.",
    ),
    "editShipperProfileTitle": MessageLookupByLibrary.simpleMessage(
      "Edit shipper profile",
    ),
    "errorTitle": MessageLookupByLibrary.simpleMessage(
      "Un probleme est survenu",
    ),
    "forbiddenAdminStepUpMessage": MessageLookupByLibrary.simpleMessage(
      "Re-authenticate recently before opening this sensitive admin surface.",
    ),
    "forbiddenMessage": MessageLookupByLibrary.simpleMessage(
      "This area is not available for your account.",
    ),
    "forbiddenTitle": MessageLookupByLibrary.simpleMessage("Access restricted"),
    "generatedDocumentViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Ouvrez les factures et recus generes depuis une route partagee securisee.",
    ),
    "generatedDocumentViewerTitle": m5,
    "languageOptionArabic": MessageLookupByLibrary.simpleMessage("Arabe"),
    "languageOptionEnglish": MessageLookupByLibrary.simpleMessage("Anglais"),
    "languageOptionFrench": MessageLookupByLibrary.simpleMessage("Francais"),
    "languageSelectionCurrentMessage": m6,
    "languageSelectionDescription": MessageLookupByLibrary.simpleMessage(
      "Choisissez la langue a utiliser dans FleetFill.",
    ),
    "languageSelectionTitle": MessageLookupByLibrary.simpleMessage(
      "Language selection",
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
      "Maintenance mode",
    ),
    "mediaUploadPermissionDescription": MessageLookupByLibrary.simpleMessage(
      "Guide the user back to media access when they need to upload proof or documents.",
    ),
    "mediaUploadPermissionTitle": MessageLookupByLibrary.simpleMessage(
      "Media upload permission",
    ),
    "moneySummaryTitle": MessageLookupByLibrary.simpleMessage(
      "Pricing summary",
    ),
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
      "Recurring routes and one-off trips stay grouped in one branch.",
    ),
    "myRoutesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Publiez une ligne recurrente ou un trajet ponctuel pour proposer de la capacite.",
    ),
    "myRoutesNavLabel": MessageLookupByLibrary.simpleMessage("Routes"),
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
    "myRoutesTitle": MessageLookupByLibrary.simpleMessage("My routes"),
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
      "Active, history, and draft shipment states stay inside this branch.",
    ),
    "myShipmentsNavLabel": MessageLookupByLibrary.simpleMessage("Shipments"),
    "myShipmentsTitle": MessageLookupByLibrary.simpleMessage("My shipments"),
    "noExactResultsMessage": MessageLookupByLibrary.simpleMessage(
      "No exact route is available for this search yet.",
    ),
    "noExactResultsTitle": MessageLookupByLibrary.simpleMessage(
      "No exact route found",
    ),
    "notFoundMessage": MessageLookupByLibrary.simpleMessage(
      "The requested page or entity could not be found.",
    ),
    "notFoundTitle": MessageLookupByLibrary.simpleMessage("Not found"),
    "notificationDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez le detail complet de cette notification.",
    ),
    "notificationDetailTitle": m7,
    "notificationsCenterDescription": MessageLookupByLibrary.simpleMessage(
      "Consultez les alertes recentes, les mises a jour de reservation et les rappels utiles.",
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
      "You are offline. Some actions are temporarily unavailable.",
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
    "oneOffTripDetailTitle": m8,
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
      "Instructions, reference, proof upload, and payment status remain in one coherent flow.",
    ),
    "paymentFlowTitle": MessageLookupByLibrary.simpleMessage("Payment flow"),
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
      "Carrier payout accounts stay grouped under the profile branch.",
    ),
    "payoutAccountsTitle": MessageLookupByLibrary.simpleMessage(
      "Payout accounts",
    ),
    "phoneCompletionDescription": MessageLookupByLibrary.simpleMessage(
      "Operational actions stay gated until a phone number is present.",
    ),
    "phoneCompletionSaveAction": MessageLookupByLibrary.simpleMessage(
      "Enregistrer le numero",
    ),
    "phoneCompletionSavedMessage": MessageLookupByLibrary.simpleMessage(
      "Numero de telephone enregistre.",
    ),
    "phoneCompletionTitle": MessageLookupByLibrary.simpleMessage(
      "Phone completion",
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
    "profileSetupTitle": MessageLookupByLibrary.simpleMessage("Profile setup"),
    "profileVerificationDocumentsTitle": MessageLookupByLibrary.simpleMessage(
      "Documents de verification du profil",
    ),
    "proofViewerDescription": MessageLookupByLibrary.simpleMessage(
      "Ouvrez cette preuve depuis une route partagee securisee lorsque l\'acces est pret.",
    ),
    "proofViewerTitle": m9,
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
    "retryLabel": MessageLookupByLibrary.simpleMessage("Retry"),
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
    "routeDetailTitle": m10,
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
    "sampleBasePriceLabel": MessageLookupByLibrary.simpleMessage("Base price"),
    "samplePlatformFeeAmount": MessageLookupByLibrary.simpleMessage(
      "DZD 1,200",
    ),
    "samplePlatformFeeLabel": MessageLookupByLibrary.simpleMessage(
      "Platform fee",
    ),
    "sampleTotalAmount": MessageLookupByLibrary.simpleMessage("DZD 13,700"),
    "sampleTotalLabel": MessageLookupByLibrary.simpleMessage("Total"),
    "searchCarrierLabel": MessageLookupByLibrary.simpleMessage("Transporteur"),
    "searchDepartureLabel": MessageLookupByLibrary.simpleMessage("Depart"),
    "searchEstimatedPriceLabel": MessageLookupByLibrary.simpleMessage(
      "Total estime",
    ),
    "searchRequestedDateLabel": MessageLookupByLibrary.simpleMessage(
      "Date de depart souhaitee",
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
      "The search form and exact-route results stay on one page with inline states.",
    ),
    "searchTripsFilterEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Aucun resultat ne correspond au tri et aux filtres actuels.",
    ),
    "searchTripsNavLabel": MessageLookupByLibrary.simpleMessage("Search"),
    "searchTripsNearestDateMessage": m11,
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
    "searchTripsResultsTitle": m12,
    "searchTripsTitle": MessageLookupByLibrary.simpleMessage("Search trips"),
    "settingsDescription": MessageLookupByLibrary.simpleMessage(
      "Gerez la langue, le theme, le support et les preferences de notification.",
    ),
    "settingsSignedOutMessage": MessageLookupByLibrary.simpleMessage(
      "Votre session a ete fermee.",
    ),
    "settingsTitle": MessageLookupByLibrary.simpleMessage("Parametres"),
    "sharedScaffoldPreviewMessage": MessageLookupByLibrary.simpleMessage(
      "Shared cards and shells stay consistent across role surfaces.",
    ),
    "sharedScaffoldPreviewTitle": MessageLookupByLibrary.simpleMessage(
      "Shared foundation preview",
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
    "shipmentDetailTitle": m13,
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
    "shipmentItemTitle": m14,
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
      "Needs review",
    ),
    "statusReadyLabel": MessageLookupByLibrary.simpleMessage("Ready"),
    "supportDescription": MessageLookupByLibrary.simpleMessage(
      "Support starts with clear email guidance and structured issue details.",
    ),
    "supportTitle": MessageLookupByLibrary.simpleMessage("Support"),
    "suspendedMessage": MessageLookupByLibrary.simpleMessage(
      "Your account is currently suspended. Contact FleetFill support by email.",
    ),
    "suspendedTitle": MessageLookupByLibrary.simpleMessage("Account suspended"),
    "trackingDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Tracking timeline, delivery confirmation, dispute, and rating actions stay together here.",
    ),
    "trackingDetailTitle": m15,
    "updateRequiredDescription": MessageLookupByLibrary.simpleMessage(
      "Mettez FleetFill a jour pour continuer avec la version prise en charge.",
    ),
    "updateRequiredTitle": MessageLookupByLibrary.simpleMessage(
      "Update required",
    ),
    "userDetailDescription": MessageLookupByLibrary.simpleMessage(
      "Shipper and carrier specifics remain section-based inside one user detail view.",
    ),
    "userDetailTitle": MessageLookupByLibrary.simpleMessage("User detail"),
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
      "Vehicle details, documents, and verification status appear here.",
    ),
    "vehicleDetailTitle": MessageLookupByLibrary.simpleMessage(
      "Vehicle detail",
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
    "vehicleVerificationRejectedBanner": m16,
    "vehiclesDescription": MessageLookupByLibrary.simpleMessage(
      "Vehicles remain under the carrier profile branch.",
    ),
    "vehiclesEmptyMessage": MessageLookupByLibrary.simpleMessage(
      "Ajoutez un vehicule avant de publier de la capacite ou de terminer la verification complete.",
    ),
    "vehiclesTitle": MessageLookupByLibrary.simpleMessage("Vehicles"),
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
    "verificationDocumentRejectedMessage": m17,
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
