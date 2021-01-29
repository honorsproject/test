import java.awt.event.MouseAdapter;
import java.awt.event.MouseEvent;

public class ResizablePanel extends JPanel {

  public ResizablePanel() {

    setLayout(new BorderLayout());
    JButton resize = new JButton();
    resize.setPreferredSize(new Dimension(10, Integer.MAX_VALUE));
    resize.addMouseMotionListener(new MouseAdapter() {
        public void mouseDragged(MouseEvent e) {
            Dimension preferredSize = ResizablePanel.this.getPreferredSize();
            ResizablePanel.this.setPreferredSize(new Dimension(preferredSize.width - e.getX(), preferredSize.height));
            ResizablePanel.this.revalidate();
        }
    });
    add(resize, BorderLayout.WEST);
  }
  void add(JComponent body) {
    super.add(body, BorderLayout.CENTER);
  };
}
