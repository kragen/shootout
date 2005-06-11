// The Great Computer Language Shootout
// http://shootout.alioth.debian.org/
// contributed by Jon Harrop, 2005 
// Compile: g++ -Wall -O3 -ffast-math ray.cpp -o ray

#include <vector>
#include <iostream>
#include <limits>
#include <cmath>

using namespace std;

numeric_limits<double> dbl;
double delta = sqrt(dbl.epsilon()), infinity = dbl.infinity(), pi = M_PI;

struct Vec { // 3D vector
  double x, y, z;
  Vec(double x2, double y2, double z2) : x(x2), y(y2), z(z2) {}
};
Vec operator+(const Vec &a, const Vec &b)
{ return Vec(a.x + b.x, a.y + b.y, a.z + b.z); }
Vec operator-(const Vec &a, const Vec &b)
{ return Vec(a.x - b.x, a.y - b.y, a.z - b.z); }
Vec operator*(double a, const Vec &b) { return Vec(a * b.x, a * b.y, a * b.z); }
double dot(const Vec &a, const Vec &b) { return a.x*b.x + a.y*b.y + a.z*b.z; }
Vec unitise(const Vec &a) { return (1 / sqrt(dot(a, a))) * a; }

struct Ray { Vec orig, dir; Ray(Vec o, Vec d) : orig(o), dir(d) {} };

struct Scene { // Abstract base class representing a scene
  virtual void intersect(double &, Vec &, const Ray &) const = 0;
  virtual void del() {};
};

struct Sphere : public Scene { // Derived class representing a sphere
  Vec center;
  double radius;

  Sphere(Vec c, double r) : center(c), radius(r) {}

  double ray_sphere(const Ray &ray) const {
    Vec v = center - ray.orig;
    double b = dot(v, ray.dir), disc = b*b - dot(v, v) + radius * radius;
    if (disc < 0) return infinity;
    double d = sqrt(disc), t2 = b + d;
    if (t2 < 0) return infinity;
    double t1 = b - d;
    return (t1 > 0 ? t1 : t2);
  }

  void intersect(double &lambda, Vec &normal, const Ray &ray) const {
    double l = ray_sphere(ray);
    if (l >= lambda) return;
    lambda = l;
    normal = unitise(ray.orig + l * ray.dir - center);
  }
};

struct Group : public Scene { // Derived class representing a group of scenes
  Sphere bound;
  vector<Scene *> objs;

  Group(Sphere b) : bound(b), objs(0) {}
  virtual ~Group() {}

  void del() {
    for (vector<Scene *>::iterator it=objs.begin(); it!=objs.end(); ++it)
      delete *it;
  }

  void intersect(double &lambda, Vec &normal, const Ray &ray) const {
    double l = bound.ray_sphere(ray);
    if (l >= lambda) return;
    for (vector<Scene *>::const_iterator it=objs.begin(); it!=objs.end(); ++it)
      (*it)->intersect(lambda, normal, ray);
  }
};

double ray_trace(Vec light, const Ray &ray, const Scene *scene) {
  double lambda = infinity;
  Vec normal(0, 0, 0);
  scene->intersect(lambda, normal, ray);
  if (lambda == infinity) return 0;
  Vec o = ray.orig + lambda * ray.dir + delta * normal;
  double g = -dot(normal, light), l = infinity;
  if (g <= 0) return 0.;
  scene->intersect(l, normal, Ray(o, Vec(0, 0, 0) - light));
  return (l == infinity ? g : 0);
}

Scene *create(int level, double r, double x, double y, double z) {
  Sphere *sphere = new Sphere(Vec(x, y, z), r);
  if (level == 1) return sphere;
  Group group = Group(Sphere(Vec(x, y, z), 3*r));
  group.objs.push_back(sphere);
  double rn = 3*r/sqrt(12.);
  for (int dz=-1; dz<=1; dz+=2)
    for (int dx=-1; dx<=1; dx+=2)
      group.objs.push_back(create(level-1, r/2, x - dx*rn, y + rn, z - dz*rn));
  return (new Group(group));
}

int main(int argc, char *argv[]) {
  int level = 6, n = (argc==2 ? atoi(argv[1]) : 256), ss = 4;
  Scene *scene=create(level, 1, 0, -1, 0); // Build the scene

  cout << "P5\n" << n << " " << n << "\n255\n";
  for (int y=n-1; y>=0; --y)
    for (int x=0; x<n; ++x) {
      double g=0;
      for (int dx=0; dx<ss; ++dx)
	for (int dy=0; dy<ss; ++dy) {
	  Vec d(x+double(dx)/ss-n/2., y+double(dy)/ss-n/2., n);
	  g += ray_trace(unitise(Vec(-1, -3, 2)), Ray(Vec(0, 0, -4),
						      unitise(d)), scene);
	}
      cout << char(.5+255*g/(ss*ss));
    }

  scene->del(); // Deallocate the scene

  return 0;
}
