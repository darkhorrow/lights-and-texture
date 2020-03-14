PImage BACKGROUND_IMAGE;

color MORNING_COLOR = color(255, 144, 33);
color NIGHT_COLOR   = color(0, 5, 43);

float interpolation = 0;
float INTERPOLATION_STEP = 0.001;

PShape SUN;

boolean isMorning = false;

float translationAngle = 0;


void setup() {
  size(768, 768, P3D);
  BACKGROUND_IMAGE = loadImage("bg.jpg");
  BACKGROUND_IMAGE.resize(width, height);
  SUN = createShape(SPHERE, 20);
  SUN.setTexture(loadImage("sun.jpg"));
  SUN.setStroke(false);
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
  
  translationAngle += 0.1;

  ambientLight(red(backgroundColor), green(backgroundColor), blue(backgroundColor));
  background(backgroundColor);
  tint(backgroundColor);
  image(BACKGROUND_IMAGE, 0, 0);
  
  pushMatrix();
  translate(width/2, height/2, 0);
  float positionX = (-width/2) * cos(radians(translationAngle));
  float positionY = (-width/2) * sin(radians(translationAngle));
  translate(positionX, positionY);
  shape(SUN);
  pointLight(red(backgroundColor), green(backgroundColor), blue(backgroundColor), positionX, positionY, 0);
  popMatrix();
  
  pushMatrix();
  translate(width/2, height/2, 0);
  rotateY(translationAngle);
  box(100);
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
