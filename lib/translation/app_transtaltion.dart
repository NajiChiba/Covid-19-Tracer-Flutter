import 'package:get/get.dart';

class AppTranslation extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'en_US': {
          'health_pass': 'Health pass',
          'card1_title': 'Open my Wallet',
          'card1_subtitle': 'Your test and\nvaccination certificates',
          'statistics1': 'Vaccination coverage',
          'statistics2': 'Other key figures',
          'update': 'Update',
          'completed': 'Completed vaccination',
          'new_cases': 'New Cases',
          'cases': 'Recovered',
          'news': 'News',
          'contact_tracing': 'Contact tracing',
          'wallet': 'Wallet',
          'add_certif': 'Add Certificates',
          'display_certif': 'Display the qr code',
          'delete': 'Delete',
          'certificates': 'Certificate',
          'save': 'Save Certificate',
          'positive': 'Positive',
          'upload': 'Upload file',
          'cancel': 'Cancel',
          'delete_title': 'Are you sure ?',
          'delete_subtitle': 'A certificate will be deleted',
          'discard_title': 'cancel changes ?',
          'yes': 'Yes',
          'no': 'No',
          'settings': 'Settings',
          'account': 'Account',
          'personal_info': 'Personal Info',
          'languages': 'Languages',
          'delete_all': 'Delete All Certificates',
          'change_name': 'Change Name',
          'new_name': 'new name',
          'save_btn': 'Save',
          'delete_all_title': 'Delete All ?',
          'delete_all_sub': 'All certificates will be deleted',
          'p1_t': 'What should\nwe call you ?',
          'p1_fn': 'full name',
          'insert_n': 'Please insert your name',
          'p2_t': 'Manage Wallet',
          'p2_sub': 'Manage your certificates wallet',
          'p3_t': 'Stay Aware',
          'p3_sub': 'stay up to date with pandemic news',
          'p4_t': 'Get Notified',
          'p4_sub': 'Get notified if you were a contact case',
          'next': 'Next',
          'skip': 'Skip',
          'get_started': 'Get Started',
          "report_tt": 'Repport test result',
          'report_page_tt':
              'You have tested positive for COVID-19 and you want to identify yourself in the app',
          'report_page_bd':
              "You should have received an email, text or letter containing a QR code sent by the platform, provided your contact details were correctly entered at the time of the test.\nYou can either access this QR code directly by clicking on the link or scanning it into the application.",
          'report_btn': 'Enter code',
          "sensitization_tt": 'Sensitization',
          'sensitization_page_tt':
              'The digital "cahier de rappel".\nEasier and anonymous.',
          'sensitization_page_bd': ' Covid-19 Tracer Signal is the simple and'
              'anonymous alternative to the "cahier de rappel".'
              '\n\n👉 Why: to be alerted and alert others if you'
              ' are exposed to COVID-19 in a place you have been to.'
              '\n\n🔐 It\'s anonymous: no personal data is'
              'collected either on the venue or on the people.'
              '\n\n☺️ It\'s simple: scan the QR Code in the'
              'places that have set up Signal. If you are'
              'positive, do not forget to identify yourself in'
              ' Covid-19 Tracer to anonymously inform other users',
          'sensitization_page_tt2': 'The QR Codes',
          'sensitization_page_bd2': 'The venues with these QR Codes have it'
              'either at the entrance, or in more approriate'
              'places to scan a QR Code.'
              'If you don\'t find the QR Code, you can ask'
              'the staff to help you.',
          'sensitization_page_tt3': 'The alerts',
          'sensitization_page_bd3': ' Covid-19 Tracer Signal is the simple and'
              'If a person later tests positive, all people'
              'will be informed that they may have been'
              'exposed to the virus and will be invited to be tested.'
              'If three people or more have been in the'
              'same place and then test positive, all'
              'the other people present in this place'
              'will be considered as contacts (because'
              'co-exposed) and invited to isolate'
              'themselves, to be tested.',
          'sensitization_btn': 'Scan a QR code',
          'card_2_tt': 'Scan a venue QR code',
          'card_2_bd': 'Be alerted in case of\nexposure in venue',
          'card_3_tt': 'You are COVID-19\npositive?',
          'card_3_bd': 'Tap here to scan the QR code'
        },
        'ar_MA': {
          'health_pass': 'جواز الصحة',
          'card1_title': 'افتح محفظتي',
          'card1_subtitle': 'شهادات الاختبار والتلقيح الخاصة بك',
          'statistics1': 'تغطية التلقيح',
          'statistics2': 'احصائيات الرئيسية الأخرى',
          'update': 'مستجدات',
          'completed': 'التلقيح المكتمل',
          'new_cases': 'حالات جديدة',
          'cases': 'متعافون',
          'news': 'آخر الأخبار',
          'contact_tracing': 'تتبع الاتصال',
          'wallet': 'محفظتي',
          'add_certif': 'أضف الشهادات',
          'display_certif': 'عرض كود Qr',
          'delete': 'حذف',
          'certificates': 'شهادة',
          'save': 'حفظ الشهادة',
          'positive': 'إيجابي',
          'upload': 'رفع ملف',
          'cancel': 'إلغاء',
          'delete_title': 'هل أنت متأكد ؟',
          'delete_subtitle': 'سيتم حذف شهادة واحدة',
          'discard_title': 'إلغاء التغييرات ؟',
          'yes': 'نعم',
          'no': 'لا',
          'settings': 'الإعدادات',
          'account': 'الحساب',
          'personal_info': 'معلومات شخصية',
          'languages': 'اللغات',
          'delete_all': 'حذف كافة الشهادات',
          'change_name': 'تغيير الإسم',
          'new_name': 'اسم جديد',
          'save_btn': 'حفظ',
          'delete_all_title': 'حذف الكل ؟',
          'delete_all_sub': 'سيتم حذف جميع الشهادات',
          'p1_t': 'ما اسمك ؟',
          'p1_fn': 'الاسم الكامل',
          'insert_n': 'الرجاء إدخال اسمك',
          'p2_t': 'إدارة المحفظة',
          'p2_sub': 'إدارة محفظة الشهادات',
          'p3_t': 'ابق على علم',
          'p3_sub': 'ابق على اطلاع بأخبار الجائحة',
          'p4_t': 'الحصول على إشعار',
          'p4_sub': 'احصل على إشعار إذا كنت تمثل حالة اتصال',
          'next': 'التالي',
          'skip': 'تخطي',
          'get_started': 'البدء',
          "report_tt": 'تقرير نتيجة الاختبار',
          'report_page_tt':
              'أثبتت الاختبارات إيجابيتك لـفيروس كوفيد 19 وتريد تسجيله بنفسك في التطبيق',
          'report_page_bd':
              'من المفترض أن تكون قد تلقيت بريدًا إلكترونيًا أو نصًا أو خطابًا يحتوي على رمز QR أرسله النظام الأساسي ، بشرط إدخال تفاصيل الاتصال الخاصة بك بشكل صحيح في وقت الاختبار.يمكنك إما الوصول إلى رمز الاستجابة السريعة هذا مباشرة من خلال النقر على الرابط أو مسحه ضوئيًا في التطبيق.',
          'report_btn': 'ادخل الرمز',
          "sensitization_tt": 'توعية',
          'sensitization_page_tt': 'دفتر التذكير الرقمي . '
              'اسهل و يحافظ على خصوصياتك.',
          'sensitization_page_bd':
              'لماذا : ليتم تنبيهك وتنبيه الآخرين إذا تعرضت لفيروس كوفيد 19 في مكان كنت فيه\n\n'
                  'مجهول الهوية: لا يتم جمع أي بيانات شخصية عن المكان أو الأشخاص.\n\n'
                  'الأمر بسيط: امسح رمز الاستجابة السريعة ضوئيًا في الأماكن التي تم إعدادها. إذا كنت إيجابيًا ، فلا تنس تحديد هويتك في التطبيق لإبلاغ المستخدمين الآخرين دون الكشف عن هويتك\n\n',
          'sensitization_page_tt2': 'رموز QR',
          'sensitization_page_bd2':
              'تحتوي الأماكن التي تحتوي على رموز QR هذه على المدخل أو في أماكن أكثر ملاءمة لمسح رمز QR ضوئيًا.',
          'sensitization_page_tt3': 'تنبيهات',
          'sensitization_page_bd3':
              'إذا كانت نتيجة اختبار شخص واحد إيجابية ، فسيتم إخبار جميع الأشخاص بأنهم ربما تعرضوا للفيروس وسيُطلب منهم إجراء الاختبار.'
                  'إذا كان ثلاثة أشخاص أو أكثر في نفس المكان ثم جاءت نتيجة الاختبار إيجابية ، فسيتم اعتبار جميع الأشخاص الآخرين الموجودين في هذا المكان حالات مخالطة (لأنهم تعرضوا للفيروس بشكل مشترك) وسيُطلب منهم عزل أنفسهم وإجراء الاختبار.',
          'sensitization_btn': 'امسح الكود QR',
          'card_2_tt': 'امسح رمز QR',
          'card_2_bd': 'يتم تنبيهك في حالة التعرض في المكان',
          'card_3_tt': 'هل أنت إيجابي لـ COVID-19؟',
          'card_3_bd': 'انقر هنا لمسح رمز QR'
        },
        'fr_FR': {
          'health_pass': 'Passe Vaccinal',
          'card1_title': 'Ouvrir mon Portefeuille',
          'card1_subtitle': 'Mes Certificats de tests\net vaccinations',
          'statistics1': 'Couverture vaccinale',
          'statistics2': 'Autres statistiques clés',
          'update': 'Nouveautés',
          'completed': 'Vaccination complète',
          'new_cases': 'Nouveaux\ncas',
          'cases': 'Rétablis',
          'news': 'Nouveautés',
          'contact_tracing': 'Recherche de contacts',
          'wallet': 'Portefeuille',
          'add_certif': 'Ajouter certificat',
          'display_certif': 'Afficher le qr code',
          'delete': 'Supprimer',
          'certificates': 'Certificat',
          'save': 'Enregistrer certificat',
          'positive': 'Positif',
          'upload': 'Importer un fichier',
          'cancel': 'Annuler',
          'delete_title': 'Êtes-vous sûr ?',
          'delete_subtitle': 'Un certificat sera supprimé',
          'discard_title': 'Annuler\nles modifications ?',
          'yes': 'Oui',
          'no': 'Non',
          'settings': 'Paramètres',
          'account': 'Compte',
          'personal_info': 'Informations Personnelles',
          'languages': 'Langues',
          'delete_all': 'Supprimer tous\nles certificats',
          'change_name': 'Changer le nom',
          'new_name': 'nouveau nom',
          'save_btn': 'Enregistrer',
          'delete_all_title': 'Supprimer tout ?',
          'delete_all_sub': 'Tous les certificats\nseront supprimés',
          'p1_t': 'Comment doit-on vous appeler ?',
          'p1_fn': 'nom complet',
          'insert_n': 'Veuillez insérer votre nom',
          'p2_t': 'Gérer le portefeuille',
          'p2_sub': 'Gérer votre portefeuille de certificats',
          'p3_t': 'Restez informé',
          'p3_sub': 'restez au courant des actualités pandémiques',
          'p4_t': 'Recevoir une notification',
          'p4_sub': 'Recevez une notification si vous étiez un cas contact',
          'next': 'Suivant',
          'skip': 'Sauter',
          'get_started': 'Commencer',
          "report_tt": 'Signaler le résultat du test',
          'report_page_tt':
              'Vous avez été testé positif pour COVID-19 et vous souhaitez vous identifier dans l\'application',
          'report_page_bd':
              'Vous avez dû recevoir un email, SMS ou courrier contenant un QR code envoyé par la plateforme, à condition que vos coordonnées aient été correctement renseignées au moment du test.\nVous pouvez soit accéder directement à ce code QR en cliquant sur le lien, soit le scanner dans l\'application.',
          'report_btn': 'Entrer le code',
          "sensitization_tt": 'Sensibilisation',
          'sensitization_page_tt': 'Le "cahier de rappel" numérique.\n'
              'Plus facile et anonyme.',
          'sensitization_page_bd':
              'Covid-19 Tracer Signal est l\'alternative simple '
                  'et anonyme au "cahier de rappel".'
                  '\n\n👉 Pourquoi : pour être alerté et alerter '
                  'les autres si vous êtes exposé au COVID-19 dans '
                  'un lieu où vous êtes allé.'
                  '\n\n🔐 C\'est anonyme : aucune donnée personnelle n\'est '
                  'collectée ni sur le lieu ni sur les personnes.'
                  '\n\n☺️ C\'est simple : scannez le QR Code dans les lieux '
                  'qui ont mis en place Signal. Si vous êtes positif, '
                  'n\'oubliez pas de vous identifier dans TousAntiCovid '
                  'pour informer anonymement les autres utilisateurs.',
          'sensitization_page_tt2': 'Les QR Codes',
          'sensitization_page_bd2': 'Les lieux avec ces codes QR l\'ont '
              'soit à l\'entrée, soit dans des lieux '
              'plus appropriés pour scanner un code QR.',
          'sensitization_page_tt3': 'Les alertes',
          'sensitization_page_bd3':
              'Si une personne est ensuite testée positive, '
                  'toutes les personnes seront informés '
                  'qu\'ils ont peut-être été exposés au virus '
                  'et seront invités à être testé.'
                  'Si trois personnes ou plus ont été dans '
                  'le même endroit puis test positif, tous les autres '
                  'personnes présentes dans ce lieu seront considérés '
                  'comme des cas contacts (car co-exposé) et seront '
                  'invités à s\'isoler et à se mettre au test.',
          'sensitization_btn': 'Scaner le code QR',
          'card_2_tt': 'Scannez le code QR \nd\'un site',
          'card_2_bd': 'être alerté en cas \nd\'exposition dans le lieu',
          'card_3_tt': 'Vous êtes positif au \nCOVID-19 ?',
          'card_3_bd': 'Appuyez ici pour scanner\nle code QR'
        }
      };
}
