# Gson uses generic type information stored in a class file when working with fields. Proguard
# removes such information by default, so configure it to keep all of it.
-keepattributes Signature

# For using GSON @Expose annotation
-keepattributes *Annotation*

# Gson specific classes
-dontwarn sun.misc.**
-keep class com.google.gson.stream.** { *; }

# Prevent ProGuard from stripping interface information from TypeAdapter, TypeAdapterFactory,
# JsonSerializer, JsonDeserializer instances (so they can be used in @JsonAdapter)
-keep class * extends com.google.gson.TypeAdapter
-keep class * implements com.google.gson.TypeAdapterFactory
-keep class * implements com.google.gson.JsonSerializer
-keep class * implements com.google.gson.JsonDeserializer

# Prevent R8 from leaving Data object members always null (for Kotlin Data Classes)
-keepclassmembers class kotlin.reflect.KClass {
  @com.google.gson.annotations.SerializedName <fields>;
}

# Retain generic signatures of TypeToken and its subclasses with R8 version 3.0 and higher.
-keep,allowobfuscation,allowshrinking class com.google.gson.reflect.TypeToken
-keep,allowobfuscation,allowshrinking class * extends com.google.gson.reflect.TypeToken

# Flutter ProGuard Rules
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.** { *; }
-keep class io.flutter.util.** { *; }
-keep class io.flutter.embedding.** { *; }
-dontwarn io.flutter.embedding.**

# Flutter Local Notifications specific rules
# Prevent obfuscation or stripping of required classes and methods
-keep class com.dexterous.flutterlocalnotifications.** { *; }
-keepclassmembers class com.dexterous.flutterlocalnotifications.** { *; }
-dontwarn com.dexterous.flutterlocalnotifications.**

# Android-specific rules to ensure Flutter plugins function correctly
-keep public class * extends android.app.Service
-keep public class * extends android.content.BroadcastReceiver
-keep public class * extends android.content.ContentProvider
-keep public class * extends android.app.Activity

# WorkManager rules for background tasks (optional)
-keep class androidx.work.** { *; }
-dontwarn androidx.work.**

# Notification rules for `flutter_local_notifications`
-keep class android.app.Notification { *; }
-keep class android.app.NotificationManager { *; }

# Ensure compatibility with Kotlin
-keepattributes RuntimeVisibleAnnotations,RuntimeInvisibleAnnotations
-keep class kotlin.Metadata { *; }

# Dynamic Feature Modules (optional)
-keepnames class * {
    @com.google.android.play.core.splitcompat.SplitCompatApplication <methods>;
}
-dontwarn com.google.android.play.core.**