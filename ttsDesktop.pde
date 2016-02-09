// Need G4P library
import g4p_controls.*;

//public variable
String voicePitch, voiceRate, voiceVolume;

public void setup() {
  size(350, 190, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  println(sketchPath());
  loadVoiceSetting();
}

public void draw() {
  background(240);
  noStroke();
  //border bawah
  fill(255, 200);
  rect(0, height-20, width, 20);
  rect(0, 0, width, 20);
  //text
  fill(0);
  textSize(12);
  text("Config Apps", width/2-35, 15);
  textSize(10);
  text("copyright \u00a9 2016 GTI", width/1.5, height-5);
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
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

  inputRate = new GTextField(voiceSettingWindow, inputPitch.getX()+inputPitch.getWidth()+100, 30, 60, 20, G4P.SCROLLBARS_NONE);
  inputRate.setText(voiceRate);
  inputRate.setOpaque(false);

  inputVolume = new GTextField(voiceSettingWindow, inputRate.getX()+inputRate.getWidth()+100, 30, 60, 20, G4P.SCROLLBARS_NONE);
  inputVolume.setText(voiceVolume);
  inputVolume.setOpaque(false);

  buttonSaveConfig = new GButton(voiceSettingWindow, voiceSettingWindow.width/2-75, inputVolume.getY()+40, 150, 30);
  println(voiceSettingWindow.width);
  buttonSaveConfig.setText("save configuration");
  buttonSaveConfig.setOpaque(false);
  buttonSaveConfig.addEventHandler(this, "buttonSaveVoiceConfiguration");

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
void saveTextFunction(String[] nameKoridor) {
  String path = sketchPath()+"/data/listKoridor.txt";
  println(path);
  String text ="";
  for (int i=0; i<nameKoridor.length; i++)
    text += nameKoridor[i] +",";
  String[] meText = split(text, ",");
  saveStrings(path, meText);
  newSettingWindow.close();
}
GWindow newSettingWindow;
GLabel labelText, labela, labelb;
GButton buttonNext, buttonContinue, buttonBack, buttonSaveConfigText;
GTextField inputA;
int newSetSlideNum;
public void newSettingWizard() {
  newSettingWindow = GWindow.getWindow(this, "New Setting Wizard", 400, 250, 500, 300, JAVA2D); 
  newSettingWindow.noLoop();
  newSettingWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  newSettingWindow.addDrawHandler(this, "win_drawNewSetting");
  //media
  buttonContinue = new GButton(newSettingWindow, newSettingWindow.width-70, newSettingWindow.height-40, 50, 25);
  buttonContinue.setOpaque(false);
  buttonContinue.setText("continue");
  buttonContinue.addEventHandler(this, "buttonContinueHandler");
  inputA = new GTextField(newSettingWindow, 150, 65, 90, 20);
  inputA.setOpaque(false);
  buttonNext = new GButton(newSettingWindow, newSettingWindow.width-70, newSettingWindow.height-40, 50, 25);
  buttonNext.setOpaque(false);
  buttonNext.setText("next");
  buttonNext.addEventHandler(this, "buttonNextHandler");
  buttonBack = new GButton(newSettingWindow, buttonNext.getX()-buttonNext.getWidth(), newSettingWindow.height-40, 50, 25);
  buttonBack.setOpaque(false);
  buttonBack.setText("back");
  buttonBack.addEventHandler(this, "buttonBackHandler");
  buttonSaveConfigText = new GButton(newSettingWindow, newSettingWindow.width-70, newSettingWindow.height-40, 50, 25);
  buttonSaveConfigText.setOpaque(false);
  buttonSaveConfigText.setText("save");
  buttonSaveConfigText.addEventHandler(this, "buttonSaveConfigTextHandler");
  newSetSlideNum = 0;
  newSettingWindow.loop();
}
//handler window
synchronized public void win_drawVoiceSetting(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();
  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(0, appc.height-20, appc.width, appc.height/6);
  //text
  appc.fill(0);
  appc.textSize(12);
  appc.text("Pitch (0 - 1) :", inputPitch.getX()-80, inputPitch.getY()+15);
  appc.text("Pitch (0 - 1) :", inputRate.getX()-80, inputPitch.getY()+15);
  appc.text("Pitch (0 - 1) :", inputVolume.getX()-80, inputPitch.getY()+15);
  appc.textSize(10);
  appc.text(sketchPath() +"/data/voice.cfg", 0, appc.height-7);
}
int korNum = 0, slideNum = 0;
String[] namaKoridor;
boolean clickSave = false, clickNext = false, clickBack = false, clickContinue = false;
synchronized public void win_drawNewSetting(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();
  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(0, 0, appc.width, appc.height/6);
  //text
  appc.fill(0);
  appc.textSize(18);
  appc.text("Welcome to the new setting wizard", 20, 30);


  if (clickSave) {
    clickSave = false;
  } else if (clickNext) {
    if (newSetSlideNum == 1) {
      namaKoridor[slideNum-1] = inputA.getText();
      printArray(namaKoridor);
    }
    if (slideNum >= korNum)
      saveTextFunction(namaKoridor);
    else
      slideNum += 1;
    clickNext = false;
    inputA.setText("");
  } else if (clickBack) {
    clickBack = false;
    inputA.setText("");
    if (slideNum <= 0)
      newSetSlideNum = 0;
    else
      slideNum -= 1;
  } else if (clickContinue) {
    clickContinue = false;
    korNum = int(inputA.getText());
    namaKoridor = new String[korNum];
    newSetSlideNum += 1;
    slideNum += 1;
    inputA.setText("");
  }
  switch(newSetSlideNum) {
  case 0:
    appc.textSize(12);
    appc.text("Input Jumlah Koridor :", 20, 80);
    buttonNext.setVisible(false);
    buttonBack.setVisible(false);
    buttonSaveConfigText.setVisible(false);
    buttonContinue.setVisible(true);
    break;
  case 1:
    appc.textSize(12);
    appc.text("Nama Koridor " +slideNum +" :", 20, 80);
    buttonNext.setVisible(true);
    buttonBack.setVisible(true);
    buttonContinue.setVisible(false);
    buttonSaveConfigText.setVisible(false);
    break;
  }
}
//handler button
public void buttonSaveVoiceConfiguration(GButton source, GEvent event) {
  println("voice config saved");
  String[] text = {inputPitch.getText() +"," +inputRate.getText() +"," +inputVolume.getText()};
  String currentPath = sketchPath() + "/data/voice.cfg";
  println(currentPath);
  saveStrings(currentPath, text);
  loadVoiceSetting();
  voiceSettingWindow.close();
}
public void buttonExit() {
  exit();
}
public void buttonContinueHandler(GButton source, GEvent event) {
  clickContinue = true;
}
public void buttonNextHandler(GButton source, GEvent event) {
  clickNext = true;
}
public void buttonBackHandler(GButton source, GEvent event) {
  clickBack = true;
}
public void buttonSaveConfigTextHandler(GButton source, GEvent event) {
  clickSave = true;
}