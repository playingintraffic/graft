--[[ 
    This file is part of GRAFT (General Runtime Abstraction & Framework Toolkit) and is licensed under the MIT License.
    See the LICENSE file in the root directory for full terms.

    © 2025 Case @ Playing In Traffic

    Support honest development — retain this credit. Don't be that guy...
]]

--- @module maths
--- Provides a suite of additional maths functions not covered by luas default `math.` api.

local maths = {}

--- Rounds a number to the specified number of decimal places.
--- @param number The number to round.
--- @param decimals The number of decimal places to round to.
--- @return The rounded number.
function maths.round(number, decimals)
    local power = 10 ^ decimals
    return math.floor(number * power + 0.5) / power
end

--- Calculates the distance between two 3D coordinate points.
--- @param start_coords vector3: The starting coordinates.
--- @param end_coords vector3: The ending coordinates.
--- @return The distance between the two points.
function maths.calculate_distance(start_coords, end_coords)
    local dx = end_coords.x - start_coords.x
    local dy = end_coords.y - start_coords.y
    local dz = end_coords.z - start_coords.z
    return math.sqrt(dx*dx + dy*dy + dz*dz)
end

--- Clamps a number within a specified range.
--- @param val number: The value to clamp.
--- @param lower number: The lower bound of the range.
--- @param upper number: The upper bound of the range.
--- @return The clamped value.
function maths.clamp(val, lower, upper)
    if lower > upper then lower, upper = upper, lower end
    return math.max(lower, math.min(upper, val))
end

--- Linearly interpolates between two numbers.
--- @param a number: The start value.
--- @param b number: The end value.
--- @param t number: The interpolation factor (0-1).
--- @return The interpolated value.
function maths.lerp(a, b, t)
    return a + (b - a) * t
end

--- Calculates the factorial of a number.
--- @param n number: The number to calculate the factorial of.
--- @return The factorial of the number.
function maths.factorial(n)
    if n == 0 then 
        return 1 
    else 
        return n * maths.factorial(n - 1) 
    end
end

--- Converts degrees to radians.
--- @param deg number: The angle in degrees.
--- @return The angle in radians.
function maths.deg_to_rad(deg)
    return deg * (math.pi / 180)
end

--- Converts radians to degrees.
--- @param rad number: The angle in radians.
--- @return The angle in degrees.
function maths.rad_to_deg(rad)
    return rad * (180 / math.pi)
end

--- Calculates the circumference of a circle given its radius.
--- @param radius number: The radius of the circle.
--- @return The circumference of the circle.
function maths.circle_circumference(radius)
    return 2 * math.pi * radius
end

--- Calculates the area of a circle given its radius.
--- @param radius number: The radius of the circle.
--- @return The area of the circle.
function maths.circle_area(radius)
    return math.pi * radius^2
end

--- Calculates the area of a triangle given three 2D points.
--- @param p1 number: The first point.
--- @param p2 number: The second point.
--- @param p3 number: The third point.
--- @return The area of the triangle.
function maths.triangle_area(p1, p2, p3)
    return math.abs((p1.x*(p2.y-p3.y) + p2.x*(p3.y-p1.y) + p3.x*(p1.y-p2.y))/2)
end

--- Calculates the mean (average) of a list of numbers.
--- @param numbers table: A table containing the list of numbers.
--- @return The mean of the numbers.
function maths.mean(numbers)
    local sum = 0
    for _, num in ipairs(numbers) do
        sum = sum + num
    end
    return sum / #numbers
end

--- Calculates the median of a list of numbers.
--- @param numbers table: A table containing the list of numbers.
--- @return The median of the numbers.
function maths.median(numbers)
    table.sort(numbers)
    local len = #numbers
    if len % 2 == 0 then
        return (numbers[len / 2] + numbers[len / 2 + 1]) / 2
    else
        return numbers[math.ceil(len / 2)]
    end
end

--- Calculates the mode (most frequent value) of a list of numbers.
--- @param numbers table: A table containing the list of numbers.
--- @return The mode of the numbers, or nil if there is no mode.
function maths.mode(numbers)
    local counts = {}
    for _, num in ipairs(numbers) do
        counts[num] = (counts[num] or 0) + 1
    end
    local max_count = 0
    local mode_val = nil
    for num, count in pairs(counts) do
        if count > max_count then
            max_count = count
            mode_val = num
        elseif count == max_count then
            mode_val = nil
        end
    end
    return mode_val
end

--- Calculates the standard deviation of a list of numbers.
--- @param numbers table: A table containing the list of numbers.
--- @return The standard deviation of the numbers.
function maths.standard_deviation(numbers)
    local avg = maths.mean(numbers)
    local sum_sq_diff = 0
    for _, num in ipairs(numbers) do
        sum_sq_diff = sum_sq_diff + (num - avg)^2
    end
    return math.sqrt(sum_sq_diff / #numbers)
end

--- Calculates the linear regression coefficients (slope and intercept) for a set of points.
--- @param points table: A table containing the list of points {x, y}.
--- @return A table with the slope and intercept of the linear regression line.
function maths.linear_regression(points)
    local n = #points
    local sum_x, sum_y, sum_xx, sum_xy = 0, 0, 0, 0
    for _, point in ipairs(points) do
        sum_x = sum_x + point.x
        sum_y = sum_y + point.y
        sum_xx = sum_xx + point.x * point.x
        sum_xy = sum_xy + point.x * point.y
    end
    local slope = (n * sum_xy - sum_x * sum_y) / (n * sum_xx - sum_x * sum_x)
    local intercept = (sum_y - slope * sum_x) / n
    return { slope = slope, intercept = intercept }
end

--- Selects a random choice from a mapping of options with weights.
--- @param map table: Table of weighted options.
--- @return The chosen option
function maths.weighted_choice(map)
    local total = 0
    for _, w in pairs(map) do
        if w > 0 then total = total + w end
    end
    if total == 0 then return nil end
    local thresh = math.random(total)
    local cumulative = 0
    for key, w in pairs(map) do
        if w > 0 then
            cumulative = cumulative + w
            if thresh <= cumulative then
                return key
            end
        end
    end
end

--- Returns a random float between min and max.
--- @param min number: Min value.
--- @param max number: Max value
--- @return number
function maths.random_between(min, max)
    return min + math.random() * (max - min)
end

return maths