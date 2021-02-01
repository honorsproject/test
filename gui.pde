import java.awt.event.*;
import java.awt.*;
import javax.swing.*;

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

      private class View extends JPanel {
        View() {
          setLayout(new BorderLayout());
          //add(canvas, BorderLayout.CENTER);
          JTextArea textArea = new JTextArea(20, 20);

          //might just make my own jpanel because awt canvas doesn't comply with swing JScrollPane
          JScrollPane scroll = new JScrollPane(textArea);
          scroll.setHorizontalScrollBarPolicy(JScrollPane.HORIZONTAL_SCROLLBAR_ALWAYS);
          scroll.setVerticalScrollBarPolicy(JScrollPane.VERTICAL_SCROLLBAR_ALWAYS);

          DnDTabbedPane sub = new DnDTabbedPane();
          sub.setTabLayoutPolicy(JTabbedPane.SCROLL_TAB_LAYOUT);
          sub.addTab("Image1", new JLabel("aaa"));
          sub.addTab("Image2", new JScrollPane(new JTree()));
          sub.addTab("Image3", new JScrollPane(new JTextArea("123412341234\n46746745\n245342\n")));

          add(sub, BorderLayout.CENTER);
          add(new JButton("info"), BorderLayout.SOUTH);
        }
      }
      private class Main extends JSplitPane {
        Main() {
          DnDTabbedPane bro = new DnDTabbedPane();
          bro.setTabLayoutPolicy(JTabbedPane.SCROLL_TAB_LAYOUT);
          bro.addTab("Image1", new JLabel("aaa"));
          bro.addTab("Image2", new JScrollPane(new JTree()));
          bro.addTab("Image3", new JScrollPane(new JTextArea("123412341234\n46746745\n245342\n")));

          setOneTouchExpandable(true);
          setLeftComponent(new View());
          setRightComponent(bro);
          setDividerLocation(600);
        }
      }
}
