/*
 * DropDownMenu - Creates a drop down menu of selectable menu items.
 *              - Extends MenuItem for reusability of code
 * (c)2013
 *
 */

public class DropDownMenu extends MenuItem {
  public MenuItem[] items;

  public DropDownMenu(int id, float centerX, float centerY, float rectWidth, float rectHeight, color c1, String t1, MenuItem[] items) {
    super(id, centerX, centerY, rectWidth, rectHeight, c1, t1, t1);
    this.items = items;
  }

  public boolean isect(int testId) {
    //If menu is clicked, then look at the individual items
    if (is_clicked) {
      is_isect = false;
      boolean child_isect = false;
      for (int i = 0; i < items.length; ++i) {
        if (items[i].isect(testId)) {
          child_isect = true;
        }
      }
      return child_isect;
    } 
    else {
      is_isect = testId == id;
      return is_isect;
    }
  }

  public boolean clicked(int testId) {
    //If menu is clicked, then look at the individual items
    if (is_clicked) {
      is_isect = false;
      is_clicked = false;
      for (int i = 0; i < items.length; ++i) {
        if (items[i].clicked(testId)) {
          //is_isect = true;
          is_clicked = true;
        }
      }
      return false;
    } 
    else {
      is_isect = testId == id;
      is_clicked = false;
      if (is_isect)
        is_clicked = true;
      return is_clicked;
    }
  }

  //Flips whether we can select this menu or not
  public void selectable() {
    boolean children_selectable = false;
    for (int i = 0; i < items.length; ++i) {
      if (items[i].is_selectable) {
        children_selectable = true;
      }
    }

    is_selectable = children_selectable;
  }

  public void render() {
    //render box
    if (is_clicked) {
      //if clicked, render the menu items
      for (int i = 0; i < items.length; ++i) {
        items[i].render();
      }
    } 
    else {
      super.render();
    }
  }

  public void renderBackBuffer(PGraphics pickBuffer) {
    //render box

    if (is_clicked) {
      //if clicked, render the menu items
      for (int i = 0; i < items.length; ++i) {
        items[i].renderBackBuffer(pickBuffer);
      }
    } 
    else {
      super.renderBackBuffer(pickBuffer);
    }
  }
}

