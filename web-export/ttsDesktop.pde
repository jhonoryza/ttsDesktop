// Need G4P library
import g4p_controls.*;
import java.awt.Font;
import javax.swing.JOptionPane;
import java.net.*;
import java.io.*;
import gifAnimation.*;

//public variable
String voicePitch, voiceRate, voiceVolume, newSettingFilePath, loadSettingPath, loadSettingWizardPath;
StringList textIndoor, textOutdoor;
GGroup mainGroup;
Gif loopingGif;
public void setup() {
  newSettingFilePath = sketchPath() +"/data/my.cfg";
  loadSettingPath = ""; 
  loadSettingWizardPath = "";
  textIndoor = new StringList();
  textOutdoor = new StringList();
  loadCurrentFont();
  size(350, 190, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  println(sketchPath());
  loadVoiceSetting();
  frameRate(20);
  loopingGif = new Gif(this, "data/a.gif");
  loopingGif.loop();
}
public void draw() {
  background(240);
  noStroke();
  image(loopingGif, width/2 - loopingGif.width/2, height / 2 - loopingGif.height / 2);
  //border bawah
  fill(255, 200);
  rect(0, height-20, width, 20);
  rect(0, 0, width, 20);

  //text
  fill(0);
  textFont(ubu12);
  text("Config Apps", width/2-35, 15);
  textSize(10);
  text("copyright \u00a9 2016 GTI", width/1.5, height-5);

  if ((loadSettingWizardWindow != null && loadSettingWizardWindow.isVisible()) || (voiceSettingWindow != null && voiceSettingWindow.isVisible()) 
    || (newSettingWindow != null && newSettingWindow.isVisible()) || (newWriteToSDWindow != null && newWriteToSDWindow.isVisible()) )
    mainGroup.setEnabled(false);
  else
    mainGroup.setEnabled(true);
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
  //buttonNew.setFont(GuiUbu11);
  //buttonLoad.setFont(GuiUbu11);
  //buttonVoice.setFont(GuiUbu11);
  //buttonSD.setFont(GuiUbu11);
  //buttonExit.setFont(GuiUbu11);
  GButton.useRoundCorners(false);
  mainGroup = new GGroup(this);
  mainGroup.addControls(buttonNew, buttonLoad, buttonVoice, buttonSD, buttonExit);
}

//handler window
int korNum = 0, slideNum = 0, newSetSlideNum = 0;
//koridor[] myKoridor;
ArrayList<koridor> myKoridor = new ArrayList<koridor>();
synchronized public void win_drawNewSetting(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(0, 0, appc.width, appc.height/7);
  appc.rect(0, appc.height-appc.height/7, appc.width, appc.height/7);

  //text
  appc.fill(0);
  appc.textFont(ubu14);
  appc.text("Welcome to the new setting wizard", 20, 30);
  appc.textSize(11);

  if (newSetSlideNum == 0) {
    appc.text("Input total koridor :", 10, 60);
  } else if (newSetSlideNum == 1) {
    appc.text("Input nama koridor " +slideNum, 10, 60);
    appc.text("Total halte (jalur pergi) == Total halte (jalur pulang) ?", 10, 110);
    if (muncul) {
      appc.text("input total halte (jalur pergi)", 10, 130);
      appc.text("input total halte (jalur pulang)", 10, 180);
    } else
      appc.text("input total halte (jalur pergi) dan (jalur pulang)", 10, 130);
  } else if (newSetSlideNum == 2) {
    appc.text("Input text indoor ", 10, 60);
  } else if (newSetSlideNum == 3) {
    appc.text("Input text outdoor ", 10, 60);
    if (browsed)
      appc.text("save path: " +newSettingFilePath, 10, newSettingWindow.height-50);
    else if (!browsed)
      appc.text("save path: " +newSettingFilePath, 10, newSettingWindow.height-50);
  }
}

synchronized public void newHalteWindowHandler(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(appc.width - 120, 0, appc.width - (appc.width - 120), appc.height);
}

synchronized public void newWriteToSDWindowHandler(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(0, appc.height-20, appc.width, appc.height/6);

  //text
  appc.fill(0);
  textFont(ubu11);
  appc.text("load setting : " +loadSettingPath, 10, 20);
}

synchronized public void win_drawVoiceSetting(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(0, appc.height-20, appc.width, appc.height/6);

  //text
  appc.fill(0);
  textFont(ubu11);
  appc.text("Pitch (0 - 1) :", inputPitch.getX()-80, inputPitch.getY()+15);
  appc.text("Pitch (0 - 1) :", inputRate.getX()-80, inputPitch.getY()+15);
  appc.text("Pitch (0 - 1) :", inputVolume.getX()-80, inputPitch.getY()+15);
  appc.textSize(10);
  appc.text(sketchPath() +"/data/voice.cfg", 0, appc.height-7);
}
synchronized public void loadSettingWizardHandler(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(appc.width-140, 0, 160, appc.height);

  //text
  //appc.fill(0);
  //textFont(ubu11);
  //appc.text(" save current \nconfiguration", appc.width-110, appc.height-90);
  //appc.text(" add new \n  koridor", appc.width-100, appc.height-270);
  //appc.text("     save as", appc.width-110, appc.height-160);
}
synchronized public void editHalteAndKoridorWindowHandler(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(appc.width-140, 0, 160, appc.height);
}
synchronized public void addNewHalteWindowHandler(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(appc.width-140, 0, 160, appc.height);
}
synchronized public void addNewKoridorWindowHandler(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(appc.width-140, 0, 160, appc.height);
}
synchronized public void editTextIndoorWindowHandler(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(appc.width-140, 0, 160, appc.height);
}
synchronized public void editTextOutdoorWindowHandler(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(appc.width-140, 0, 160, appc.height);
}
synchronized public void pleaseWindowHandler(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();
  appc.fill(0);
  textFont(ubu11);
  appc.text("please wait", appc.width/2 - 30, 20);
  appc.image(loadingGif, appc.width/2 - loadingGif.width/2, appc.height / 2 - loadingGif.height / 2);
}
public void GUINewSetSlideNum0() {
  if (buttonNext != null && buttonBack != null && buttonContinue != null && optYes != null && optNo != null && in1 != null && in2 != null && editHalte != null) {
    buttonNext.setVisible(false);
    buttonBack.setVisible(false);
    buttonContinue.setVisible(true);
    optYes.setVisible(false);
    optNo.setVisible(false);
    in1.setVisible(false);
    in2.setVisible(false);
    editHalte.setVisible(false);
    for (int i=0; i<5; i++)
      inB[i].setVisible(false);
    buttonBrowse.setVisible(false);
  }
}
boolean muncul = false;
public void GUINewSetSlideNum1() {
  if (buttonNext != null && buttonBack != null && buttonContinue != null && optYes != null && optNo != null && in1 != null && in2 != null && editHalte != null) {
    buttonNext.setVisible(true);
    buttonBack.setVisible(true);
    buttonContinue.setVisible(false);
    optYes.setVisible(true);
    optNo.setVisible(true);
    if (in2.isVisible())
      muncul = true;
    else if (!in2.isVisible())
      muncul = false;
    for (int i=0; i<5; i++)
      inB[i].setVisible(false);
    buttonBrowse.setVisible(false);
  }
}
public void GUINewSetSlideNum2() {
  if (buttonNext != null && buttonBack != null && buttonContinue != null && optYes != null && optNo != null && in1 != null && in2 != null && editHalte != null) {
    buttonNext.setVisible(true);
    buttonBack.setVisible(true);
    buttonContinue.setVisible(false);
    optYes.setVisible(false);
    optNo.setVisible(false);
    in1.setVisible(false);
    editHalte.setVisible(false);
    for (int i=0; i<5; i++) {
      inB[i].setVisible(true);
      if (i==0)
        inB[i].setPromptText("input text indoor " +i);
      if (i>0)
        inB[i].setPromptText("input text indoor "+i +" (optional)");
    }
    buttonBrowse.setVisible(false);
  }
}
public void GUINewSetSlideNum3() {
  if (buttonNext != null && buttonBack != null && buttonContinue != null && optYes != null && optNo != null && in1 != null && in2 != null && editHalte != null) {
    buttonNext.setVisible(true);
    buttonBack.setVisible(true);
    buttonContinue.setVisible(false);
    optYes.setVisible(false);
    optNo.setVisible(false);
    in1.setVisible(false);
    editHalte.setVisible(false);
    for (int i=0; i<5; i++) {
      inB[i].setVisible(true);
      if (i==0)
        inB[i].setPromptText("input text outdoor " +i);
      if (i>0)
        inB[i].setPromptText("input text outdoor "+i +" (optional)");
    }
    buttonBrowse.setVisible(true);
  }
}
PFont linuxFont12, linuxFont11, linuxFont14;
PFont s11, s12, s14;
PFont ubu11, ubu12, ubu14;
Font source11, source12, source14;
Font GuiUbu11, GuiUbu12, GuiUbu14;
public void loadCurrentFont() {
  linuxFont12 = createFont(sketchPath() +"/data/UbuntuMono.ttf", 12);
  linuxFont11 = createFont(sketchPath() +"/data/UbuntuMono.ttf", 11);
  linuxFont14 = createFont(sketchPath() +"/data/UbuntuMono.ttf", 14);
  s12 = createFont(sketchPath() +"/data/SourceCodePro.ttf", 12);
  s11 = createFont(sketchPath() +"/data/SourceCodePro.ttf", 11);
  s14 = createFont(sketchPath() +"/data/SourceCodePro.ttf", 14);
  ubu12 = createFont(sketchPath() +"/data/Ubuntu.ttf", 12);
  ubu11 = createFont(sketchPath() +"/data/Ubuntu.ttf", 11);
  ubu14 = createFont(sketchPath() +"/data/Ubuntu.ttf", 14);

  source11 = new Font("SourceCodePro", Font.PLAIN, 11);
  source12 = new Font("SourceCodePro", Font.PLAIN, 12);
  source14 = new Font("SourceCodePro", Font.PLAIN, 14);

  try {
    GuiUbu11 = Font.createFont(Font.TRUETYPE_FONT, new File(sketchPath() +"/data/Ubuntu.ttf")).deriveFont(11f);
    GuiUbu12 = Font.createFont(Font.TRUETYPE_FONT, new File(sketchPath() +"/data/Ubuntu.ttf")).deriveFont(12f);
    GuiUbu14 = Font.createFont(Font.TRUETYPE_FONT, new File(sketchPath() +"/data/Ubuntu.ttf")).deriveFont(14f);
  }
  catch(Exception e)
  {
    e.printStackTrace();
  }
}
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
GLabel[] labelMe;
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
        labelMe[i] = new GLabel(loadSettingWizardWindow, 10, 10 +(i*50), 200, 20);
        labelMe[i].setOpaque(false);
        labelMe[i].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
        labelMe[i].setText("Koridor " +(i+1));

        me[i] = new GTextField(loadSettingWizardWindow, 10, 30 +(i*50), 200, 20);
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
      }     

      GButton buttonSaveLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-60, 100, 35);
      buttonSaveLoadSettingWizard.setOpaque(false);
      buttonSaveLoadSettingWizard.setText("save current configuration");
      buttonSaveLoadSettingWizard.addEventHandler(this, "buttonSaveLoadSettingWizardHandler");

      GButton buttonAddLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-110, 100, 35);
      buttonAddLoadSettingWizard.setOpaque(false);
      buttonAddLoadSettingWizard.setText("add new koridor");
      buttonAddLoadSettingWizard.addEventHandler(this, "buttonAddLoadSettingWizardHandler");

      GButton buttonIndoorLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-160, 100, 35);
      buttonIndoorLoadSettingWizard.setOpaque(false);
      buttonIndoorLoadSettingWizard.setText("edit text outdoor");
      buttonIndoorLoadSettingWizard.addEventHandler(this, "buttonOutdoorLoadSettingWizardHandler");

      GButton buttonOutdoorLoadSettingWizard = new GButton(loadSettingWizardWindow, loadSettingWizardWindow.width-120, loadSettingWizardWindow.height-210, 100, 35);
      buttonOutdoorLoadSettingWizard.setOpaque(false);
      buttonOutdoorLoadSettingWizard.setText("edit text indoor");
      buttonOutdoorLoadSettingWizard.addEventHandler(this, "buttonIndoorLoadSettingWizardHandler");

      loadSettingWizardWindow.loop();
    }
  }
}
void refreshLoadWizard() {
  loadSettingWizardWindow.noLoop();
  me = new GTextField[korNum];
  labelMe = new GLabel[korNum];
  butMe = new GButton[korNum]; 
  delMe = new GButton[korNum];
  for (int i=0; i<korNum; i++) {
    labelMe[i] = new GLabel(loadSettingWizardWindow, 10, 10 +(i*50), 200, 20);
    labelMe[i].setOpaque(false);
    labelMe[i].setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
    labelMe[i].setText("Koridor " +(i+1));

    me[i] = new GTextField(loadSettingWizardWindow, 10, 30 +(i*50), 200, 20);
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
  }
  loadSettingWizardWindow.loop();
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
    }
  }
  //GButton myButton = new GButton(editHalteAndKoridorWindow, editHalteAndKoridorWindow.width-120, editHalteAndKoridorWindow.height-60, 100, 35);
  //myButton.setOpaque(false);
  //myButton.setText("save");
  //myButton.addEventHandler(this, "myButtonHandler");

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
    }
  }
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
void pleaseWaitWindow(){
  please = GWindow.getWindow(this, "Warn", 400, 350, 350, 250, JAVA2D);
  please.noLoop();
  please.setActionOnClose(G4P.CLOSE_WINDOW);
  please.addDrawHandler(this, "pleaseWindowHandler");  
  loadingGif = new Gif(this, "data/b.gif");
  loadingGif.loop();
  please.loop();
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
/* =========================================================
 * ====                   WARNING                        ===
 * =========================================================
 * The code in this tab has been generated from the GUI form
 * designer and care should be taken when editing this file.
 * Only add/edit code inside the event handlers i.e. only
 * use lines between the matching comment tags. e.g.

 void myBtnEvents(GButton button) { //_CODE_:button1:12356:
     // It is safe to enter your event code here  
 } //_CODE_:button1:12356:
 
 * Do not rename this tab!
 * =========================================================
 */

public void buttonNew_click(GButton source, GEvent event) { //_CODE_:buttonNew:677724:
  println("buttonNew clicked");
  newSettingWizard();
} //_CODE_:buttonNew:677724:

public void buttonLoad_click(GButton source, GEvent event) { //_CODE_:buttonLoad:917085:
  println("buttonLoad clicked");
   loadSettingWizard();
} //_CODE_:buttonLoad:917085:

public void buttonVoice_click(GButton source, GEvent event) { //_CODE_:buttonVoice:220763:
  println("buttonVoice clicked");
  voiceSetting();
} //_CODE_:buttonVoice:220763:

public void buttonSD_click(GButton source, GEvent event) { //_CODE_:buttonSD:263848:
  println("buttonSD clicked");
  createWriteToSDWindow();
} //_CODE_:buttonSD:263848:

public void buttonExit_click(GButton source, GEvent event) { //_CODE_:buttonExit:988049:
  println("buttonExit clicked");
  buttonExit();
} //_CODE_:buttonExit:988049:



// Create all the GUI controls. 
// autogenerated do not edit
public void createGUI(){
  G4P.messagesEnabled(false);
  G4P.setGlobalColorScheme(8);
  G4P.setCursor(ARROW);
  surface.setTitle("Configurator"); 
  buttonNew = new GButton(this, 20, 30, 100, 30);
  buttonNew.setText("New Setting");
  buttonNew.addEventHandler(this, "buttonNew_click");
  buttonLoad = new GButton(this, 20, 80, 100, 30);
  buttonLoad.setText("Load Setting");
  buttonLoad.addEventHandler(this, "buttonLoad_click");
  buttonVoice = new GButton(this, 230, 30, 100, 30);
  buttonVoice.setText("Voice Tuning");
  buttonVoice.addEventHandler(this, "buttonVoice_click");
  buttonSD = new GButton(this, 230, 80, 100, 30);
  buttonSD.setText("Write To Sd Card");
  buttonSD.addEventHandler(this, "buttonSD_click");
  buttonExit = new GButton(this, 20, 130, 100, 30);
  buttonExit.setText("Exit");
  buttonExit.addEventHandler(this, "buttonExit_click");
}

// Variable declarations 
// autogenerated do not edit
GButton buttonNew; 
GButton buttonLoad; 
GButton buttonVoice; 
GButton buttonSD; 
GButton buttonExit; 
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
  selectInput("Select a load setting file", "loadSettingLoaded");
}
void loadSettingLoaded(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    loadSettingPath = selection.getAbsolutePath();
    String lines[] = loadStrings(loadSettingPath);
    println(lines.length);
    boolean change = false; 
    int korCount = 0; 
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
}
public void buttonWriteTextHandler(GButton source, GEvent event) {
  selectFolder("select sd card", "writeToSDCard");
}
void writeToSDCard(File selection) {
  boolean change = false;
  int fcount=0, ncount=0;

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
  } else {
    if (!loadSettingPath.isEmpty()) {
      String lines[] = loadStrings(loadSettingPath);
      println(lines.length);
      for (int i = 0; i < lines.length; i++) {
        println(lines[i]);
        String[] list = split(lines[i], ":");
        printArray(list);

        for (int j=0; j<list.length; j++) {
          list[j] = trim(list[j]);
          if (i == 0 && j == 1) {
            korNum = int(list[j]);
          } else if (i == 1 && j == 1) {
            String[] newlist = split(list[j], ",");
            //list koridor
            saveStrings(selection +"/listkoridor.txt", newlist);
          } else if (i == lines.length-2 && j == 1) {
            String[] newlist = split(list[j], ",");
            //textindoor
            saveStrings(selection +"/textindoor.txt", newlist);
          } else if (i == lines.length-1 && j == 1) {
            String[] newlist = split(list[j], ",");
            //textoutdoor
            saveStrings(selection +"/textoutdoor.txt", newlist);
          } else {
            if ( i % 2 == 0 && j == 1) {
              //total halte
            } else if ( i % 2 != 0 && j == 1) {
              if (!change) {
                String[] newlist = split(list[j], ",");
                saveStrings(selection +"/go" +fcount +".txt", newlist);
                change = true;
                fcount++;
              } else if (change) {
                String[] newlist = split(list[j], ",");
                saveStrings(selection +"/back" +ncount +".txt", newlist);
                change = false;
                ncount++;
              }
            }
          }
        }
      }
      JOptionPane.showMessageDialog(null, "Save success", "Message", JOptionPane.WARNING_MESSAGE);
    } else {
      JOptionPane.showMessageDialog(null, "Load setting file first", "Error", JOptionPane.WARNING_MESSAGE);
    }
  }
  newWriteToSDWindow.close();
  newWriteToSDWindow = null;
}
public void buttonWriteVoiceHandler(GButton source, GEvent event) {
  selectFolder("select sd card", "writeVoiceToSDCard");
}
void writeVoiceToSDCard(File selection) {
  //String textVoice = "";
  //String pitch = voicePitch;
  //String rate = voiceRate;
  //String vol = voiceVolume;
  //String u= "http://code.responsivevoice.org/getvoice.php?t=" 
  //  +textVoice +"&tl=id&sv=&vn=&pitch=" +pitch +"&rate=" +rate +"&vol=" +vol;

  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    JOptionPane.showMessageDialog(null, "no selection", "Error", JOptionPane.WARNING_MESSAGE);
  } else {
    if (!loadSettingPath.isEmpty()) {
      pleaseWaitWindow();
      createMp3(selection);
      please.close(); 
      please = null;
    } else {
      JOptionPane.showMessageDialog(null, "Load setting file first", "Error", JOptionPane.WARNING_MESSAGE);
    }
  }
}
void createMp3(File selection) {
  String textVoice = "";
  String pitch = voicePitch;
  String rate = voiceRate;
  String vol = voiceVolume;
  for (int i=0; i<korNum; i++) {
    String text = myKoridor.get(i).namaKoridor;
    textVoice = text.replace(" ", "%20");
    String u= "http://code.responsivevoice.org/getvoice.php?t=" 
      +textVoice +"&tl=id&sv=&vn=&pitch=" +pitch +"&rate=" +rate +"&vol=" +vol;
    saveToFile(u, text, selection.toString());

    for (int j=0; j<myKoridor.get(i).namaHalteGo.size(); j++) {
      text = myKoridor.get(i).namaHalteGo.get(j);
      textVoice = text.replace(" ", "%20");
      u= "http://code.responsivevoice.org/getvoice.php?t=" 
        +textVoice +"&tl=id&sv=&vn=&pitch=" +pitch +"&rate=" +rate +"&vol=" +vol;
      saveToFile(u, text, selection.toString());
    }
    for (int j=0; j<myKoridor.get(i).namaHalteBack.size(); j++) {
      text = myKoridor.get(i).namaHalteBack.get(j);
      textVoice = text.replace(" ", "%20");
      u= "http://code.responsivevoice.org/getvoice.php?t=" 
        +textVoice +"&tl=id&sv=&vn=&pitch=" +pitch +"&rate=" +rate +"&vol=" +vol;
      saveToFile(u, text, selection.toString());
    }
  }
  for (int i=0; i<textIndoor.size(); i++) {
    String text = textIndoor.get(i);
    textVoice = text.replace(" ", "%20");
    String u= "http://code.responsivevoice.org/getvoice.php?t=" 
      +textVoice +"&tl=id&sv=&vn=&pitch=" +pitch +"&rate=" +rate +"&vol=" +vol;
    saveToFile(u, text, selection.toString());
  }
  for (int i=0; i<textOutdoor.size(); i++) {
    String text = textOutdoor.get(i);
    textVoice = text.replace(" ", "%20");
    String u= "http://code.responsivevoice.org/getvoice.php?t=" 
      +textVoice +"&tl=id&sv=&vn=&pitch=" +pitch +"&rate=" +rate +"&vol=" +vol;
    saveToFile(u, text, selection.toString());
  }
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
    butMe[i].dispose();
    me[i].dispose();
    labelMe[i].dispose();

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
  resetEditHalteAndKoridor(source);
}
public void addMyButtonHandler(GButton source, GEvent event) {
  createAddNewHalteWindow();
}
public void buttonCreateHalteHandler(GButton source, GEvent event) {
  int halteMode = dropHalte.getSelectedIndex();
  String indexHalte = fieldIndexHalte.getText();
  String namaHalte = fieldNamaHalte.getText();
  if (!indexHalte.isEmpty() && !namaHalte.isEmpty()) {
    if (numberOrNot(indexHalte) && int(indexHalte) > 0) {
      if (halteMode == 0) {
        if (int(indexHalte)-1 < myKoridor.get(currentHal).totalHalteGo +1) {
          clearEditKoridor();
          myKoridor.get(currentHal).totalHalteGo ++;
          myKoridor.get(currentHal).namaHalteGo.add(int(indexHalte)-1, namaHalte);
        } else {
          JOptionPane.showMessageDialog(null, "index number too high", "Error", JOptionPane.WARNING_MESSAGE);
        }
      } else if (halteMode == 1) {
        if (int(indexHalte)-1 < myKoridor.get(currentHal).totalHalteBack +1) {
          clearEditKoridor();
          myKoridor.get(currentHal).totalHalteBack ++;
          myKoridor.get(currentHal).namaHalteBack.add(int(indexHalte)-1, namaHalte);
        } else {
          JOptionPane.showMessageDialog(null, "index number too high", "Error", JOptionPane.WARNING_MESSAGE);
        }
      }      
      addNewHalteWindow.close();
      addNewHalteWindow = null; 
      refreshEditHalteAndKoridor();
    } else {
      JOptionPane.showMessageDialog(null, "field cannot be empty, index must be number and greater than zero", "Error", JOptionPane.WARNING_MESSAGE);
    }
  } else {
    JOptionPane.showMessageDialog(null, "field cannot be empty", "Error", JOptionPane.WARNING_MESSAGE);
  }
}
void clearEditKoridor() {
  int totHalteGo = myKoridor.get(currentHal).totalHalteGo;
  int totHalteBack = myKoridor.get(currentHal).totalHalteBack;
  int tot = totHalteGo+totHalteBack+1;
  for (int j=0; j<tot; j++) {
    if (j > 0 && j<=totHalteGo) {
      int k = j - 1;
      myField[j].dispose();
      myLabelField[j].dispose();
      delMyField[j].dispose();
    } else if (j > totHalteGo) {
      int k = j - (totHalteGo+1);
      myField[j].dispose();
      myLabelField[j].dispose();
      delMyField[j].dispose();
    }
  }
}
public void buttonAddLoadSettingWizardHandler(GButton source, GEvent event) {
  createAddNewKoridorWindow();
}
public void buttonCreateKoridorHandler(GButton source, GEvent event) {
  String indexKoridor = fieldIndexKoridor.getText();
  String namaKoridor = fieldNamaKoridor.getText();
  if (!indexKoridor.isEmpty() && !namaKoridor.isEmpty()) {
    if (numberOrNot(indexKoridor) && int(indexKoridor) > 0) {
      if (int(indexKoridor)-1 < korNum +1) {        
        clearKoridor();
        korNum ++;
        myKoridor.add(int(indexKoridor)-1, new koridor());
        myKoridor.get(int(indexKoridor)-1).namaKoridor = namaKoridor;
        addNewKoridorWindow.close();
        addNewKoridorWindow = null;
        refreshLoadWizard();
      } else {
        JOptionPane.showMessageDialog(null, "index numberr too high", "Error", JOptionPane.WARNING_MESSAGE);
      }
    } else {
      JOptionPane.showMessageDialog(null, "field cannot be empty, index must be number and greater than zero", "Error", JOptionPane.WARNING_MESSAGE);
    }
  } else {
    JOptionPane.showMessageDialog(null, "field cannot be empty", "Error", JOptionPane.WARNING_MESSAGE);
  }
}
void clearKoridor() {
  int lastKorNum = korNum;
  for (int i=0; i<lastKorNum; i++) {
    delMe[i].dispose();
    butMe[i].dispose();
    me[i].dispose();
    labelMe[i].dispose();
  }
}
public void buttonIndoorLoadSettingWizardHandler(GButton source, GEvent event) {
  createEditTextIndoorWindow();
}
public void buttonSaveTextIndoorHandler(GButton source, GEvent event) {
  for (int i=0; i<5; i++) {
    textIndoor.set(i, fieldEditTextIndoor[i].getText());
  }
  editTextIndoorWindow.close();
  editTextIndoorWindow = null;
}
public void buttonOutdoorLoadSettingWizardHandler(GButton source, GEvent event) {
  createEditTextOutdoorWindow();
}
public void buttonSaveTextOutdoorHandler(GButton source, GEvent event) {
  for (int i=0; i<5; i++) {
    textOutdoor.set(i, fieldEditTextOutdoor[i].getText());
  }
  editTextOutdoorWindow.close();
  editTextOutdoorWindow = null;
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