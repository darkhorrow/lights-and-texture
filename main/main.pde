QueasyCam cam;

PImage BACKGROUND_IMAGE;

color MORNING_COLOR = color(255, 144, 33);
color NIGHT_COLOR   = color(0, 5, 43);

float interpolation = 0;
float INTERPOLATION_STEP = 0.001;

PShape SUN;

PShape TERRAIN;
PShape TABLE;
PShape BED;

boolean isMorning = false;

float translationAngle = 0;

float rotation = 0;

void setup() {
  fullScreen(P3D);
  BACKGROUND_IMAGE = loadImage("bg.jpg");
  BACKGROUND_IMAGE.resize(width, height);
  TERRAIN = loadShape("medieval_house.obj");
  TABLE = loadShape("table.obj");
  BED = loadShape("cama.obj");
  TERRAIN.rotateX(PI);
  TABLE.rotateX(PI);
  BED.rotateX(PI);
  TABLE.scale(0.0125);
  BED.scale(2);
  SUN = createShape(SPHERE, 5);
  SUN.setTexture(loadImage("sun.jpg"));
  SUN.setStroke(false);
  cam = new QueasyCam(this);
  cam.position = new PVector(width/2, height/2 - 3, 650);
  cam.controllable = false;
}

void draw() {
  color backgroundColor;

  if (isMorning) {
    backgroundColor = lerpColor(MORNING_COLOR, NIGHT_COLOR, interpolation);
    interpolation += INTERPOLATION_STEP;
  } else {
    backgroundColor = lerpColor(NIGHT_COLOR, MORNING_COLOR, interpolation);
    interpolation += INTERPOLATION_STEP;
  }
  
  translationAngle += 0.085;

  ambientLight(red(backgroundColor), green(backgroundColor), blue(backgroundColor));
  background(backgroundColor);
  tint(backgroundColor);
  
  pushMatrix();
  translate(0, 0, 400);
  image(BACKGROUND_IMAGE, 0, 0);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2, 410);
  float positionX = -110 * cos(radians(translationAngle));
  float positionY = -110 * sin(radians(translationAngle));
  translate(positionX, positionY);
  shape(SUN);
  pointLight(red(backgroundColor), green(backgroundColor), blue(backgroundColor), positionX, positionY, 0);
  popMatrix();
  
  translate(width/2, height/2, 652);
  
  pushMatrix();
  shape(TERRAIN);
  translate(3, -1.5, 0);
  shape(TABLE);
  popMatrix();
  
  pushMatrix();
  translate(-4.5, 0, 0);
  shape(BED);
  popMatrix();

  if (isMorning && interpolation > 1) {
    isMorning = false;
    interpolation = 0;
    translationAngle = 0;
  } else if (!isMorning && interpolation > 1) {
    isMorning = true;
    interpolation = 0;
  }
}
