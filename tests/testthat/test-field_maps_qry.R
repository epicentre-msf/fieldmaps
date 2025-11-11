test_that("field_maps_qry generates correct SQL for humanitarian polygons", {
  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  qry <- fieldmaps:::field_maps_qry(
    iso3 = "KEN",
    level = 1,
    con = con,
    dataset = "humanitarian",
    geom = "polygons"
  )

  expect_type(qry, "character")
  expect_match(qry, "SELECT \\* EXCLUDE geometry_bbox")
  expect_match(qry, "FROM 'https://data\\.fieldmaps\\.io/edge-matched/humanitarian/intl/adm1_polygons\\.parquet'")
  expect_match(qry, "WHERE iso_3 = 'KEN'")
})

test_that("field_maps_qry generates correct SQL for different admin levels", {
  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  qry_2 <- fieldmaps:::field_maps_qry("USA", 2, con)
  expect_match(qry_2, "adm2_polygons\\.parquet")

  qry_3 <- fieldmaps:::field_maps_qry("USA", 3, con)
  expect_match(qry_3, "adm3_polygons\\.parquet")

  qry_4 <- fieldmaps:::field_maps_qry("USA", 4, con)
  expect_match(qry_4, "adm4_polygons\\.parquet")
})

test_that("field_maps_qry handles different geometry types", {
  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  qry_poly <- fieldmaps:::field_maps_qry("KEN", 1, con, geom = "polygons")
  expect_match(qry_poly, "adm1_polygons\\.parquet")

  qry_lines <- fieldmaps:::field_maps_qry("KEN", 1, con, geom = "lines")
  expect_match(qry_lines, "adm1_lines\\.parquet")

  qry_points <- fieldmaps:::field_maps_qry("KEN", 1, con, geom = "points")
  expect_match(qry_points, "adm1_points\\.parquet")
})

test_that("field_maps_qry handles different datasets", {
  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  qry_hum <- fieldmaps:::field_maps_qry("KEN", 1, con, dataset = "humanitarian")
  expect_match(qry_hum, "edge-matched/humanitarian/")

  qry_open <- fieldmaps:::field_maps_qry("KEN", 1, con, dataset = "open")
  expect_match(qry_open, "edge-matched/open/")
})

test_that("field_maps_qry properly escapes ISO3 codes (SQL injection protection)", {
  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  # glue_sql should properly escape values
  qry <- fieldmaps:::field_maps_qry("USA", 1, con)

  # The ISO3 code should be properly quoted in the WHERE clause
  expect_match(qry, "WHERE iso_3 = 'USA'")

  # Should not have unescaped single quotes that could break SQL
  expect_false(grepl("WHERE iso_3 = USA[^']", qry))
})

test_that("field_maps_qry excludes geometry_bbox column", {
  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  qry <- fieldmaps:::field_maps_qry("KEN", 1, con)
  expect_match(qry, "EXCLUDE geometry_bbox")
})

test_that("field_maps_qry works with different ISO3 codes", {
  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  qry_ken <- fieldmaps:::field_maps_qry("KEN", 1, con)
  expect_match(qry_ken, "iso_3 = 'KEN'")

  qry_usa <- fieldmaps:::field_maps_qry("USA", 1, con)
  expect_match(qry_usa, "iso_3 = 'USA'")

  qry_cod <- fieldmaps:::field_maps_qry("COD", 1, con)
  expect_match(qry_cod, "iso_3 = 'COD'")
})
