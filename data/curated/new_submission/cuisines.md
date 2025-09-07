| variable       | class     | description                                                                 |
|:---------------|:----------|:----------------------------------------------------------------------------|
| name           | character | Name of the recipe.                                                         |
| country        | character | The country/region the cuisine is from.                                     |
| url            | character | Link to the recipe.                                                         |
| author         | character | Author of the recipe.                                                       |
| date_published | date      | When the recipe was published/updated.                                      |
| ingredients    | character | The ingredients of the recipe.                                              |
| calories       | integer   | Calories per serving.                                                       |
| fat            | integer   | Fat per serving.                                                            |
| carbs          | integer   | Carbs per serving.                                                          |
| protein        | integer   | Proteins per serving.                                                       |
| avg_rating     | double    | Average rating out of 5 stars.                                              |
| total_ratings  | integer   | Number of ratings received.                                                 |
| reviews        | integer   | Number of written reviews.                                                  |
| prep_time      | integer   | Preparation time in minutes.                                                |
| cook_time      | integer   | Cooking time in minutes.                                                    |
| total_time     | integer   | Prep + cook time in minutes. Note that this value may not always match the  |
|                |           | actual total effort required, as other time-related fields (such as         |
|                |           | refrigeration, marination, fry time, or additional wait periods) have been  |
|                |           | excluded due to inconsistent availability across recipes.                   |
| servings       | integer   | Number of servings.                                                         |
