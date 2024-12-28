package com.adDrive

import io.flutter.embedding.android.FlutterActivity
import androidx.annotation.NonNull
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
    override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
        MapKitFactory.setLocale("YOUR_LOCALE")
        MapKitFactory.setApiKey("67f55339-3dc0-4273-aff4-cd2df9844757")
        super.configureFlutterEngine(flutterEngine)
    }
}