import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:motor_asin/controller.dart';

class Dil extends Translations {
  @override
  static const varsayilan = Locale("tr", "TR");
  static const diller = [
    Locale("tr", "TR"),
    Locale("en", "EN"),
  ];

  static bool dil = true;

  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'hello': 'Hello World',
          'ulke': "70 COUNTRY",
          'sube': '7 BRANCH',
          "marka": "+130 BRAND",
          "kalite": "QUALİTY",
          "yonetimKurulu": "Board Of Management",
          "motorAsinyonetimKurulu": "Motor Aşin Board Of Management Memebers",
          "ramazanAsciKimdir": "Who İs Ramazan AŞÇI ?",
          "markalar": "BRANCHS",
          "ulkeler": "COUNTRIES",
          "motorAsinTanitim":
              "Taken courageous steps, our late founder Suphi Aşçı has always been an inspiration for us at Motor Aşin to be keen in novelty. Our journey, which had started with retailing in Elazig in 1971, continued with a bold leap in İstanbul, and extended to wholesaling and then to foreign trade...",
          "dahaFazla": "See More...",
          "motorAsinTanitimDetay":
              "During this time, we have developed our own brand with the knowledge and experience we have gained in 40 years by working with world-renowned high quality distinguished brands that have proven themselves in the global market. After developing the ASPart brand in 2012, we offered 13 products with 400 varieties under ASPart brand to the domestic market in 2014. ASPart, due to its high quality and product variety, has gained a strong position in the market in a short time and, now is in our Motor AŞİN product portfolio with 100 products and nearly 10 thousand varieties.For more information about ASPart brand and our products: \nhttps://aspart.com",
          "ara": "Call",
          "urunGrupları": "PRODUCT GROUPS",
          "stratejikVizyon": "Strategic Vision",
          "bizeUlasin": "Contact Us",
          "hakkımızda": "About Us",
          "anasayfa": "Home",
          "konum": "Location",
          "musterimizOl": "Be Customer",
          "isBasvurusu": "Job Application",
          "siparisTakip": "Order Tracking",
        },
        'tr_TR': {
          'hello': 'Merhaba Dünya',
          'ulke': "70 ÜLKE",
          'sube': '7 ŞUBE',
          "marka": "+130 MARKA",
          "kalite": "KALİTE",
          "yonetimKurulu": "Yönetim Kurulu",
          "motorAsinyonetimKurulu": "Motor Aşin Yönetim Kurulu Üyeleri",
          "ramazanAsciKimdir": "Ramazan AŞÇİ Kimdir ?",
          "markalar": "MARKALAR",
          "ulkeler": "ÜLKELER",
          "motorAsinTanitim":
              "Motor AŞİN olarak kurucumuz rahmetli büyüğümüz Suphi Aşçı’nın  cesaretle attığı adımları örnek alarak daima yeninin arayışı içinde olduk. 1971 yılında Elazığ’da perakendecilikle başlayan yolculuğumuz, cesur atılımlarla İstanbul’da devam etti, toptancılığa ve ardından dış ticarete kadar uzandı...",
          "dahaFazla": "Daha fazla gör...",
          "motorAsinTanitimDetay":
              "Motor AŞİN olarak kurucumuz rahmetli büyüğümüz Suphi Aşçı’nın cesaretle attığı adımları örnek alarak daima yeninin arayışı içinde olduk. 1971 yılında Elazığ’da perakendecilikle başlayan yolculuğumuz, cesur atılımlarla İstanbul’da devam etti, toptancılığa ve ardından dış ticarete kadar uzandı.Bu süre içerisinde dünyaca bilinen, kalitesiyle kendini kanıtlamış seçkin ve prestijli markalarla çalışarak, 40 yıl içinde edindiğimiz bilgi ve tecrübemizle kendi markamızı geliştirdik. 2012 yılında ASPart markasını oluşturduktan sonra, 2014 yılında 13 ürün 400 çeşit ile ASPart ürünlerini yurtiçinde satışa sunduk. Kalitesi ve ürün çeşitliliği ile kısa sürede pazarda kendine güçlü bir yer edinen ASPart, bugün 100 ürün ve 10 bine yakın çeşitle Motor AŞİN ürün portföyümüzde yer alıyor. ASPart markası ve ürünlerimizle ilgili detaylı bilgi için:\naspart.com",
          "ara": "Ara",
          "urunGrupları": "ÜRÜN GRUPLARI",
          "stratejikVizyon": "Stratejik Vizyon",
          "bizeUlasin": "Bize Ulaşın",
          "hakkımızda": "Hakkımızda",
          "anasayfa": "Anasayfa",
          "konum": "Konum",
          "musterimizOl": "Müşterimiz Ol",
          "isBasvurusu": "İş Başvurusu",
          "siparisTakip": "Sipariş Takip",
        }
      };
}
