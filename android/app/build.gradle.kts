import java.util.Properties

plugins {
    id("com.android.application")
    id("com.google.gms.google-services")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

val releaseSigningProperties = Properties()
val releaseSigningPropertiesFile = rootProject.file("app/release-signing.local.properties")

if (releaseSigningPropertiesFile.exists()) {
    releaseSigningPropertiesFile.inputStream().use { releaseSigningProperties.load(it) }
}

fun signingValue(name: String): String? =
    releaseSigningProperties.getProperty(name)?.takeIf { it.isNotBlank() }

val releaseKeystorePath =
    providers.gradleProperty("FLEETFILL_RELEASE_STORE_FILE")
        .orElse(providers.environmentVariable("FLEETFILL_RELEASE_STORE_FILE"))
        .orElse(signingValue("FLEETFILL_RELEASE_STORE_FILE") ?: "")
val releaseKeystorePassword =
    providers.gradleProperty("FLEETFILL_RELEASE_STORE_PASSWORD")
        .orElse(providers.environmentVariable("FLEETFILL_RELEASE_STORE_PASSWORD"))
        .orElse(signingValue("FLEETFILL_RELEASE_STORE_PASSWORD") ?: "")
val releaseKeyAlias =
    providers.gradleProperty("FLEETFILL_RELEASE_KEY_ALIAS")
        .orElse(providers.environmentVariable("FLEETFILL_RELEASE_KEY_ALIAS"))
        .orElse(signingValue("FLEETFILL_RELEASE_KEY_ALIAS") ?: "")
val releaseKeyPassword =
    providers.gradleProperty("FLEETFILL_RELEASE_KEY_PASSWORD")
        .orElse(providers.environmentVariable("FLEETFILL_RELEASE_KEY_PASSWORD"))
        .orElse(signingValue("FLEETFILL_RELEASE_KEY_PASSWORD") ?: "")

android {
    namespace = "com.carbodex.fleetfill"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    signingConfigs {
        create("release") {
            val hasReleaseSigning =
                releaseKeystorePath.isPresent &&
                    releaseKeystorePassword.isPresent &&
                    releaseKeyAlias.isPresent &&
                    releaseKeyPassword.isPresent

            if (hasReleaseSigning) {
                storeFile = file(releaseKeystorePath.get())
                storePassword = releaseKeystorePassword.get()
                keyAlias = releaseKeyAlias.get()
                keyPassword = releaseKeyPassword.get()
            }
        }
    }

    defaultConfig {
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.carbodex.fleetfill"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    buildTypes {
        release {
            val hasReleaseSigning =
                releaseKeystorePath.isPresent &&
                    releaseKeystorePassword.isPresent &&
                    releaseKeyAlias.isPresent &&
                    releaseKeyPassword.isPresent
            signingConfig = if (hasReleaseSigning) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}

flutter {
    source = "../.."
}
