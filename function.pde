GWindow voiceSettingWindow;
GTextField inputPitch, inputRate, inputVolume;
GTextArea textPreviewConfig;
GButton buttonSaveConfig;
//function
public void voiceSetting() {
  voiceSettingWindow = GWindow.getWindow(this, "Voice Tuning", 50, 100, 500, 240, JAVA2D); 
  voiceSettingWindow.noLoop();
  voiceSettingWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  voiceSettingWindow.addDrawHandler(this, "win_drawVoiceSetting");

  inputPitch = new GTextField(voiceSettingWindow, 100, 30, 60, 20, G4P.SCROLLBARS_NONE);
  inputPitch.setText(voicePitch);
  inputPitch.setOpaque(false);
  inputPitch.setFont(GuiUbu11);

  inputRate = new GTextField(voiceSettingWindow, inputPitch.getX()+inputPitch.getWidth()+100, 30, 60, 20, G4P.SCROLLBARS_NONE);
  inputRate.setText(voiceRate);
  inputRate.setOpaque(false);
  inputRate.setFont(GuiUbu11);

  inputVolume = new GTextField(voiceSettingWindow, inputRate.getX()+inputRate.getWidth()+100, 30, 60, 20, G4P.SCROLLBARS_NONE);
  inputVolume.setText(voiceVolume);
  inputVolume.setOpaque(false);
  inputVolume.setFont(GuiUbu11);

  textPreviewConfig = new GTextArea(voiceSettingWindow, 10, inputVolume.getY()+40, 480, 40, G4P.SCROLLBARS_NONE);
  textPreviewConfig.setText("pemberhentian berikutnya, halte sarijadi, perhatikan barang bawaan anda dan hati hati melangkah, terimakasih");
  textPreviewConfig.setFont(GuiUbu11);
  textPreviewConfig.setEnabled(false);

  GButton buttonPreviewConfig = new GButton(voiceSettingWindow, voiceSettingWindow.width/2-75, inputVolume.getY()+100, 150, 30);
  buttonPreviewConfig.setText("preview voice");
  buttonPreviewConfig.setOpaque(false);
  buttonPreviewConfig.addEventHandler(this, "buttonPreviewConfig");

  buttonSaveConfig = new GButton(voiceSettingWindow, voiceSettingWindow.width/2-75, inputVolume.getY()+140, 150, 30);
  buttonSaveConfig.setText("save configuration");
  buttonSaveConfig.setOpaque(false);
  buttonSaveConfig.addEventHandler(this, "buttonSaveVoiceConfiguration");
  //buttonSaveConfig.setFont(GuiUbu11);

  voiceSettingWindow.loop();
}

void loadVoiceSetting() {
  String currentPath = sketchPath() +"/data/voice.cfg";
  String[] file = loadStrings(currentPath);
  String text = "";
  for (int i=0; i<file.length; i++)
    text += file[i];
  String[] list = split(text, ",");
  voicePitch = list[0];
  voiceRate = list[1];
  voiceVolume = list[2];
  println("pitch " +voicePitch +" rate " +voiceRate +" volume " +voiceVolume);
}

PrintWriter output;
void saveTextFunction() {
  output = createWriter(newSettingFilePath); 
  output.println("total koridor : " +korNum);
  if (korNum > 0) {
    String data = "list koridor : ";
    for (int i=0; i<korNum; i++) {
      if (i>0)
        data += ",";
      data += myKoridor.get(i).namaKoridor;
    }
    output.println(data);
    for (int i=0; i<korNum; i++) {
      data = "list halte : ";
      output.println("total halte (jalur pergi) koridor "+i +" : " +myKoridor.get(i).totalHalteGo);
      for (int j=0; j<myKoridor.get(i).totalHalteGo; j++) {
        if (j>0)
          data += ",";
        if (myKoridor.get(i).namaHalteGo.size() < 1)
          data += "";
        else
          data += myKoridor.get(i).namaHalteGo.get(j);
      }
      output.println(data);
      data = "list halte : ";
      output.println("total halte (jalur pulang) koridor "+i +" : " +myKoridor.get(i).totalHalteBack);
      for (int j=0; j<myKoridor.get(i).totalHalteBack; j++) {
        if (j>0)
          data += ",";
        if (myKoridor.get(i).namaHalteBack.size() < 1)
          data += "";
        else
          data += myKoridor.get(i).namaHalteBack.get(j);
      }
      output.println(data);
      data = "list text indoor : ";
    }
    for (int i=0; i<textIndoor.size(); i++) {
      if (i>0)
        data += ",";
      data += textIndoor.get(i);
    }
    output.println(data);
    data = "list text outoor : ";
    for (int i=0; i<textOutdoor.size(); i++) {
      if (i>0)
        data += ",";
      data += textOutdoor.get(i);
    }
    output.println(data);
    data = "";
  }
  output.println("pre text : " +preText);
  output.println("afer text: " +afterText);
  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  //exit(); // Stops the program
  //return 1;
}

GWindow newSettingWindow;
GLabel labelText, labela, labelb;
GButton buttonNext, buttonContinue, buttonBack, editHalte, buttonBrowse, buttonPreviewVoice;
GTextField inputA, in1, in2, inPreTemp, inAfterTemp, inHal; 
GTextField[] inB;
GOption optYes, optNo;
GToggleGroup optGroup;
GTabManager tab;
public void newSettingWizard() {
  newSettingWindow = GWindow.getWindow(this, "New Setting Wizard", 20, 20, 500, 300, JAVA2D); 
  newSettingWindow.noLoop();
  newSettingWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  newSettingWindow.addDrawHandler(this, "win_drawNewSetting");
  //page continue
  inPreTemp = new GTextField(newSettingWindow, 10, 140, 480, 20, G4P.SCROLLBARS_NONE);
  inPreTemp.setText(preText);
  inPreTemp.setFont(GuiUbu11);
  inHal = new GTextField(newSettingWindow, 10, inPreTemp.getY()+25, 480, 20, G4P.SCROLLBARS_NONE);
  inHal.setText("halte kopo");
  inHal.setFont(GuiUbu11);
  inAfterTemp = new GTextField(newSettingWindow, 10, inHal.getY()+25, 480, 20, G4P.SCROLLBARS_NONE);
  inAfterTemp.setText(afterText);
  inAfterTemp.setFont(GuiUbu11);
  buttonPreviewVoice = new GButton(newSettingWindow, 10, inAfterTemp.getY()+35, 90, 25);
  buttonPreviewVoice.setText("preview voice");
  buttonPreviewVoice.setOpaque(false);
  buttonPreviewVoice.addEventHandler(this, "buttonPreviewVoiceHandler");
  buttonPreviewVoice.setFont(GuiUbu11);
  //media
  buttonContinue = new GButton(newSettingWindow, newSettingWindow.width-70, newSettingWindow.height-30, 60, 25);
  buttonContinue.setOpaque(false);
  buttonContinue.setText("continue");
  buttonContinue.addEventHandler(this, "buttonContinueHandler");
  buttonContinue.setFont(GuiUbu11);
  inputA = new GTextField(newSettingWindow, 10, 65, 260, 20, G4P.SCROLLBARS_NONE);
  inputA.addEventHandler(this, "inputAHandler");
  inputA.setPromptText("input here");
  inputA.setFont(GuiUbu11);
  inB = new GTextField[5];
  inB[0] = new GTextField(newSettingWindow, 10, 65, 260, 20, G4P.SCROLLBARS_NONE);
  inB[0].setOpaque(false);
  inB[0].addEventHandler(this, "inB1Handler");
  inB[0].setFont(GuiUbu11);
  inB[1] = new GTextField(newSettingWindow, 10, inB[0].getY()+30, 260, 20, G4P.SCROLLBARS_NONE);
  inB[1].setOpaque(false);
  inB[1].addEventHandler(this, "inB2Handler");
  inB[1].setFont(GuiUbu11);
  inB[2] = new GTextField(newSettingWindow, 10, inB[1].getY()+30, 260, 20, G4P.SCROLLBARS_NONE);
  inB[2].setOpaque(false);
  inB[2].addEventHandler(this, "inB3Handler");
  inB[2].setFont(GuiUbu11);
  inB[3] = new GTextField(newSettingWindow, 10, inB[2].getY()+30, 260, 20, G4P.SCROLLBARS_NONE);
  inB[3].setOpaque(false);
  inB[3].addEventHandler(this, "inB4Handler");
  inB[3].setFont(GuiUbu11);
  inB[4] = new GTextField(newSettingWindow, 10, inB[3].getY()+30, 260, 20, G4P.SCROLLBARS_NONE);
  inB[4].setOpaque(false);
  inB[4].addEventHandler(this, "inB5Handler");
  inB[4].setFont(GuiUbu11);

  buttonNext = new GButton(newSettingWindow, newSettingWindow.width-70, newSettingWindow.height-30, 50, 25);
  buttonNext.setOpaque(false);
  buttonNext.setText("next");
  buttonNext.addEventHandler(this, "buttonNextHandler");
  buttonNext.setFont(GuiUbu11);
  buttonBack = new GButton(newSettingWindow, buttonNext.getX()-buttonNext.getWidth()- 20, newSettingWindow.height-30, 50, 25);
  buttonBack.setOpaque(false);
  buttonBack.setText("back");
  buttonBack.addEventHandler(this, "buttonBackHandler");
  buttonBack.setFont(GuiUbu11);
  optYes = new GOption(newSettingWindow, 310, 90, 60, 30);
  optYes.addEventHandler(this, "optYesHandler");
  optYes.setText("ya");
  optYes.setOpaque(false);
  optYes.setFont(GuiUbu11);
  optYes.setSelected(true);
  optNo = new GOption(newSettingWindow, optYes.getX()+60, 90, 60, 30);
  optNo.addEventHandler(this, "optNoHandler");
  optNo.setText("tidak");
  optNo.setOpaque(false);
  optNo.setFont(GuiUbu11);
  optGroup = new GToggleGroup();
  optGroup.addControl(optYes);
  optGroup.addControl(optNo);
  in1 = new GTextField(newSettingWindow, 10, 140, 260, 20, G4P.SCROLLBARS_NONE);
  in1.setVisible(false);
  in1.setOpaque(false);
  in1.addEventHandler(this, "in1Handler");
  in1.setPromptText("total halte (jalur pergi)");
  in1.setFont(GuiUbu11);
  in2 = new GTextField(newSettingWindow, 10, in1.getY()+50, 260, 20, G4P.SCROLLBARS_NONE);
  in2.setVisible(false);
  in2.setOpaque(false);
  in2.addEventHandler(this, "in2Handler");
  in2.setPromptText("total halte (jalur pulang)");
  in2.setFont(GuiUbu11);
  tab = new GTabManager();
  tab.addControls(inputA, in1, in2);
  editHalte = new GButton(newSettingWindow, optYes.getX(), in1.getY(), 80, 20);
  editHalte.setText("edit halte");
  editHalte.setOpaque(false);
  editHalte.setVisible(false);
  editHalte.addEventHandler(this, "editHalteHandler");
  editHalte.setFont(GuiUbu11);
  buttonBrowse = new GButton(newSettingWindow, 10, newSettingWindow.height - 30, 80, 20);
  buttonBrowse.setText("browse");
  buttonBrowse.setOpaque(false);
  buttonBrowse.setVisible(false);
  buttonBrowse.addEventHandler(this, "browseHandler");
  buttonBrowse.setFont(GuiUbu11);
  //value init
  korNum = 0; 
  slideNum = 0; 
  newSetSlideNum = 0;
  GUINewSetSlideNum0();
  myKoridor.clear();
  textIndoor = new StringList();
  textOutdoor = new StringList();
  newSettingWindow.loop();
}

GWindow newHalteWindow;
GPanel panelHalte;
GTextField[] inputHalteGo;
GTextField[] inputHalteBack;
void createListHalte() {
  //myKoridor.get(slideNum-1).totalHalteGo = int(in1.getText());
  //if (!in2.isVisible()) {
  //  myKoridor.get(slideNum-1).totalHalteBack = int(in1.getText());
  //} else {
  //  myKoridor.get(slideNum-1).totalHalteBack = int(in2.getText());
  //}
  //println(myKoridor.get(slideNum-1).totalHalteBack);
  //println(myKoridor.get(slideNum-1).totalHalteBack);
  if (optYes.isSelected()) {
    if (!in1.getText().isEmpty() && int(in1.getText()) > 0 && numberOrNot(in1.getText())) {
      myKoridor.get(slideNum-1).totalHalteGo = int(in1.getText());
      myKoridor.get(slideNum-1).totalHalteBack = int(in1.getText());
      createNewHalteWindow();
    } else {
      JOptionPane.showMessageDialog(null, "field cannot be empty and must be number greater than zero", "Error", JOptionPane.WARNING_MESSAGE);
    }
  } else if (optNo.isSelected()) {
    if (!in1.getText().isEmpty() && int(in1.getText()) > 0 && numberOrNot(in1.getText())
      && !in2.getText().isEmpty() && int(in2.getText()) > 0 && numberOrNot(in2.getText())) {
      myKoridor.get(slideNum-1).totalHalteGo = int(in1.getText());
      myKoridor.get(slideNum-1).totalHalteBack = int(in2.getText());
      createNewHalteWindow();
    } else {
      JOptionPane.showMessageDialog(null, "field cannot be empty and must be number greater than zero", "Error", JOptionPane.WARNING_MESSAGE);
    }
  }
}
GCustomSlider sdr1;
void createNewHalteWindow() {
  newHalteWindow = GWindow.getWindow(this, "edit halte", 120, 20, 500, 300, JAVA2D);
  newHalteWindow.noLoop();
  newHalteWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  newHalteWindow.addDrawHandler(this, "newHalteWindowHandler");
  newHalteWindow.addKeyHandler(this, "newHalteWindowKeyHandler");
  newHalteWindow.addMouseHandler(this, "newHalteWindowMouseHandler");

  panelHalte = new GPanel(newHalteWindow, 0, 0, newHalteWindow.width - 20, newHalteWindow.height, "here");
  panelHalte.setOpaque(false);

  inputHalteGo = new GTextField[myKoridor.get(slideNum-1).totalHalteGo];
  inputHalteBack = new GTextField[myKoridor.get(slideNum-1).totalHalteBack];  
  GLabel[] labelHalteGo = new GLabel[myKoridor.get(slideNum-1).totalHalteGo];
  GLabel[] labelHalteBack = new GLabel[myKoridor.get(slideNum-1).totalHalteBack];

  GTabManager tabHalte = new GTabManager();
  int lastPosition = 0;
  for (int i=0; i<myKoridor.get(slideNum-1).totalHalteGo; i++) {
    inputHalteGo[i] = new GTextField(newHalteWindow, 10, 20 + (i*40), 300, 20);
    inputHalteGo[i].setOpaque(false);
    inputHalteGo[i].setPromptText("input nama halte " +(i+1) +" (jalur pergi)");
    inputHalteGo[i].setFont(GuiUbu11);

    labelHalteGo[i] = new GLabel(newHalteWindow, 10, inputHalteGo[i].getY() - 20, 200, 20);
    labelHalteGo[i].setOpaque(false);
    labelHalteGo[i].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    labelHalteGo[i].setFont(GuiUbu11);
    labelHalteGo[i].setText("input nama halte " +(i+1) +" (jalur pergi)");

    panelHalte.addControl(inputHalteGo[i]);
    panelHalte.addControl(labelHalteGo[i]);
    tabHalte.addControl(inputHalteGo[i]);
  }
  for (int i=0; i<myKoridor.get(slideNum-1).totalHalteBack; i++) {
    inputHalteBack[i] = new GTextField(newHalteWindow, 10, (60 + inputHalteGo[inputHalteGo.length-1].getY()) + (i*40), 300, 20);
    inputHalteBack[i].setOpaque(false);
    inputHalteBack[i].setPromptText("input nama halte " +(i+1) +" (jalur pulang)");
    inputHalteBack[i].setFont(GuiUbu11);

    labelHalteBack[i] = new GLabel(newHalteWindow, 10, inputHalteBack[i].getY() - 20, 200, 20);
    labelHalteBack[i].setOpaque(false);
    labelHalteBack[i].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    labelHalteBack[i].setFont(GuiUbu11);
    labelHalteBack[i].setText("input nama halte " +(i+1) +" (jalur pulang)");

    panelHalte.addControl(inputHalteBack[i]);
    panelHalte.addControl(labelHalteBack[i]);
    tabHalte.addControl(inputHalteBack[i]);

    lastPosition = int(inputHalteBack[i].getY());
  }

  GLabel labelKoridorTitle = new GLabel(newHalteWindow, newHalteWindow.width - 120, 10, 110, newHalteWindow.height - 60);
  labelKoridorTitle.setOpaque(false);
  labelKoridorTitle.setLocalColorScheme(int(random(0, 7)));
  labelKoridorTitle.setTextAlign(GAlign.CENTER, GAlign.TOP);
  labelKoridorTitle.setFont(GuiUbu14);
  labelKoridorTitle.setText("koridor " +myKoridor.get(slideNum-1).namaKoridor);

  GButton saveHalte = new GButton(newHalteWindow, newHalteWindow.width - 90, newHalteWindow.height - 40, 60, 25);
  saveHalte.setText("save");
  saveHalte.setOpaque(false);
  saveHalte.addEventHandler(this, "saveHalteHandler");
  saveHalte.setFont(GuiUbu11);

  //load pre-data to input
  if (myKoridor.get(slideNum-1).namaHalteGo.size() <= myKoridor.get(slideNum-1).totalHalteGo) {
    for (int i=0; i<myKoridor.get(slideNum-1).namaHalteGo.size(); i++)
      inputHalteGo[i].setText(myKoridor.get(slideNum-1).namaHalteGo.get(i));
  } else if (myKoridor.get(slideNum-1).namaHalteGo.size() > myKoridor.get(slideNum-1).totalHalteGo) {
    for (int i=0; i<myKoridor.get(slideNum-1).totalHalteGo; i++)
      inputHalteGo[i].setText(myKoridor.get(slideNum-1).namaHalteGo.get(i));
  }
  if (myKoridor.get(slideNum-1).namaHalteBack.size() <= myKoridor.get(slideNum-1).totalHalteBack) {
    for (int i=0; i<myKoridor.get(slideNum-1).namaHalteBack.size(); i++)
      inputHalteBack[i].setText(myKoridor.get(slideNum-1).namaHalteBack.get(i));
  } else if (myKoridor.get(slideNum-1).namaHalteBack.size() > myKoridor.get(slideNum-1).totalHalteBack) {
    for (int i=0; i<myKoridor.get(slideNum-1).totalHalteBack; i++)
      inputHalteBack[i].setText(myKoridor.get(slideNum-1).namaHalteBack.get(i));
  }

  //add handler to the last input
  //inputHalteBack[myKoridor.get(slideNum-1).totalHalteBack-1].addEventHandler(this, "halteEnterHandler");
  int currentPosition;
  if ((lastPosition) > 300)
    currentPosition = 300 - (lastPosition + 40);
  else
    currentPosition = 0;
  sdr1 = new GCustomSlider(newHalteWindow, 395, 0, 300, 50, "blue18px ");
  // show          opaque  ticks value limits
  sdr1.setShowDecor(false, false, false, false);
  sdr1.setEasing(15);
  sdr1.setLimits(0, 0, currentPosition);
  sdr1.setRotation(PI/2);
  newHalteWindow.loop();
}
GWindow newWriteToSDWindow;
GButton buttonLoadSetting, buttonWriteText, buttonWriteVoice;
public void createWriteToSDWindow() {
  newWriteToSDWindow = GWindow.getWindow(this, "write to sd", 150, 20, 500, 200, JAVA2D);
  newWriteToSDWindow.noLoop();
  newWriteToSDWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  newWriteToSDWindow.addDrawHandler(this, "newWriteToSDWindowHandler");
  //newWriteToSDWindow.addKeyHandler(this, "newHalteWindowKeyHandler");
  //newWriteToSDWindow.addMouseHandler(this, "newHalteWindowMouseHandler");

  buttonLoadSetting = new GButton(newWriteToSDWindow, 10, 30, 90, 30);
  buttonLoadSetting.setText("load setting");
  buttonLoadSetting.setOpaque(false);
  buttonLoadSetting.addEventHandler(this, "buttonLoadSettingHandler");
  //buttonLoadSetting.setFont(GuiUbu11);

  buttonWriteText = new GButton(newWriteToSDWindow, 10, buttonLoadSetting.getY() + 40, 90, 30);
  buttonWriteText.setText("write text");
  buttonWriteText.setOpaque(false);
  buttonWriteText.addEventHandler(this, "buttonWriteTextHandler");
  //buttonWriteText.setFont(GuiUbu11);

  buttonWriteVoice = new GButton(newWriteToSDWindow, 10, buttonWriteText.getY() + 40, 90, 30);
  buttonWriteVoice.setText("write voice");
  buttonWriteVoice.setOpaque(false);
  buttonWriteVoice.addEventHandler(this, "buttonWriteVoiceHandler");
  //buttonWriteVoice.setFont(GuiUbu11);

  newWriteToSDWindow.loop();
}
//load pre data new setting wizard
public void loadPreDataNewWizard() {
  inputA.setText(myKoridor.get(slideNum-1).namaKoridor);
  if (myKoridor.get(slideNum-1).choice)
    yesOptionFunction();
  else
    noOptionFunction();
}
public void loadPreDataNewWizard2() {
  if (textIndoor.size() > 0) {
    for (int i=0; i<textIndoor.size(); i++)
      inB[i].setText(textIndoor.get(i));
  }
  for (int i=textIndoor.size(); i<5; i++)
    inB[i].setText("");
}
public void loadPreDataNewWizard3() {
  if (textOutdoor.size() > 0) {
    for (int i=0; i<textOutdoor.size(); i++)
      inB[i].setText(textOutdoor.get(i));
  }
  for (int i=textOutdoor.size(); i<5; i++)
    inB[i].setText("");
}
//halte edit function
public void saveCurrentHalte() {
  if (myKoridor.get(slideNum-1).namaHalteGo.size() == myKoridor.get(slideNum-1).totalHalteGo) {
    //set data 
    for (int i=0; i<myKoridor.get(slideNum-1).totalHalteGo; i++)
      myKoridor.get(slideNum-1).namaHalteGo.set(i, inputHalteGo[i].getText());
  } else if (myKoridor.get(slideNum-1).namaHalteGo.size() < myKoridor.get(slideNum-1).totalHalteGo) {
    //remove data then add new data
    myKoridor.get(slideNum-1).namaHalteGo.clear();
    for (int i=0; i<myKoridor.get(slideNum-1).totalHalteGo; i++)
      myKoridor.get(slideNum-1).namaHalteGo.add(inputHalteGo[i].getText());
  } else if (myKoridor.get(slideNum-1).namaHalteGo.size() > myKoridor.get(slideNum-1).totalHalteGo) {
    //remove data then add new data
    myKoridor.get(slideNum-1).namaHalteGo.clear();
    for (int i=0; i<myKoridor.get(slideNum-1).totalHalteGo; i++)
      myKoridor.get(slideNum-1).namaHalteGo.add(inputHalteGo[i].getText());
  }

  printArray(myKoridor.get(slideNum-1).namaHalteGo);
  if (myKoridor.get(slideNum-1).namaHalteBack.size() == myKoridor.get(slideNum-1).totalHalteBack) {
    //set data 
    for (int i=0; i<myKoridor.get(slideNum-1).totalHalteBack; i++)
      myKoridor.get(slideNum-1).namaHalteBack.set(i, inputHalteBack[i].getText());
  } else if (myKoridor.get(slideNum-1).namaHalteBack.size() < myKoridor.get(slideNum-1).totalHalteBack) {
    //remove data then add new data
    myKoridor.get(slideNum-1).namaHalteBack.clear();
    for (int i=0; i<myKoridor.get(slideNum-1).totalHalteBack; i++)
      myKoridor.get(slideNum-1).namaHalteBack.add(inputHalteBack[i].getText());
  } else if (myKoridor.get(slideNum-1).namaHalteBack.size() > myKoridor.get(slideNum-1).totalHalteBack) {
    //remove data then add new data
    myKoridor.get(slideNum-1).namaHalteBack.clear();
    for (int i=0; i<myKoridor.get(slideNum-1).totalHalteBack; i++)
      myKoridor.get(slideNum-1).namaHalteBack.add(inputHalteBack[i].getText());
  }
  printArray(myKoridor.get(slideNum-1).namaHalteBack);
  newHalteWindow.close();
  newHalteWindow = null;
}

//button function
public void continueButtonFuntion() {
  korNum = int(inputA.getText());
  if (korNum != 0 || !inputA.getText().isEmpty()) {
    myKoridor = new ArrayList<koridor>();
    //new koridor[korNum];
    //println(myKoridor.length);
    preText = inPreTemp.getText();
    afterText = inAfterTemp.getText();
    newSetSlideNum = 1;
    slideNum += 1;
    myKoridor.add(new koridor());
    //myKoridor[slideNum-1] = new koridor();
    inputA.setPromptText("Nama Koridor " +slideNum);
    loadPreDataNewWizard();
    GUINewSetSlideNum1();
  }
}
public void nextButtonFuntion() {
  if (newSetSlideNum == 1) {
    if (slideNum >= korNum) {
      myKoridor.get(slideNum-1).namaKoridor = inputA.getText();
      newSetSlideNum = 2;
      GUINewSetSlideNum2();
      loadPreDataNewWizard2();
    } else {
      if (newSetSlideNum == 1) {
        //myKoridor[slideNum] = new koridor();
        if (myKoridor.size() < korNum)
          myKoridor.add(new koridor());
        //if(myKoridor.size() >= korNum)
        //myKoridor.set(korNum, new koridor());
        myKoridor.get(slideNum-1).namaKoridor = inputA.getText();
        println(myKoridor.get(slideNum-1).namaKoridor);
        if (in2.isVisible()) {
          myKoridor.get(slideNum-1).totalHalteGo = int(in1.getText());
          myKoridor.get(slideNum-1).totalHalteBack = int(in2.getText());
        } else {
          myKoridor.get(slideNum-1).totalHalteGo = int(in1.getText());
          myKoridor.get(slideNum-1).totalHalteBack = int(in1.getText());
        }
      }
      slideNum += 1;
      loadPreDataNewWizard();
    }
    in1.setText(""); 
    in2.setText("");
    inputA.setPromptText("Nama Koridor " +slideNum);
  } else if (newSetSlideNum == 2) {
    if (!inB[0].getText().isEmpty()) {
      //add new data
      if (textIndoor.size() > 0)
        textIndoor.set(0, inB[0].getText());
      else
        textIndoor.append(inB[0].getText());
      for (int i=1; i<5; i++) {
        if (!inB[i].getText().isEmpty()) {
          if (textIndoor.size() > i)
            textIndoor.set(i, inB[i].getText());
          else
            textIndoor.append(inB[i].getText());
        }
      }

      newSetSlideNum = 3;
      buttonNext.setText("finish");
      GUINewSetSlideNum3();
      loadPreDataNewWizard3();
    }
  } else if (newSetSlideNum == 3) {
    selectOutput("Select a file to write to:", "fileSelected");
    //if (!newSettingFilePath.isEmpty() && newSettingFilePath != null) {
    //  //save function
    //  if (!inB[0].getText().isEmpty()) {
    //    //add new data
    //    if (textOutdoor.size() > 0)
    //      textOutdoor.set(0, inB[0].getText());
    //    else
    //      textOutdoor.append(inB[0].getText());

    //    for (int i=1; i<5; i++) {
    //      if (!inB[i].getText().isEmpty()) {
    //        if (textOutdoor.size() > i)
    //          textOutdoor.set(i, inB[i].getText());
    //        else
    //          textOutdoor.append(inB[i].getText());
    //      }
    //    }
    //  }
    //  saveTextFunction();
    //  println(myKoridor.size());
    //  newSettingWindow.close(); 
    //  newSettingWindow = null;
    //  println("saved to " +newSettingFilePath);
    //} else {
    //  println("no path file");
    //}
  }
}
public void backButtonFunction() {
  if (newSetSlideNum == 1) {
    myKoridor.remove(slideNum-1);
    inputA.setText("");
    slideNum -= 1;
    if (slideNum < 1) {
      newSetSlideNum = 0;
      slideNum = 0;
      //myKoridor.remove(slideNum-1);
      GUINewSetSlideNum0();
      inputA.setPromptText("Input Jumlah Koridor");
    } else {
      inputA.setPromptText("Nama Koridor " +slideNum);
      loadPreDataNewWizard();
    }
  } else if (newSetSlideNum == 2) {
    newSetSlideNum = 1; 
    GUINewSetSlideNum1();
    loadPreDataNewWizard();
  } else if (newSetSlideNum == 3) {
    if (!inB[0].getText().isEmpty()) {
      //add new data
      if (textOutdoor.size() > 0)
        textOutdoor.set(0, inB[0].getText());
      else
        textOutdoor.append(inB[0].getText());

      for (int i=1; i<5; i++) {
        if (!inB[i].getText().isEmpty()) {
          if (textOutdoor.size() > i)
            textOutdoor.set(i, inB[i].getText());
          else
            textOutdoor.append(inB[i].getText());
        }
      }
    }

    newSetSlideNum = 2; 
    buttonNext.setText("next");
    loadPreDataNewWizard2();
  }
}
// option function
public void yesOptionFunction() {
  in1.setVisible(true);
  if (in2 != null)
    in2.setVisible(false);
  editHalte.setVisible(true);
  muncul = false;
}
public void noOptionFunction() {
  in1.setVisible(true);
  in2.setVisible(true);
  editHalte.setVisible(true);
  muncul = true;
}

public void loadSettingWizard() {
  selectInput("Select a file to process:", "loadSettingWizardLoaded");
}
GWindow loadSettingWizardWindow;
GTextField[] me;
GLabel[] labelMe;
GButton[] butMe, delMe;
GPanel groupLoadSettingWizard;
GCustomSlider sdr2;
int totalKor = 0;
void loadSettingWizardLoaded(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    loadSettingWizardPath = selection.getAbsolutePath();
    int korCount = 0; 
    int lastPosition = 0;
    boolean change = false;
    if (!loadSettingWizardPath.isEmpty()) {
      String lines[] = loadStrings(loadSettingWizardPath);
      println(lines.length);
      for (int i = 0; i < lines.length; i++) {
        String[] list = split(lines[i], ":");
        for (int j=0; j<list.length; j++) {
          list[j] = trim(list[j]);
          if (i == 0 && j == 1) {
            korNum = int(list[j]);
          } else if (i == 1 && j == 1) {
            String[] newlist = split(list[j], ",");
            //myKoridor = new koridor[newlist.length];
            for (int k=0; k<newlist.length; k++) {
              //myKoridor[k] = new koridor();
              if (myKoridor.size() < korNum)
                myKoridor.add(new koridor());
              myKoridor.get(k).namaKoridor = trim(newlist[k]);
            }
          } else if (i == lines.length-4 && j == 1) {
            String[] newlist = split(list[j], ",");
            for (int k=0; k<newlist.length; k++) {
              if (textIndoor.size() < newlist.length)
                textIndoor.append(trim(newlist[k]));
              else if (textIndoor.size() >= newlist.length)
                textIndoor.set(k, trim(newlist[k]));
            }
          } else if (i == lines.length-3 && j == 1) {
            String[] newlist = split(list[j], ",");
            for (int k=0; k<newlist.length; k++) {
              if (textOutdoor.size() < newlist.length)
                textOutdoor.append(trim(newlist[k]));
              else if (textOutdoor.size() >= newlist.length)
                textOutdoor.set(k, trim(newlist[k]));
            }
          } else if (i == lines.length-2 && j == 1) {
            preText = list[j];
          } else if (i == lines.length-1 && j == 1) {
            afterText = list[j];
          } else {
            if ( i % 2 == 0 && j == 1) {
              if (!change) {
                myKoridor.get(korCount).totalHalteGo = int(list[j]);
              } else if (change) {
                myKoridor.get(korCount).totalHalteBack = int(list[j]);
              }
            } else if ( i % 2 != 0 && j == 1) {
              if (!change) {
                String[] newlist = split(list[j], ",");
                for (int k=0; k<newlist.length; k++) {
                  if (myKoridor.get(korCount).namaHalteGo.size() < newlist.length)
                    myKoridor.get(korCount).namaHalteGo.add(trim(newlist[k]));
                  else if (myKoridor.get(korCount).namaHalteGo.size() >= newlist.length)
                    myKoridor.get(korCount).namaHalteGo.set(k, trim(newlist[k]));
                }
                //printArray(myKoridor[korCount].namaHalteGo);
                change = true;
              } else if (change) {
                String[] newlist = split(list[j], ",");
                for (int k=0; k<newlist.length; k++) {
                  if (myKoridor.get(korCount).namaHalteBack.size() < newlist.length)
                    myKoridor.get(korCount).namaHalteBack.add(trim(newlist[k]));
                  else if (myKoridor.get(korCount).namaHalteBack.size() >= newlist.length)
                    myKoridor.get(korCount).namaHalteBack.set(k, trim(newlist[k]));
                }
                //printArray(myKoridor[korCount].namaHalteBack);
                change = false;
                korCount ++;
              }
            }
          }
        }
        //printArray(list);
      }
    }
    if (korNum < 1) {
      JOptionPane.showMessageDialog(null, "no data loaded", "error", JOptionPane.WARNING_MESSAGE);
    } else {
      for (int i=0; i<myKoridor.size(); i++) {
        printArray(myKoridor.get(i).namaKoridor);
        println(myKoridor.get(i).totalHalteGo);
        printArray(myKoridor.get(i).namaHalteGo);
        println(myKoridor.get(i).totalHalteBack);
        printArray(myKoridor.get(i).namaHalteBack);
      }
      printArray(textIndoor); 
      printArray(textOutdoor);
      //create UI
      loadSettingWizardWindow = GWindow.getWindow(this, "List koridor", 150, 20, 500, 300, JAVA2D);
      loadSettingWizardWindow.noLoop();
      loadSettingWizardWindow.setActionOnClose(G4P.CLOSE_WINDOW);
      loadSettingWizardWindow.addDrawHandler(this, "loadSettingWizardHandler");
      loadSettingWizardWindow.addMouseHandler(this, "loadSettingWizardWindowMouseHandler");

      groupLoadSettingWizard = new GPanel(loadSettingWizardWindow, 0, 0, loadSettingWizardWindow.width, loadSettingWizardWindow.height, "here");
      groupLoadSettingWizard.setOpaque(false);

      me = new GTextField[korNum];
      labelMe = new GLabel[korNum];
      butMe = new GButton[korNum]; 
      delMe = new GButton[korNum];

      for (int i=0; i<me.length; i++) {
        labelMe[i] = new GLabel(loadSettingWizardWindow, 10, 10 +(i*50), 170, 20);
        labelMe[i].setOpaque(false);
        labelMe[i].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
        labelMe[i].setText("Koridor " +(i+1));

        me[i] = new GTextField(loadSettingWizardWindow, 10, 30 +(i*50), 170, 20);
        me[i].setOpaque(true);
        me[i].setText("koridor " +myKoridor.get(i).namaKoridor);
        me[i].setTextEditEnabled(false);

        butMe[i] = new GButton(loadSettingWizardWindow, me[i].getX() + me[i].getWidth() + 10, me[i].getY(), 60, 20);
        butMe[i].setOpaque(false);
        butMe[i].setText("edit");
        butMe[i].addEventHandler(this, "butMeButtonHandler");
        butMe[i].tagNo = i;

        delMe[i] = new GButton(loadSettingWizardWindow, butMe[i].getX() + butMe[i].getWidth() + 10, me[i].getY(), 60, 20);
        delMe[i].setOpaque(false);
        delMe[i].setText("delete");
        delMe[i].addEventHandler(this, "delMeButtonHandler");
        delMe[i].tagNo = i;

        groupLoadSettingWizard.addControls(me[i], butMe[i], delMe[i], labelMe[i]);
        lastPosition = int(me[i].getY());
      }     

      GButton buttonSaveLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-60, 100, 35);
      buttonSaveLoadSettingWizard.setOpaque(false);
      buttonSaveLoadSettingWizard.setText("save current configuration");
      buttonSaveLoadSettingWizard.addEventHandler(this, "buttonSaveLoadSettingWizardHandler");

      GButton buttonAddLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-110, 100, 35);
      buttonAddLoadSettingWizard.setOpaque(false);
      buttonAddLoadSettingWizard.setText("add new koridor");
      buttonAddLoadSettingWizard.addEventHandler(this, "buttonAddLoadSettingWizardHandler");

      GButton buttonOutdoorLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-160, 100, 35);
      buttonOutdoorLoadSettingWizard.setOpaque(false);
      buttonOutdoorLoadSettingWizard.setText("edit text outdoor");
      buttonOutdoorLoadSettingWizard.addEventHandler(this, "buttonOutdoorLoadSettingWizardHandler");

      GButton buttonIndoorLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-210, 100, 35);
      buttonIndoorLoadSettingWizard.setOpaque(false);
      buttonIndoorLoadSettingWizard.setText("edit text indoor");
      buttonIndoorLoadSettingWizard.addEventHandler(this, "buttonIndoorLoadSettingWizardHandler");

      GButton buttonPreTextLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-260, 100, 35);
      buttonPreTextLoadSettingWizard.setOpaque(false);
      buttonPreTextLoadSettingWizard.setText("edit pre text");
      buttonPreTextLoadSettingWizard.addEventHandler(this, "buttonPreTextLoadSettingWizardHandler");

      int currentPosition;
      if ((lastPosition) > 300)
        currentPosition = 300 - (lastPosition + 40);
      else
        currentPosition = 0;
      sdr2 = new GCustomSlider(loadSettingWizardWindow, 375, 0, 300, 50, "blue18px ");
      // show          opaque  ticks value limits
      sdr2.setShowDecor(false, false, false, false);
      sdr2.setEasing(15);
      sdr2.setLimits(0, 0, currentPosition);
      sdr2.setRotation(PI/2);

      loadSettingWizardWindow.loop();
    }
  }
}
void refreshLoadWizard() {
  loadSettingWizardWindow.noLoop();
  sdr2.dispose();
  me = new GTextField[korNum];
  labelMe = new GLabel[korNum];
  butMe = new GButton[korNum]; 
  delMe = new GButton[korNum];
  int lastPosition = 0;
  for (int i=0; i<korNum; i++) {
    labelMe[i] = new GLabel(loadSettingWizardWindow, 10, 10 +(i*50), 170, 20);
    labelMe[i].setOpaque(false);
    labelMe[i].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    labelMe[i].setText("Koridor " +(i+1));

    me[i] = new GTextField(loadSettingWizardWindow, 10, 30 +(i*50), 170, 20);
    me[i].setOpaque(true);
    me[i].setText("koridor " +myKoridor.get(i).namaKoridor);
    me[i].setTextEditEnabled(false);

    butMe[i] = new GButton(loadSettingWizardWindow, me[i].getX() + me[i].getWidth() + 10, me[i].getY(), 60, 20);
    butMe[i].setOpaque(false);
    butMe[i].setText("edit");
    butMe[i].addEventHandler(this, "butMeButtonHandler");
    butMe[i].tagNo = i;

    delMe[i] = new GButton(loadSettingWizardWindow, butMe[i].getX() + butMe[i].getWidth() + 10, me[i].getY(), 60, 20);
    delMe[i].setOpaque(false);
    delMe[i].setText("delete");
    delMe[i].addEventHandler(this, "delMeButtonHandler");
    delMe[i].tagNo = i;

    groupLoadSettingWizard.addControls(me[i], butMe[i], delMe[i], labelMe[i]);
    lastPosition = int(me[i].getY());
  }
  int currentPosition;
  if ((lastPosition) > 300)
    currentPosition = 300 - (lastPosition + 40);
  else
    currentPosition = 0;
  sdr2 = new GCustomSlider(loadSettingWizardWindow, 375, 0, 300, 50, "blue18px ");
  // show          opaque  ticks value limits
  sdr2.setShowDecor(false, false, false, false);
  sdr2.setEasing(15);
  sdr2.setLimits(0, 0, currentPosition);
  sdr2.setRotation(PI/2);
  loadSettingWizardWindow.loop();
}
GWindow editHalteAndKoridorWindow;
GPanel editHalteAndKoridorPanel;
GTextField[] myField;
GButton[] delMyField;
GLabel[] myLabelField;
int currentHal = 0;
GCustomSlider sdr3;
public void editHalteAndKoridor(int i) {
  currentHal = i;
  //create UI
  editHalteAndKoridorWindow = GWindow.getWindow(this, "Edit koridor " +myKoridor.get(i).namaKoridor, 500, 20, 500, 300, JAVA2D);
  editHalteAndKoridorWindow.noLoop();
  editHalteAndKoridorWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  editHalteAndKoridorWindow.addDrawHandler(this, "editHalteAndKoridorWindowHandler");
  editHalteAndKoridorWindow.addMouseHandler(this, "editHalteAndKoridorWindowMouseHandler");
  //create Panel
  editHalteAndKoridorPanel = new GPanel(editHalteAndKoridorWindow, 0, 0, editHalteAndKoridorWindow.width, editHalteAndKoridorWindow.height);
  editHalteAndKoridorPanel.setOpaque(false);
  //create editable textfield
  int totalHalteGo = myKoridor.get(i).totalHalteGo;
  int totalHalteBack = myKoridor.get(i).totalHalteBack;
  int total = totalHalteGo+totalHalteBack+1;
  myField = new GTextField[total];
  myLabelField = new GLabel[total];
  delMyField = new GButton[total];
  int space = 50; 
  int field = 250; 
  int lastPosition = 0;
  for (int j=0; j<total; j++) {
    if (j == 0) {
      myField[j] = new GTextField(editHalteAndKoridorWindow, 10, 30+(j*space), field, 20);
      myField[j].setOpaque(true);
      myField[j].setText(myKoridor.get(i).namaKoridor);

      myLabelField[j] = new GLabel(editHalteAndKoridorWindow, 10, 10+(j*space), field, 20);
      myLabelField[j].setOpaque(false);
      myLabelField[j].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
      myLabelField[j].setText("Koridor");
      editHalteAndKoridorPanel.addControls(myField[j], myLabelField[j]);
    } else if (j > 0 && j<=totalHalteGo) {
      int k = j - 1;
      myLabelField[j] = new GLabel(editHalteAndKoridorWindow, 10, 10+(j*space), field, 20);
      myLabelField[j].setOpaque(false);
      myLabelField[j].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
      myLabelField[j].setText("Halte "+(k+1) +" (jalur pergi) ");
      //myLabelField[j].setLocalColorScheme(G4P.RED_SCHEME);

      myField[j] = new GTextField(editHalteAndKoridorWindow, 10, 30+(j*space), field, 20);
      myField[j].setOpaque(true);
      myField[j].setText(myKoridor.get(i).namaHalteGo.get(k));

      delMyField[j] = new GButton(editHalteAndKoridorWindow, myField[j].getX()+myField[j].getWidth()+20, myField[j].getY(), 60, 20);
      delMyField[j].setOpaque(false);
      delMyField[j].setText("delete");
      delMyField[j].addEventHandler(this, "delMyFieldHandler");
      delMyField[j].tagNo = j;

      editHalteAndKoridorPanel.addControls(myField[j], myLabelField[j], delMyField[j]);
    } else if (j > totalHalteGo) {
      int k = j - (totalHalteGo+1);
      myField[j] = new GTextField(editHalteAndKoridorWindow, 10, 30+(j*space), field, 20);
      myField[j].setOpaque(true);
      myField[j].setText(myKoridor.get(i).namaHalteBack.get(k));

      myLabelField[j] = new GLabel(editHalteAndKoridorWindow, 10, 10+(j*space), field, 20);
      myLabelField[j].setOpaque(false);
      myLabelField[j].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
      myLabelField[j].setText("Halte "+(k+1) +" (jalur pulang) ");
      //myLabelField[j].setLocalColorScheme(G4P.BLUE_SCHEME);

      delMyField[j] = new GButton(editHalteAndKoridorWindow, myField[j].getX()+myField[j].getWidth()+20, myField[j].getY(), 60, 20);
      delMyField[j].setOpaque(false);
      delMyField[j].setText("delete");
      delMyField[j].addEventHandler(this, "delMyFieldHandler");
      delMyField[j].tagNo = j;
      editHalteAndKoridorPanel.addControls(myField[j], myLabelField[j], delMyField[j]);
      lastPosition = int(myField[j].getY());
    }
  }

  int currentPosition;
  if ((lastPosition) > 300)
    currentPosition = 300 - (lastPosition + 40);
  else
    currentPosition = 0;
  sdr3 = new GCustomSlider(editHalteAndKoridorWindow, 375, 0, 300, 50, "blue18px ");
  // show          opaque  ticks value limits
  sdr3.setShowDecor(false, false, false, false);
  sdr3.setEasing(15);
  sdr3.setLimits(0, 0, currentPosition);
  sdr3.setRotation(PI/2);

  GButton addMyButton = new GButton(editHalteAndKoridorWindow, editHalteAndKoridorWindow.width-120, 20, 100, 35);
  addMyButton.setOpaque(false);
  addMyButton.setText("add new halte");
  addMyButton.addEventHandler(this, "addMyButtonHandler");

  editHalteAndKoridorWindow.loop();
}
void resetEditHalteAndKoridor(GButton source) {
  int totalHalteGo = myKoridor.get(currentHal).totalHalteGo;
  int totalHalteBack = myKoridor.get(currentHal).totalHalteBack;
  int total = totalHalteGo+totalHalteBack+1;
  for (int j=0; j<total; j++) {
    if (j > 0 && j<=totalHalteGo) {
      int k = j - 1;
      myField[j].dispose();
      myLabelField[j].dispose();
      delMyField[j].dispose();
      if (source.tagNo == j) {
        myKoridor.get(currentHal).namaHalteGo.remove(k);
        myKoridor.get(currentHal).totalHalteGo --;
      }
    } else if (j > totalHalteGo) {
      int k = j - (totalHalteGo+1);
      myField[j].dispose();
      myLabelField[j].dispose();
      delMyField[j].dispose();
      if (source.tagNo == j) {
        myKoridor.get(currentHal).namaHalteBack.remove(k);
        myKoridor.get(currentHal).totalHalteBack --;
      }
    }
  } 
  refreshEditHalteAndKoridor();
}
void refreshEditHalteAndKoridor() {
  editHalteAndKoridorWindow.noLoop();
  int i = currentHal;
  int totalHalteGo = myKoridor.get(i).totalHalteGo;
  int totalHalteBack = myKoridor.get(i).totalHalteBack;
  int total = totalHalteGo+totalHalteBack+1;
  myField = new GTextField[total];
  myLabelField = new GLabel[total];
  delMyField = new GButton[total];
  int space = 50; 
  int field = 250; 
  int lastPosition = 0;
  println(total);
  for (int j=0; j<total; j++) {
    if (j > 0 && j<=totalHalteGo) {
      int k = j - 1;
      myLabelField[j] = new GLabel(editHalteAndKoridorWindow, 10, 10+(j*space), field, 20);
      myLabelField[j].setOpaque(false);
      myLabelField[j].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
      myLabelField[j].setText("halte "+(k+1) +" (jalur pergi) ");

      myField[j] = new GTextField(editHalteAndKoridorWindow, 10, 30+(j*space), field, 20);
      myField[j].setOpaque(true);
      myField[j].setText(myKoridor.get(i).namaHalteGo.get(k));

      delMyField[j] = new GButton(editHalteAndKoridorWindow, myField[j].getX()+myField[j].getWidth()+20, myField[j].getY(), 60, 20);
      delMyField[j].setOpaque(false);
      delMyField[j].setText("delete");
      delMyField[j].addEventHandler(this, "delMyFieldHandler");
      delMyField[j].tagNo = j;
      editHalteAndKoridorPanel. addControls(myField[j], myLabelField[j], delMyField[j]);
    } else if (j > totalHalteGo) {
      int k = j - (totalHalteGo+1);
      myField[j] = new GTextField(editHalteAndKoridorWindow, 10, 30+(j*space), field, 20);
      myField[j].setOpaque(true);
      myField[j].setText(myKoridor.get(i).namaHalteBack.get(k));

      myLabelField[j] = new GLabel(editHalteAndKoridorWindow, 10, 10+(j*space), field, 20);
      myLabelField[j].setOpaque(false);
      myLabelField[j].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
      myLabelField[j].setText("halte "+(k+1) +" (jalur pulang) ");

      delMyField[j] = new GButton(editHalteAndKoridorWindow, myField[j].getX()+myField[j].getWidth()+20, myField[j].getY(), 60, 20);
      delMyField[j].setOpaque(false);
      delMyField[j].setText("delete");
      delMyField[j].addEventHandler(this, "delMyFieldHandler");
      delMyField[j].tagNo = j;
      editHalteAndKoridorPanel.addControls(myField[j], myLabelField[j], delMyField[j]);
      lastPosition = int(myField[j].getY());
    }
  }
  sdr3.dispose();
  editHalteAndKoridorPanel.moveTo(0, 0);
  int currentPosition;
  if ((lastPosition) > 300)
    currentPosition = 300 - (lastPosition + 40);
  else
    currentPosition = 0;
  sdr3 = new GCustomSlider(editHalteAndKoridorWindow, 375, 0, 300, 50, "blue18px ");
  // show          opaque  ticks value limits
  sdr3.setShowDecor(false, false, false, false);
  sdr3.setEasing(15);
  sdr3.setLimits(0, 0, currentPosition);
  sdr3.setRotation(PI/2);
  editHalteAndKoridorWindow.loop();
}
public void saveTemporary() {
  int totalHalteGo = myKoridor.get(currentHal).totalHalteGo;
  int totalHalteBack = myKoridor.get(currentHal).totalHalteBack;
  int total = totalHalteGo+totalHalteBack+1;
  for (int j=0; j<total; j++) {
    if (j == 0) {
      myKoridor.get(currentHal).namaKoridor = myField[j].getText();
    } else if (j > 0 && j<=totalHalteGo) {
      int k = j - 1;
      myKoridor.get(currentHal).namaHalteGo.set(k, myField[j].getText());
    } else if (j > totalHalteGo) {
      int k = j - (totalHalteGo+1);
      myKoridor.get(currentHal).namaHalteBack.set(k, myField[j].getText());
    }
  }
  JOptionPane.showMessageDialog(null, "saved success ", "alert", JOptionPane.WARNING_MESSAGE);
  editHalteAndKoridorWindow.close();
  editHalteAndKoridorWindow = null;
}
GWindow addNewHalteWindow;
GDropList dropHalte; 
GTextField fieldIndexHalte, fieldNamaHalte;
public void createAddNewHalteWindow() {
  addNewHalteWindow = GWindow.getWindow(this, "Add new halte", 500, 350, 500, 130, JAVA2D);
  addNewHalteWindow.noLoop();
  addNewHalteWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  addNewHalteWindow.addDrawHandler(this, "addNewHalteWindowHandler");

  GLabel labelIndexHalte = new GLabel(addNewHalteWindow, 10, 20, 100, 20);
  labelIndexHalte.setOpaque(false);
  labelIndexHalte.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelIndexHalte.setText("Index halte");

  fieldIndexHalte = new GTextField(addNewHalteWindow, 10, labelIndexHalte.getY()+20, 200, 20);

  dropHalte = new GDropList(addNewHalteWindow, fieldIndexHalte.getX()+fieldIndexHalte.getWidth()+20, 10, 120, 60, 2);
  ArrayList<String> items = new ArrayList<String>();
  items.add("halte (jalur pergi)"); 
  items.add("halte (jalur pulang)");
  dropHalte.setItems(items, 0);
  dropHalte.setOpaque(false);

  GLabel labelNamaHalte = new GLabel(addNewHalteWindow, 10, fieldIndexHalte.getY()+30, 100, 20);
  labelNamaHalte.setOpaque(false);
  labelNamaHalte.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelNamaHalte.setText("Nama halte");

  fieldNamaHalte = new GTextField(addNewHalteWindow, 10, labelNamaHalte.getY()+20, 200, 20);

  GButton buttonCreateHalte = new GButton(addNewHalteWindow, addNewHalteWindow.width-120, addNewHalteWindow.height-60, 100, 35);
  buttonCreateHalte.setOpaque(false);
  buttonCreateHalte.setText("create");
  buttonCreateHalte.addEventHandler(this, "buttonCreateHalteHandler");

  addNewHalteWindow.loop();
}
GWindow addNewKoridorWindow;
GTextField fieldIndexKoridor, fieldNamaKoridor;
public void createAddNewKoridorWindow() {
  addNewKoridorWindow = GWindow.getWindow(this, "Add new koridor", 500, 100, 400, 130, JAVA2D);
  addNewKoridorWindow.noLoop();
  addNewKoridorWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  addNewKoridorWindow.addDrawHandler(this, "addNewKoridorWindowHandler");

  GLabel labelIndexKoridor = new GLabel(addNewKoridorWindow, 10, 10, 100, 20);
  labelIndexKoridor.setOpaque(false);
  labelIndexKoridor.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelIndexKoridor.setText("Index koridor");

  fieldIndexKoridor = new GTextField(addNewKoridorWindow, 10, labelIndexKoridor.getY()+20, 200, 20);

  GLabel labelNamaKoridor = new GLabel(addNewKoridorWindow, 10, fieldIndexKoridor.getY()+30, 100, 20);
  labelNamaKoridor.setOpaque(false);
  labelNamaKoridor.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelNamaKoridor.setText("Nama koridor");

  fieldNamaKoridor = new GTextField(addNewKoridorWindow, 10, labelNamaKoridor.getY()+20, 200, 20);

  GButton buttonCreateKoridor = new GButton(addNewKoridorWindow, addNewKoridorWindow.width-120, 70, 100, 35);
  buttonCreateKoridor.setOpaque(false);
  buttonCreateKoridor.setText("create");
  buttonCreateKoridor.addEventHandler(this, "buttonCreateKoridorHandler");

  addNewKoridorWindow.loop();
}
GWindow editTextIndoorWindow;
GTextField[] fieldEditTextIndoor;
public void createEditTextIndoorWindow() {
  editTextIndoorWindow = GWindow.getWindow(this, "Edit text indoor", 400, 140, 500, 280, JAVA2D);
  editTextIndoorWindow.noLoop();
  editTextIndoorWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  editTextIndoorWindow.addDrawHandler(this, "editTextIndoorWindowHandler");

  GLabel[] labelEditTextIndoor = new GLabel[5];
  fieldEditTextIndoor = new GTextField[5];

  for (int i=0; i<5; i++) {
    labelEditTextIndoor[i] =  new GLabel(editTextIndoorWindow, 10, 10+(i*50), 100, 20);
    labelEditTextIndoor[i].setOpaque(false);
    labelEditTextIndoor[i].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    labelEditTextIndoor[i].setText("Text indoor " +(i+1));
    fieldEditTextIndoor[i] = new GTextField(editTextIndoorWindow, 10, labelEditTextIndoor[i].getY()+20, 300, 20);
  }
  for (int i=0; i<textIndoor.size(); i++) {
    fieldEditTextIndoor[i].setText(textIndoor.get(i));
  }
  GButton buttonSaveTextIndoor = new GButton(editTextIndoorWindow, editTextIndoorWindow.width-120, editTextIndoorWindow.height-60, 100, 35);
  buttonSaveTextIndoor.setOpaque(false);
  buttonSaveTextIndoor.setText("save");
  buttonSaveTextIndoor.addEventHandler(this, "buttonSaveTextIndoorHandler");

  editTextIndoorWindow.loop();
}
GWindow editTextOutdoorWindow;
GTextField[] fieldEditTextOutdoor;
public void createEditTextOutdoorWindow() {
  editTextOutdoorWindow = GWindow.getWindow(this, "Edit text outdoor", 400, 140, 500, 280, JAVA2D);
  editTextOutdoorWindow.noLoop();
  editTextOutdoorWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  editTextOutdoorWindow.addDrawHandler(this, "editTextOutdoorWindowHandler");

  GLabel[] labelEditTextOutdoor = new GLabel[5];
  fieldEditTextOutdoor = new GTextField[5];

  for (int i=0; i<5; i++) {
    labelEditTextOutdoor[i] =  new GLabel(editTextOutdoorWindow, 10, 10+(i*50), 100, 20);
    labelEditTextOutdoor[i].setOpaque(false);
    labelEditTextOutdoor[i].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    labelEditTextOutdoor[i].setText("Text outdoor " +(i+1));
    fieldEditTextOutdoor[i] = new GTextField(editTextOutdoorWindow, 10, labelEditTextOutdoor[i].getY()+20, 300, 20);
  }
  for (int i=0; i<textOutdoor.size(); i++) {
    fieldEditTextOutdoor[i].setText(textOutdoor.get(i));
  }
  GButton buttonSaveTextOutdoor = new GButton(editTextOutdoorWindow, editTextOutdoorWindow.width-120, editTextOutdoorWindow.height-60, 100, 35);
  buttonSaveTextOutdoor.setOpaque(false);
  buttonSaveTextOutdoor.setText("save");
  buttonSaveTextOutdoor.addEventHandler(this, "buttonSaveTextOutdoorHandler");

  editTextOutdoorWindow.loop();
}
public void saveToFile(String u, String filename, String pathFileMp3) {
  try {
    URL url = new URL(u);
    try {
      URLConnection connection = url.openConnection();
      // pose as webbrowser
      connection.setRequestProperty("User-Agent", "Mozilla/4.0 (compatible; MSIE 6.0; Windows NT 5.1; .NET CLR 1.0.3705; .NET CLR 1.1.4322; .NET CLR 1.2.30703)");
      connection.connect();
      InputStream is = connection.getInputStream();
      // create a file named after the text
      File f;
      f = new File(pathFileMp3 +"/" +filename +".mp3");
      OutputStream out = new FileOutputStream(f);
      byte buf[] = new byte[1024];
      int len;
      while ((len = is.read(buf)) > 0) {
        out.write(buf, 0, len);
        //print(buf);
      }
      out.close();
      is.close();
    } 
    catch (IOException e) {
      e.printStackTrace();
    }
  } 
  catch (MalformedURLException e) {
    e.printStackTrace();
  }
}
GWindow please;
Gif loadingGif;
void pleaseWaitWindow() {
  please = GWindow.getWindow(this, "please wait", 400, 350, 300, 160, JAVA2D);
  please.noLoop();
  please.setActionOnClose(G4P.CLOSE_WINDOW);
  please.addDrawHandler(this, "pleaseWindowHandler");  
  loadingGif.loop();
  please.loop();
}
GWindow pretextWindow;
GTextField inPreField, inAfterField;
void editPreTextWindow() {
  pretextWindow = GWindow.getWindow(this, "Edit pre text", 400, 350, 600, 160, JAVA2D);
  pretextWindow.noLoop();
  pretextWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  pretextWindow.addDrawHandler(this, "pretextWindowHandler");  
  inPreField = new GTextField(pretextWindow, 10, 20, 500, 20);
  inPreField.setText(preText);
  inAfterField = new GTextField(pretextWindow, 10, 65, 500, 20);
  inAfterField.setText(afterText);
  GButton saveMe = new GButton(pretextWindow, pretextWindow.width/2 - 200/2, 120, 200, 20);
  saveMe.setOpaque(false);
  saveMe.setText("save");
  saveMe.addEventHandler(this, "saveMeHandler");
  pretextWindow.loop();
}
boolean numberOrNot(String input)
{
  try
  {
    Integer.parseInt(input);
  }
  catch(NumberFormatException ex)
  {
    return false;
  }
  return true;
}