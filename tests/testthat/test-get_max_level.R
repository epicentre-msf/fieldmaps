test_that("get_max_level returns correct level for humanitarian dataset", {
  skip_if_offline()
  skip_on_cran()

  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  # Load required extensions
  fieldmaps:::load_extensions(con)

  # Kenya has multiple admin levels in humanitarian dataset
  max_lvl <- fieldmaps:::get_max_level("KEN", "humanitarian", con)
  expect_type(max_lvl, "double")
  expect_gte(max_lvl, 1)
  expect_lte(max_lvl, 4)
})

test_that("get_max_level returns correct level for open dataset", {
  skip_if_offline()
  skip_on_cran()

  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  fieldmaps:::load_extensions(con)

  max_lvl <- fieldmaps:::get_max_level("USA", "open", con)
  expect_type(max_lvl, "double")
  expect_gte(max_lvl, 1)
  expect_lte(max_lvl, 4)
})

test_that("get_max_level handles different countries", {
  skip_if_offline()
  skip_on_cran()

  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  fieldmaps:::load_extensions(con)

  # Test multiple countries
  max_ken <- fieldmaps:::get_max_level("KEN", "humanitarian", con)
  expect_type(max_ken, "double")

  max_usa <- fieldmaps:::get_max_level("USA", "open", con)
  expect_type(max_usa, "double")

  max_fra <- fieldmaps:::get_max_level("FRA", "open", con)
  expect_type(max_fra, "double")
})

test_that("get_max_level throws error for invalid ISO3 code", {
  skip_if_offline()
  skip_on_cran()

  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  fieldmaps:::load_extensions(con)

  expect_error(
    fieldmaps:::get_max_level("XXX", "humanitarian", con),
    "No administrative levels found"
  )
})

test_that("get_max_level throws error for country not in dataset", {
  skip_if_offline()
  skip_on_cran()

  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  fieldmaps:::load_extensions(con)

  # Use a valid ISO3 code that might not be in the humanitarian dataset
  expect_error(
    fieldmaps:::get_max_level("ZZZ", "humanitarian", con),
    "No administrative levels found|could not be converted"
  )
})

test_that("get_max_level correctly maps dataset names to CSV files", {
  skip_if_offline()
  skip_on_cran()

  con <- DBI::dbConnect(duckdb::duckdb())
  on.exit(DBI::dbDisconnect(con, shutdown = TRUE))

  fieldmaps:::load_extensions(con)

  # Should work with "humanitarian" mapping to "cod.csv"
  expect_error(
    fieldmaps:::get_max_level("KEN", "humanitarian", con),
    NA
  )

  # Should work with "open" mapping to "geoboundaries.csv"
  expect_error(
    fieldmaps:::get_max_level("USA", "open", con),
    NA
  )
})
