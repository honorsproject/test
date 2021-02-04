import java.awt.event.*;
import javax.swing.event.*;
import java.awt.*;
import javax.swing.*;
import javax.imageio.*;

public class Gui extends JPanel {
  JFrame frame;

  Gui() {
    //hook into processing's prexistent frame
    frame = (JFrame) ((processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative()).getFrame();
    frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
    frame.setResizable(true);
    //Replace processing's canvas when safe to do so
    SwingUtilities.invokeLater(new Runnable() {
      public void run() {
        frame.setContentPane(buildGui());
        frame.revalidate();
      }
    });
  }

  Gui buildGui() {
    frame.setJMenuBar(new Menubar());
    setLayout(new BorderLayout());

    //ResizablePanel sidebar = new ResizablePanel();
    //sidebar.add(new JButton("properties"));
    //add(sidebar, BorderLayout.EAST);

    add(new ToolBar(), BorderLayout.NORTH);
    add(new Main(), BorderLayout.CENTER);
    add(new JButton("tools"), BorderLayout.WEST);

    return this;
  }

  private class Menubar extends JMenuBar implements ActionListener {
    JMenu file, edit, view, layer, filter;
    JMenuItem thing;
    Menubar() {
      add(file = new JMenu("File"));
      add(edit = new JMenu("Edit"));
      add(view = new JMenu("View"));
      add(layer = new JMenu("Layer"));
      add(filter = new JMenu("Filter"));

      thing = new JMenuItem("idk");
      file.add(thing);
      thing.addActionListener(this);
    }
    @Override
    public void actionPerformed(ActionEvent e) {
      if(e.getSource() == thing) {
        println("idk");
      }
    }
  }

  private class ToolBar extends JToolBar {
    ToolBar() {
      //setFloatable(false);

      setOrientation(JToolBar.HORIZONTAL);
      addSeparator(new Dimension(20, 20));
    }
    protected JPanel wrapped() {
      JPanel toolBarWrapper = new JPanel();
      toolBarWrapper.setLayout(new BorderLayout());
      toolBarWrapper.add(this, BorderLayout.NORTH);
      return toolBarWrapper;
    }
  }

  private class View extends JPanel implements ChangeListener {
    DnDTabbedPane main;
    View() {
      setLayout(new BorderLayout());
      //add(canvas, BorderLayout.CENTER);
      JTextArea textArea = new JTextArea(20, 20);

      //might just make my own jpanel because awt canvas doesn't comply with swing JScrollPane
      JScrollPane scroll = new JScrollPane(textArea);
      scroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
      scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);

      main = new DnDTabbedPane();
      main.setTabLayoutPolicy(JTabbedPane.SCROLL_TAB_LAYOUT);

      for(int i = 0; i<5; i++) {
        main.addTab("Image" + str(i), new ImageView());
      }
      add(main, BorderLayout.CENTER);

      JSlider zoomSlider = new JSlider(JSlider.HORIZONTAL, 1, 400, 100);
      zoomSlider.addChangeListener(this);

      add(zoomSlider, BorderLayout.SOUTH);
    }
    public void stateChanged(ChangeEvent e) {
      JSlider source = (JSlider)e.getSource();
      ImageView imgview= (ImageView) main.getSelectedComponent();
      imgview.setZoom((double)source.getValue() / 100);
    }
  }

  private class Main extends JSplitPane {
    Main() {
      DnDTabbedPane bro = new DnDTabbedPane();
      bro.setTabLayoutPolicy(JTabbedPane.SCROLL_TAB_LAYOUT);
      bro.addTab("test", new JLabel("properties"));

      setOneTouchExpandable(true);
      setLeftComponent(new View());
      setRightComponent(bro);
      setDividerLocation(600);
    }
  }
}

public class ImageView extends JScrollPane {
  Canvas canvas = new Canvas();
  ImageView() {
    super();
    setViewportView(canvas);
    //addMouseListener(canvas);
  }
  public void setZoom(double zoom, Point stable) {
    JViewport vp = getViewport();
    Rectangle bounds = vp.getViewRect();
    double d = zoom / canvas.zoom - 1;
    canvas.setZoom(zoom);
    vp.revalidate();
    //might introduce rounding errors but whatever
    vp.setViewPosition(new Point(bounds.x + (int)(stable.x * d), bounds.y + (int)(stable.y * d)));
  }
  public void setZoom(double zoom) {
    Rectangle bounds = getViewport().getViewRect();
    setZoom(zoom, new Point(bounds.x + bounds.width/2, bounds.y + bounds.height/2));
  }
  private class Canvas extends JComponent {
    public double zoom;
    private int width, height;
    Image img; //BufferedImage later
    Canvas() {
      img = Toolkit.getDefaultToolkit().getImage("path");
      img = new BufferedImage(1920, 1080, BufferedImage.TYPE_INT_RGB);
      /*try {
        img = ImageIO.read(new File("path"));
      } catch (IOException e) {}*/
      //TODO make image loader
      while (img.getWidth(null) == -1) {} //should add a progress bar
      setZoom(1D);
    }
    private void setZoom(double zoom) {
      this.zoom = zoom;
      height = (int)(img.getHeight(null) * zoom);
      width = (int)(img.getWidth(null) * zoom);
      setPreferredSize(new Dimension(width, height));
      repaint();
    }
    @Override
    public void paintComponent(Graphics g) {
      super.paintComponent(g);
      Graphics2D g2d = (Graphics2D) g;
      g2d.scale(zoom, zoom);
      g2d.drawImage(img, (int)(0 / zoom), (int)(0 / zoom), this);
      validate();
    }
  }
}
