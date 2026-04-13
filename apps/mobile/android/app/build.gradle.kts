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

fun resolveSigningValue(name: String): String? =
    providers.gradleProperty(name).orNull
        ?.takeIf { it.isNotBlank() }
        ?: providers.environmentVariable(name).orNull
            ?.takeIf { it.isNotBlank() }
        ?: signingValue(name)

val releaseKeystorePath = resolveSigningValue("FLEETFILL_RELEASE_STORE_FILE")
val releaseKeystorePassword = resolveSigningValue("FLEETFILL_RELEASE_STORE_PASSWORD")
val releaseKeyAlias = resolveSigningValue("FLEETFILL_RELEASE_KEY_ALIAS")
val releaseKeyPassword = resolveSigningValue("FLEETFILL_RELEASE_KEY_PASSWORD")
val hasReleaseSigning =
    !releaseKeystorePath.isNullOrBlank() &&
        !releaseKeystorePassword.isNullOrBlank() &&
        !releaseKeyAlias.isNullOrBlank() &&
        !releaseKeyPassword.isNullOrBlank()
val isReleaseBuildRequested = gradle.startParameter.taskNames.any {
    it.contains("Release", ignoreCase = true)
}

if (isReleaseBuildRequested && !hasReleaseSigning) {
    throw GradleException(
        "Release signing is required for release builds. Set FLEETFILL_RELEASE_STORE_FILE, FLEETFILL_RELEASE_STORE_PASSWORD, FLEETFILL_RELEASE_KEY_ALIAS, and FLEETFILL_RELEASE_KEY_PASSWORD.",
    )
}

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
            if (hasReleaseSigning) {
                storeFile = file(releaseKeystorePath!!)
                storePassword = releaseKeystorePassword
                keyAlias = releaseKeyAlias
                keyPassword = releaseKeyPassword
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
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}
