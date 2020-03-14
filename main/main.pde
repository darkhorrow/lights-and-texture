PImage BACKGROUND_IMAGE;

color MORNING_COLOR = color(255, 144, 33);
color NIGHT_COLOR   = color(0, 5, 43);

float interpolation = 0;
float INTERPOLATION_STEP = 0.001;

boolean isMorning = true;

float translationAngle = 0;


void setup() {
  size(1024, 768, P3D);
  BACKGROUND_IMAGE = loadImage("bg.jpg");
  BACKGROUND_IMAGE.resize(width, height);
}

void draw() {
  color backgroundColor;

  if (isMorning) {
    backgroundColor = lerpColor(MORNING_COLOR, NIGHT_COLOR, interpolation);
    interpolation += INTERPOLATION_STEP;
    translationAngle += 0.5;
  } else {
    backgroundColor = lerpColor(NIGHT_COLOR, MORNING_COLOR, interpolation);
    interpolation += INTERPOLATION_STEP;
  }

  ambientLight(red(backgroundColor), green(backgroundColor), blue(backgroundColor));
  background(backgroundColor);
  tint(backgroundColor);
  image(BACKGROUND_IMAGE, 0, 0);
  
  translate(width/2, height/2 + 100, -500);
  translate((-width/2 -500 + 200) * cos(radians(translationAngle)), (-width/2 -500 + 200) * sin(radians(translationAngle)), 0);
  sphere(100);

  if (isMorning && interpolation > 1) {
    isMorning = false;
    interpolation = 0;
  } else if (!isMorning && interpolation > 1) {
    isMorning = true;
    interpolation = 0;
  }
}
