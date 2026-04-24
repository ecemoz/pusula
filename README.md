# Pusula - Okuma Asistanı

Pusula, öğrencilerin okuduğunu anlama becerilerini geliştirmek ve okuma süreçlerini takip etmek amacıyla tasarlanmış modern, öğrenci dostu bir Flutter uygulamasıdır.

## 🌟 Özellikler

- **Metin Seslendirme (Text-to-Speech):** Okuma metinlerini sesli olarak dinleyebilme özelliği.
- **Paragraf Paragraf Navigasyon:** Uzun metinleri daha kolay okunabilir parçalara bölerek adım adım ilerleme.
- **Yer İmleri (Bookmarking):** Kalınan yeri kaydetme ve daha sonra kolayca geri dönme.
- **Özet Üretimi:** Okunan metinlerin özetlerini çıkararak kavramayı artırma.
- **Gelişim Takip Panosu:** Öğrencilerin okuma istatistiklerini ve ilerlemelerini görsel olarak takip edebilecekleri gösterge paneli.
- **Minimalist Tasarım:** Dikkat dağıtmayan, pastel renklerin hakim olduğu, kullanıcı dostu arayüz.

## 🛠 Kullanılan Teknolojiler ve Paketler

Proje geliştirilirken aşağıdaki temel paketler ve teknolojiler kullanılmıştır:

- **Flutter / Dart:** Çapraz platform mobil uygulama geliştirme.
- **[Provider](https://pub.dev/packages/provider):** Durum yönetimi (State Management).
- **[Flutter TTS](https://pub.dev/packages/flutter_tts):** Metinden sese (Text-to-Speech) dönüşüm işlemleri.
- **[Shared Preferences](https://pub.dev/packages/shared_preferences):** Yerel veri depolama (Ayarlar, ilerleme durumu vb.).
- **[Google Fonts](https://pub.dev/packages/google_fonts):** Modern ve okunabilir tipografi.
- **[Percent Indicator](https://pub.dev/packages/percent_indicator):** Gelişim ve ilerleme durumlarını görselleştirmek için.
- **[Lucide Icons](https://pub.dev/packages/lucide_icons) & Cupertino Icons:** Uygulama içi ikonografi.

## 📂 Proje Yapısı

```text
lib/
├── core/       # Temel yapılandırmalar, sabitler ve tema dosyaları
├── models/     # Veri modelleri
├── providers/  # Provider sınıfları (Durum yönetimi)
├── screens/    # Uygulama ekranları ve sayfaları
├── services/   # Dış servisler ve veritabanı işlemleri
├── widgets/    # Tekrar kullanılabilir UI bileşenleri
└── main.dart   # Uygulamanın başlangıç noktası
```

## 🚀 Kurulum ve Çalıştırma

Projeyi yerel ortamınızda çalıştırmak için aşağıdaki adımları izleyebilirsiniz:

1. Depoyu klonlayın veya indirin.
2. Proje dizinine gidin:
   ```bash
   cd pusula
   ```
3. Gerekli bağımlılıkları yükleyin:
   ```bash
   flutter pub get
   ```
4. Uygulamayı çalıştırın (Bir emülatör veya fiziksel cihaz bağlı olduğundan emin olun):
   ```bash
   flutter run
   ```

## 📱 Tasarım Anlayışı

Pusula, öğrencilerin okuma alışkanlıklarını desteklemek amacıyla **dikkat dağıtıcı unsurlardan arındırılmış**, odaklanmayı kolaylaştıran *pastel tonlarda* bir arayüze sahiptir. Alt gezinme çubuğu (bottom navigation) sayesinde uygulamanın temel özellikleri arası geçişler hızlı ve akıcıdır.


https://github.com/user-attachments/assets/25f2391e-d344-4081-80b6-c12fba97b20e


