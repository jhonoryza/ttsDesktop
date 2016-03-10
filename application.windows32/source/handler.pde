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
public void buttonPreviewVoiceHandler(GButton source, GEvent event) {
  String pitch = voicePitch;
  String rate = voiceRate;
  String vol = voiceVolume;
  String textVoice = inPreTemp.getText() + inHal.getText() + inAfterTemp.getText();
  textVoice = textVoice.replace(" ", "%20");
  String u = "http://code.responsivevoice.org/getvoice.php?t=" 
    +textVoice +"&tl=id&sv=&vn=&pitch=" +pitch +"&rate=" +rate +"&vol=" +vol;
  String loc = sketchPath() +"/data/";
  saveToFile(u, "previewvoice", loc);
  player = minim.loadFile(loc +"previewvoice.mp3");
  player.play();
  //File meFile = new File(loc);
  //Desktop desktop = Desktop.getDesktop();
  //try {
  //  desktop.open(meFile);
  //} 
  //catch (IOException iae) {
  //  System.out.println("File Not Found");
  //}
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
          } else if (i == lines.length-4 && j == 1) {
            String[] newlist = split(list[j], ",");
            //textindoor
            saveStrings(selection +"/textindoor.txt", newlist);
          } else if (i == lines.length-3 && j == 1) {
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
      Desktop desktop = Desktop.getDesktop();
      try {
        desktop.open(selection);
      } 
      catch (IOException iae) {
        System.out.println("File Not Found");
      }
      //JOptionPane.showMessageDialog(null, "Save success", "Message", JOptionPane.WARNING_MESSAGE);
    } else {
      JOptionPane.showMessageDialog(null, "Load setting file first", "Error", JOptionPane.WARNING_MESSAGE);
    }
  }
  //newWriteToSDWindow.close();
  //newWriteToSDWindow = null;
}
public void buttonWriteVoiceHandler(GButton source, GEvent event) {
  selectFolder("select sd card", "writeVoiceToSDCard");
}
void writeVoiceToSDCard(File selection) {
  if (selection == null) {
    println("Window was closed or the user hit cancel.");
    //JOptionPane.showMessageDialog(null, "no selection", "Error", JOptionPane.WARNING_MESSAGE);
  } else {
    if (!loadSettingPath.isEmpty()) {
      pleaseWaitWindow();
      createMp3(selection);
      please.close(); 
      please = null;
      Desktop desktop = Desktop.getDesktop();
      try {
        desktop.open(selection);
      } 
      catch (IOException iae) {
        System.out.println("File Not Found");
      }
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
  for (int i=0; i<myKoridor.size(); i++) {
    String text; 
    String nameFile; 
    String u;
    //text = preText +"koridor " +myKoridor.get(i).namaKoridor +afterText;
    //String nameFile = myKoridor.get(i).namaKoridor;
    //textVoice = text.replace(" ", "%20");
    //String u= "http://code.responsivevoice.org/getvoice.php?t=" 
    //  +textVoice +"&tl=id&sv=&vn=&pitch=" +pitch +"&rate=" +rate +"&vol=" +vol;
    //saveToFile(u, nameFile, selection.toString());

    for (int j=0; j<myKoridor.get(i).namaHalteGo.size(); j++) {
      text = preText +"halte " +myKoridor.get(i).namaHalteGo.get(j) +afterText;
      nameFile = myKoridor.get(i).namaHalteGo.get(j);
      textVoice = text.replace(" ", "%20");
      u= "http://code.responsivevoice.org/getvoice.php?t=" 
        +textVoice +"&tl=id&sv=&vn=&pitch=" +pitch +"&rate=" +rate +"&vol=" +vol;
      saveToFile(u, nameFile, selection.toString());
    }
    for (int j=0; j<myKoridor.get(i).namaHalteBack.size(); j++) {
      text = preText +"halte " +myKoridor.get(i).namaHalteBack.get(j) +afterText;
      nameFile = myKoridor.get(i).namaHalteBack.get(j);
      textVoice = text.replace(" ", "%20");
      u= "http://code.responsivevoice.org/getvoice.php?t=" 
        +textVoice +"&tl=id&sv=&vn=&pitch=" +pitch +"&rate=" +rate +"&vol=" +vol;
      saveToFile(u, nameFile, selection.toString());
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
  int total = 0;
  for (int i=0; i<5; i++) {
    if (fieldEditTextIndoor[i].getText() != null && !fieldEditTextIndoor[i].getText().isEmpty() )
      total = i;
  }
  for (int i=0; i<total; i++) {
    textIndoor.set(i, fieldEditTextIndoor[i].getText());
  }
  editTextIndoorWindow.close();
  editTextIndoorWindow = null;
}
public void buttonOutdoorLoadSettingWizardHandler(GButton source, GEvent event) {
  createEditTextOutdoorWindow();
}
public void buttonSaveTextOutdoorHandler(GButton source, GEvent event) {
  int total = 0;
  for (int i=0; i<5; i++) {
    if (fieldEditTextOutdoor[i].getText() != null && !fieldEditTextOutdoor[i].getText().isEmpty() )
      total = i;
  }
  for (int i=0; i<total; i++) {
    textOutdoor.set(i, fieldEditTextOutdoor[i].getText());
  }
  editTextOutdoorWindow.close();
  editTextOutdoorWindow = null;
}
public void buttonPreTextLoadSettingWizardHandler(GButton source, GEvent event) {
  editPreTextWindow();
}
public void saveMeHandler(GButton source, GEvent event) {
  preText = inPreField.getText();
  afterText = inAfterField.getText();
  pretextWindow.close();
  pretextWindow = null;
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