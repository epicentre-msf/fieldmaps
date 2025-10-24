#' Load required DuckDB extensions for spatial and HTTP operations
#'
#' This function installs and loads the necessary DuckDB extensions required
#' for working with spatial data and remote files via HTTP/HTTPS.
#'
#' @param con A DBI database connection object (typically DuckDB connection)
#'
#' @return NULL (invisible). Function is called for its side effects.
#'
#' @details
#' The function performs the following operations:
#' 1. Installs and loads the 'spatial' extension for spatial data operations
#' 2. Installs and loads the 'httpfs' extension for HTTP/HTTPS file access
#' 3. Registers GeoArrow extensions for enhanced spatial data handling
#'
#' @keywords internal
load_extensions <- function(con) {
  DBI::dbExecute(con, "INSTALL spatial")
  DBI::dbExecute(con, "LOAD spatial")
  DBI::dbExecute(con, "INSTALL httpfs")
  DBI::dbExecute(con, "LOAD httpfs")
  DBI::dbExecute(con, "CALL register_geoarrow_extensions()")
}

#' Validate and standardize country input
#'
#' This function takes a country input (either country name or ISO3 code) and
#' ensures it's returned as a valid uppercase ISO3 code. If a country name is
#' provided, it attempts to convert it to an ISO3 code using the countrycode
#' package.
#'
#' @param country A character string representing either a country name or
#'   ISO3 code (e.g., "United States" or "USA")
#'
#' @return A character string containing the uppercase ISO3 country code
#'
#' @details
#' The function performs the following steps:
#' 1. Converts input to uppercase
#' 2. Checks if input is already a 3-letter ISO code
#' 3. If not, attempts conversion using countrycode package
#' 4. Throws an error if conversion fails
#'
#' @keywords internal
validate_country <- function(country) {
  c_raw <- country
  # common exceptions
  if (country %in% c("DRC", "drc")) {
    country <- "COD"
  }
  if (country %in% c("CAR", "car")) {
    country <- "CAF"
  }
  # if 3 letter lowercase code supplied, convert to upper
  if (grepl("^[a-z]{3}$", country)) {
    country <- toupper(country)
  }
  # if a 3 letter iso code is not supplied, try to convert
  # the country name to the an iso code with countrycode
  if (!grepl("^[A-Z]{3}$", country)) {
    country <- suppressWarnings(countrycode::countrycode(country, "country.name", "iso3c"))
    if (is.na(country)) {
      cli::cli_abort(c(
        "x" = "Country name '{c_raw}' could not be converted to an ISO3 code. Did you spell it correctly?",
        "i" = "Try supplying the ISO3 code instead.",
        "i" = "See https://en.wikipedia.org/wiki/ISO_3166-1_alpha-3 for details."
      ))
    }
  }
  return(country)
}

#' Get maximum administrative level for a country
#'
#' Queries the remote CSV file to determine the highest administrative level
#' available for a given country in the specified dataset.
#'
#' @param iso3 A character string containing the ISO3 country code
#' @param dataset A character string specifying the dataset type, either
#'   "humanitarian" or "open"
#' @param con A DBI database connection object
#'
#' @return An integer representing the maximum administrative level available
#'   for the country
#'
#' @details
#' The function maps dataset names to CSV file names:
#' - "humanitarian" maps to "cod.csv"
#' - "open" maps to "geoboundaries.csv"
#'
#' @keywords internal
get_max_level <- function(iso3, dataset, con) {
  csv_name <- switch(dataset, humanitarian = "cod", open = "geoboundaries")
  DBI::dbGetQuery(
    con,
    glue::glue_sql(
      "SELECT src_lvl as n
       FROM read_csv_auto('https://data.fieldmaps.io/{`csv_name`}.csv')
       WHERE iso_3 = {iso3}",
      .con = con
    )
  )$n
}

#' Generate SQL query for administrative boundary data
#'
#' Creates a SQL query string to retrieve administrative boundary data from
#' Field Maps remote parquet files based on specified parameters.
#'
#' @param iso3 A character string containing the ISO3 country code
#' @param level An integer specifying the administrative level (1, 2, 3 or 4)
#' @param con A DBI duckdb connection object for SQL safety
#' @param dataset A character string specifying the dataset type, either
#'   "humanitarian" (default) or "open"
#' @param geom A character string specifying the geometry type, either
#'   "polygons" (default), "lines" or "points"
#'
#' @return A character string containing the SQL query
#'
#' @keywords internal
field_maps_qry <- function(iso3, level, con, dataset = "humanitarian", geom = "polygons") {
  glue::glue_sql(
    "SELECT * EXCLUDE geometry_bbox
     FROM 'https://data.fieldmaps.io/edge-matched/{`dataset`}/intl/adm{level}_{`geom`}.parquet'
     WHERE iso_3 = {iso3}",
    .con = con
  )
}
