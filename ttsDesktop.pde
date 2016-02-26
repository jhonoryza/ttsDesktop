// Need G4P library
import g4p_controls.*;
import java.awt.Font;
import javax.swing.JOptionPane;
import java.net.*;
import java.io.*;
import gifAnimation.*;
import java.awt.Desktop;
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