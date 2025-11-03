library(BSol.mapR)
library(dplyr)
library(tmap)
library(sf)


WM_LAs <- st_read(
  "data/WestMidLAs/WestMidLAs.shp"
) 

self_harm_hosp <- read.csv(
  "data/hosp_self_harm_10to24_westmids.csv"
)

self_harm_map <- WM_LAs %>%
  left_join(
    self_harm_hosp,
    by = join_by("LAD24CD" == "Area.Code")
  ) %>%
  mutate(
    PlotValue = round(Value, 1)
  )

map1 <- tm_shape(self_harm_map) +
  tm_fill(
    "Value",
    fill.scale = tm_scale_continuous(),
    fill.legend = tm_legend(
      title = ""
    )
    ) +
  tm_text("PlotValue") + 
  tm_borders() +
  tm_title(
    text = "Hospital admissions as a result of self-harm per 100,000 persons aged 10-24 yrs (2023/24)"
  ) +
  tm_layout(
    legend.frame.alpha = 0,
    legend.frame.lwd = 0,
    legend.height = 10
  )

save_map(map1, "output/hosp_self_harm_10to24_westmids.png", width = 6, height = 4)





mh_hosp <- read.csv(
  "data/hosp_mental_health_under18_westmids.csv"
)

mh_map <- WM_LAs %>%
  left_join(
    mh_hosp,
    by = join_by("LAD24CD" == "Area.Code")
  ) %>%
  mutate(
    PlotValue = round(Value, 1)
  )

map2 <- tm_shape(mh_map) +
  tm_fill(
    "Value",
    fill.scale = tm_scale_continuous(),
    fill.legend = tm_legend(
      title = ""
    )
  ) +
  tm_text("PlotValue") + 
  tm_borders() +
  tm_title(
    text = "Hospital admissions for mental health conditions per 100,000 aged <18 yrs (2023/24)"
  ) +
  tm_layout(
    legend.frame.alpha = 0,
    legend.frame.lwd = 0,
    legend.height = 10
  )

save_map(map2, "output/hosp_mh_under18_westmids.png", width = 6, height = 4)