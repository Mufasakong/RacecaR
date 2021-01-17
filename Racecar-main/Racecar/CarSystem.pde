class CarSystem {
  //CarSystem - 
  //Her kan man lave en generisk alogoritme, der skaber en optimal "hjerne" til de forhåndenværende betingelser

  ArrayList<CarController> CarControllerList  = new ArrayList<CarController>();

  CarSystem(int populationSize) {
    for (int i=0; i<populationSize; i++) { 
      CarController controller = new CarController();
      CarControllerList.add(controller);
    }
  }

  void updateAndDisplay() {
    //1.) Opdaterer sensorer og bilpositioner
    for (CarController controller : CarControllerList) {
      controller.update();
    }

    //2.) Tegner tilsidst - så sensorer kun ser banen og ikke andre biler!
    for (CarController controller : CarControllerList) {
      controller.display();
    }
  }

  void Algoritme() {
    float sum = 0;
    ArrayList<CarController> parents = new ArrayList<CarController>();
    ArrayList<CarController> children  = new ArrayList<CarController>();

    for (int i = 0; i>CarControllerList.size(); i++) {
      sum+=CarControllerList.get(i).sensorSystem.fitness;
    }
    
    while (children.size()+CarControllerList.size()<101) {
      while (parents.size()<3)
        for (int i = 0; i < CarControllerList.size(); i++) {
          if (random(sum)<CarControllerList.get(i).sensorSystem.fitness && parents.size()<3) {
            parents.add(CarControllerList.get(i));
          }
        }
      children.add(new CarController());
      for (int i =0; i<8; i++) {
        if (parents.get(0).hjerne.weights[i] < parents.get(1).hjerne.weights[i])
          children.get(children.size()-1).hjerne.weights[i]=random(parents.get(0).hjerne.weights[i], parents.get(1).hjerne.weights[i]);
        if (parents.get(1).hjerne.weights[i]<parents.get(0).hjerne.weights[i])
          children.get(children.size()-1).hjerne.weights[i]=random(parents.get(1).hjerne.weights[i], parents.get(0).hjerne.weights[i]);
        if (parents.get(0).hjerne.weights[i]==parents.get(1).hjerne.weights[i])
          children.get(children.size()-1).hjerne.weights[i]=parents.get(0).hjerne.weights[i];
        if (random(1)<mutationRate)
          children.get(children.size()-1).hjerne.weights[i]=random(-children.get(children.size()-1).varians, children.get(children.size()-1).varians);
      }

      for (int i =0; i<3; i++) {
        if (parents.get(0).hjerne.biases[i]<parents.get(1).hjerne.biases[i])
          children.get(children.size()-1).hjerne.biases[i]=random(parents.get(0).hjerne.biases[i], parents.get(1).hjerne.biases[i]);
        if (parents.get(1).hjerne.biases[i]<parents.get(0).hjerne.biases[i])
          children.get(children.size()-1).hjerne.biases[i]=random(parents.get(1).hjerne.biases[i], parents.get(0).hjerne.biases[i]);
        if (parents.get(0).hjerne.biases[i]==parents.get(1).hjerne.biases[i])
          children.get(children.size()-1).hjerne.biases[i]=parents.get(0).hjerne.biases[i];
        if (random(1)<mutationRate)
          children.get(children.size()-1).hjerne.biases[i]=random(-children.get(children.size()-1).varians, children.get(children.size()-1).varians);
      }
    }
    for (int i = 0; i<CarControllerList.size(); i++) {
      children.add(CarControllerList.get(i));
    }
    CarControllerList.clear();
    for (int i = 0; i<children.size(); i++) {
      CarControllerList.add(children.get(i));
    }
    for (int i = 0; i<CarControllerList.size(); i++) {
      CarControllerList.get(i).sensorSystem.fitness=0;
      CarControllerList.get(i).sensorSystem.whiteSensorFrameCount=0;
      CarControllerList.get(i).sensorSystem.lapTimeInFrames=500;
      CarControllerList.get(i).sensorSystem.time=0;
      CarControllerList.get(i).sensorSystem.clockWiseRotationFrameCounter = 0;
      CarControllerList.get(i).bil.pos = new PVector(60, 232);
    }
  }
}
