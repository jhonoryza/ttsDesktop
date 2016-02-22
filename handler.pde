//handler button
public void buttonSaveVoiceConfiguration(GButton source, GEvent event) {
  println("voice config saved");
  String[] text = {inputPitch.getText() +"," +inputRate.getText() +"," +inputVolume.getText()};
  String currentPath = sketchPath() + "/data/voice.cfg";
  println(currentPath);
  saveStrings(currentPath, text);
  loadVoiceSetting();
  voiceSettingWindow.close();
  voiceSettingWindow = null;
}
public void buttonExit() {
  exit();
}
public void buttonContinueHandler(GButton source, GEvent event) {
  continueButtonFuntion();
}
public void buttonNextHandler(GButton source, GEvent event) {
  nextButtonFuntion();
}
public void buttonBackHandler(GButton source, GEvent event) {
  backButtonFunction();
}
public void editHalteHandler(GButton source, GEvent event) {
  myKoridor.get(slideNum-1).namaKoridor = inputA.getText();
  if (!myKoridor.get(slideNum-1).namaKoridor.isEmpty())
    createListHalte();
}
public void inB1Handler(GButton source, GEvent event) {
}
public void inB2Handler(GButton source, GEvent event) {
}
public void inB3Handler(GButton source, GEvent event) {
}
public void inB4Handler(GButton source, GEvent event) {
}
public void inB5Handler(GButton source, GEvent event) {
}
public void saveHalteHandler(GButton source, GEvent event) {
  saveCurrentHalte();
}
public void buttonLoadSettingHandler(GButton source, GEvent event) {
  selectInput("Select a file to process:", "loadSettingLoaded");
}
void loadSettingLoaded(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    loadSettingPath = selection.getAbsolutePath();
  }
}
public void buttonWriteTextHandler(GButton source, GEvent event) {
  if (!loadSettingPath.isEmpty()) {
    String lines[] = loadStrings(loadSettingPath);
    println(lines.length);
    for (int i = 0; i < lines.length; i++) {
      println(lines[i]);
      String[] list = split(lines[i], ":");
      printArray(list);
      //for (int j=0; j<list.length; j++) {
      //  String[] koridorFiles = loadStrings(path +"\\" +list[j]);
      //  loadFilesToArea(koridorFiles, j, i);
      //}
    }
  }
  newWriteToSDWindow.close();
  newWriteToSDWindow = null;
}
public void buttonWriteVoiceHandler(GButton source, GEvent event) {
}
boolean browsed = false;
public void browseHandler(GButton source, GEvent event) {
  selectOutput("Select a file to write to:", "fileSelected");
}
void fileSelected(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    browsed = true;
    newSettingFilePath = selection.getAbsolutePath();
  }
}
public void butMeButtonHandler(GButton source, GEvent event) {
  for (int i=0; i<korNum; i++) {
    if (source.tagNo == i) {
      println("tag "+i +" clicked"); 
      editHalteAndKoridor(i);
    }
  }
}
public void delMeButtonHandler(GButton source, GEvent event) {
  int lastKorNum = korNum;
  for (int i=0; i<lastKorNum; i++) {
    delMe[i].dispose();
    delMe[i] = null;
    butMe[i].dispose();
    butMe[i] = null;
    me[i].dispose();
    me[i] = null;
    labelMe[i].dispose();
    labelMe[i] = null;
    
    if (source.tagNo == i) {
      myKoridor.remove(i);
      korNum --;
    }
  }
  refreshLoadWizard();
}
public void buttonSaveLoadSettingWizardHandler(GButton source, GEvent event) {
  selectOutput("Save as:", "fileLoadSettingWizard");
}
public void buttonLocationLoadSettingWizardHandler(GButton source, GEvent event) {
  //selectOutput("Save as:", "fileLoadSettingWizard");
}
void fileLoadSettingWizard(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    browsed = true;
    newSettingFilePath = selection.getAbsolutePath();
    saveTextFunction();
    println("saved to " +newSettingFilePath);
    JOptionPane.showMessageDialog(null, "saved to " +newSettingFilePath, "save path", JOptionPane.WARNING_MESSAGE);
    loadSettingWizardWindow.close(); 
    loadSettingWizardWindow = null;
  }
}
public void myButtonHandler(GButton source, GEvent event) {
  saveTemporary();
}
public void delMyFieldHandler(GButton source, GEvent event) {
  int totalHalteGo = myKoridor.get(currentHal).totalHalteGo;
  int totalHalteBack = myKoridor.get(currentHal).totalHalteBack;
  int total = totalHalteGo+totalHalteBack+1;
  for (int j=0; j<total; j++) {
    if (j > 0 && j<=totalHalteGo) {
      int k = j - 1;
      myField[j].dispose();
      myLabelField[j].dispose();
      delMyField[j].dispose();
      myField[j] = null;
      myLabelField[j] = null;
      delMyField[j] = null;
      if (source.tagNo == j) {
        myKoridor.get(currentHal).namaHalteGo.remove(k);
        myKoridor.get(currentHal).totalHalteGo --;
      }
    } else if (j > totalHalteGo) {
      int k = j - (totalHalteGo+1);
      myField[j].dispose();
      myLabelField[j].dispose();
      delMyField[j].dispose();
      myField[j] = null;
      myLabelField[j] = null;
      delMyField[j] = null;
      if (source.tagNo == j) {
        myKoridor.get(currentHal).namaHalteBack.remove(k);
        myKoridor.get(currentHal).totalHalteBack --;
      }
    }
  }
  refreshEditHalteAndKoridor();
}
//handler option
public void optYesHandler(GOption source, GEvent event) {
  myKoridor.get(slideNum-1).choice = true;
  optYes.setSelected(true);
  optNo.setSelected(false);
  yesOptionFunction();
}
public void optNoHandler(GOption source, GEvent event) {
  myKoridor.get(slideNum-1).choice = false;
  optYes.setSelected(false);
  optNo.setSelected(true);
  noOptionFunction() ;
}
//handler input
public void inputAHandler(GTextField source, GEvent event) {
  if (event == GEvent.ENTERED && newSetSlideNum == 0) {
    continueButtonFuntion();
  }
}
public void in1Handler(GTextField source, GEvent event) {
  if (event == GEvent.ENTERED && !in2.isVisible()) {
    myKoridor.get(slideNum-1).namaKoridor = inputA.getText();
    if (!myKoridor.get(slideNum-1).namaKoridor.isEmpty())
      createListHalte();
  }
}
public  void in2Handler(GTextField source, GEvent event) {
  if (event == GEvent.ENTERED) {
    myKoridor.get(slideNum-1).namaKoridor = inputA.getText();
    if (!myKoridor.get(slideNum-1).namaKoridor.isEmpty())
      createListHalte();
  }
}
public void halteEnterHandler(GTextField source, GEvent event) {
  if (event == GEvent.ENTERED) {
    saveCurrentHalte();
  }
}
//handler key
public void newHalteWindowKeyHandler(PApplet app, GWinData data, KeyEvent event) {
  if (event.getAction() == KeyEvent.PRESS && app.keyCode == UP) {
    panelHalte.moveTo(0, panelHalte.getY()-2);
  } else if (event.getAction() == KeyEvent.PRESS && app.keyCode == DOWN) {
    panelHalte.moveTo(0, panelHalte.getY()+2);
  }
}
//handler mouse
public void newHalteWindowMouseHandler(PApplet app, GWinData data, MouseEvent mevent) {
  if (mevent.getAction() == MouseEvent.WHEEL) {
    panelHalte.moveTo(0, panelHalte.getY() +(10*mevent.getCount()));
  }
}
public void loadSettingWizardWindowMouseHandler(PApplet app, GWinData data, MouseEvent mevent) {
  if (mevent.getAction() == MouseEvent.WHEEL) {
    groupLoadSettingWizard.moveTo(0, groupLoadSettingWizard.getY() +(10*mevent.getCount()));
  }
}
public void editHalteAndKoridorWindowMouseHandler(PApplet app, GWinData data, MouseEvent mevent) {
  if (mevent.getAction() == MouseEvent.WHEEL) {
    editHalteAndKoridorPanel.moveTo(0, editHalteAndKoridorPanel.getY() +(10*mevent.getCount()));
  }
}