|variable             |class   |description                                                                                           |
|:--------------------|:-------|:-----------------------------------------------------------------------------------------------------|
|wind_speed_class     |integer |Beaufort scale class (0--12), corresponding to `ships$wind_speed_class`.                              |
|wind_description     |ordered |Text description of the wind conditions, ordered from `"calm"` (class 0) to `"hurricane"` (class 12). |
|wind_speed_knots_min |integer |Minimum wind speed in knots for this class.                                                           |
|wind_speed_knots_max |integer |Maximum wind speed in knots for this class. `NA` for class 12 (hurricane), which has no upper bound.  |

