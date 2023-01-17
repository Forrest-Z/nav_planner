# Defines a shape message
# A shape can be either a Circle or a Polygon
# For a Circle, the first point represents the centre and 
# the x on the second represents the radius
# For a Polygon, all the points are points in the polygon

int32 CIRCLE = 0
int32 POLYGON = 1

int32 type
int32 parameter  #禁行:缺省　单行区:0~8　限速区: y=(int)(x*100)
geometry_msgs/Point[] points 