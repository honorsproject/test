//import java.awt.event.*;
import java.awt.*;
import javax.swing.*;

Gui gui;
void setup() {
  surface.setSize(800, 600);
  surface.setResizable(true);
  frameRate(1000);

  gui = new Gui();
}
void draw() {
  gui.frame.revalidate();
  background(0);
  rect(10, 10, width - 20, height - 20);
}
