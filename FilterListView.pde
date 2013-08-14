/*
 * FilterListView
 *
 * After clicking, filter will have a string with all protocols selected,
 *                 index_of_filter will have the row number of that protocol
 */

public class FilterListView {
  public int[] filters;

  public MenuItem[] all_items;
  public MenuItem reset_button;

  public boolean is_isect;
  public boolean is_clicked;

  public String filter = ""; 
  public int index_of_filter;

  protected Parser p;
  protected final int SPACING = 15;

  ArrayList winner, league, matchup, submission, rating;
  boolean filtering = false;

  public float view_width, x, y;
  //public ArrayList currentFilterItems;

  public final float PADDING = 100;
  public final float HORIZ_PADDING = 10;
  public final float VERT_PADDING = 10;

  static final int BITS = 32;

  public FilterListView(Parser p, float x, float y) {
    //this.filters = filters;
    is_isect = false;
    is_clicked = false;
    this.p = p;
    this.index_of_filter = -1;
    this.x = x;
    this.y = y;

    all_items = new MenuItem[26 + 5];

    Iterator iter = p.groups.entrySet().iterator();
    int i = 0, k = 0;

    float max_width = textWidth("  ");

    while (iter.hasNext ()) {

      Map.Entry me = (Map.Entry)iter.next();
      String[] protocols = (String[])me.getValue();

      if (textWidth(" " + (String)me.getKey() + " ") > max_width) {
        max_width =  textWidth(" " + (String)me.getKey() + " ");
      }
      for (int j = 0; j < protocols.length; ++j) {
        if (textWidth(protocols[j]) > max_width)
          max_width = textWidth(" " + protocols[j] + " ");
      }
    }

    view_width = max_width;

    iter = p.groups.entrySet().iterator();

    int protocol_num = 0;
    int group_num = 0;
    int c = 0;
    while (iter.hasNext ()) {
      Map.Entry me = (Map.Entry)iter.next();
      int drop_down_menu_index = i;
      String[] protocols = (String[])me.getValue();
      int j = 0;

      //2) Create menu item for each

      MenuItem[] items = new MenuItem[protocols.length];
      for (j = 0; j < protocols.length; ++j) {
        float current_height = (textAscent() + textDescent()) * (group_num+j) + (group_num * SPACING);

        int protocol_number = c;

        all_items[i+j+1] = new MenuItem(protocol_number, x, y + current_height, max_width, textAscent() + textDescent(), color(255), protocols[j], (String)me.getKey());
        items[j] = all_items[i+j+1];
        protocol_num++;
        c++;
      }
      all_items[i] = new DropDownMenu(26 + group_num, x, y + (textAscent() + textDescent() + SPACING) * group_num, max_width, textAscent() + textDescent(), color(255), (String)me.getKey(), items);
      i += j;
      i++; 

      group_num++;
    }
    reset_button = new DropDownMenu(26 + group_num + 1, x, y + VERT_PADDING + (textAscent() + textDescent() + SPACING) * group_num, max_width, textAscent() + textDescent() + VERT_PADDING, color(200, 0, 50), "RESET", null);

    winner = new ArrayList();
    league = new ArrayList();
    matchup = new ArrayList();
    submission = new ArrayList();
    rating = new ArrayList();
  } 

  public void render() {
    fill(0);
    stroke(0);
    textAlign(CENTER);
    textSize(12);

    reset_button.render();

    for (int i = 0; i < all_items.length; ++i) {
      if ( all_items[i] instanceof DropDownMenu && !all_items[i].is_selected) {
        all_items[i].render();
      }
    }

    for (int i = 0; i < all_items.length; ++i) {
      if ( all_items[i] instanceof DropDownMenu && all_items[i].is_selected) {
        all_items[i].render();
      }
    }

    if (filtering) {
      //      String[] lsp = split(p.protocols[index_of_filter], "+");
      float sx = x + view_width;
      float sy = y;
      fill(255, 0, 0);
      //      textSize(14);
      textAlign(LEFT);
      text("Filters Selected:", sx, sy);
      fill(157, 80, 238);
      
      if (rating.size() > 0) {
        sy += 0.03*height;
        renderFilter(rating, "Rating", sx, sy);
      }
      
      if (league.size() > 0) {
        sy += 0.03*height;
        renderFilter(league, "League", sx, sy);
      }
      
      if (matchup.size() > 0) {
        sy += 0.03*height;
        renderFilter(matchup, "Matchup", sx, sy);
      }

      if (winner.size() > 0) {
        sy += 0.03*height;
        renderFilter(winner, "Winner", sx, sy);
      }

      if (submission.size() > 0) {
        sy += 0.03*height;
        renderSubmission(submission, sx, sy);
      }

      


      //      for (int i = 0; i < lsp.length; i++) {
      //        sy += 0.03*height;
      //        text(lsp[i], sx+5, sy);
      //      }
    }
  }

  public void renderFilter(ArrayList list, String category, float x, float y) {
    String s = "";
    for (int i = 0; i < list.size(); ++i) {
//      if (list.get(i) instanceof Boolean) {
//        if ((Boolean)list.get(i))
//          s += "WCF";
//        else
//          s += "NANG";
//      } else {
        s += (String)list.get(i);
      //}
      if (i < list.size() - 1)
        s += ", ";
    }
    text(category + ": " + s, x, y);
  }
  
  public void renderSubmission(ArrayList list, float x, float y){
    String s = "";
    for (int i = 0; i < list.size(); ++i) {
        if ((Boolean)list.get(i))
          s += "WCF";
        else
          s += "NANG";
       
      if (i < list.size() - 1)
        s += ", ";
    }
    text("Submission: " + s, x, y);
  }

  public void renderBackBuffer(PGraphics pickBuffer) {
    pickBuffer.fill(0);
    pickBuffer.stroke(0);
    pickBuffer.textAlign(CENTER);
    pickBuffer.textSize(12);

    reset_button.renderBackBuffer(pickBuffer);

    for (int i = 0; i < all_items.length; ++i) {
      if ( all_items[i] instanceof DropDownMenu && !all_items[i].is_selected) {
        all_items[i].renderBackBuffer(pickBuffer);
      }
    }

    for (int i = 0; i < all_items.length; ++i) {
      if ( all_items[i] instanceof DropDownMenu && all_items[i].is_selected) {
        all_items[i].renderBackBuffer(pickBuffer);
      }
    }
  }

  public boolean isect(int testId) {
    boolean first_isect_found = false;

    first_isect_found = reset_button.isect(testId);

    for (int i = 0; i < all_items.length; ++i) {
      if (all_items[i] instanceof DropDownMenu && all_items[i].is_clicked) {

        if (all_items[i].isect(testId)) {
          if (!first_isect_found) {
            first_isect_found = true;
          }
          else all_items[i].is_isect = false;
        }
      }
    }

    for (int i = 0; i < all_items.length; ++i) {
      if (all_items[i] instanceof DropDownMenu && !all_items[i].is_clicked)
        if (all_items[i].isect(testId)) {
          if (!first_isect_found) {

            first_isect_found = true;
          }
          else all_items[i].is_isect = false;
        }
    }
    is_isect = first_isect_found;
    return first_isect_found;
  }

  public boolean clicked(int testId) {
    is_clicked = false;

    if (reset_button.clicked(testId)) {
      filter = "";
      index_of_filter = -1;
      reset_button.is_clicked = false;
      winner.clear();
      league.clear();
      matchup.clear();
      submission.clear();
      rating.clear();
      filtering = false;
      //      currentFilterItems.clear();

      for (int i = 0; i < all_items.length; ++i) {
        all_items[i].is_selected = false;
        all_items[i].is_clicked = false;
      }

      is_clicked = true;
    }

    for (int i = 0; i < all_items.length; ++i) {
      if ( all_items[i].clicked(testId) ) {
        is_clicked = true;
      }

      if (all_items[i] instanceof DropDownMenu)
        all_items[i].is_selected = all_items[i].is_clicked;
      else {
        all_items[i].select();
        //        int id = all_items[i].id;
        //        int index = id / BITS;
        //        int bit = id % BITS;
        if (all_items[i].is_clicked) {

          if (all_items[i].is_selected) {
            //            filters[index] = filters[index] | (1 << bit);
            if (all_items[i].group.equals("Winner")) {
              winner.add(all_items[i].getText());
            }
            if (all_items[i].group.equals("League")) {
              league.add(all_items[i].getText());
            }
            if (all_items[i].group.equals("Matchup")) {
              matchup.add(all_items[i].getText());
            }
            if (all_items[i].group.equals("Submission Type")) {
              submission.add(all_items[i].getText().equals("WCF"));
            }
            if (all_items[i].group.equals("Rating")) {
              rating.add(all_items[i].getText());
            }
            //Add protocol to the filter
            //            String protocol = all_items[i].getText();
            //            addToFilter(protocol);
          } 
          else {
            if (winner.size() > 0)
              winner.remove(all_items[i].getText());

            if (league.size() > 0)
              league.remove(all_items[i].getText());

            if (matchup.size() > 0)
              matchup.remove(all_items[i].getText());

            if (submission.size() > 0)
              submission.remove(all_items[i].getText().equals("WCF"));

            if (rating.size() > 0)
              rating.remove(all_items[i].getText());

            //            filters[index] = filters[index] & ~(1 << bit);

            //Remove protocol from the filter
            //            String protocol = all_items[i].getText();
            //            removeFromFilter(protocol);
          }
        }
      }

      if (winner.size() > 0 || league.size() > 0 || matchup.size() > 0 || submission.size() > 0 || rating.size() > 0)
        filtering = true;
      else
        filtering = false;
      //System.err.println(winner);
    }


    //index_of_filter = p.findIndexForProtocol(filter);

    //    String backup = filter;
    //
    //    for (int i = 0; i < all_items.length; ++i) {
    //      if (!(all_items[i] instanceof DropDownMenu)) {
    //        //addToFilter(all_items[i].getText());
    //        if (p.findIndexForProtocol(filter) < 0) {
    //          all_items[i].is_selectable = false;
    //        } 
    //        else {
    //          all_items[i].is_selectable = true;
    //        }
    //        filter = backup;
    //      }
    //    }

    for (int i = 0; i < all_items.length; ++i) {
      if (all_items[i] instanceof DropDownMenu) {
        ((DropDownMenu)all_items[i]).selectable();
      }
    }
    //
    //    filter = backup;
    //println(index_of_filter + ": " + filter);
    return is_clicked;
  }
  //
  //  public void addToFilter(String protocol) {
  //
  //    //Special case: first protocol to enter filter
  //    if (filter.length() == 0) {
  //      filter = protocol;
  //      return;
  //    }
  //
  //    //Make sure protocol is not in the current filter
  //    String[] protocols = filter.split("\\+");
  //    for (int j = 0; j < protocols.length; ++j) {
  //      if (protocols[j].equals(protocol)) {
  //        return;
  //      }
  //    }
  //
  //    filter = "";
  //    boolean inserted = false;
  //
  //    String[] protocolsSorted = new String[protocols.length + 1];
  //    arrayCopy(protocols, protocolsSorted);
  //    protocolsSorted[protocols.length] = protocol;
  //    protocolsSorted = sort(protocolsSorted);
  //    for (int j = 0; j < protocolsSorted.length; ++j) {
  //      filter += protocolsSorted[j];
  //      if (j < protocolsSorted.length - 1)
  //        filter += "+";
  //    }
  //
  //    //    //Insert into filter in sorted order
  //    //    for (int j = 0; j < protocols.length; ++j) {
  //    //      if (!inserted && protocols[j].compareTo(protocol) > 0) {
  //    //        filter += protocol + "+";
  //    //        inserted = true;
  //    //      }
  //    //
  //    //      filter += protocols[j];
  //    //      if (j < protocols.length - 1)
  //    //        filter += "+";
  //    //    }
  //    //
  //    //    //Add to the end of the filter if not yet inserted
  //    //    if (!inserted) {
  //    //      if (protocols.length > 0)
  //    //        filter += "+";
  //    //      filter += protocol;
  //    //    }
  //
  //  }
  //
  //
  //
  //  public void removeFromFilter(String protocol) {
  //    if (filter.contains(protocol)) {
  //      //println(filter);
  //      String[] protocols = filter.split("\\+");
  //      filter = "";
  //      int count = protocols.length - 1;
  //      for (int j = 0; j < protocols.length; ++j) {
  //        if (!protocols[j].equals(protocol)) {
  //          filter += protocols[j];
  //          count--;
  //          if (count > 0)
  //            filter += "+";
  //        }
  //      }
  //    }
  //  }
}

