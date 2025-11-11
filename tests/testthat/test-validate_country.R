test_that("validate_country handles uppercase ISO3 codes correctly", {
  expect_equal(fieldmaps:::validate_country("USA"), "USA")
  expect_equal(fieldmaps:::validate_country("KEN"), "KEN")
  expect_equal(fieldmaps:::validate_country("FRA"), "FRA")
  expect_equal(fieldmaps:::validate_country("GBR"), "GBR")
})

test_that("validate_country converts lowercase ISO3 codes to uppercase", {
  expect_equal(fieldmaps:::validate_country("usa"), "USA")
  expect_equal(fieldmaps:::validate_country("ken"), "KEN")
  expect_equal(fieldmaps:::validate_country("fra"), "FRA")
})

test_that("validate_country handles DRC special case", {
  expect_equal(fieldmaps:::validate_country("DRC"), "COD")
  expect_equal(fieldmaps:::validate_country("drc"), "COD")
})

test_that("validate_country handles CAR special case", {
  expect_equal(fieldmaps:::validate_country("CAR"), "CAF")
  expect_equal(fieldmaps:::validate_country("car"), "CAF")
})

test_that("validate_country converts country names to ISO3 codes", {
  expect_equal(fieldmaps:::validate_country("United States"), "USA")
  expect_equal(fieldmaps:::validate_country("Kenya"), "KEN")
  expect_equal(fieldmaps:::validate_country("France"), "FRA")
  expect_equal(fieldmaps:::validate_country("United Kingdom"), "GBR")
  expect_equal(fieldmaps:::validate_country("Germany"), "DEU")
})

test_that("validate_country throws error for invalid country names", {
  expect_error(
    fieldmaps:::validate_country("InvalidCountryXYZ"),
    "could not be converted to an ISO3 code"
  )
  expect_error(
    fieldmaps:::validate_country("NotACountry"),
    "could not be converted to an ISO3 code"
  )
})

test_that("validate_country throws error for empty or NA values", {
  expect_error(
    fieldmaps:::validate_country(""),
    "could not be converted to an ISO3 code"
  )
  expect_error(
    fieldmaps:::validate_country(NA_character_),
    "could not be converted to an ISO3 code"
  )
})

test_that("validate_country handles mixed case country names", {
  expect_equal(fieldmaps:::validate_country("united states"), "USA")
  expect_equal(fieldmaps:::validate_country("KENYA"), "KEN")
})
