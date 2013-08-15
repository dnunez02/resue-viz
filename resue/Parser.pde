/*
 * Reads in a CSV file.
 *
 * league,matchup,winner,length,rating,submission,date,version,[winner_apm],[winner_epm],[loser_apm],[loser_epm],[submitter]
 *
 * (c)2013 Diogenes A. Nunez
 */

public class Parser {

  Game[] games;
  HashMap groups;
  public color[] colors = null;
  public static final int RATING_OFFSET = 0;
  public static final int LEAGUE_OFFSET = 5;
  public static final int RACE_OFFSET = 12;
  public static final int SUBMISSION_OFFSET = 15;
  public static final int MATCHUP_OFFSET = 17;

  public Parser(String filename) {
    String[] cs_lines = loadStrings(filename);
    games = new Game[cs_lines.length];
    //System.err.println(cs_lines.length);
    String[] game;
    String[] time;
    String[] date;

    for (int i = 0; i < cs_lines.length; ++i) {
      game = split(cs_lines[i], ",");
      time = split(game[3], ":");
      date = split(game[6], "/");
      games[i] = new Game(stringToLeague(game[0]), stringToMatchup(game[1]), game[2].charAt(0), int(time[0]), int(time[1]), int(time[2]), int(game[4]), game[5].equals("WCF"), int(date[0]), int(date[1]), int(date[2]), stringToVersion(game[7]), int(game[8]), int(game[9]), int(game[10]), int(game[11]), game[12], i | 0xFF0000);
    }

    //    for (int i = 0; i < 413; ++i) {
    //      System.err.println(games[i]);
    //    }

    groups = new HashMap();
    String[] list = new String[7];
    list[0] = ("Bronze");
    list[1] = ("Silver");
    list[2] = ("Gold");
    list[3] = ("Platinum");
    list[4] = ("Diamond");
    list[5] = ("Master");
    list[6] = ("Grandmaster");
    groups.put("League", list);

    list = new String[3];
    list[0] = ("T");
    list[1] = ("P");
    list[2] = ("Z");
    groups.put("Winner", list);

    list = new String[9];
    list[0] = ("TvT");
    list[1] = ("TvZ");
    list[2] = ("TvP");
    list[3] = ("PvT");
    list[4] = ("PvZ");
    list[5] = ("PvP");
    list[6] = ("ZvT");
    list[7] = ("ZvZ");
    list[8] = ("ZvP");
    groups.put("Matchup", list);

    list = new String[2];
    list[0] = "NANG";
    list[1] = "WCF";
    groups.put("Submission Type", list);

    list = new String[5];
    list[0] = "1";
    list[1] = "2";
    list[2] = "3";
    list[3] = "4";
    list[4] = "5";
    groups.put("Rating", list);


    readConfig();
  }

  public void readConfig() {
    String[] lines = loadStrings("config");
    colors = new color[5+7+3+2+9];
    int colorIndex = 0;
    for (int i = 0; i < lines.length; ++i) {
      if (lines[i].startsWith("["))
        continue;
      String[] colorChoice = split(lines[i], ",");
      colors[colorIndex] = color(int(colorChoice[1]), int(colorChoice[2]), int(colorChoice[3]));
      colorIndex++;
    }
  }

  public int stringToLeague(String league) {
    if (league.equals("Bronze")) {
      return Game.BRONZE;
    } 
    else if (league.equals("Silver")) {
      return Game.SILVER;
    } 
    else if (league.equals("Gold")) {
      return Game.GOLD;
    } 
    else if (league.equals("Platinum")) {
      return Game.PLATINUM;
    } 
    else if (league.equals("Diamond")) {
      return Game.DIAMOND;
    } 
    else if (league.equals("Master")) {
      return Game.MASTER;
    } 
    else if (league.equals("Grandmaster")) {
      return Game.GRANDMASTER;
    }

    return -1;
  }

  public String leagueToString(int league) {
    switch(league) {
    case Game.BRONZE: 
      return "Bronze"; 
    case Game.SILVER: 
      return "Silver"; 
    case Game.GOLD: 
      return "Gold"; 
    case Game.PLATINUM: 
      return "Platinum"; 
    case Game.DIAMOND: 
      return "Diamond"; 
    case Game.MASTER: 
      return "Master"; 
    case Game.GRANDMASTER: 
      return "Grandmaster"; 
    default: 
      return "Unknown";
    }
  }

  public int stringToMatchup(String matchup) {
    if (matchup.equals("TvT")) {
      return Game.TvT;
    } 
    else if (matchup.equals("TvZ")) {
      return Game.TvZ;
    } 
    else if (matchup.equals("TvP")) {
      return Game.TvP;
    } 
    else if (matchup.equals("ZvT")) {
      return Game.ZvT;
    } 
    else if (matchup.equals("ZvZ")) {
      return Game.ZvZ;
    } 
    else if (matchup.equals("ZvP")) {
      return Game.ZvP;
    } 
    else if (matchup.equals("PvT")) {
      return Game.PvT;
    }
    else if (matchup.equals("PvZ")) {
      return Game.PvZ;
    } 
    else if (matchup.equals("PvP")) {
      return Game.PvP;
    } 
    return -1;
  }

  public String matchupToString(int matchup) {
    switch(matchup) {
    case Game.TvT: 
      return "TvT"; 
    case Game.TvZ: 
      return "TvZ"; 

    case Game.TvP: 
      return "TvP"; 

    case Game.ZvT: 
      return "ZvT"; 

    case Game.ZvZ: 
      return "ZvZ"; 

    case Game.ZvP: 
      return "ZvP"; 

    case Game.PvT: 
      return "PvT"; 

    case Game.PvZ: 
      return "PvZ"; 

    case Game.PvP: 
      return "PvP"; 

    default: 
      return "Unkown";
    }
  }

  public char stringToVersion(String version) {
    if (version.equals("WoL")) {
      return Game.WoL;
    } 
    else if (version.equals("HotS")) {
      return Game.HotS;
    }

    return 'D';
  }
}

