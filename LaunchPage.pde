void launchPage(String url) {
  if (System.getProperty("os.name").contains("Windows")) {
    try {
      Runtime.getRuntime().exec("C:\\Program Files\\Google\\Chrome\\Application\\chrome.exe --app=" + url);
    } 
    catch (IOException e64) {
      try {
        Runtime.getRuntime().exec("C:\\Program Files (x86)\\Google\\Chrome\\Application\\chrome.exe --app=" + url);
      } 
      catch (IOException e86) {
      }
    }
  } else if (System.getProperty("os.name").contains("Mac")) {
    try {
      Runtime.getRuntime().exec("~/Library/Application Support/Google/Chrome.app --app=" + url);
    } 
    catch (IOException e) {
    }
  }
}
