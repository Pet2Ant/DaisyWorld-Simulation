void addIcon() {
  SwingUtilities.invokeLater(new Runnable() {
    public void run() {
      JFrame window = (JFrame) SwingUtilities.getWindowAncestor((java.awt.Component)surface.getNative());
      // Change the program icon
      window.setIconImage(new javax.swing.ImageIcon("C:/DaisyWorld Simulation/icon.png").getImage());
    }
  });
}
