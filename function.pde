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

void saveTextFunction() {
  String path = sketchPath()+"/data/listKoridor.txt";
  println(path);
  String text ="";
  for (int i=0; i<korNum; i++)
    text += myKoridor[i].namaKoridor +",";
  String[] meText = split(text, ",");
  saveStrings(path, meText);
  newSettingWindow.close();
}

GWindow newSettingWindow;
GLabel labelText, labela, labelb;
GButton buttonNext, buttonContinue, buttonBack, editHalte;
GTextField inputA, in1, in2;
GOption optYes, optNo;
GToggleGroup optGroup;
GTabManager tab;
public void newSettingWizard() {
  newSettingWindow = GWindow.getWindow(this, "New Setting Wizard", 20, 20, 500, 300, JAVA2D); 
  newSettingWindow.noLoop();
  newSettingWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  newSettingWindow.addDrawHandler(this, "win_drawNewSetting");
  //media
  buttonContinue = new GButton(newSettingWindow, newSettingWindow.width-70, newSettingWindow.height-40, 60, 25);
  buttonContinue.setOpaque(false);
  buttonContinue.setText("continue");
  buttonContinue.addEventHandler(this, "buttonContinueHandler");
  buttonContinue.setFont(GuiUbu11);
  inputA = new GTextField(newSettingWindow, 10, 65, 260, 20, G4P.SCROLLBARS_NONE);
  inputA.setOpaque(false);
  inputA.addEventHandler(this, "inputAHandler");
  inputA.setPromptText("input total koridor");
  inputA.setFont(GuiUbu11);
  buttonNext = new GButton(newSettingWindow, newSettingWindow.width-70, newSettingWindow.height-40, 50, 25);
  buttonNext.setOpaque(false);
  buttonNext.setText("next");
  buttonNext.addEventHandler(this, "buttonNextHandler");
  buttonNext.setFont(GuiUbu11);
  buttonBack = new GButton(newSettingWindow, buttonNext.getX()-buttonNext.getWidth(), newSettingWindow.height-40, 50, 25);
  buttonBack.setOpaque(false);
  buttonBack.setText("back");
  buttonBack.addEventHandler(this, "buttonBackHandler");
  buttonBack.setFont(GuiUbu11);
  optYes = new GOption(newSettingWindow, 310, 90, 60, 30);
  optYes.addEventHandler(this, "optYesHandler");
  optYes.setText("ya");
  optYes.setOpaque(false);
  optYes.setFont(GuiUbu11);
  optNo = new GOption(newSettingWindow, optYes.getX()+60, 90, 60, 30);
  optNo.addEventHandler(this, "optNoHandler");
  optNo.setText("tidak");
  optNo.setOpaque(false);
  optNo.setFont(GuiUbu11);
  optGroup = new GToggleGroup();
  optGroup.addControl(optYes);
  optGroup.addControl(optNo);
  in1 = new GTextField(newSettingWindow, 10, 120, 260, 20, G4P.SCROLLBARS_NONE);
  in1.setVisible(false);
  in1.setOpaque(false);
  in1.addEventHandler(this, "in1Handler");
  in1.setPromptText("jumlah halte (jalur pergi)");
  in1.setFont(GuiUbu11);
  in2 = new GTextField(newSettingWindow, 10, 150, 260, 20, G4P.SCROLLBARS_NONE);
  in2.setVisible(false);
  in2.setOpaque(false);
  in2.addEventHandler(this, "in2Handler");
  in2.setPromptText("jumlah halte (jalur pulang)");
  in2.setFont(GuiUbu11);
  tab = new GTabManager();
  tab.addControls(inputA, in1, in2);
  editHalte = new GButton(newSettingWindow, optYes.getX(), in2.getY(), 80, 20);
  editHalte.setText("edit halte");
  editHalte.setOpaque(false);
  editHalte.setVisible(false);
  editHalte.addEventHandler(this, "editHalteHandler");
  editHalte.setFont(GuiUbu11);
  newSettingWindow.loop();
}

GWindow newHalteWindow;
GPanel panelHalte;
GTextField[] inputHalteGo;
GTextField[] inputHalteBack;
void createListHalte() {
  myKoridor[slideNum-1].totalHalteGo = int(in1.getText());
  if (!in2.isVisible()) {
    myKoridor[slideNum-1].totalHalteBack = int(in1.getText());
  } else {
    myKoridor[slideNum-1].totalHalteBack = int(in2.getText());
  }
  println(myKoridor[slideNum-1].totalHalteBack);
  println(myKoridor[slideNum-1].totalHalteBack);

  newHalteWindow = GWindow.getWindow(this, "edit halte", 120, 20, 500, 300, JAVA2D);
  newHalteWindow.noLoop();
  newHalteWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  newHalteWindow.addDrawHandler(this, "newHalteWindowHandler");
  newHalteWindow.addKeyHandler(this, "newHalteWindowKeyHandler");
  newHalteWindow.addMouseHandler(this, "newHalteWindowMouseHandler");

  panelHalte = new GPanel(newHalteWindow, 0, 0, newHalteWindow.width - 20, newHalteWindow.height, "here");
  panelHalte.setOpaque(false);

  inputHalteGo = new GTextField[myKoridor[slideNum-1].totalHalteGo];
  inputHalteBack = new GTextField[myKoridor[slideNum-1].totalHalteBack];  
  GLabel[] labelHalteGo = new GLabel[myKoridor[slideNum-1].totalHalteGo];
  GLabel[] labelHalteBack = new GLabel[myKoridor[slideNum-1].totalHalteBack];

  GTabManager tabHalte = new GTabManager();

  for (int i=0; i<myKoridor[slideNum-1].totalHalteGo; i++) {
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
  for (int i=0; i<myKoridor[slideNum-1].totalHalteBack; i++) {
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
  labelKoridorTitle.setLocalColorScheme(int(random(0,7)));
  labelKoridorTitle.setTextAlign(GAlign.CENTER, GAlign.TOP);
  labelKoridorTitle.setFont(GuiUbu14);
  labelKoridorTitle.setText("koridor " +myKoridor[slideNum-1].namaKoridor);

  GButton saveHalte = new GButton(newHalteWindow, newHalteWindow.width - 90, newHalteWindow.height - 40, 60, 25);
  saveHalte.setText("save");
  saveHalte.setOpaque(false);
  saveHalte.addEventHandler(this, "saveHalteHandler");
  saveHalte.setFont(GuiUbu11);

  newHalteWindow.loop();
}

//button function
public void continueButtonFuntion() {
  korNum = int(inputA.getText());
  if (korNum != 0 || !inputA.getText().isEmpty()) {
    myKoridor = new koridor[korNum];
    println(myKoridor.length);
    newSetSlideNum = 1;
    slideNum += 1;
    myKoridor[slideNum-1] = new koridor();
    inputA.setPromptText("Nama Koridor " +slideNum);
  }
  inputA.setText("");
}
public void nextButtonFuntion() {
  if (newSetSlideNum == 1) {
    myKoridor[slideNum] = new koridor();
    myKoridor[slideNum-1].namaKoridor = inputA.getText();
    println(myKoridor[slideNum-1].namaKoridor);
  }
  if (slideNum >= korNum) {
    saveTextFunction();
    newSetSlideNum = 0;
    slideNum = 0;
  } else
    slideNum += 1;

  in1.setText(""); 
  in2.setText("");
  inputA.setPromptText("Nama Koridor " +slideNum);
  inputA.setText("");
}
public void backButtonFunction() {
  inputA.setText("");
  slideNum -= 1;
  if (slideNum < 1) {
    newSetSlideNum = 0;
    slideNum = 0;
    inputA.setPromptText("Input Jumlah Koridor");
  } else {
    inputA.setPromptText("Nama Koridor " +slideNum);
  }
}
// option function
public void yesOptionFunction() {
  in1.setVisible(true);
  if (in2 != null)
    in2.setVisible(false);
  editHalte.setVisible(true);
}
public void noOptionFunction() {
  in1.setVisible(true);
  in2.setVisible(true);
  editHalte.setVisible(true);
}