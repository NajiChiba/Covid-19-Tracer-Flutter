// ignore_for_file: avoid_print, non_constant_identifier_names

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;

class StatisticsController extends GetxController {
  RxString newCases = '-'.obs;
  RxString recovred = '-'.obs;
  RxString vaccinated = '-'.obs;
  RxString vaccinationPerc = '-'.obs;
  final url = 'https://www.worldometers.info/coronavirus/country/morocco';
  final vacc_url = 'http://www.covidmaroc.ma/Pages/AccueilAR.aspx';

  @override
  void onInit() {
    super.onInit();
    getCases();
  }

  @override
  void onClose() {
    super.onClose();
    print('closed');
  }

  void getCases() async {
    try {
      var response = await http.Client().get(Uri.parse(url));

      var vacResponse = await http.Client().get(Uri.parse(vacc_url));

      if (response.statusCode == 200) {
        var document = parser.parse(response.body);
        // NEW CASES
        try {
          var strNewCases =
              document.getElementsByClassName('news_li')[0].children[0].text;
          strNewCases =
              strNewCases.replaceAll((RegExp(r'[^0-9 ,]')), '').trim() + '';

          newCases(strNewCases);

          var strRecovered = document
              .getElementsByClassName('maincounter-number')[2]
              .children[0]
              .innerHtml
              .trim();

          strRecovered = strRecovered.trim() + '';
          recovred(strRecovered);
        } catch (e) {
          print(e);
        }
      }
      if (vacResponse.statusCode == 200) {
        var document = parser.parse(vacResponse.body);
        // VACCINATION
        try {
          var strVaccinated = document
              .getElementsByTagName('tbody')[0]
              .children[3]
              .children[0]
              .children[1]
              .text
              .trim();

          strVaccinated = strVaccinated
              .replaceAll(RegExp(r"\s+"), '')
              .replaceAll('\u200B', '');

          if (strVaccinated.length >= 7) {
            vaccinated(
                (double.parse(strVaccinated) / 1000000).toStringAsFixed(1) +
                    'M');
          }

          // vacc percent
          vaccinationPerc(
              ((100 * double.parse(strVaccinated) / (36.91 * 1000000))
                          .toStringAsFixed(1) +
                      '%')
                  .replaceAll('.', ','));
        } catch (e) {
          print(e);
        }
      }
    } catch (e) {
      print(e);
    }
  }

  get getNewCases => newCases.value;
  get getRecovered => recovred.value;
  get getVaccinated => vaccinated.value;
  get getVaccinatedPerc => vaccinationPerc.value;
}
