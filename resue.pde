import java.util.Iterator;
import java.util.Map;

Parser p;
FilterListView flv;
PGraphics pg, front;

int SPACING = 15;
int START_ROW = 100;
int START_COL = 10;
boolean redraw;

void setup() {
  size(800, 600);
  p = new Parser("ResueJune.csv");
  flv = new FilterListView(p, 100, (5 * height)/8);
  pg = createGraphics(width, height);
  front = createGraphics(width, height);
  redraw = true;
  drawBack();
}

void draw() {
  smooth();//

  if (keyPressed && key == 'b') {
    image(pg, 0, 0);
    redraw = true;
    return;
  }
  if (redraw) {
    //System.err.println("Redrawing buffer");
    front.beginDraw();
    front.background(255); 

    //flv.render();

    float x = START_ROW;
    float y = START_COL;
    Game []games = p.games;
    for (int i = 0; i < games.length; ++i) {
      //int rating = games[i].rating;

      if (!is_filtered(games[i])) {
        front.fill(50);
        front.rect(x, y, SPACING, SPACING);
      } 
      else {
        games[i].render(front, x, y, SPACING);
      }
      x += SPACING;
      if ( x + SPACING > width - START_ROW ) {
        x = START_ROW;
        y += SPACING;
      }
    }
    redraw = false;
    front.endDraw();
  } else {
    //System.err.println("Using buffer");
     image(front, 0, 0); 
  }
  
  flv.render();
  float x = START_ROW;
  float y = START_COL;
  for (int i = 0; i < p.games.length; ++i) {
    if (p.games[i].is_isect) {
      fill(0);
      textSize(12);
      textAlign(LEFT, CENTER);
      text(p.games[i].toString(), width/2, 3 * height / 4);
      rectMode(CENTER);
      strokeWeight(3);
      p.games[i].render(x + (SPACING/2), y + (SPACING/2), SPACING * 2);
      strokeWeight(1);
      rectMode(CORNER);
    }

    //    if (!is_filtered(games[i]))
    //      continue;

    x += SPACING;
    if ( x + SPACING > width - START_ROW ) {
      x = START_ROW;
      y += SPACING;
    }
  }
}

void drawBack() {
  pg.beginDraw();
  pg.background(255);
  flv.renderBackBuffer(pg);

  float x = START_ROW;
  float y = START_COL;
  for (int i = 0; i < p.games.length; ++i) {
    if (is_filtered(p.games[i])) {
      p.games[i].renderBack(pg, x, y);
    }
    //continue;


    x += SPACING;
    if ( x + SPACING > width - START_ROW ) {
      x = START_ROW;
      y += SPACING;
    }
  }
  pg.endDraw();
}

boolean is_filtered(Game g) {
  if (flv.winner.size() > 0) {
    if (!flv.winner.contains(str(g.winner))) {
      return false;
    }
  }

  if (flv.league.size() > 0) {
    if (!flv.league.contains((p.leagueToString(g.league)))) {
      return false;
    }
  }

  if (flv.matchup.size() > 0) {
    if (!flv.matchup.contains((p.matchupToString(g.matchup)))) {
      return false;
    }
  }

  if (flv.submission.size() > 0) {
    if (!flv.submission.contains((g.submission_type))) {
      return false;
    }
  }

  if (flv.rating.size() > 0) {
    if (!flv.rating.contains(str(g.rating))) {
      return false;
    }
  }

  return true;
}

void mouseMoved() {
  drawBack();

  if (flv.isect(pg.get(mouseX, mouseY) & 0xFFFFFF)){
    return;
  }
  
  for (int i = 0; i < p.games.length; ++i) {
    p.games[i].isect(pg.get(mouseX, mouseY) & 0xFFFFFF);
  }
}

void mousePressed() {
  drawBack();

  if(flv.clicked(pg.get(mouseX, mouseY) & 0xFFFFFF))
    redraw = true;
}

