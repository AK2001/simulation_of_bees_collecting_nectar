import javax.swing.*;

String prompt(String s)
{
   println(s);
   String entry = JOptionPane.showInputDialog(s); // pop-up window
   if (entry == null)
      return null;
   println(entry);
   return entry;
}

String getString(String s)
{
   return prompt(s);
}

int getInt(String s)
{
   return Integer.parseInt(getString(s));
}
