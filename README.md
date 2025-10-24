
<!-- README.md is generated from README.Rmd. Please edit that file -->

# fieldmaps

<!-- badges: start -->

<!-- badges: end -->

The goal of fieldmaps is to …

## Installation

You can install the development version of fieldmaps like so:

``` r
pak::pak("epicentre-msf/fieldmaps")
```

## Example

This is a basic example which shows you how to solve a common problem:

``` r
library(fieldmaps)
library(sf)
#> Linking to GEOS 3.13.0, GDAL 3.8.5, PROJ 9.5.1; sf_use_s2() is TRUE

country <- "Niger"

# downlaod single admin level
adm1 <- get_adm_level(country, level = 1)

# print
adm1
#> Simple feature collection with 8 features and 38 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 0.1617178 ymin: 11.69376 xmax: 16 ymax: 23.515
#> Geodetic CRS:  WGS 84
#>    fid        adm1_id adm1_src adm1_name adm1_name1 adm1_name2      adm0_id
#> 1 2098 NER-20240408-1    NE001    Agadez       <NA>       <NA> NER-20250729
#> 2 2099 NER-20240408-2    NE002     Diffa       <NA>       <NA> NER-20250729
#> 3 2100 NER-20240408-3    NE003     Dosso       <NA>       <NA> NER-20250729
#> 4 2101 NER-20240408-4    NE004    Maradi       <NA>       <NA> NER-20250729
#> 5 2102 NER-20240408-5    NE005    Tahoua       <NA>       <NA> NER-20250729
#> 6 2103 NER-20240408-6    NE006 Tillabéri       <NA>       <NA> NER-20250729
#> 7 2104 NER-20240408-7    NE007    Zinder       <NA>       <NA> NER-20250729
#> 8 2105 NER-20240408-8    NE008    Niamey       <NA>       <NA> NER-20250729
#>   adm0_src adm0_name adm0_name1 adm0_name2 src_lvl src_lang src_lang1 src_lang2
#> 1      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 2      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 3      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 4      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 5      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 6      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 7      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 8      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#>     src_date src_update                                         src_name
#> 1 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 2 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 3 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 4 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 5 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 6 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 7 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 8 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#>    src_name1 src_lic                                     src_url src_grp iso_cd
#> 1 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 2 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 3 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 4 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 5 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 6 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 7 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 8 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#>   iso_2 iso_3 iso_3_grp region3_cd     region3_nm region2_cd         region2_nm
#> 1    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 2    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 3    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 4    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 5    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 6    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 7    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 8    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#>   region1_cd region1_nm status_cd status_nm   wld_date wld_update wld_view
#> 1          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 2          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 3          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 4          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 5          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 6          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 7          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 8          2     Africa         1     State 2025-02-24 2025-07-29     intl
#>   wld_notes                       geometry
#> 1      <NA> MULTIPOLYGON (((7.000488 15...
#> 2      <NA> MULTIPOLYGON (((12.68944 13...
#> 3      <NA> MULTIPOLYGON (((3.680954 11...
#> 4      <NA> MULTIPOLYGON (((7.590064 13...
#> 5      <NA> MULTIPOLYGON (((5.127439 13...
#> 6      <NA> MULTIPOLYGON (((1.751848 12...
#> 7      <NA> MULTIPOLYGON (((9.204075 12...
#> 8      <NA> MULTIPOLYGON (((2.126099 13...

# download all available admin levels
shps <- get_all_adm_levels(country)
#> ℹ Requesting 3 NER admin levels available in Field Maps.

# print
shps
#> $ADM1
#> Simple feature collection with 8 features and 38 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 0.1617178 ymin: 11.69376 xmax: 16 ymax: 23.515
#> Geodetic CRS:  WGS 84
#>    fid        adm1_id adm1_src adm1_name adm1_name1 adm1_name2      adm0_id
#> 1 2098 NER-20240408-1    NE001    Agadez       <NA>       <NA> NER-20250729
#> 2 2099 NER-20240408-2    NE002     Diffa       <NA>       <NA> NER-20250729
#> 3 2100 NER-20240408-3    NE003     Dosso       <NA>       <NA> NER-20250729
#> 4 2101 NER-20240408-4    NE004    Maradi       <NA>       <NA> NER-20250729
#> 5 2102 NER-20240408-5    NE005    Tahoua       <NA>       <NA> NER-20250729
#> 6 2103 NER-20240408-6    NE006 Tillabéri       <NA>       <NA> NER-20250729
#> 7 2104 NER-20240408-7    NE007    Zinder       <NA>       <NA> NER-20250729
#> 8 2105 NER-20240408-8    NE008    Niamey       <NA>       <NA> NER-20250729
#>   adm0_src adm0_name adm0_name1 adm0_name2 src_lvl src_lang src_lang1 src_lang2
#> 1      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 2      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 3      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 4      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 5      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 6      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 7      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#> 8      NER     Niger      Niger         NA       3       fr      <NA>      <NA>
#>     src_date src_update                                         src_name
#> 1 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 2 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 3 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 4 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 5 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 6 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 7 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#> 8 2006-01-01 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015)
#>    src_name1 src_lic                                     src_url src_grp iso_cd
#> 1 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 2 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 3 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 4 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 5 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 6 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 7 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#> 8 OCHA Niger   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562
#>   iso_2 iso_3 iso_3_grp region3_cd     region3_nm region2_cd         region2_nm
#> 1    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 2    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 3    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 4    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 5    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 6    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 7    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 8    NE   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#>   region1_cd region1_nm status_cd status_nm   wld_date wld_update wld_view
#> 1          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 2          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 3          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 4          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 5          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 6          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 7          2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 8          2     Africa         1     State 2025-02-24 2025-07-29     intl
#>   wld_notes                       geometry
#> 1      <NA> MULTIPOLYGON (((7.000488 15...
#> 2      <NA> MULTIPOLYGON (((12.68944 13...
#> 3      <NA> MULTIPOLYGON (((3.680954 11...
#> 4      <NA> MULTIPOLYGON (((7.590064 13...
#> 5      <NA> MULTIPOLYGON (((5.127439 13...
#> 6      <NA> MULTIPOLYGON (((1.751848 12...
#> 7      <NA> MULTIPOLYGON (((9.204075 12...
#> 8      <NA> MULTIPOLYGON (((2.126099 13...
#> 
#> $ADM2
#> Simple feature collection with 67 features and 43 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 0.1617178 ymin: 11.69376 xmax: 16 ymax: 23.515
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>      fid           adm2_id adm2_src    adm2_name adm2_name1 adm2_name2
#> 1  28881 NER-20240408-1-01 NE001001 Aderbissinat       <NA>       <NA>
#> 2  28882 NER-20240408-1-02 NE001002        Arlit       <NA>       <NA>
#> 3  28883 NER-20240408-1-03 NE001003        Bilma       <NA>       <NA>
#> 4  28884 NER-20240408-1-04 NE001004    Iferouane       <NA>       <NA>
#> 5  28885 NER-20240408-1-05 NE001005       Ingall       <NA>       <NA>
#> 6  28886 NER-20240408-1-06 NE001006 Tchirozerine       <NA>       <NA>
#> 7  28887 NER-20240408-2-01 NE002001        Bosso       <NA>       <NA>
#> 8  28888 NER-20240408-2-02 NE002002        Diffa       <NA>       <NA>
#> 9  28889 NER-20240408-2-03 NE002003  Goudoumaria       <NA>       <NA>
#> 10 28890 NER-20240408-2-04 NE002004  Maïné Soroa       <NA>       <NA>
#>           adm1_id adm1_src adm1_name adm1_name1 adm1_name2      adm0_id
#> 1  NER-20240408-1    NE001    Agadez       <NA>       <NA> NER-20250729
#> 2  NER-20240408-1    NE001    Agadez       <NA>       <NA> NER-20250729
#> 3  NER-20240408-1    NE001    Agadez       <NA>       <NA> NER-20250729
#> 4  NER-20240408-1    NE001    Agadez       <NA>       <NA> NER-20250729
#> 5  NER-20240408-1    NE001    Agadez       <NA>       <NA> NER-20250729
#> 6  NER-20240408-1    NE001    Agadez       <NA>       <NA> NER-20250729
#> 7  NER-20240408-2    NE002     Diffa       <NA>       <NA> NER-20250729
#> 8  NER-20240408-2    NE002     Diffa       <NA>       <NA> NER-20250729
#> 9  NER-20240408-2    NE002     Diffa       <NA>       <NA> NER-20250729
#> 10 NER-20240408-2    NE002     Diffa       <NA>       <NA> NER-20250729
#>    adm0_src adm0_name adm0_name1 adm0_name2 src_lvl src_lang src_lang1
#> 1       NER     Niger      Niger         NA       3       fr      <NA>
#> 2       NER     Niger      Niger         NA       3       fr      <NA>
#> 3       NER     Niger      Niger         NA       3       fr      <NA>
#> 4       NER     Niger      Niger         NA       3       fr      <NA>
#> 5       NER     Niger      Niger         NA       3       fr      <NA>
#> 6       NER     Niger      Niger         NA       3       fr      <NA>
#> 7       NER     Niger      Niger         NA       3       fr      <NA>
#> 8       NER     Niger      Niger         NA       3       fr      <NA>
#> 9       NER     Niger      Niger         NA       3       fr      <NA>
#> 10      NER     Niger      Niger         NA       3       fr      <NA>
#>    src_lang2   src_date src_update
#> 1       <NA> 2006-01-01 2024-04-08
#> 2       <NA> 2006-01-01 2024-04-08
#> 3       <NA> 2006-01-01 2024-04-08
#> 4       <NA> 2006-01-01 2024-04-08
#> 5       <NA> 2006-01-01 2024-04-08
#> 6       <NA> 2006-01-01 2024-04-08
#> 7       <NA> 2006-01-01 2024-04-08
#> 8       <NA> 2006-01-01 2024-04-08
#> 9       <NA> 2006-01-01 2024-04-08
#> 10      <NA> 2006-01-01 2024-04-08
#>                                            src_name  src_name1 src_lic
#> 1   IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger   Other
#> 2   IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger   Other
#> 3   IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger   Other
#> 4   IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger   Other
#> 5   IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger   Other
#> 6   IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger   Other
#> 7   IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger   Other
#> 8   IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger   Other
#> 9   IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger   Other
#> 10  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger   Other
#>                                        src_url src_grp iso_cd iso_2 iso_3
#> 1  https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE   NER
#> 2  https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE   NER
#> 3  https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE   NER
#> 4  https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE   NER
#> 5  https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE   NER
#> 6  https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE   NER
#> 7  https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE   NER
#> 8  https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE   NER
#> 9  https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE   NER
#> 10 https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE   NER
#>    iso_3_grp region3_cd     region3_nm region2_cd         region2_nm region1_cd
#> 1        NER         11 Western Africa        202 Sub-Saharan Africa          2
#> 2        NER         11 Western Africa        202 Sub-Saharan Africa          2
#> 3        NER         11 Western Africa        202 Sub-Saharan Africa          2
#> 4        NER         11 Western Africa        202 Sub-Saharan Africa          2
#> 5        NER         11 Western Africa        202 Sub-Saharan Africa          2
#> 6        NER         11 Western Africa        202 Sub-Saharan Africa          2
#> 7        NER         11 Western Africa        202 Sub-Saharan Africa          2
#> 8        NER         11 Western Africa        202 Sub-Saharan Africa          2
#> 9        NER         11 Western Africa        202 Sub-Saharan Africa          2
#> 10       NER         11 Western Africa        202 Sub-Saharan Africa          2
#>    region1_nm status_cd status_nm   wld_date wld_update wld_view wld_notes
#> 1      Africa         1     State 2025-02-24 2025-07-29     intl      <NA>
#> 2      Africa         1     State 2025-02-24 2025-07-29     intl      <NA>
#> 3      Africa         1     State 2025-02-24 2025-07-29     intl      <NA>
#> 4      Africa         1     State 2025-02-24 2025-07-29     intl      <NA>
#> 5      Africa         1     State 2025-02-24 2025-07-29     intl      <NA>
#> 6      Africa         1     State 2025-02-24 2025-07-29     intl      <NA>
#> 7      Africa         1     State 2025-02-24 2025-07-29     intl      <NA>
#> 8      Africa         1     State 2025-02-24 2025-07-29     intl      <NA>
#> 9      Africa         1     State 2025-02-24 2025-07-29     intl      <NA>
#> 10     Africa         1     State 2025-02-24 2025-07-29     intl      <NA>
#>                          geometry
#> 1  MULTIPOLYGON (((7.18927 15....
#> 2  MULTIPOLYGON (((6.068356 18...
#> 3  MULTIPOLYGON (((12.29449 17...
#> 4  MULTIPOLYGON (((10.37923 17...
#> 5  MULTIPOLYGON (((6.671082 16...
#> 6  MULTIPOLYGON (((8.02948 16....
#> 7  MULTIPOLYGON (((12.94488 13...
#> 8  MULTIPOLYGON (((12.69057 13...
#> 9  MULTIPOLYGON (((10.64587 13...
#> 10 MULTIPOLYGON (((11.36749 13...
#> 
#> $ADM3
#> Simple feature collection with 266 features and 48 fields
#> Geometry type: MULTIPOLYGON
#> Dimension:     XY
#> Bounding box:  xmin: 0.1617178 ymin: 11.69376 xmax: 16 ymax: 23.515
#> Geodetic CRS:  WGS 84
#> First 10 features:
#>      fid              adm3_id    adm3_src    adm3_name adm3_name1 adm3_name2
#> 1  88429 NER-20240408-1-01-01 NE001001001 Aderbissinat       <NA>       <NA>
#> 2  88430 NER-20240408-1-02-01 NE001002001        Arlit       <NA>       <NA>
#> 3  88431 NER-20240408-1-02-02 NE001002002       Dannet       <NA>       <NA>
#> 4  88432 NER-20240408-1-02-03 NE001002003     Gougaram       <NA>       <NA>
#> 5  88433 NER-20240408-1-03-01 NE001003001        Bilma       <NA>       <NA>
#> 6  88434 NER-20240408-1-03-02 NE001003002       Dirkou       <NA>       <NA>
#> 7  88435 NER-20240408-1-03-03 NE001003003        Djado       <NA>       <NA>
#> 8  88436 NER-20240408-1-03-04 NE001003004        Fachi       <NA>       <NA>
#> 9  88437 NER-20240408-1-04-01 NE001004001    Iferouane       <NA>       <NA>
#> 10 88438 NER-20240408-1-04-02 NE001004002        Timia       <NA>       <NA>
#>              adm2_id adm2_src    adm2_name adm2_name1 adm2_name2        adm1_id
#> 1  NER-20240408-1-01 NE001001 Aderbissinat       <NA>       <NA> NER-20240408-1
#> 2  NER-20240408-1-02 NE001002        Arlit       <NA>       <NA> NER-20240408-1
#> 3  NER-20240408-1-02 NE001002        Arlit       <NA>       <NA> NER-20240408-1
#> 4  NER-20240408-1-02 NE001002        Arlit       <NA>       <NA> NER-20240408-1
#> 5  NER-20240408-1-03 NE001003        Bilma       <NA>       <NA> NER-20240408-1
#> 6  NER-20240408-1-03 NE001003        Bilma       <NA>       <NA> NER-20240408-1
#> 7  NER-20240408-1-03 NE001003        Bilma       <NA>       <NA> NER-20240408-1
#> 8  NER-20240408-1-03 NE001003        Bilma       <NA>       <NA> NER-20240408-1
#> 9  NER-20240408-1-04 NE001004    Iferouane       <NA>       <NA> NER-20240408-1
#> 10 NER-20240408-1-04 NE001004    Iferouane       <NA>       <NA> NER-20240408-1
#>    adm1_src adm1_name adm1_name1 adm1_name2      adm0_id adm0_src adm0_name
#> 1     NE001    Agadez       <NA>       <NA> NER-20250729      NER     Niger
#> 2     NE001    Agadez       <NA>       <NA> NER-20250729      NER     Niger
#> 3     NE001    Agadez       <NA>       <NA> NER-20250729      NER     Niger
#> 4     NE001    Agadez       <NA>       <NA> NER-20250729      NER     Niger
#> 5     NE001    Agadez       <NA>       <NA> NER-20250729      NER     Niger
#> 6     NE001    Agadez       <NA>       <NA> NER-20250729      NER     Niger
#> 7     NE001    Agadez       <NA>       <NA> NER-20250729      NER     Niger
#> 8     NE001    Agadez       <NA>       <NA> NER-20250729      NER     Niger
#> 9     NE001    Agadez       <NA>       <NA> NER-20250729      NER     Niger
#> 10    NE001    Agadez       <NA>       <NA> NER-20250729      NER     Niger
#>    adm0_name1 adm0_name2 src_lvl src_lang src_lang1 src_lang2   src_date
#> 1       Niger         NA       3       fr      <NA>      <NA> 2006-01-01
#> 2       Niger         NA       3       fr      <NA>      <NA> 2006-01-01
#> 3       Niger         NA       3       fr      <NA>      <NA> 2006-01-01
#> 4       Niger         NA       3       fr      <NA>      <NA> 2006-01-01
#> 5       Niger         NA       3       fr      <NA>      <NA> 2006-01-01
#> 6       Niger         NA       3       fr      <NA>      <NA> 2006-01-01
#> 7       Niger         NA       3       fr      <NA>      <NA> 2006-01-01
#> 8       Niger         NA       3       fr      <NA>      <NA> 2006-01-01
#> 9       Niger         NA       3       fr      <NA>      <NA> 2006-01-01
#> 10      Niger         NA       3       fr      <NA>      <NA> 2006-01-01
#>    src_update                                         src_name  src_name1
#> 1  2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger
#> 2  2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger
#> 3  2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger
#> 4  2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger
#> 5  2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger
#> 6  2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger
#> 7  2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger
#> 8  2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger
#> 9  2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger
#> 10 2024-04-08  IGNN (as of 2006) and  OCHA/ROWCA ( 2014/ 2015) OCHA Niger
#>    src_lic                                     src_url src_grp iso_cd iso_2
#> 1    Other https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE
#> 2    Other https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE
#> 3    Other https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE
#> 4    Other https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE
#> 5    Other https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE
#> 6    Other https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE
#> 7    Other https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE
#> 8    Other https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE
#> 9    Other https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE
#> 10   Other https://data.humdata.org/dataset/cod-ab-ner     COD    562    NE
#>    iso_3 iso_3_grp region3_cd     region3_nm region2_cd         region2_nm
#> 1    NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 2    NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 3    NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 4    NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 5    NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 6    NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 7    NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 8    NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 9    NER       NER         11 Western Africa        202 Sub-Saharan Africa
#> 10   NER       NER         11 Western Africa        202 Sub-Saharan Africa
#>    region1_cd region1_nm status_cd status_nm   wld_date wld_update wld_view
#> 1           2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 2           2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 3           2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 4           2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 5           2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 6           2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 7           2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 8           2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 9           2     Africa         1     State 2025-02-24 2025-07-29     intl
#> 10          2     Africa         1     State 2025-02-24 2025-07-29     intl
#>    wld_notes                       geometry
#> 1       <NA> MULTIPOLYGON (((7.18927 15....
#> 2       <NA> MULTIPOLYGON (((7.36367 18....
#> 3       <NA> MULTIPOLYGON (((6.06832 18....
#> 4       <NA> MULTIPOLYGON (((7.432199 18...
#> 5       <NA> MULTIPOLYGON (((14.23151 17...
#> 6       <NA> MULTIPOLYGON (((12.15448 19...
#> 7       <NA> MULTIPOLYGON (((12.17764 19...
#> 8       <NA> MULTIPOLYGON (((12.18439 17...
#> 9       <NA> MULTIPOLYGON (((10.99714 20...
#> 10      <NA> MULTIPOLYGON (((10.86046 18...
```
