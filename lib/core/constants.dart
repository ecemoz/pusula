import '../models/reading_content.dart';

class AppConstants {
  static const String appName = 'PUSULA';
  
  static final ReadingContent sampleContent = ReadingContent(
    id: 'sample_1',
    title: 'Küçük Prens ve Yıldızlar',
    paragraphs: [
      'Bir zamanlar, çok uzak bir galakside, sadece küçük bir ev boyutunda olan bir gezegende Küçük Prens yaşardı.',
      'Bu gezegende üç tane yanardağ, birkaç baobab ağacı ve çok sevdiği bir gül vardı.',
      'Küçük Prens her sabah gezegenini temizler, yanardağlarını temizler ve gülünü sular, onunla sohbet ederdi.',
      'Gül bazen çok nazlı olurdu ama Küçük Prens onu yine de çok severdi çünkü o gülü kendisi büyütmüştü.',
      'Bir gün Küçük Prens, evreni keşfetmek ve yeni arkadaşlar bulmak için gezegeninden ayrılmaya karar verdi.',
      'Yolculuğu sırasında birçok farklı gezegene uğradı ve her birinde farklı yetişkinlerle tanıştı. Ama hiçbiri onun gibi hayal kurmayı bilmiyordu.',
      'En sonunda Dünya adında büyük ve güzel bir gezegene ulaştı. Orada bir tilki ile tanıştı ve ona evcilleştirmenin ne demek olduğunu öğretti.',
    ],
    summary: 'Küçük Prens, kendi küçük gezegeninde bir gülle yaşayan bir çocuktur. Evreni keşfetmek için yola çıkar ve Dünya\'da bir tilkiyle tanışarak dostluğun önemini öğrenir.',
  );
}
