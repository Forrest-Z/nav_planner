#pragma once

#include <mpac_geometry/polygon.h>
#include <mpac_generic/serialization.h>

namespace boost {
  namespace serialization {
    class access;
    // --------------------------------- Polygon ----------------------------
    template<typename Archive>
      void serialize(Archive& ar, mpac_geometry::Polygon& p, const unsigned version) {
      ar & p.points;
    }
    /* template<typename Archive> */
    /*   void save(Archive& ar, const mpac_geometry::Polygon& obj, const unsigned version) { */
    /*   ar << obj.points; */
    /* } */
    
    /* template<typename Archive> */
    /*   void load(Archive& ar, mpac_geometry::Polygon& obj, const unsigned version) { */
    /*   ar >> obj.points; */
    /* } */
  }
}


