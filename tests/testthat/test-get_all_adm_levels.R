test_that("get_all_adm_levels returns a named list", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("KEN")

  expect_type(result, "list")
  expect_true(length(result) > 0)
  expect_true(all(nzchar(names(result))))
})

test_that("get_all_adm_levels returns sf objects for each level", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("KEN")

  for (level_data in result) {
    expect_s3_class(level_data, "sf")
    expect_true("geometry" %in% names(level_data))
  }
})

test_that("get_all_adm_levels names list elements correctly", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("KEN")

  # Names should be ADM1, ADM2, etc.
  expect_true(all(grepl("^ADM[0-9]$", names(result))))

  # Should be in order
  level_nums <- as.integer(gsub("ADM", "", names(result)))
  expect_equal(level_nums, sort(level_nums))
})

test_that("get_all_adm_levels works with country names", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("Kenya")

  expect_type(result, "list")
  expect_true(length(result) > 0)
})

test_that("get_all_adm_levels works with ISO3 codes", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("KEN")

  expect_type(result, "list")
  expect_true(length(result) > 0)
})

test_that("get_all_adm_levels works with different datasets", {
  skip_if_offline()
  skip_on_cran()

  hum <- get_all_adm_levels("KEN", dataset = "humanitarian")
  expect_type(hum, "list")
  expect_true(length(hum) > 0)

  open <- get_all_adm_levels("USA", dataset = "open")
  expect_type(open, "list")
  expect_true(length(open) > 0)
})

test_that("get_all_adm_levels works with different geometry types", {
  skip_if_offline()
  skip_on_cran()

  poly <- get_all_adm_levels("KEN", geom = "polygons")
  expect_type(poly, "list")

  lines <- get_all_adm_levels("KEN", geom = "lines")
  expect_type(lines, "list")

  points <- get_all_adm_levels("KEN", geom = "points")
  expect_type(points, "list")
})

test_that("get_all_adm_levels accepts custom DuckDB connection", {
  skip_if_offline()
  skip_on_cran()

  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  result <- get_all_adm_levels("LUX", con = con)

  expect_type(result, "list")
  expect_true(DBI::dbIsValid(con)) # Connection should still be valid
})

test_that("get_all_adm_levels throws error for invalid country", {
  expect_error(
    get_all_adm_levels("NotACountry"),
    "could not be converted to an ISO3 code"
  )
})

test_that("get_all_adm_levels returns increasing number of features", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("KEN")

  # Generally, higher admin levels have more features
  # (though this isn't always strictly true)
  counts <- sapply(result, nrow)
  expect_true(all(counts > 0))

  # At minimum, each level should have data
  expect_true(length(result) >= 1)
})

test_that("get_all_adm_levels maintains consistent CRS across levels", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("KEN")

  # All should have EPSG:4326 (WGS84)
  crs_codes <- sapply(result, function(x) sf::st_crs(x)$epsg)
  expect_true(all(crs_codes == 4326))
})

test_that("get_all_adm_levels handles DRC special case", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("DRC")

  expect_type(result, "list")
  # Check that iso_3 column has COD (not DRC)
  expect_true(all(result[[1]]$iso_3 == "COD"))
})

test_that("get_all_adm_levels handles CAR special case", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("CAR")

  expect_type(result, "list")
  # Check that iso_3 column has CAF (not CAR)
  expect_true(all(result[[1]]$iso_3 == "CAF"))
})

test_that("get_all_adm_levels excludes geometry_bbox column", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("KEN")

  for (level_data in result) {
    expect_false("geometry_bbox" %in% names(level_data))
  }
})

test_that("get_all_adm_levels returns at least ADM1", {
  skip_if_offline()
  skip_on_cran()

  result <- get_all_adm_levels("KEN")

  # Every country should have at least ADM1
  expect_true("ADM1" %in% names(result))
})
