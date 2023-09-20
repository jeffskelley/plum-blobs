float repelDistance = 20.0; 

class Chain {
  ArrayList<Spring> springs;
  ArrayList<Particle> particles;
  color chainColor;
  
  Chain(float x, float y, int particlesPerChain, float restLength) {
    particles = new ArrayList<Particle>();
    springs = new ArrayList<Spring>();
    chainColor = color(random(100, 255), random(100, 200), random(200, 255));
    
    float circumference = particlesPerChain * restLength;
    float radius = circumference / (2 * PI);
    
    // add particles
    for (int i = 0; i < particlesPerChain; i++) {
      float a = (TWO_PI / particlesPerChain) * i;
      float px = x + radius * cos(a);
      float py = y + radius * sin(a);
      particles.add(new Particle(px, py));
    }
    
    // add springs
    for (int i = 0; i < particles.size(); i++) {
      Particle p0 = particles.get(i);
      Particle p1 = particles.get(i < particles.size() - 1 ? i + 1 : 0);
      springs.add(new Spring(p0, p1, restLength));
    }
  }
  
  void update(ArrayList<Particle> allParticles) {
    for (int i = 0; i < springs.size(); i++) {
      // add spring forces
      springs.get(i).update();
    }
    
    for (int i = 0; i < particles.size(); i++) {
      Particle p = particles.get(i);
      
      // add gravity
      PVector gravity = PVector.sub(new PVector(width / 2, height / 2), p.position);
      gravity.normalize();
      gravity.mult(0.01);
      p.applyForce(gravity);
      
      // add particle separation
      for (int j = 0; j < allParticles.size(); j++) {
        Particle p1 = allParticles.get(j);
        float d = dist(p.position.x, p.position.y, p1.position.x, p1.position.y);
        if (p != p1 && d <= repelDistance) {
          PVector force = PVector.sub(p.position, p1.position);
          force.normalize();
          force.mult(1 / d * 10);
          p.applyForce(force);
        }
      }
      
      p.update();
    }
  }
  
  void draw() {   
    //fill(chainColor);
    noFill();
    stroke(chainColor);
    strokeWeight(3);
    //noStroke();
      
    beginShape();
    Particle first = particles.get(0);
    Particle second = particles.get(1);
    Particle last = particles.get(particles.size() - 1);
    
    curveVertex(last.position.x, last.position.y);
    
    for (int i = 0; i < this.particles.size(); i++) {
      Particle p = this.particles.get(i);
      curveVertex(p.position.x, p.position.y);
    }
    
    curveVertex(first.position.x, first.position.y);
    curveVertex(second.position.x, second.position.y);
    endShape();
    
    
    // for debugging
    //for (int i = 0; i < springs.size(); i++) {
    //  springs.get(i).draw();  
    //}
    //for (int i = 0; i < particles.size(); i++) {
    //  particles.get(i).draw();
    //}
  }
}
