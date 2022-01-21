package Tsyapalo.places
import androidx.annotation.NonNull
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugins.GeneratedPluginRegistrant
import com.yandex.mapkit.MapKitFactory

class MainActivity: FlutterActivity() {
  override fun configureFlutterEngine(@NonNull flutterEngine: FlutterEngine) {
    MapKitFactory.setLocale("ru_RU")
    MapKitFactory.setApiKey("57599b15-e159-498d-8b36-43fecb47d1b3")
    super.configureFlutterEngine(flutterEngine)
  }
}