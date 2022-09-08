import 'package:get/get.dart';

class MyLocale implements Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'ar': {
          'Scan': 'مسح',
          'History': 'السجل',
          'Settings': 'الاعدادات',
          'Sound': 'الصوت',
          'Result': 'النتيجة',
          'Website': 'الموقع',
          'Vibrate': 'الاهتزاز',
          'Copy to Clipboard': 'نسخ إلى الحافظة',
          'Beep when scanned': 'صفير عند مسحها ضوئيًا',
          'Vibrate when scanned': 'الاهتزاز عند المسح الضوئي',
          'Auto-copy scanned QR result': 'نسخ تلقائي نتيجة QR الممسوحة ضوئيًا',
          'Language': 'اللغة',
          'Privacy Policy': 'سياسة الخصوصية',
          'Version': 'الاصدار',
          'made': 'صنع بحب ❤️ بواسطة ',
          'open': 'فتح',
          'copy': 'نسخ',
          'share': 'مشاركة',
          'Scan-code': 'مسح الكود',
          'Deleted Qr Code': 'تم ازالة Qr ',
          'Please Choose a valid Photo': 'الرجاء اضافة صورة صحيحة',
          'Just Qr Code': 'فقط Qr كود',
          'scanned': 'مسحت'
        },
        'en': {
          'Scan': 'Scan',
          'History': 'History',
          'Settings': 'Settings',
          'Result': 'Result',
          'Website': 'Website',
          'Sound': 'Sound',
          'Vibrate': 'Vibrate',
          'Copy to clipboard': 'Copy to clipboard',
          'Beep when scanned': 'Beep when scanned',
          'Vibrate when scanned': 'Vibrate when scanned',
          'Auto-copy scanned QR result': 'Auto-copy scanned QR result',
          'Language': 'Language',
          'Privacy Policy': 'Privacy Policy',
          'Version': 'Version',
          'made': 'made with ❤️ by ',
          'open': 'Open',
          'copy': 'Copy',
          'share': 'Share',
          'Scan-code': 'Scan code',
          'Deleted Qr Code': 'Deleted Qr Code',
          'Please Choose a valid Photo': 'Please Choose a valid Photo',
          'Just Qr Code': 'Just Qr Code',
          'scanned': 'scanned'
        },
      };
}
