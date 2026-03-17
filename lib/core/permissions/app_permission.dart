enum AppPermission {
  notifications,
  mediaUpload,
}

extension AppPermissionX on AppPermission {
  String get recoveryPath {
    switch (this) {
      case AppPermission.notifications:
        return '/permissions/notifications-help';
      case AppPermission.mediaUpload:
        return '/permissions/media-upload-help';
    }
  }
}
