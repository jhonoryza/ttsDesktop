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
  myKoridor[slideNum-1].namaKoridor = inputA.getText();
  if (!myKoridor[slideNum-1].namaKoridor.isEmpty())
    createListHalte();
}
public void saveHalteHandler(GButton source, GEvent event) {
  if (myKoridor[slideNum-1].namaHalteGo.size() == myKoridor[slideNum-1].totalHalteGo) {
    //set data 
    for (int i=0; i<myKoridor[slideNum-1].totalHalteGo; i++)
      myKoridor[slideNum-1].namaHalteGo.set(i, inputHalteGo[i].getText());
  } else if (myKoridor[slideNum-1].namaHalteGo.size() < myKoridor[slideNum-1].totalHalteGo) {
    //remove data then add new data
    myKoridor[slideNum-1].namaHalteGo.clear();
    for (int i=0; i<myKoridor[slideNum-1].totalHalteGo; i++)
      myKoridor[slideNum-1].namaHalteGo.append(inputHalteGo[i].getText());
  } else if (myKoridor[slideNum-1].namaHalteGo.size() > myKoridor[slideNum-1].totalHalteGo) {
    //remove data then add new data
    myKoridor[slideNum-1].namaHalteGo.clear();
    for (int i=0; i<myKoridor[slideNum-1].totalHalteGo; i++)
      myKoridor[slideNum-1].namaHalteGo.append(inputHalteGo[i].getText());
  }
  
  printArray(myKoridor[slideNum-1].namaHalteGo);
  if (myKoridor[slideNum-1].namaHalteBack.size() == myKoridor[slideNum-1].totalHalteBack) {
    //set data 
    for (int i=0; i<myKoridor[slideNum-1].totalHalteBack; i++)
      myKoridor[slideNum-1].namaHalteBack.set(i, inputHalteBack[i].getText());
  } else if (myKoridor[slideNum-1].namaHalteBack.size() < myKoridor[slideNum-1].totalHalteBack) {
    //remove data then add new data
    myKoridor[slideNum-1].namaHalteBack.clear();
    for (int i=0; i<myKoridor[slideNum-1].totalHalteBack; i++)
      myKoridor[slideNum-1].namaHalteBack.append(inputHalteBack[i].getText());
  } else if (myKoridor[slideNum-1].namaHalteBack.size() > myKoridor[slideNum-1].totalHalteBack) {
    //remove data then add new data
    myKoridor[slideNum-1].namaHalteBack.clear();
    for (int i=0; i<myKoridor[slideNum-1].totalHalteBack; i++)
      myKoridor[slideNum-1].namaHalteBack.append(inputHalteBack[i].getText());
  }
  printArray(myKoridor[slideNum-1].namaHalteBack);
}
//handler option
public void optYesHandler(GOption source, GEvent event) {
  myKoridor[slideNum-1].choice = true;
  optYes.setSelected(true);optNo.setSelected(false);
  yesOptionFunction();
}
public void optNoHandler(GOption source, GEvent event) {
  myKoridor[slideNum-1].choice = false;
  optYes.setSelected(false);optNo.setSelected(true);
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
    myKoridor[slideNum-1].namaKoridor = inputA.getText();
    if (!myKoridor[slideNum-1].namaKoridor.isEmpty())
      createListHalte();
  }
}
public  void in2Handler(GTextField source, GEvent event) {
  if (event == GEvent.ENTERED) {
    myKoridor[slideNum-1].namaKoridor = inputA.getText();
    if (!myKoridor[slideNum-1].namaKoridor.isEmpty())
      createListHalte();
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