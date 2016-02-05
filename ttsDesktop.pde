// Need G4P library
import g4p_controls.*;

//public variable
String voicePitch, voiceRate, voiceVolume;

public void setup() {
  size(350, 170, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  println(sketchPath());
  loadVoiceSetting();
}

public void draw() {
  background(240);
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
  label2.setText("copyright \u00a9 2016 GTI");
}

GWindow voiceSettingWindow;
GLabel labelPitch, labelRate, labelVolume;
GTextField inputPitch, inputRate, inputVolume;
GButton buttonSaveConfig;
//function
public void voiceSetting() {
  voiceSettingWindow = GWindow.getWindow(this, "Voice Tuning", 50, 100, 500, 100, JAVA2D); 
  voiceSettingWindow.noLoop();
  voiceSettingWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  voiceSettingWindow.addDrawHandler(this, "win_drawVoiceSetting");

  labelPitch = new GLabel(voiceSettingWindow, 10, 10, 80, 20);
  labelPitch.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelPitch.setText("Pitch (0 - 1):");
  labelPitch.setOpaque(false);

  inputPitch = new GTextField(voiceSettingWindow, labelPitch.getX()+labelPitch.getWidth(), 10, 60, 20, G4P.SCROLLBARS_NONE);
  inputPitch.setText(voicePitch);
  inputPitch.setOpaque(false);

  labelRate = new GLabel(voiceSettingWindow, inputPitch.getX()+inputPitch.getWidth() +20, 10, 80, 20);
  labelRate.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelRate.setText("Rate (0 - 1):");
  labelRate.setOpaque(false);

  inputRate = new GTextField(voiceSettingWindow, labelRate.getX()+labelRate.getWidth(), 10, 60, 20, G4P.SCROLLBARS_NONE);
  inputRate.setText(voiceRate);
  inputRate.setOpaque(false);

  labelVolume = new GLabel(voiceSettingWindow, inputRate.getX()+inputRate.getWidth() +20, 10, 100, 20);
  labelVolume.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelVolume.setText("Volume (0 - 1):");
  labelVolume.setOpaque(false);

  inputVolume = new GTextField(voiceSettingWindow, labelVolume.getX()+labelVolume.getWidth(), 10, 60, 20, G4P.SCROLLBARS_NONE);
  inputVolume.setText(voiceVolume);
  inputVolume.setOpaque(false);

  buttonSaveConfig = new GButton(voiceSettingWindow, voiceSettingWindow.width/2-75, inputVolume.getY()+40, 150, 20);
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
//handler window
synchronized public void win_drawVoiceSetting(PApplet appc, GWinData data) {
  appc.background(240);
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