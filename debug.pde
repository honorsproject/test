import java.util.List;
import java.util.ArrayList;
public static List<Component> getAllComponents(final Container c, int depth) {
  Component[] comps = c.getComponents();
  List<Component> compList = new ArrayList<Component>();
  for (Component comp : comps) {
    compList.add(comp);
    for(int i = 0; i < depth; i++)
      print("  ");
    println(comp.getClass().getCanonicalName());
    if (comp instanceof Container)
      try {
        compList.addAll(getAllComponents((Container) comp, ++depth));
        depth--;
      } catch (Exception e) {}
  }
  return compList;
}
public static List<Component> getAllComponents(final Container c) {
  return getAllComponents(c, 0);
}
