//import java.awt.event.*;
import java.awt.*;
import javax.swing.*;

Gui gui;
void setup() {
  surface.setSize(800, 600);
  surface.setResizable(true);
  frameRate(1000);

  gui = new Gui();
  gui.frame.createBufferStrategy(1);
  background(255);
  fill(0);
  strokeWeight(10);
}
PVector last = new PVector(mouseX, mouseY);
void draw() {
  gui.refresh();
  if (mousePressed) {
    line(last.x, last.y, mouseX, mouseY);
  }
  last.set(mouseX, mouseY);
}
