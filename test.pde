import java.awt.event.*;
import java.awt.*;
import javax.swing.*;
processing.awt.PSurfaceAWT.SmoothCanvas surf;
Container panel, layer;
JFrame frame;

public class Menubar extends JMenuBar {
  JMenu file, edit, view, layer, filter;
  Menubar() {
    add(file = new JMenu("File"));
    add(edit = new JMenu("Edit"));
    add(view = new JMenu("View"));
    add(layer = new JMenu("Layer"));
    add(filter = new JMenu("Filter"));
  }
}

void setup() {
  surface.setSize(800, 600);
  surface.setResizable(true);
  frameRate(1000);
  surf = (processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative();
  panel = surf.getParent();
  layer = panel.getParent();
  frame = (JFrame) surf.getFrame();
  frame.setJMenuBar(new Menubar());
  layer.setLayout(new BorderLayout());

  panel.setLayout(new BorderLayout());
  panel.remove(surf);
  JPanel wrapper = new JPanel();
  wrapper.add(surf);
  panel.add(wrapper, BorderLayout.CENTER);
  panel.add(new JButton("bruh"), BorderLayout.WEST);
  panel.add(new JButton("bruh"), BorderLayout.EAST);
  panel.add(new JButton("bruh"), BorderLayout.NORTH);
  panel.add(new JButton("bruh"), BorderLayout.SOUTH);
  frame.revalidate();
  getAllComponents(frame);
  //Gui gui = new Gui();
}
void draw() {
  //surf.setSize(100, 100);
  frame.revalidate();
  frame.repaint(); //makes sure processing stays that way
  background(0);
  ellipse(mouseX, mouseY, 50, 50);
}
