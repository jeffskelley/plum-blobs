//float numChains = 0;
float numChains = pow(7, 2); // should always be a power of 2
int particlesPerChain = 25;
float restLength = 25.0;
float lastTime = 0;

ArrayList<Chain> chains;
ArrayList<Particle> allParticles;
PShape logo;

//ArrayList<Particle> logoParticles;

void setup() {
  size(1000, 1000);
  //logoParticles = new ArrayList<Particle>();
  chains = new ArrayList<Chain>();
  allParticles = new ArrayList<Particle>();
  
  // initialize logo
  logo = loadShape("img/plum-logo.svg");
  
  // initialize logo particles
  JSONArray particlesData = loadJSONArray("data/logo.json");
  for (int i = 0; i < particlesData.size(); i++) {
    JSONObject particleData = particlesData.getJSONObject(i);
    float x = particleData.getFloat("x");
    float y = particleData.getFloat("y");
    Particle p = new Particle(x, y);
    p.fixed = true;
    allParticles.add(p);
  }

  // initialize chains
  float rows = sqrt(numChains);
  
  float circumference = particlesPerChain * restLength;
  float diameter = circumference / PI;
  float chainsPerRow = sqrt(numChains);
  float w = diameter * chainsPerRow + (chainsPerRow - 1) * restLength;
  float h = diameter * chainsPerRow + (chainsPerRow - 1) * restLength;
  
  for (int i = 0; i < numChains; i++) {
    float x = (i % rows) / (rows - 1) * w - ((w - width) / 2);
    float y = floor(i / rows) / (rows - 1) * h - ((h - height) / 2);
    
    // kill the middle 4 -- not dynamic rn
    if (i != 14 && i != 15 && i != 20 && i != 21) {
       chains.add(new Chain(x, y, particlesPerChain, restLength)); 
    }
  }
  
  // get references to all particles
  for (int i = 0; i < chains.size(); i++) {
    allParticles.addAll(chains.get(i).particles);
  }
}

void draw() {
  //float currentTime = millis();
  //System.out.println(currentTime - lastTime);
  //lastTime = currentTime;
  
  background(25);
  for (int i = 0; i < chains.size(); i++) {
    Chain c = chains.get(i);
    c.update(allParticles);
    c.draw();
  }
  
  push();
  translate((width - logo.width)/2, (height - logo.height)/2);
  shape(logo, 0, 0);
  pop();
  
  //for (int i = 0; i < logoParticles.size(); i++) {
  //  logoParticles.get(i).draw();
  //}
}


//void mouseClicked() {
//  Particle p = new Particle(mouseX, mouseY);
//  p.fixed = true;
//  logoParticles.add(p);
//}

//void keyTyped() {
//  if (key == ' ') {
//    JSONArray values = new JSONArray();
    
//    for (int i = 0; i < logoParticles.size(); i++) {
//      Particle p = logoParticles.get(i);
//      JSONObject pos = new JSONObject();
//      pos.setFloat("x", p.position.x);
//      pos.setFloat("y", p.position.y);
//      values.setJSONObject(i, pos);
//    }
    
//    saveJSONArray(values, "data/logo.json");
//  }
//}

//void mouseClicked() {
//  saveFrame();
//}
