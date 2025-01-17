
gpwm
====

<!-- badges: start -->
<!-- badges: end -->
The goal of gpwm is to supply functions for analysis of PWM motifs using the misha package.

Installation
------------

You can install gpwm by running:

``` r
remotes::install_github("aviezerl/gpwm")
```

Example
-------

``` r
library(gpwm)
library(tidyverse)

# Set misha database
gsetroot("/net/mraid14/export/data/db/tgdb/mm9/trackdb/")

# Define foreground intervals
intervals_fg <- get_promoters(upstream = 40, downstream=10) %>% sample_n(1e4)

# Define background intervals
intervals_bg <- get_promoters(upstream = 40, downstream=10) %>% anti_join(intervals_fg)


intervals <- bind_rows(
    intervals_fg %>% mutate(type = 'fg'),
    intervals_bg %>% mutate(type = 'bg')
)

# Extract motifs
motifs <- gpwm.extract_all('motifs_10bp', intervals)

# Calculate enrichment
enrich <- gpwm.motif_enrich(
    fg = motifs %>% filter(type == "fg"), 
    bg = motifs %>% filter(type == "bg"), 
    pattern = "motifs_10bp", 
    size = 50, 
    quantile_thresh=0.99, 
    max.jobs = 5)
```
