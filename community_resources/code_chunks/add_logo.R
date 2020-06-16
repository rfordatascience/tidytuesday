# A lightweight function using the magick package
# https://cran.r-project.org/web/packages/magick/vignettes/intro.html

# Adds a logo to one of 4 corners as seen below
# Plot and logo path can be a local image or url to an image
# logo_position can be 'top left', 'top right', 'bottom left', or 'bottom right'

# example
add_logo(
  plot_path = "https://pbs.twimg.com/media/DwaRAv6U0AAaLIx.jpg",
  logo_path = "https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/static/plot_logo.png",
  logo_position = "bottom left"
)

# The actual function
add_logo <- function(plot_path, logo_path, logo_position){
  
  # Useful error message for logo position
  if (!logo_position %in% c("top right", "top left", "bottom right", "bottom left")) { 
      stop("Error Message: Uh oh! Logo Position not recognized\n  Try: logo_positon = 'top left', 'top right', 'bottom left', or 'bottom right'")
  }
  
  # read in raw images
  plot <- magick::image_read(plot_path)
  logo_raw <- magick::image_read(logo_path)
  
  # get dimensions of plot for scaling
  plot_height <- magick::image_info(plot)$height
  plot_width <- magick::image_info(plot)$width
  
  # scale to 1/10th width of plot
  logo <- magick::image_scale(logo_raw, as.character(plot_width/10))
  
  # Get width of logo
  logo_width <- magick::image_info(logo)$width
  logo_height <- magick::image_info(logo)$height
  
  
  # Set position of logo
  # Position starts at 0,0 at top left
  
  if (logo_position == "top right") {
    x_pos = plot_width - logo_width - 1
    y_pos = "0"
    
  } else if (logo_position == "top left") {
    x_pos = "0"
    y_pos = "0"
    
  } else if (logo_position == "bottom right") {
    x_pos = plot_width - logo_width - 1
    y_pos = plot_height - logo_height - 1
    
  } else if (logo_position == "bottom left") {
    x_pos = "0"
    y_pos = plot_height - logo_height - 1
  }
  
  # Compose the actual overlay
  magick::image_composite(plot, logo, offset = paste0("+", x_pos, "+", y_pos))
}
