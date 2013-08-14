/*
 * MenuItem - Displays a part of the menu for a single item
 *            Allows highlighting, clicking, and can be set to unclickable.
 *
 * (c)2013
 */

public class MenuItem {

  protected float centerX, centerY;
  protected float rectWidth, rectHeight;
  protected color menu_color;
  protected String item_name;
  String group;
  public boolean is_isect;
  public boolean is_clicked, is_selected;
  public boolean is_selectable; 
  public int id;
  
  public final color HIGHLIGHT_COLOR = color(0, 180, 240);
  public final color SELECTED_COLOR = color(200, 0, 50);
  public final color NON_SELECT_COLOR = color(110);
  public final float SHADOW_PADDING = 5;

  public MenuItem(int id, float centerX, float centerY, float rectWidth, float rectHeight, color menu_color, String item_name, String group) {
    setCenterPos(centerX, centerY);
    setDimensions(rectWidth, rectHeight);
    setColor(menu_color);
    setText(item_name);

    this.id = id;  
    is_isect = false;
    is_clicked = false;
    is_selected = false;
    is_selectable = true;
    
    this.group = group;
  }

  public void setCenterPos(float x, float y) {
    centerX = x;
    centerY = y;
  }

  public void setDimensions(float w, float h) {
    rectWidth = w;
    rectHeight = h;
  }

  public void setColor(color c) {
    menu_color = c;
  }

  public void setText(String t) {
    item_name = t;
  }

  public float getCenterX() {
    return centerX;
  }

  public float getCenterY() {
    return centerY;
  }

  public float getWidth() {
    return rectWidth;
  }

  public float getHeight() {
    return rectHeight;
  }

  public color getColor() {
    return menu_color;
  }

  public String getText() {
    return item_name;
  }

  public boolean isect(int testId) {
    is_isect = testId == id;
    return is_isect;
  }

  //only called by Intersection Controller when mouse is pressed
  public boolean clicked(int testId) {
    is_clicked = isect(testId);
    return is_clicked;
  }

  public void select() {
    if (is_clicked && is_selectable)
      is_selected = !is_selected;
  }

  //Draw a button filled with menu_color centered at (centerX, centerY)
  //with text item_name displayed above it. 
  public void render() {
    float posX = centerX - (rectWidth/2);
    float posY = centerY - (rectHeight/2);

    if (!(this instanceof DropDownMenu)) {
      stroke(0, 128);
      fill(0, 128);
      rect(posX + SHADOW_PADDING, posY + SHADOW_PADDING, rectWidth, rectHeight);
      
    }

    stroke(0);
    if (!is_selectable) fill (NON_SELECT_COLOR);
    else if (is_selected) fill(SELECTED_COLOR);
    else if (is_isect) fill (HIGHLIGHT_COLOR);
    else fill(menu_color);

    rect(posX, posY, rectWidth, rectHeight);

    fill(0);
    textAlign(CENTER, CENTER);
    text(item_name, centerX, centerY);
  }

  public void renderBackBuffer(PGraphics pickBuffer) {
    float posX = centerX - (rectWidth/2);
    float posY = centerY - (rectHeight/2);

    //highlight if selected
    pickBuffer.stroke(red(id), green(id), blue(id));
    pickBuffer.fill(red(id), green(id), blue(id));

    pickBuffer.rect(posX, posY, rectWidth, rectHeight);
    pickBuffer.noStroke();
  }
}

