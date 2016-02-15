// Need G4P library
import g4p_controls.*;
import java.awt.Font;

//public variable
String voicePitch, voiceRate, voiceVolume;

public void setup() {
  loadCurrentFont();
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
  textFont(ubu12);
  text("Config Apps", width/2-35, 15);
  textSize(10);
  text("copyright \u00a9 2016 GTI", width/1.5, height-5);
}

// Use this method to add additional statements
// to customise the GUI controls
public void customGUI() {
  buttonNew.setFont(GuiUbu11);
  buttonLoad.setFont(GuiUbu11);
  buttonVoice.setFont(GuiUbu11);
  buttonSD.setFont(GuiUbu11);
  buttonExit.setFont(GuiUbu11);
}

//handler window
int korNum = 0, slideNum = 0, newSetSlideNum = 0;
koridor[] myKoridor = new koridor[0];
synchronized public void win_drawNewSetting(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();

  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(0, 0, appc.width, appc.height/7);

  //text
  appc.fill(0);
  appc.textFont(ubu14);
  appc.text("Welcome to the new setting wizard", 20, 30);
  appc.textSize(11);

  if (newSetSlideNum == 0) {
    appc.text("Input total koridor :", 10, 60);
    if (buttonNext != null && buttonBack != null && buttonContinue != null && optYes != null && optNo != null && in1 != null && in2 != null && editHalte != null) {
      buttonNext.setVisible(false);
      buttonBack.setVisible(false);
      buttonContinue.setVisible(true);
      optYes.setVisible(false);
      optNo.setVisible(false);
      in1.setVisible(false);
      in2.setVisible(false);
      editHalte.setVisible(false);
    }
  } else if (newSetSlideNum == 1) {
    appc.text("Input nama koridor", 10, 60);
    appc.text("Total halte (jalur pergi) == Total halte (jalur pulang) ?", 10, 110);
    if (buttonNext != null && buttonBack != null && buttonContinue != null && optYes != null && optNo != null && in1 != null && in2 != null && editHalte != null) {
      buttonNext.setVisible(true);
      buttonBack.setVisible(true);
      buttonContinue.setVisible(false);
      optYes.setVisible(true);
      optNo.setVisible(true);
    }
  }
}

synchronized public void newHalteWindowHandler(PApplet appc, GWinData data) {
  appc.background(240);
  appc.noStroke();
  
  //border
  appc.fill(255, 255, 255, 200);
  appc.rect(appc.width - 120, 0, appc.width - (appc.width - 120), appc.height);
  
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