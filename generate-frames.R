library(sf)
library(raster)
library(ncdf4)
library(gdal)
library(gdalUtils)
library(tmap)
library(spData)

temp <- brick('data/data-noaa-temp/tmin.2021.nc', var='tmin')
temp <- raster::rotate(temp)

alpha <- 0.6
for (i in 2:365) {
  temp[[i]] = alpha * temp[[i]] + (1 - alpha) * temp[[i - 1]]
}

for (i in 1:365) {
  tm <- tm_shape(temp[[i]], bbox=extent(-180, 180, -90, 90)) +
    tm_raster(palette = "-RdYlGn", breaks = c(-80, -60, -40, -20, 0, 20, 40), title='Air Temperature [°C]') +
    tm_layout(
      legend.position = c("left", "bottom"),
      title = paste('Global Daily Air Temperature (Day ', sprintf('% 3d', i), ')', sep=''),
      title.position = c('left', 'bottom')
    )
  tmap_save(tm, paste('frames/image_', sprintf('%03d', i), '.png', sep=""))
}
