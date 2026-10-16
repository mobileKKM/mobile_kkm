import java.util.Properties

plugins {
    id("com.android.application")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

// The release key: android/key.properties (gitignored) with storeFile, storePassword, keyAlias and keyPassword.
// Without the file the release build is signed with the debug key, so a checkout without the key still builds.
val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystorePropertiesFile.inputStream().use { keystoreProperties.load(it) }
}

android {
    namespace = "de.codebucket.mkkm"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
    }

    defaultConfig {
        applicationId = "de.codebucket.mkkm"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        // Uses the version code from pubspec.yaml. When using split APKs, 1000 * ABI_VERSION
        // is added automatically by Flutter. (https://developer.android.com/studio/build/configure-apk-splits#configure-APK-versions)
        // You can force using the value of versionCode by specifying the `-P force-version-code-ignoring-abi=true`
        // flag during build.
        versionCode = flutter.versionCode
        versionName = flutter.versionName

        // `flutter build --target-platform` builds the engine and the Dart code for those ABIs alone, but plugins'
        // prebuilt libraries (MapLibre's) still come for every ABI, and a device would then pick one without the
        // engine. Flutter passes the list to Gradle, and its plugin has already set the filter to all of its ABIs.
        val abis = mapOf("android-arm" to "armeabi-v7a", "android-arm64" to "arm64-v8a", "android-x64" to "x86_64")
        (findProperty("target-platform") as String?)?.let { platforms ->
            ndk {
                abiFilters.clear()
                abiFilters += platforms.split(",").map { abis.getValue(it.trim()) }
            }
        }
    }

    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("release") {
                storeFile = file(keystoreProperties.getProperty("storeFile"))
                storePassword = keystoreProperties.getProperty("storePassword")
                keyAlias = keystoreProperties.getProperty("keyAlias")
                keyPassword = keystoreProperties.getProperty("keyPassword")
            }
        }
    }

    buildTypes {
        release {
            signingConfig = signingConfigs.findByName("release") ?: signingConfigs.getByName("debug")
        }
    }

    // AGP puts a dependency list, encrypted with a Google key, into the APK's signing block. F-Droid rejects it as
    // an opaque blob; Play reads it from the bundle, so the bundle keeps it.
    dependenciesInfo {
        includeInApk = false
        includeInBundle = true
    }

    // The native libraries (Flutter, MapLibre, the Dart code, SQLite) are most of the APK. Stored uncompressed, as
    // AGP does by default, they more than double its size; compressed, Android extracts them on install. Play builds
    // its own APKs from the bundle.
    packaging {
        jniLibs {
            useLegacyPackaging = true
        }
    }
}

kotlin {
    compilerOptions {
        jvmTarget = org.jetbrains.kotlin.gradle.dsl.JvmTarget.JVM_17
    }
}

flutter {
    source = "../.."
}
