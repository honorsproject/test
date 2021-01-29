public class Gui {
      public processing.awt.PSurfaceAWT.SmoothCanvas canvas;
      public Container mainPanel;
      public JFrame frame;
      Gui() {
        //hook into premade frame
        canvas = (processing.awt.PSurfaceAWT.SmoothCanvas) surface.getNative();
        mainPanel = canvas.getParent();
        frame = (JFrame) canvas.getFrame();
        mainPanel.remove(canvas);

        buildGui();

        //finish
        //getAllComponents(frame);
      }

      void buildGui() {
        com.formdev.flatlaf.FlatDarkLaf.install();

        frame.setJMenuBar(new Menubar());
        mainPanel.setLayout(new BorderLayout());

        ResizablePanel sidebar = new ResizablePanel();
        sidebar.add(new JButton("properties"));

        mainPanel.add(new ToolBar(), BorderLayout.NORTH);
        mainPanel.add(new View(), BorderLayout.CENTER);
        mainPanel.add(new JButton("tools"), BorderLayout.WEST);
        mainPanel.add(sidebar, BorderLayout.EAST);
        //mainPanel.add(new JButton("bruh"), BorderLayout.SOUTH);
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

      private class View extends JPanel {
        View() {
          setLayout(new BorderLayout());
          //add(canvas, BorderLayout.CENTER);
          JTextArea textArea = new JTextArea(20, 20);
          Canvas canv = new Canvas();
          canv.setPreferredSize(new Dimension(5000, 5000));
          canv.setBackground(new Color(255, 0, 0));
          JScrollPane scroll = new JScrollPane(canv);
          scroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
          scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);

          add(scroll, BorderLayout.CENTER);
          add(new JButton("info"), BorderLayout.SOUTH);
        }
      }

      public void refresh() {
        frame.revalidate();
        width = canvas.getWidth();
        height = canvas.getHeight();
      }
}
