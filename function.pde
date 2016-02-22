GWindow voiceSettingWindow;
GTextField inputPitch, inputRate, inputVolume;
GButton buttonSaveConfig;
//function
public void voiceSetting() {
  voiceSettingWindow = GWindow.getWindow(this, "Voice Tuning", 50, 100, 500, 140, JAVA2D); 
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

  buttonSaveConfig = new GButton(voiceSettingWindow, voiceSettingWindow.width/2-75, inputVolume.getY()+40, 150, 30);
  buttonSaveConfig.setText("save configuration");
  buttonSaveConfig.setOpaque(false);
  buttonSaveConfig.addEventHandler(this, "buttonSaveVoiceConfiguration");
  buttonSaveConfig.setFont(GuiUbu11);

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
        data += myKoridor.get(i).namaHalteGo.get(j);
      }
      output.println(data);
      data = "list halte : ";
      output.println("total halte (jalur pulang) koridor "+i +" : " +myKoridor.get(i).totalHalteBack);
      for (int j=0; j<myKoridor.get(i).totalHalteBack; j++) {
        if (j>0)
          data += ",";
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
    data = "list text outoor : s";
    for (int i=0; i<textOutdoor.size(); i++) {
      if (i>0)
        data += ",";
      data += textOutdoor.get(i);
    }
    output.println(data);
    data = "";
  }

  output.flush(); // Writes the remaining data to the file
  output.close(); // Finishes the file
  //exit(); // Stops the program
  //return 1;
}

GWindow newSettingWindow;
GLabel labelText, labela, labelb;
GButton buttonNext, buttonContinue, buttonBack, editHalte, buttonBrowse;
GTextField inputA, in1, in2; 
GTextField[] inB;
GOption optYes, optNo;
GToggleGroup optGroup;
GTabManager tab;
public void newSettingWizard() {
  newSettingWindow = GWindow.getWindow(this, "New Setting Wizard", 20, 20, 500, 300, JAVA2D); 
  newSettingWindow.noLoop();
  newSettingWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  newSettingWindow.addDrawHandler(this, "win_drawNewSetting");
  //media
  buttonContinue = new GButton(newSettingWindow, newSettingWindow.width-70, newSettingWindow.height-30, 60, 25);
  buttonContinue.setOpaque(false);
  buttonContinue.setText("continue");
  buttonContinue.addEventHandler(this, "buttonContinueHandler");
  buttonContinue.setFont(GuiUbu11);
  inputA = new GTextField(newSettingWindow, 10, 65, 260, 20, G4P.SCROLLBARS_NONE);
  inputA.setOpaque(false);
  inputA.addEventHandler(this, "inputAHandler");
  inputA.setPromptText("input total koridor");
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
  myKoridor.get(slideNum-1).totalHalteGo = int(in1.getText());
  if (!in2.isVisible()) {
    myKoridor.get(slideNum-1).totalHalteBack = int(in1.getText());
  } else {
    myKoridor.get(slideNum-1).totalHalteBack = int(in2.getText());
  }
  println(myKoridor.get(slideNum-1).totalHalteBack);
  println(myKoridor.get(slideNum-1).totalHalteBack);

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

  for (int i=0; i<myKoridor.get(slideNum-1).totalHalteGo; i++) {
    inputHalteGo[i] = new GTextField(newHalteWindow, 10, 20 + (i*40), 360, 20);
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
    inputHalteBack[i] = new GTextField(newHalteWindow, 10, (60 + inputHalteGo[inputHalteGo.length-1].getY()) + (i*40), 360, 20);
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
  inputHalteBack[myKoridor.get(slideNum-1).totalHalteBack-1].addEventHandler(this, "halteEnterHandler");
  newHalteWindow.loop();
}
GWindow newWriteToSDWindow;
GButton buttonLoadSetting, buttonWriteText, buttonWriteVoice;
public void createWriteToSDWindow() {
  newWriteToSDWindow = GWindow.getWindow(this, "write to sd", 150, 20, 500, 300, JAVA2D);
  newWriteToSDWindow.noLoop();
  newWriteToSDWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  newWriteToSDWindow.addDrawHandler(this, "newWriteToSDWindowHandler");
  //newWriteToSDWindow.addKeyHandler(this, "newHalteWindowKeyHandler");
  //newWriteToSDWindow.addMouseHandler(this, "newHalteWindowMouseHandler");

  buttonLoadSetting = new GButton(newWriteToSDWindow, 10, 40, 90, 30);
  buttonLoadSetting.setText("load setting");
  buttonLoadSetting.setOpaque(false);
  buttonLoadSetting.addEventHandler(this, "buttonLoadSettingHandler");
  buttonLoadSetting.setFont(GuiUbu11);

  buttonWriteText = new GButton(newWriteToSDWindow, 10, buttonLoadSetting.getY() + 40, 90, 30);
  buttonWriteText.setText("write text");
  buttonWriteText.setOpaque(false);
  buttonWriteText.addEventHandler(this, "buttonWriteTextHandler");
  buttonWriteText.setFont(GuiUbu11);

  buttonWriteVoice = new GButton(newWriteToSDWindow, 10, buttonWriteText.getY() + 40, 90, 30);
  buttonWriteVoice.setText("write voice");
  buttonWriteVoice.setOpaque(false);
  buttonWriteVoice.addEventHandler(this, "buttonWriteVoiceHandler");
  buttonWriteVoice.setFont(GuiUbu11);

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
      myKoridor.get(slideNum-1).namaHalteGo.append(inputHalteGo[i].getText());
  } else if (myKoridor.get(slideNum-1).namaHalteGo.size() > myKoridor.get(slideNum-1).totalHalteGo) {
    //remove data then add new data
    myKoridor.get(slideNum-1).namaHalteGo.clear();
    for (int i=0; i<myKoridor.get(slideNum-1).totalHalteGo; i++)
      myKoridor.get(slideNum-1).namaHalteGo.append(inputHalteGo[i].getText());
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
      myKoridor.get(slideNum-1).namaHalteBack.append(inputHalteBack[i].getText());
  } else if (myKoridor.get(slideNum-1).namaHalteBack.size() > myKoridor.get(slideNum-1).totalHalteBack) {
    //remove data then add new data
    myKoridor.get(slideNum-1).namaHalteBack.clear();
    for (int i=0; i<myKoridor.get(slideNum-1).totalHalteBack; i++)
      myKoridor.get(slideNum-1).namaHalteBack.append(inputHalteBack[i].getText());
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
    if (!newSettingFilePath.isEmpty() && newSettingFilePath != null) {
      //save function
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
      saveTextFunction();
      println(myKoridor.size());
      newSettingWindow.close(); 
      newSettingWindow = null;
      println("saved to " +newSettingFilePath);
    } else {
      println("no path file");
    }
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
      myKoridor.remove(slideNum-1);
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
GButton[] butMe, delMe;
GPanel groupLoadSettingWizard;
int totalKor = 0;
void loadSettingWizardLoaded(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    loadSettingWizardPath = selection.getAbsolutePath();
    int korCount = 0; 
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
          } else if (i == lines.length-2 && j == 1) {
            String[] newlist = split(list[j], ",");
            for (int k=0; k<newlist.length; k++) {
              if (textIndoor.size() < newlist.length)
                textIndoor.append(trim(newlist[k]));
              else if (textIndoor.size() >= newlist.length)
                textIndoor.set(k, trim(newlist[k]));
            }
          } else if (i == lines.length-1 && j == 1) {
            String[] newlist = split(list[j], ",");
            for (int k=0; k<newlist.length; k++) {
              if (textOutdoor.size() < newlist.length)
                textOutdoor.append(trim(newlist[k]));
              else if (textOutdoor.size() >= newlist.length)
                textOutdoor.set(k, trim(newlist[k]));
            }
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
                    myKoridor.get(korCount).namaHalteGo.append(trim(newlist[k]));
                  else if (myKoridor.get(korCount).namaHalteGo.size() >= newlist.length)
                    myKoridor.get(korCount).namaHalteGo.set(k, trim(newlist[k]));
                }
                //printArray(myKoridor[korCount].namaHalteGo);
                change = true;
              } else if (change) {
                String[] newlist = split(list[j], ",");
                for (int k=0; k<newlist.length; k++) {
                  if (myKoridor.get(korCount).namaHalteBack.size() < newlist.length)
                    myKoridor.get(korCount).namaHalteBack.append(trim(newlist[k]));
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
      loadSettingWizardWindow = GWindow.getWindow(this, "list koridor", 150, 20, 500, 300, JAVA2D);
      loadSettingWizardWindow.noLoop();
      loadSettingWizardWindow.setActionOnClose(G4P.CLOSE_WINDOW);
      loadSettingWizardWindow.addDrawHandler(this, "loadSettingWizardHandler");
      loadSettingWizardWindow.addMouseHandler(this, "loadSettingWizardWindowMouseHandler");

      groupLoadSettingWizard = new GPanel(loadSettingWizardWindow, 0, 0, loadSettingWizardWindow.width, loadSettingWizardWindow.height, "here");
      groupLoadSettingWizard.setOpaque(false);

      me = new GTextField[korNum];
      butMe = new GButton[korNum]; 
      delMe = new GButton[korNum];

      for (int i=0; i<me.length; i++) {
        me[i] = new GTextField(loadSettingWizardWindow, 10, 20 +(i*30), 200, 20);
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

        groupLoadSettingWizard.addControls(me[i], butMe[i], delMe[i]);
      }     

      GButton buttonSaveLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-60, 100, 35);
      buttonSaveLoadSettingWizard.setOpaque(false);
      buttonSaveLoadSettingWizard.setText("save current configuration");
      buttonSaveLoadSettingWizard.addEventHandler(this, "buttonSaveLoadSettingWizardHandler");

      GButton buttonAddLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-110, 100, 35);
      buttonAddLoadSettingWizard.setOpaque(false);
      buttonAddLoadSettingWizard.setText("add new koridor");
      buttonAddLoadSettingWizard.addEventHandler(this, "buttonAddLoadSettingWizardHandler");
      loadSettingWizardWindow.loop();
    }
  }
}
void refreshLoadWizard() {
  me = new GTextField[korNum];
  butMe = new GButton[korNum]; 
  delMe = new GButton[korNum];
  for (int i=0; i<me.length; i++) {
    me[i] = new GTextField(loadSettingWizardWindow, 10, 20 +(i*30), 200, 20);
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

    groupLoadSettingWizard.addControls(me[i], butMe[i], delMe[i]);
  }
}
GWindow editHalteAndKoridorWindow;
GPanel editHalteAndKoridorPanel;
GTextField[] myField;
GButton[] delMyField;
GLabel[] myLabelField;
int currentHal = 0;
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
  for (int j=0; j<total; j++) {
    if (j == 0) {
      myField[j] = new GTextField(editHalteAndKoridorWindow, 10, 30+(j*space), field, 20);
      myField[j].setOpaque(true);
      myField[j].setText(myKoridor.get(i).namaKoridor);

      myLabelField[j] = new GLabel(editHalteAndKoridorWindow, 10, 10+(j*space), field, 20);
      myLabelField[j].setOpaque(false);
      myLabelField[j].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
      myLabelField[j].setText("koridor");
      editHalteAndKoridorPanel.addControls(myField[j], myLabelField[j]);
    } else if (j > 0 && j<=totalHalteGo) {
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

      editHalteAndKoridorPanel.addControls(myField[j], myLabelField[j], delMyField[j]);
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
    }
  }
  GButton myButton = new GButton(editHalteAndKoridorWindow, editHalteAndKoridorWindow.width-100, editHalteAndKoridorWindow.height-60, 60, 25);
  myButton.setOpaque(false);
  myButton.setText("save");
  myButton.addEventHandler(this, "myButtonHandler");
  editHalteAndKoridorWindow.loop();
}
void refreshEditHalteAndKoridor() {
  int i = currentHal;
  int totalHalteGo = myKoridor.get(i).totalHalteGo;
  int totalHalteBack = myKoridor.get(i).totalHalteBack;
  int total = totalHalteGo+totalHalteBack+1;
  myField = new GTextField[total];
  myLabelField = new GLabel[total];
  delMyField = new GButton[total];
  int space = 50; 
  int field = 250;
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

      editHalteAndKoridorPanel.addControls(myField[j], myLabelField[j], delMyField[j]);
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
    }
  }
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