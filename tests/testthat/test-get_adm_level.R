test_that("get_adm_level returns sf object with correct structure", {
  skip_if_offline()
  skip_on_cran()

  # Use Kenya for testing
  result <- get_adm_level("KEN", level = 1)

  expect_s3_class(result, "sf")
  expect_true("geometry" %in% names(result))
  expect_equal(sf::st_crs(result)$epsg, 4326) # WGS84
})

test_that("get_adm_level works with country names", {
  skip_if_offline()
  skip_on_cran()

  result <- get_adm_level("Kenya", level = 1)

  expect_s3_class(result, "sf")
  expect_true(nrow(result) > 0)
})

test_that("get_adm_level works with ISO3 codes", {
  skip_if_offline()
  skip_on_cran()

  result <- get_adm_level("KEN", level = 1)

  expect_s3_class(result, "sf")
  expect_true(nrow(result) > 0)
})

test_that("get_adm_level works with lowercase ISO3 codes", {
  skip_if_offline()
  skip_on_cran()

  result <- get_adm_level("ken", level = 1)

  expect_s3_class(result, "sf")
  expect_true(nrow(result) > 0)
})

test_that("get_adm_level works with different admin levels", {
  skip_if_offline()
  skip_on_cran()

  result_1 <- get_adm_level("KEN", level = 1)
  expect_s3_class(result_1, "sf")

  result_2 <- get_adm_level("KEN", level = 2)
  expect_s3_class(result_2, "sf")

  # Level 2 should have more or equal rows than level 1
  expect_gte(nrow(result_2), nrow(result_1))
})

test_that("get_adm_level works with different geometry types", {
  skip_if_offline()
  skip_on_cran()

  poly <- get_adm_level("KEN", level = 1, geom = "polygons")
  expect_s3_class(poly, "sf")
  expect_true("POLYGON" %in% class(sf::st_geometry(poly)[[1]]) ||
              "MULTIPOLYGON" %in% class(sf::st_geometry(poly)[[1]]))

  lines <- get_adm_level("KEN", level = 1, geom = "lines")
  expect_s3_class(lines, "sf")

  points <- get_adm_level("KEN", level = 1, geom = "points")
  expect_s3_class(points, "sf")
})

test_that("get_adm_level works with different datasets", {
  skip_if_offline()
  skip_on_cran()

  hum <- get_adm_level("KEN", level = 1, dataset = "humanitarian")
  expect_s3_class(hum, "sf")

  open <- get_adm_level("USA", level = 1, dataset = "open")
  expect_s3_class(open, "sf")
})

test_that("get_adm_level accepts custom DuckDB connection", {
  skip_if_offline()
  skip_on_cran()

  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  result <- get_adm_level("KEN", level = 1, con = con)

  expect_s3_class(result, "sf")
  expect_true(DBI::dbIsValid(con)) # Connection should still be valid
})

test_that("get_adm_level throws error for invalid country", {
  expect_error(
    get_adm_level("NotACountry", level = 1),
    "could not be converted to an ISO3 code"
  )
})

test_that("get_adm_level throws error when level exceeds maximum", {
  skip_if_offline()
  skip_on_cran()

  # Try to get a level that doesn't exist for Kenya
  expect_error(
    get_adm_level("KEN", level = 99),
    "level.*must be 1, 2, 3, or 4"
  )
})

test_that("get_adm_level throws error for invalid connection type", {
  skip_if_offline()
  skip_on_cran()

  # Create a non-DuckDB connection (SQLite)
  con <- DBI::dbConnect(RSQLite::SQLite(), ":memory:")
  on.exit(DBI::dbDisconnect(con))

  expect_error(
    get_adm_level("KEN", level = 1, con = con),
    "must be a DuckDB connection"
  )
})

test_that("get_adm_level with check_max_level = FALSE skips validation", {
  skip_if_offline()
  skip_on_cran()

  # This should work even if we request a high level, as long as data exists
  result <- get_adm_level("KEN", level = 1, check_max_level = FALSE)
  expect_s3_class(result, "sf")
})

test_that("get_adm_level returns data with iso_3 column", {
  skip_if_offline()
  skip_on_cran()

  result <- get_adm_level("KEN", level = 1)

  expect_true("iso_3" %in% names(result))
  expect_true(all(result$iso_3 == "KEN"))
})

test_that("get_adm_level handles DRC special case", {
  skip_if_offline()
  skip_on_cran()

  result <- get_adm_level("DRC", level = 1)

  expect_s3_class(result, "sf")
  expect_true(all(result$iso_3 == "COD"))
})

test_that("get_adm_level handles CAR special case", {
  skip_if_offline()
  skip_on_cran()

  result <- get_adm_level("CAR", level = 1)

  expect_s3_class(result, "sf")
  expect_true(all(result$iso_3 == "CAF"))
})

test_that("get_adm_level excludes geometry_bbox column", {
  skip_if_offline()
  skip_on_cran()

  result <- get_adm_level("KEN", level = 1)

  expect_false("geometry_bbox" %in% names(result))
})
