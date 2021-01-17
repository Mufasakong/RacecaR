//populationSize: Hvor mange "controllere" der genereres, controller = bil & hjerne & sensorer
int       populationSize  = 100;     
int gen = 0;
float mutationRate = random(0.2);
int bestLapTime;

//CarSystem: Indholder en population af "controllere" 
CarSystem carSystem       = new CarSystem(populationSize);

//trackImage: RacerBanen , Vejen=sort, Udenfor=hvid, Målstreg= 100%grøn 
PImage    trackImage;

void setup() {
  size(1000, 600);
  trackImage = loadImage("track.png");
  trackImage.resize(491,439);
}

void draw() {
  clear();
  background(255);
  image(trackImage, 0, 80);  
  fill(0, 0, 150);
  textSize(25);
  text("Generation:" + gen + "\nBest lap time: " + bestLapTime + "\nMutations Rate: " + mutationRate, 500, 50);
  fill(255);
  carSystem.updateAndDisplay();

  //TESTKODE: Frastortering af dårlige biler, for hver gang der går 500 frame - f.eks. dem der kører uden for banen
  if (frameCount%500 == 0) {
    gen++;
    mutationRate = random(0.2);
    for (int i = 0; i < carSystem.CarControllerList.size(); i++) {
      carSystem.CarControllerList.get(i).sensorSystem.updateFitness();
    }
    for (int i= 0; i < carSystem.CarControllerList.size(); i++) {
      float top = 0;
      float top2nd = 0;
      for (int j = 0; j < carSystem.CarControllerList.size(); j++) {
        if (carSystem.CarControllerList.get(j).sensorSystem.fitness > carSystem.CarControllerList.get((int)top).sensorSystem.fitness)
          top = j;
      }

      for (int j= 0; j < carSystem.CarControllerList.size(); j++) {
        if (carSystem.CarControllerList.get(j).sensorSystem.fitness < carSystem.CarControllerList.get((int)top).sensorSystem.fitness && carSystem.CarControllerList.get(j).sensorSystem.fitness > carSystem.CarControllerList.get((int)top2nd).sensorSystem.fitness)
          top2nd = j;
      }

      if (carSystem.CarControllerList.get(i).sensorSystem.fitness<=carSystem.CarControllerList.get((int)top2nd).sensorSystem.fitness / 10) {
        carSystem.CarControllerList.remove(i);
        i--;
      }
    }
    while (carSystem.CarControllerList.size() > 50) {
      int rest = 0;
      for (int j = 0; j < carSystem.CarControllerList.size(); j++) {
        if (carSystem.CarControllerList.get(j).sensorSystem.fitness < carSystem.CarControllerList.get(rest).sensorSystem.fitness) {
          rest = j;
        }
      }
      carSystem.CarControllerList.remove(rest);
    }
    int bestLapPlace = 0;
    for (int j =0; j < carSystem.CarControllerList.size(); j++) {
      if (carSystem.CarControllerList.get(j).sensorSystem.lapTimeInFrames < carSystem.CarControllerList.get((int)bestLapPlace).sensorSystem.lapTimeInFrames && carSystem.CarControllerList.get(j).sensorSystem.lapTimeInFrames>120 && carSystem.CarControllerList.get(j).sensorSystem.whiteSensorFrameCount == 0 && carSystem.CarControllerList.get(j).sensorSystem.clockWiseRotationFrameCounter > 0) {
        bestLapPlace = j;
        bestLapTime = carSystem.CarControllerList.get(j).sensorSystem.lapTimeInFrames;
      }
    }
    carSystem.Algoritme();
  }
}
