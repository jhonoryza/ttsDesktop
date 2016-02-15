public class koridor {
  // The variables can be anything you like.
  String namaKoridor;
  int totalHalteGo, totalHalteBack;
  StringList namaHalteGo, namaHalteBack;
  boolean choice;
  koridor(){
    namaKoridor = "";
    totalHalteBack = 0;
    totalHalteGo = 0;
    namaHalteGo = new StringList();
    namaHalteBack = new StringList();
    choice = true;
  }
}