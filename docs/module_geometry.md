# Geometry

A collection of geometry-based math functions used for spatial calculations in both 2D and 3D.

## Shared Functions

### distance_2d

Calculates the distance between two 2D points.

#### Params

* `p1` (table): The first point `{ x, y }`.
* `p2` (table): The second point `{ x, y }`.

#### Returns

* `number`: The Euclidean distance.

```lua
geometry.distance_2d({x=0,y=0}, {x=10,y=10})
```

---

### distance_3d

Calculates the distance between two 3D points.

#### Params

* `p1` (table): The first point `{ x, y, z }`.
* `p2` (table): The second point `{ x, y, z }`.

#### Returns

* `number`: The Euclidean distance.

```lua
geometry.distance_3d({x=0,y=0,z=0}, {x=5,y=5,z=5})
```

---

### midpoint

Returns the midpoint between two 3D points.

#### Params

* `p1` (table): First point `{ x, y, z }`.
* `p2` (table): Second point `{ x, y, z }`.

#### Returns

* `table`: Midpoint `{ x, y, z }`.

```lua
geometry.midpoint({x=0,y=0,z=0}, {x=10,y=10,z=10})
```

---

### is_point_in_rect

Checks if a 2D point is inside a rectangle.

#### Params

* `point` (table): `{ x, y }`
* `rect` (table): `{ x, y, width, height }`

#### Returns

* `boolean`: True if inside.

```lua
geometry.is_point_in_rect({x=5,y=5}, {x=0,y=0,width=10,height=10})
```

---

### is_point_in_box

Checks if a 3D point is inside a box.

#### Params

* `point` (table): `{ x, y, z }`
* `box` (table): `{ x, y, z, width, height, depth }`

#### Returns

* `boolean`: True if inside.

```lua
geometry.is_point_in_box({x=1,y=1,z=1}, {x=0,y=0,z=0,width=5,height=5,depth=5})
```

---

### is_point_on_line_segment

Checks if a 2D point lies on a line segment.

#### Params

* `point` (table): `{ x, y }`
* `line_start` (table): `{ x, y }`
* `line_end` (table): `{ x, y }`

#### Returns

* `boolean`: True if on segment.

```lua
geometry.is_point_on_line_segment({x=5,y=5}, {x=0,y=0}, {x=10,y=10})
```

---

### project_point_on_line

Projects a 2D point onto a line.

#### Params

* `p` (table): Point to project `{ x, y }`
* `p1` (table): Start of line `{ x, y }`
* `p2` (table): End of line `{ x, y }`

#### Returns

* `table`: Projected point `{ x, y }`

```lua
geometry.project_point_on_line({x=1,y=2}, {x=0,y=0}, {x=4,y=4})
```

---

### calculate_slope

Gets the slope of a line between two 2D points.

#### Params

* `p1` (table): `{ x, y }`
* `p2` (table): `{ x, y }`

#### Returns

* `number|nil`: The slope, or nil for vertical lines.

```lua
geometry.calculate_slope({x=0,y=0}, {x=2,y=2})
```

---

### angle_between_points

Returns angle in degrees between two 2D points.

#### Params

* `p1` (table): `{ x, y }`
* `p2` (table): `{ x, y }`

#### Returns

* `number`: Angle in degrees.

```lua
geometry.angle_between_points({x=0,y=0}, {x=1,y=1})
```

---

### angle_between_3_points

Gets angle at `p2` formed by three 3D points.

#### Params

* `p1` (table): `{ x, y, z }`
* `p2` (table): `{ x, y, z }`
* `p3` (table): `{ x, y, z }`

#### Returns

* `number`: Angle in degrees.

```lua
geometry.angle_between_3_points(a, b, c)
```

---

### do_circles_intersect

Checks if two 2D circles intersect.

#### Params

* `c1_center` (table): `{ x, y }`
* `c1_radius` (number)
* `c2_center` (table): `{ x, y }`
* `c2_radius` (number)

#### Returns

* `boolean`: True if intersecting.

```lua
geometry.do_circles_intersect({x=0,y=0}, 5, {x=7,y=0}, 3)
```

---

### is_point_in_circle

Checks if a point is inside a 2D circle.

#### Params

* `point` (table): `{ x, y }`
* `circle_center` (table): `{ x, y }`
* `circle_radius` (number)

#### Returns

* `boolean`: True if inside.

```lua
geometry.is_point_in_circle({x=1,y=1}, {x=0,y=0}, 2)
```

---

### do_lines_intersect

Checks if two 2D line segments intersect.

#### Params

* `l1_start`, `l1_end`, `l2_start`, `l2_end`: `{ x, y }`

#### Returns

* `boolean`: True if intersect.

```lua
geometry.do_lines_intersect(a1, a2, b1, b2)
```

---

### line_intersects_circle

Checks if a 2D line crosses a circle.

#### Params

* `line_start`, `line_end`, `circle_center`: `{ x, y }`
* `circle_radius` (number)

#### Returns

* `boolean`: True if intersects.

```lua
geometry.line_intersects_circle({x=0,y=0}, {x=10,y=0}, {x=5,y=0}, 2)
```

---

### does_rect_intersect_line

Checks if a 2D line crosses a rectangle.

#### Params

* `rect` (table): `{ x, y, width, height }`
* `line_start`, `line_end`: `{ x, y }`

#### Returns

* `boolean`: True if intersects.

```lua
geometry.does_rect_intersect_line(rect, a, b)
```

---

### closest_point_on_line_segment

Finds closest 2D point on a line segment.

#### Params

* `point`, `line_start`, `line_end`: `{ x, y }`

#### Returns

* `table`: Closest point `{ x, y }`

```lua
geometry.closest_point_on_line_segment(p, a, b)
```

---

### triangle_area_3d

Gets the area of a triangle in 3D.

#### Params

* `p1`, `p2`, `p3`: `{ x, y, z }`

#### Returns

* `number`: Area.

```lua
geometry.triangle_area_3d(p1, p2, p3)
```

---

### is_point_in_sphere

Checks if a point is inside a 3D sphere.

#### Params

* `point`, `sphere_center`: `{ x, y, z }`
* `sphere_radius` (number)

#### Returns

* `boolean`: True if inside.

```lua
geometry.is_point_in_sphere({x=0,y=0,z=0}, {x=0,y=0,z=0}, 10)
```

---

### do_spheres_intersect

Checks if two 3D spheres overlap.

#### Params

* `s1_center`, `s2_center`: `{ x, y, z }`
* `s1_radius`, `s2_radius` (number)

#### Returns

* `boolean`: True if intersect.

```lua
geometry.do_spheres_intersect(a, 5, b, 7)
```

---

### is_point_in_convex_polygon

Checks if a 2D point is in a convex polygon.

#### Params

* `point` (table): `{ x, y }`
* `polygon` (table): Array of `{ x, y }` points

#### Returns

* `boolean`: True if inside.

```lua
geometry.is_point_in_convex_polygon(p, polygon)
```

---

### rotate_point_around_point_2d

Rotates a 2D point around a pivot by degrees.

#### Params

* `point`, `pivot`: `{ x, y }`
* `angle_degrees`: `number`

#### Returns

* `table`: Rotated `{ x, y }`

```lua
geometry.rotate_point_around_point_2d(p, origin, 90)
```

---

### distance_point_to_plane

Gets the distance from point to plane.

#### Params

* `point`, `plane_point`, `plane_normal`: `{ x, y, z }`

#### Returns

* `number`: Distance.

```lua
geometry.distance_point_to_plane(p, plane_point, normal)
```

---

### rotation_to_direction

Converts Euler rotation to a direction vector.

#### Params

* `rotation` (table): `{ x = pitch, y = roll, z = yaw }`

#### Returns

* `vector3`: Direction.

```lua
geometry.rotation_to_direction({x=0,y=0,z=90})
```

---

### rotate_box

Gets rotated corners of a 3D box.

#### Params

* `center`: `{ x, y, z }`
* `width`, `length`, `heading`: `number`

#### Returns

* `table`: Array of `vector3` corners.

```lua
geometry.rotate_box(center, 2.0, 4.0, 45)
```

---

### calculate_rotation_matrix

Builds a 3x3 rotation matrix.

#### Params

* `heading`, `pitch`, `roll`: `number`

#### Returns

* `table`: Matrix.

```lua
geometry.calculate_rotation_matrix(90, 0, 0)
```

---

### translate_point_to_local_space

Translates a point to local box space.

#### Params

* `point`, `box_origin`: `{ x, y, z }`
* `rot_matrix`: Matrix from `calculate_rotation_matrix`

#### Returns

* `table`: Transformed point.

```lua
geometry.translate_point_to_local_space(point, origin, matrix)
```

---

### is_point_in_oriented_box

Checks if a point is inside a rotated 3D box.

#### Params

* `point`: `{ x, y, z }`
* `box`: `{ coords, width, height, depth, heading, pitch, roll }`

#### Returns

* `boolean`: True if inside.

```lua
geometry.is_point_in_oriented_box(p, box)
```