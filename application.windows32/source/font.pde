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