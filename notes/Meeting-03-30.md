## Algorithms we are Implementing

---
### 1D 

##### Cubic spline
A spline is a piecewise function connecting a sample of datapoints. If our original data is 1000 points, we may only feed in 10-20 of those points to form the spline. There are a number of different ways to handle the endpoints of a cubic spline, we are using what is called a ***not-a-knot cubic spline***. 

##### Linear fit / Cubic fit
Find a single line/cubic function that roughly fits the data.

##### Levenberg–Marquardt
I'd recommend checking out the [wiki](https://en.wikipedia.org/wiki/Levenberg%E2%80%93Marquardt_algorithm). But my understanding is the L-M algorithm is a damped least-squares solution for non-linear equations.  

---
#### 2D
##### bicubic spline
Like a cubic spline but add another dimension. Also has different ways of handling end-points, including not-a-knot, which may be the best in order to stay consistent

##### If time permits 
- Bilinear spline?
	- Bunch of straight lines between points in 3d space

