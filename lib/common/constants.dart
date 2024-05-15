class Constants{
  static String baseurl(String date)=>
      "https://api.github.com/search/repositories?q=created:>$date&sort=stars&order=desc.";
}