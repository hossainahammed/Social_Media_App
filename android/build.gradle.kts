plugins {
    id("com.android.application") version "8.7.0" apply false
    id("com.google.gms.google-services") version "4.4.0" apply false
}

buildscript {
    repositories {
        google()  // Google repository
        mavenCentral()
    }
    dependencies {
        classpath("com.android.tools.build:gradle:7.0.4")
        classpath("com.google.gms:google-services:4.4.0")  // Google Services classpath
    }
}

android {
    compileSdk = 33

    defaultConfig {
        applicationId = "com.example.socialmediaapp"  // Your app package name
        minSdk = 21
        targetSdk = 33
        versionCode = 1
        versionName = "1.0"
    }

    buildTypes {
        getByName("release") {
            isMinifyEnabled = false
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

dependencies {
    implementation("androidx.appcompat:appcompat:1.2.0")
    implementation("com.google.firebase:firebase-auth:21.0.1")  // Firebase Auth
    implementation("com.google.firebase:firebase-firestore:24.1.0")  // Firebase Firestore
    implementation("com.google.firebase:firebase-storage:19.2.0")  // Firebase Storage
}

// Apply the Google services plugin at the bottom
apply(plugin = "com.google.gms.google-services")
