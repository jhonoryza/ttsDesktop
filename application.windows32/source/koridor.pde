public class koridor {
  // The variables can be anything you like.
  String namaKoridor;
  int totalHalteGo, totalHalteBack;
  ArrayList<String> namaHalteGo, namaHalteBack;
  boolean choice;
  koridor(){
    namaKoridor = "";
    totalHalteBack = 0;
    totalHalteGo = 0;
    namaHalteGo = new ArrayList<String>();
    namaHalteBack = new ArrayList<String>();
    choice = true;
  }
}