class Particle {
  PVector position;
  PVector velocity;
  PVector acceleration;
  float maxspeed = 0.5;
  boolean fixed = false;
  
  Particle(float x, float y) {
    position = new PVector(x, y);
    velocity = new PVector(0, 0);
    acceleration = new PVector(0, 0);
  }
  
  void applyForce(PVector force) {
    if (!fixed) {
      acceleration.add(force.mult(0.9));
    }
  }
  
  void update() {
    velocity.add(acceleration);
    velocity.limit(maxspeed);
    position.add(velocity);
    acceleration.mult(0);
  }
  
  void draw() {
    noStroke();
    fill(0, 0, 255);
    circle(position.x, position.y, 5);
  }
}
