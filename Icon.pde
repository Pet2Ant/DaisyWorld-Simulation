void addIcon() {
  SwingUtilities.invokeLater(new Runnable() {
    public void run() {
      String projectDir = System.getProperty("user.dir") + "/../DaisyWorld Simulation";
      println(projectDir);
      JFrame window = (JFrame) SwingUtilities.getWindowAncestor((java.awt.Component)surface.getNative());
      // Change the program icon
    window.setIconImage(new javax.swing.ImageIcon(projectDir + "/icon.png").getImage());    }
  });
}
