// Need G4P library
import g4p_controls.*;

//public variable


public void setup() {
  size(340, 220, JAVA2D);
  createGUI();
  customGUI();
  // Place your setup code here
  println(sketchPath());
}

public void draw() {
  background(240);
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
}

//function
public void voiceSetting() {
  GWindow voiceSettingWindow = GWindow.getWindow(this, "Voice Tuning", 50, 100, 500, 100, JAVA2D); 
  voiceSettingWindow.noLoop();
  voiceSettingWindow.setActionOnClose(G4P.CLOSE_WINDOW);
  voiceSettingWindow.addDrawHandler(this, "win_drawVoiceSetting");

  GLabel labelPitch = new GLabel(voiceSettingWindow, 10, 10, 80, 20);
  labelPitch.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelPitch.setText("Pitch (0 - 1):");
  labelPitch.setOpaque(false);

  GTextField inputPitch = new GTextField(voiceSettingWindow, labelPitch.getX()+labelPitch.getWidth(), 10, 60, 20, G4P.SCROLLBARS_NONE);
  inputPitch.setText("0.5");
  inputPitch.setOpaque(false);

  GLabel labelRate = new GLabel(voiceSettingWindow, inputPitch.getX()+inputPitch.getWidth() +20, 10, 80, 20);
  labelRate.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelRate.setText("Rate (0 - 1):");
  labelRate.setOpaque(false);

  GTextField inputRate = new GTextField(voiceSettingWindow, labelRate.getX()+labelRate.getWidth(), 10, 60, 20, G4P.SCROLLBARS_NONE);
  inputRate.setText("0.5");
  inputRate.setOpaque(false);
  
  GLabel labelVolume = new GLabel(voiceSettingWindow, inputRate.getX()+inputRate.getWidth() +20, 10, 100, 20);
  labelVolume.setTextAlign(GAlign.LEFT, GAlign.MIDDLE);
  labelVolume.setText("Volume (0 - 1):");
  labelVolume.setOpaque(false);

  GTextField inputVolume = new GTextField(voiceSettingWindow, labelVolume.getX()+labelVolume.getWidth(), 10, 60, 20, G4P.SCROLLBARS_NONE);
  inputVolume.setText("0.5");
  inputVolume.setOpaque(false);

  GButton buttonSaveConfig = new GButton(voiceSettingWindow, sketchWidth()/2, inputVolume.getY()+40, 150,20);
  buttonSaveConfig.setText("save configuration");
  buttonSaveConfig.setOpaque(false);

  voiceSettingWindow.loop();
}

//handler window
synchronized public void win_drawVoiceSetting(PApplet appc, GWinData data) {
  appc.background(240);
}