#ifndef LINE_ITERATOR_H_
#define LINE_ITERATOR_H_

#include <float.h>
#include <math.h>
#include <stdint.h>
#include <stdlib.h>
#include <mpac_generic/types.h>


class LineIterator {
 public:
  LineIterator(double x0, double y0, double x1, double y1, double delta)
      : x0_(x0), y0_(y0), x1_(x1), y1_(y1), x_(x0), y_(y0), curstep_(0) {
    double len = hypot(x1 - x0, y1 - y0);
    numsteps_ = ceil(len / delta);

    deltax_ = delta * (x1 - x0) / len;
    deltay_ = delta * (y1 - y0) / len;
  }
  //过点的垂线
  LineIterator(bool bforward, double x, double y, double x_delta, double y_delta, double delta)
      : x0_(x), y0_(y), x1_(DBL_MAX), y1_(DBL_MAX), x_(x), y_(y), curstep_(0) {
    double len = hypot(x_delta, y_delta) * (bforward ? 1 : -1);
    numsteps_ = INT32_MAX;

    deltax_ = delta * x_delta / len;
    deltay_ = delta * y_delta / len;
  }

  bool isValid() const { return curstep_ <= numsteps_; }

  void advance() {
    curstep_++;
    x_ += deltax_;  // Change the x as appropriate
    y_ += deltay_;  // Change the y as appropriate

    if (curstep_ == numsteps_) {
      x_ = x1_;
      y_ = y1_;
    }
  }

  double getX() const { return x_; }
  double getY() const { return y_; }

  double getX0() const { return x0_; }
  double getY0() const { return y0_; }

  double getX1() const { return x1_; }
  double getY1() const { return y1_; }

 private:
  double x0_;  ///< X coordinate of first end point.
  double y0_;  ///< Y coordinate of first end point.
  double x1_;  ///< X coordinate of second end point.
  double y1_;  ///< Y coordinate of second end point.

  double x_;  ///< X coordinate of current point.
  double y_;  ///< Y coordinate of current point.

  double deltax_;  ///< Difference between Xs of endpoints.
  double deltay_;  ///< Difference between Ys of endpoints.
  int numsteps_;
  int curstep_;
};

class GridLineIterator {
 public:
  GridLineIterator(int x0, int y0, int x1, int y1)
      : x0_(x0),
        y0_(y0),
        x1_(x1),
        y1_(y1),
        x_(x0),  // X and Y start of at first endpoint.
        y_(y0),
        deltax_(abs(x1 - x0)),
        deltay_(abs(y1 - y0)),
        curpixel_(0) {
    if (x1_ >= x0_) {  // The x-values are increasing
      xinc1_ = 1;
      xinc2_ = 1;
    } else {  // The x-values are decreasing
      xinc1_ = -1;
      xinc2_ = -1;
    }

    if (y1_ >= y0_) {  // The y-values are increasing
      yinc1_ = 1;
      yinc2_ = 1;
    } else {  // The y-values are decreasing
      yinc1_ = -1;
      yinc2_ = -1;
    }

    if (deltax_ >= deltay_) {  // There is at least one x-value for every y-value
      xinc1_ = 0;              // Don't change the x when numerator >= denominator
      yinc2_ = 0;              // Don't change the y for every iteration
      den_ = deltax_;
      num_ = deltax_ / 2;
      numadd_ = deltay_;
      numpixels_ = deltax_;  // There are more x-values than y-values
    } else {                 // There is at least one y-value for every x-value
      xinc2_ = 0;            // Don't change the x for every iteration
      yinc1_ = 0;            // Don't change the y when numerator >= denominator
      den_ = deltay_;
      num_ = deltay_ / 2;
      numadd_ = deltax_;
      numpixels_ = deltay_;  // There are more y-values than x-values
    }
  }

  bool isValid() const { return curpixel_ <= numpixels_; }

  void advance() {
    num_ += numadd_;     // Increase the numerator by the top of the fraction
    if (num_ >= den_) {  // Check if numerator >= denominator
      num_ -= den_;      // Calculate the new numerator value
      x_ += xinc1_;      // Change the x as appropriate
      y_ += yinc1_;      // Change the y as appropriate
    }
    x_ += xinc2_;  // Change the x as appropriate
    y_ += yinc2_;  // Change the y as appropriate

    curpixel_++;
  }

  int getX() const { return x_; }
  int getY() const { return y_; }

  int getX0() const { return x0_; }
  int getY0() const { return y0_; }

  int getX1() const { return x1_; }
  int getY1() const { return y1_; }

 private:
  int x0_;  ///< X coordinate of first end point.
  int y0_;  ///< Y coordinate of first end point.
  int x1_;  ///< X coordinate of second end point.
  int y1_;  ///< Y coordinate of second end point.

  int x_;  ///< X coordinate of current point.
  int y_;  ///< Y coordinate of current point.

  int deltax_;  ///< Difference between Xs of endpoints.
  int deltay_;  ///< Difference between Ys of endpoints.

  int curpixel_;  ///< index of current point in line loop.

  int xinc1_, xinc2_, yinc1_, yinc2_;
  int den_, num_, numadd_, numpixels_;
};

void getLineGrids(int x0, int y0, int x1, int y1, std::vector<mpac_generic::Grid>& line_grids) {

  //std::cout<<x0<<" "<<y0<<" "<<x1<<" "<<y1<<std::endl;
  for (GridLineIterator line(x0, y0, x1, y1); line.isValid(); line.advance()) {
      mpac_generic::Grid grid;
      grid.setValue(line.getX(), line.getY());
     // printf("line point:%d %d\n",grid.x,grid.y);
      line_grids.push_back(grid);
  }
}

#endif  // LINE_ITERATOR_H_
