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
    summary:
        'Küçük Prens, kendi küçük gezegeninde bir gülle yaşayan bir çocuktur. Evreni keşfetmek için yola çıkar ve Dünya\'da bir tilkiyle tanışarak dostluğun önemini öğrenir.',
    fetchedAt: DateTime(2026, 4, 25),
  );

  static final List<ReadingContent> mockPulledContents = [
    ReadingContent(
      id: 'sample_2',
      title: 'Deniz Fenerinin Sırrı',
      paragraphs: [
        'Kasabanın kıyısındaki eski deniz feneri, her gece aynı saatte üç kez yanıp sönerdi.',
        'Defne, bu ışığın bir işaret olduğunu düşünüyordu ve merakına yenik düşüp tepeye doğru yürümeye başladı.',
        'Kapıyı açtığında içeride eski haritalar ve üstünde notlar bulunan bir masa gördü.',
        'Notlarda, kayıp bir teknenin rotası ve dalgaların sesiyle çözülen bir şifre yazıyordu.',
        'Defne, haritadaki işaretleri takip ederek sabaha karşı teknenin küçük koyda saklandığını buldu.',
        'Kasaba halkı bu keşifle çok sevindi; Defne ise cesaretin meraktan doğduğunu öğrendi.',
      ],
      summary:
          'Defne, gizemli deniz fenerinin işaretini takip ederek kayıp teknenin yerini bulur ve kasabanın kahramanı olur.',
      fetchedAt: DateTime(2026, 4, 26),
    ),
    ReadingContent(
      id: 'sample_3',
      title: 'Ormandaki Matematik Kulübü',
      paragraphs: [
        'Çam ormanında yaşayan hayvanlar, kış hazırlıklarını daha düzenli yapmak için bir kulüp kurdu.',
        'Sincap Mino, cevizleri beşerli gruplara ayırınca saymanın çok kolaylaştığını gösterdi.',
        'Kirpi Ela, her gün ne kadar yiyecek topladıklarını bir tabloya yazdı ve eksikleri fark etti.',
        'Baykuş öğretmen, toplama ve çıkarma oyunlarıyla herkesin plan yapmasını sağladı.',
        'Bir hafta sonunda depolar tam doldu; çünkü herkes saymayı, ölçmeyi ve paylaşmayı öğrenmişti.',
        'Kulüp, matematiğin sadece derste değil, günlük yaşamda da işe yaradığını kanıtladı.',
      ],
      summary:
          'Ormandaki hayvanlar matematik kulübü sayesinde planlı çalışır, kış için yeterli yiyecek toplar.',
      fetchedAt: DateTime(2026, 4, 27),
    ),
    ReadingContent(
      id: 'sample_4',
      title: 'Gökyüzünü Dinleyen Çocuk',
      paragraphs: [
        'Aras, her akşam balkona çıkıp bulutların şekillerini bir deftere çizerdi.',
        'Bir gece rüzgarın sesi değişince, bunun yaklaşan yağmurun haberi olduğunu fark etti.',
        'Ertesi gün okul pikniği vardı ve herkes hava çok güzel olacak sanıyordu.',
        'Aras öğretmenine gördüklerini anlattı; öğretmeni de alternatif bir kapalı alan planı yaptı.',
        'Öğleden sonra yağmur başladı ama hazırlıklı oldukları için etkinlik neşeyle devam etti.',
        'Aras, dikkatle dinlemenin ve gözlem yapmanın ne kadar değerli olduğunu anladı.',
      ],
      summary:
          'Aras gökyüzünü gözlemleyerek yağmuru önceden tahmin eder ve okul etkinliğinin sorunsuz geçmesini sağlar.',
      fetchedAt: DateTime(2026, 4, 27),
    ),
  ];

  static const int pageChunkParagraphCount = 2;

  static ReadingContent nextMockContent(List<ReadingContent> existingLibrary) {
    final existingIds = existingLibrary.map((item) => item.id).toSet();
    final candidate = mockPulledContents.firstWhere(
      (item) => !existingIds.contains(item.id),
      orElse: () {
        final nextIndex = (existingLibrary.length % mockPulledContents.length);
        final base = mockPulledContents[nextIndex];
        return ReadingContent(
          id: '${base.id}_${DateTime.now().millisecondsSinceEpoch}',
          title: '${base.title} (Yeni)',
          paragraphs: base.paragraphs,
          summary: base.summary,
          fetchedAt: DateTime.now(),
        );
      },
    );
    return candidate;
  }
}
