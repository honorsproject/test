public class Gui extends JLayeredPane {
  private JFrame frame;
  Gui() {
    frame = (JFrame) ((processing.awt.PSurfaceAWT.SmoothCanvas)surface.getNative()).getFrame();
    com.formdev.flatlaf.FlatDarkLaf.install(); //optional but try catch doesnt work for some reason
    setLayout(new BorderLayout());
    setBorder(BorderFactory.createEmptyBorder(23, 0, 0, 0)); //pad out menubar

    //Toolbar
    add(new ToolBar().wrapped(), BorderLayout.NORTH);

    //add(new JButton("South"), BorderLayout.SOUTH);
    add(new Tools().wrapped(), BorderLayout.WEST);
    //add(new JButton("West"), BorderLayout.WEST);
    //add(new ViewPort(), BorderLayout.CENTER);

    frame.setJMenuBar(new Menubar());
    frame.setGlassPane(this);
    frame.getGlassPane().setVisible(true);
    frame.setVisible(true);
  }

  private class Menubar extends JMenuBar {
    JMenu file, edit, view, layer, filter;
    Menubar() {
      add(file = new JMenu("File"));
      add(edit = new JMenu("Edit"));
      add(view = new JMenu("View"));
      add(layer = new JMenu("Layer"));
      add(filter = new JMenu("Filter"));
    }
  }

  private class ToolBar extends JToolBar {
    ToolBar() {
      //setFloatable(false);
      addSeparator(new Dimension(20, 20));
    }
    protected JPanel wrapped() {
      JPanel toolBarWrapper = new JPanel();
      toolBarWrapper.setLayout(new BorderLayout());
      toolBarWrapper.add(this, BorderLayout.NORTH);
      return toolBarWrapper;
    }
  }

  private class Tools extends JToolBar {
    Tools() {
      addSeparator(new Dimension(20, 20));
      setOrientation(JToolBar.VERTICAL);
    }
    protected JPanel wrapped() {
      JPanel toolBarWrapper = new JPanel();
      toolBarWrapper.setLayout(new BorderLayout());
      toolBarWrapper.add(this, BorderLayout.WEST);
      return toolBarWrapper;
    }
  }

  private class ViewPort extends JPanel {
    ViewPort() {
      setOpaque(false);
    }
  }
}
