# ===================================
# Flutter Core
# ===================================
-keep class io.flutter.** { *; }
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.view.** { *; }
-keep class io.flutter.plugins.** { *; }
-dontwarn io.flutter.embedding.**

# ===================================
# FlutterFire Background / Engine
# ===================================
-keep class io.flutter.plugins.firebase.messaging.** { *; }
-keep class io.flutter.embedding.engine.FlutterEngine { *; }
-keep class io.flutter.embedding.engine.dart.** { *; }

# ===================================
# Firebase & Google Services
# ===================================
-keep class com.google.firebase.** { *; }
-keep class com.google.firebase.messaging.** { *; }
-keep class com.google.firebase.iid.** { *; }
-keep class com.google.android.gms.** { *; }
-keep class com.google.android.gms.internal.** { *; }
-dontwarn com.google.firebase.**
-dontwarn com.google.android.gms.**

# Firebase Firestore
-keepclassmembers class * extends com.google.firebase.firestore.** {
    <fields>;
}

# ===================================
# Google Play Core
# ===================================
-keep class com.google.android.play.core.** { *; }
-keep class com.google.android.play.core.splitcompat.** { *; }
-dontwarn com.google.android.play.core.**

# ===================================
# Agora (Video / Voice Call)
# ===================================
-keep class io.agora.** { *; }
-keep class io.agora.rtc.** { *; }
-keep class io.agora.rtc2.** { *; }
-dontwarn io.agora.**

# ===================================
# Kotlin (Safe Minimal Rules)
# ===================================
-keep class kotlin.Metadata { *; }
-dontwarn kotlin.**
-dontwarn kotlinx.**

# Kotlin Coroutines
-keepnames class kotlinx.coroutines.internal.MainDispatcherFactory {}
-keepnames class kotlinx.coroutines.CoroutineExceptionHandler {}

# ===================================
# Gson
# ===================================
-keep class com.google.gson.** { *; }
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer
-keepattributes Signature
-keepattributes *Annotation*
-keepattributes EnclosingMethod
-dontwarn sun.misc.**

# Prevent Gson from stripping generic types
-keepclassmembers,allowobfuscation class * {
  @com.google.gson.annotations.SerializedName <fields>;
}

# ===================================
# OkHttp
# ===================================
-keep class okhttp3.** { *; }
-keep interface okhttp3.** { *; }
-keep class okio.** { *; }
-dontwarn okhttp3.**
-dontwarn okio.**
-dontwarn javax.annotation.**
-dontwarn org.conscrypt.**

# OkHttp Platform
-keepnames class okhttp3.internal.publicsuffix.PublicSuffixDatabase

# ===================================
# Retrofit
# ===================================
-keep class retrofit2.** { *; }
-keepclasseswithmembers class * {
    @retrofit2.http.* <methods>;
}
-keepclassmembernames interface * {
    @retrofit2.http.* <methods>;
}
-dontwarn retrofit2.**

# ===================================
# App Package (IMPORTANT)
# ===================================
-keep class com.supercycle.trader.** { *; }
-keepclassmembers class com.supercycle.trader.** { *; }

# ===================================
# Parcelable Models
# ===================================
-keep class * implements android.os.Parcelable {
    public static final ** CREATOR;
}

# ===================================
# Native Methods
# ===================================
-keepclasseswithmembernames class * {
    native <methods>;
}

# ===================================
# Enums
# ===================================
-keepclassmembers enum * {
    public static **[] values();
    public static ** valueOf(java.lang.String);
}

# ===================================
# Serializable
# ===================================
-keepclassmembers class * implements java.io.Serializable {
    static final long serialVersionUID;
    private static final java.io.ObjectStreamField[] serialPersistentFields;
    private void writeObject(java.io.ObjectOutputStream);
    private void readObject(java.io.ObjectInputStream);
    java.lang.Object writeReplace();
    java.lang.Object readResolve();
}

# ===================================
# Exceptions
# ===================================
-keep public class * extends java.lang.Exception
