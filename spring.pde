class Spring {
  Particle p0;
  Particle p1;
  float restLength;
  float k = 0.5;
  
  Spring(Particle p0, Particle p1, float restLength) {
    this.p0 = p0;
    this.p1 = p1;
    this.restLength = restLength;
  }
  
  void update() {
    PVector force = PVector.sub(p1.position, p0.position);
    float x = force.mag() - restLength;
    force.normalize();
    force.mult(k * x);
    p0.applyForce(force);
    force.mult(-1);
    p1.applyForce(force);
  }
  
  void draw() {
    noFill();
    stroke(0, 0, 255, 100);
    strokeWeight(2);
    line(p0.position.x, p0.position.y, p1.position.x, p1.position.y);
  }
}
