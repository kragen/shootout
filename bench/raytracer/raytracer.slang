#!/usr/bin/env slsh

#ifnexists DOUBLE_EPSILON
variable DOUBLE_EPSILON = 2.22045e-16;
#endif
private variable delta = sqrt (DOUBLE_EPSILON);
#ifnexists _Inf
variable _Inf = -log(0);
#endif
private variable INFINITY = _Inf;

typedef struct { x,y,z } Vec;
private define vector (x,y,z) { variable v=@Vec; v.x=x; v.y=y; v.z=z; return v;}
private define dot (a,b) { return a.x*b.x + a.y*b.y + a.z*b.z; }
private define add (a,b) { return vector (a.x+b.x, a.y+b.y, a.z+b.z);}
private define sub (a,b) { return vector (a.x-b.x, a.y-b.y, a.z-b.z);}
private define scale (a,v) { return vector (a*v.x, a*v.y, a*v.z); }
private define unitise (a) { return scale(1.0 / sqrt(dot(a, a)), a); }
private define filter_vector (v, i) { return vector (v.x[i], v.y[i], v.z[i]); }
private define replicate_vector (n,v)
{
   return vector (Double_Type[n]+v.x,Double_Type[n]+v.y,Double_Type[n]+v.z);
}

typedef struct {orig, dir} Ray_Type;
private define ray (o, d) 
{ 
   variable r = @Ray_Type; r.orig = o; r.dir = d; return r; 
}
private define filter_rays (r, i)
{
   return ray (filter_vector (r.orig, i), filter_vector (r.dir, i));
}

private variable SphereTag = 1;
private variable GroupTag = 2;
typedef struct { center, radius } Sphere_Type;
private define sphere (c, r) 
{
   variable s = @Sphere_Type;s.center = c; s.radius = r; return s;
}

typedef struct { bound, child } Group_Type;
typedef struct { tag, data } Scene_Type;

private define ray_sphere (r, s)
{
   variable v = sub(s.center, r.orig);
   variable b = dot (v, r.dir);
   variable disc = b*b - dot (v,v) + s.radius*s.radius;
   
   variable d = sqrt (disc);
   variable t2 = b + d;
   variable t1 = b - d;
   variable i = where (t1>0.0);
   t2[i] = t1[i];
   t2[where ((disc < 0.0) or (t2 < 0.0))] = INFINITY;
   return t2;
}

private define intersect ();
private define intersect (lambda, normal, r, scene)
{
   variable l, i, j, n;
   EXIT_BLOCK
     {
	lambda[j] = l;
	normal.x[j] = n.x; normal.y[j] = n.y; normal.z[j] = n.z;
     }

   if (scene.tag == SphereTag)
     {
	variable s = scene.data;
	l = ray_sphere (r, s);
	j = where (l < lambda);	r = filter_rays (r, j);	l = l[j];
	n = unitise (add(r.orig, sub (scale (l,r.dir), s.center)));
	return;
     }

   variable g = scene.data;
   l = ray_sphere (r, g.bound);
   j = where (l < lambda);  
   r = filter_rays(r, j); n = filter_vector (normal,j); l = lambda[j];
   foreach (g.child) {g=(); intersect (l, n, r, g);}
}

private define ray_trace (n, light, r, scene)
{
   variable lambda = Double_Type[n]; lambda[*] = INFINITY;
   variable normal = vector(Double_Type[n],Double_Type[n],Double_Type[n]);
   intersect (lambda, normal, r, scene);
   variable g = Double_Type[n], g1 = dot (normal, light);
   variable i = where ((lambda != INFINITY) and (g1 > 0.0));
   g[i] = g1[i];  normal = filter_vector (normal, i); lambda = lambda[i];
   r = filter_rays (r, i);

   variable r2 = ray (add(r.orig,scale(lambda,add(r.dir,scale(delta,normal)))),
		      replicate_vector(length(i),light));
   lambda[*] = INFINITY;
   intersect(lambda, normal, r2, scene);
   g[i[where (lambda != INFINITY)]] = 0;
   return g;
}

private define create ();
private define create (level, r, x, y, z)
{
   variable scene = @Scene_Type;
   if (level == 1)
     {
	scene.tag = SphereTag;
	scene.data = sphere(vector(x, y, z), r);
	return scene;
     }
   
   variable g = @Group_Type;
   scene.tag = GroupTag;
   scene.data = g;
   g.bound = sphere(vector(x, y, z), 3*r);
   variable n = 5;
   variable cs = Scene_Type[n];
   g.child = cs;
   variable  rn = 3*r/sqrt(12.0);
   _for (0, n-2, 1)
     {
	variable i = ();
	cs[i] = create (level-1, r/2.0, 
			x - ((i&1)*2-1)*rn, y + rn, z - ((i/2)*2-1)*rn);
     }
    cs[n-1] = create(1, r, x, y, z);
   return scene;
}

define slsh_main ()
{
   variable n = 256;
   if (__argc > 1) n = integer (__argv[1]);
   variable level = 6, ss=4, n2 = n*n, i;
   variable light = sub(vector(0.0,0.0,0.0),unitise(vector(-1.0, -3.0, 2.0)));
   variable scene = create(level, 1, 0, -1, 0);
   variable x0 = Double_Type[n,n], y0 = Double_Type[n,n], z0 = Double_Type[n,n];
   _for (0, n-1, 1) { i=(); x0[i,*] = [0:n-1]; y0[*,i] = [n-1:0:-1]; }
   reshape (x0, [n2]); reshape (y0, [n2]); reshape (z0, [n2]);
   z0[*] = n;

   variable g = 0.0, dx, dy;
   variable orig = replicate_vector (n2,vector(0.0,0.0,-4.0));
   for (dx=0; dx<ss; ++dx)
     {
        for (dy=0; dy<ss; ++dy) 
	  {
	     variable d = vector (x0 + (dx/double(ss)-0.5*n),
				  y0 + (dy/double(ss)-0.5*n), z0);
	     g += ray_trace (n2, light, ray(orig, unitise(d)), scene);
	  }
    }
   reshape (g, [n,n]);
   ()=printf("P5\n%d %d\n255\n", n, n);
   () = fwrite (typecast (0.5 + (255.0/(ss*ss))*g, UChar_Type), stdout);
}
