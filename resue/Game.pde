public class Game {
  static final int BRONZE = 0;
  static final int SILVER = 1;
  static final int GOLD = 2;
  static final int PLATINUM = 3;
  static final int DIAMOND = 4;
  static final int MASTER = 5;
  static final int GRANDMASTER = 6;

  static final char TERRAN = 'T';
  static final char PROTOSS = 'P';
  static final char ZERG = 'Z';

  static final boolean NANG = false;
  static final boolean WCF = true;

  static final char WoL = 'W';
  static final char HotS = 'H';

  //matchups
  static final int TvT = 0;
  static final int TvZ = 1;
  static final int TvP = 2;
  static final int PvT = 3;
  static final int PvZ = 4;
  static final int PvP = 5;
  static final int ZvT = 6;
  static final int ZvZ = 7;
  static final int ZvP = 8;

  int league;
  int matchup;
  char winner;
  int rating;

  int hour, minute, second;

  int month, day, year;
  boolean submission_type;
  char version;

  int winner_apm, winner_epm, loser_apm, loser_epm;
  String submitter;

  int id;
  boolean is_isect;

  public Game(int league, int matchup, char winner, int hour, int minute, int second, int rating, boolean submission_type, int day, int month, int year, char version, int winner_apm, int winner_epm, int loser_apm, int loser_epm, String submitter, int id) {
    this.league = league;
    this.matchup = matchup;
    this.winner = winner;
    this.hour = hour;
    this.minute = minute;
    this.second = second;
    this.rating = rating;
    this.submission_type = submission_type;
    this.day = day;
    this.month = month;
    this.year = year;
    this.version = version;
    this.winner_apm = winner_apm;
    this.winner_epm = winner_epm;
    this.loser_apm = loser_apm;
    this.loser_epm = loser_epm;
    this.submitter = submitter;
    this.id = id;

    is_isect = false;
  }

  public String toString() {
    String s = "League: ";
    switch(league) {
    case BRONZE: 
      s += "Bronze"; 
      break;
    case SILVER: 
      s += "Silver"; 
      break;
    case GOLD: 
      s += "Gold"; 
      break;
    case PLATINUM: 
      s += "Platinum"; 
      break;
    case DIAMOND: 
      s += "Diamond"; 
      break;
    case MASTER: 
      s += "Master"; 
      break;
    case GRANDMASTER: 
      s += "Grandmaster"; 
      break;
    default: 
      s += "Unknown"; 
      break;
    }

    s += "\nMatchup: ";
    switch(matchup) {
    case TvT: 
      s += "TvT"; 
      break;
    case TvZ: 
      s += "TvZ"; 
      break;
    case TvP: 
      s += "TvP"; 
      break;
    case ZvT: 
      s += "ZvT"; 
      break;
    case ZvZ: 
      s += "ZvZ"; 
      break;
    case ZvP: 
      s += "ZvP"; 
      break;
    case PvT: 
      s += "PvT"; 
      break;
    case PvZ: 
      s += "PvZ"; 
      break;
    case PvP: 
      s += "PvP"; 
      break;
    default: 
      s += "Unkown"; 
      break;
    }

    s += "\nWinner: ";

    if (str(winner).equals(str(TERRAN)))  s+= "Terran";  
    else if (str(winner).equals(str(PROTOSS))) s+= "Protoss";  
    else if (str(winner).equals(str(ZERG))) s+= "Zerg";
    else s += "Unknown";
    /*
    switch(winner) {
    case TERRAN: 
      s+= "Terran"; 
      break;
    case PROTOSS: 
      s+= "Protoss"; 
      break;
    case ZERG: 
      s+= "Zerg"; 
      break;
    default: 
      s+= "Unknown"; 
      break;
    }
*/
    s += "\nTime: " + str(hour) + ":" + str(minute) + ":" + str(second); 

    s += "\nRating: " + str(rating);

    s += "\nVersion: ";
    switch(version) {
    case WoL: 
      s += "WoL"; 
      break;
    case HotS: 
      s += "HotS"; 
      break;
    default: 
      s += "Unknown"; 
      break;
    }

    s += "\nDate: " + str(month+1) + "/" + str(day) + "/" + str(year);

    s += "\nSubmission Type: ";
    if (submission_type == NANG)
      s += "Normal Ass Normal Game"; 
    else if (submission_type == WCF)
      s += "When Cheese Fails"; 

    s += "\nWinner APM: " + str(winner_apm);
    s += "\nWinner EPM: " + str(winner_epm);
    s += "\nLoser APM: " + str(loser_apm);
    s += "\nLoser EPM: " + str(loser_epm);

    s += "\nSubmitter: " + submitter;
    return s;
  }

  public void render(float x, float y, float spacing) {
    color c = color(0, 0, 0);
    switch(rating) {
    case 1: 
      c = color(215, 25, 28); 
      break;
    case 2: 
      c = color(253, 174, 97); 
      break;
    case 3: 
      c = color(255, 255, 191); 
      break;
    case 4: 
      c = color(166, 217, 106); 
      break;
    case 5: 
      c = color(26, 150, 65); 
      break;
    }

    if (keyPressed && key == 'w') {
      //      switch(winner) {
      //      case Game.TERRAN: 
      //        c = color(124, 182, 232); 
      //        break;
      //      case Game.PROTOSS: 
      //        c = color(255, 215, 0); 
      //        break;
      //      case Game.ZERG: 
      //        c = color(153, 85, 187); 
      //        break;
      //      }
      if (str(winner).equals(str(TERRAN)))  c = color(124, 182, 232); 
      else if (str(winner).equals(str(PROTOSS))) c = color(255, 215, 0); 
      else if (str(winner).equals(str(ZERG))) c = color(153, 85, 187);
    }

    if (keyPressed && key == 'm') {
      switch(matchup) {
      case Game.TvT:
        c = color(55, 126, 184); 
        break;
      case Game.TvZ: 
        c = color(77, 175, 74);
        break;
      case Game.TvP: 
        c = color(228, 26, 28);
        break;
      case Game.ZvT: 
        c = color(255, 127, 0); 
        break;
      case Game.ZvZ: 
        c = color(152, 78, 163); 
        break;
      case Game.ZvP: 
        c = color(166, 86, 40); 
        break;
      case Game.PvT: 
        c = color(247, 129, 191); 
        break;
      case Game.PvZ: 
        c = color(153, 153, 153); 
        break;
      case Game.PvP: 
        c = color(255, 255, 51); 
        break;
      }
    }

    if (keyPressed && key == 'l') {
      switch(league) {
      case Game.BRONZE:
        c = color(205, 127, 50); 
        break;
      case Game.SILVER: 
        c = color(132, 132, 130);
        break;
      case Game.GOLD: 
        c = color(255, 215, 0);
        break;
      case Game.PLATINUM: 
        c = color(229, 228, 226);
        break;
      case Game.DIAMOND: 
        c = color(185, 242, 255);
        break;
      case Game.MASTER: 
        c = color(124, 182, 232);
        break;
      case Game.GRANDMASTER: 
        c = color(255, 126, 0);
        break;
      }
    }

    if (keyPressed && key == 's') {
      if (submission_type == Game.NANG)
        c = color(22, 46, 164);
      else if (submission_type == Game.WCF)
        c = color(255, 182, 0);
    }

    //    if (is_isect)
    //      fill(0);
    //    else
    fill(c);
    rect(x, y, spacing, spacing);
  }

  public void renderBack(PGraphics pg, float x, float y) {
    pg.fill(red(id), green(id), blue(id));
    pg.rect(x, y, SPACING, SPACING);
  }

  public boolean isect(int testId) {
    is_isect = testId == id;
    return is_isect;
  }
  
  public void render(PGraphics pg, float x, float y, float spacing) {
    color c = color(0, 0, 0);
    switch(rating) {
    case 1: 
      c = color(215, 25, 28); 
      break;
    case 2: 
      c = color(253, 174, 97); 
      break;
    case 3: 
      c = color(255, 255, 191); 
      break;
    case 4: 
      c = color(166, 217, 106); 
      break;
    case 5: 
      c = color(26, 150, 65); 
      break;
    }

    if (keyPressed && key == 'w') {
      //      switch(winner) {
      //      case Game.TERRAN: 
      //        c = color(124, 182, 232); 
      //        break;
      //      case Game.PROTOSS: 
      //        c = color(255, 215, 0); 
      //        break;
      //      case Game.ZERG: 
      //        c = color(153, 85, 187); 
      //        break;
      //      }
      if (str(winner).equals(str(TERRAN)))  c = color(124, 182, 232); 
      else if (str(winner).equals(str(PROTOSS))) c = color(255, 215, 0); 
      else if (str(winner).equals(str(ZERG))) c = color(153, 85, 187);
    }

    if (keyPressed && key == 'm') {
      switch(matchup) {
      case Game.TvT:
        c = color(55, 126, 184); 
        break;
      case Game.TvZ: 
        c = color(77, 175, 74);
        break;
      case Game.TvP: 
        c = color(228, 26, 28);
        break;
      case Game.ZvT: 
        c = color(255, 127, 0); 
        break;
      case Game.ZvZ: 
        c = color(152, 78, 163); 
        break;
      case Game.ZvP: 
        c = color(166, 86, 40); 
        break;
      case Game.PvT: 
        c = color(247, 129, 191); 
        break;
      case Game.PvZ: 
        c = color(153, 153, 153); 
        break;
      case Game.PvP: 
        c = color(255, 255, 51); 
        break;
      }
    }

    if (keyPressed && key == 'l') {
      switch(league) {
      case Game.BRONZE:
        c = color(205, 127, 50); 
        break;
      case Game.SILVER: 
        c = color(132, 132, 130);
        break;
      case Game.GOLD: 
        c = color(255, 215, 0);
        break;
      case Game.PLATINUM: 
        c = color(229, 228, 226);
        break;
      case Game.DIAMOND: 
        c = color(185, 242, 255);
        break;
      case Game.MASTER: 
        c = color(124, 182, 232);
        break;
      case Game.GRANDMASTER: 
        c = color(255, 126, 0);
        break;
      }
    }

    if (keyPressed && key == 's') {
      if (submission_type == Game.NANG)
        c = color(22, 46, 164);
      else if (submission_type == Game.WCF)
        c = color(255, 182, 0);
    }

    //    if (is_isect)
    //      fill(0);
    //    else
    pg.fill(c);
    pg.rect(x, y, spacing, spacing);
  }
}

