#' Get Administrative Boundaries for a Specific Level
#'
#' Downloads administrative boundary data for a specific administrative level
#' from the Field Maps dataset. Field Maps provides standardized administrative
#' boundaries for humanitarian and development use cases.
#'
#' @param country Character. Country name or ISO3 code to download boundaries for.
#' @param level Numeric. Administrative level to retrieve (1, 2, 3, or 4).
#'   Level 1 represents the largest sub-national divisions (states/provinces),
#'   with higher numbers representing smaller administrative units.
#' @param con DuckDB connection object. If NULL, a temporary connection will be created.
#' @param dataset Character. Dataset to use, either "humanitarian" or "open".
#'   Default is "humanitarian". See https://fieldmaps.io/data/ for details.
#' @param geom Character. Geometry type to retrieve: "polygons", "lines", or "points".
#'   Default is "polygons".
#' @param check_max_level Logical. Whether to validate that the requested level
#'   exists for the country. Default is TRUE.
#'
#' @return An sf object containing the administrative boundaries with CRS 4326 (WGS84).
#'
#' @examples
#' \dontrun{
#' # Get level 1 administrative boundaries for Kenya
#' kenya_adm1 <- get_adm_level("Kenya", level = 1)
#'
#' # Get level 2 boundaries using ISO3 code
#' ken_adm2 <- get_adm_level("KEN", level = 2)
#'
#' # Use open dataset instead of humanitarian
#' boundaries <- get_adm_level("Uganda", level = 1, dataset = "open")
#' }
#'
#' @export
get_adm_level <- function(country, level, con = NULL, dataset = "humanitarian", geom = "polygons", check_max_level = TRUE) {
  # Validate inputs
  iso3 <- validate_country(country)
  if (!is.numeric(level) || length(level) != 1 || !level %in% 1:4) {
    cli::cli_abort("{.arg level} must be 1, 2, 3, or 4.")
  }
  rlang::arg_match(dataset, c("humanitarian", "open"))
  rlang::arg_match(geom, c("polygons", "lines", "points"))

  # Connection management
  manage_connection <- is.null(con)
  if (manage_connection) {
    con <- DBI::dbConnect(duckdb::duckdb())
    on.exit(DBI::dbDisconnect(con, shutdown = TRUE))
  } else {
    if (!inherits(con, "duckdb_connection")) {
      cli::cli_abort("{.arg con} must be a DuckDB connection")
    }
  }

  # ensure extensions are loaded
  load_extensions(con)

  # Check requested admin level exists
  if (check_max_level) {
    max_level <- get_max_level(iso3, dataset, con)
    if (level > max_level) {
      cli::cli_abort("Requested admin level {level} not found. Field Maps has only {max_level} levels for country {iso3}.")
    }
  }

  # Build and execute query
  requireNamespace("geoarrow", quietly = TRUE) # ensure geoarrow is loaded for st_as_sf to work
  query <- field_maps_qry(iso3, level, con, dataset, geom)
  dplyr::tbl(con, dplyr::sql(query)) |>
    arrow::to_arrow() |>
    sf::st_as_sf(crs = 4326)
}

#' Get All Available Administrative Levels for a Country
#'
#' Downloads all available administrative boundary levels for a country from
#' the Field Maps dataset. This function automatically determines the maximum
#' administrative level available and retrieves all levels from 1 to the maximum.
#'
#' @inheritParams get_adm_level
#'
#' @return A named list of sf objects, with names like "ADM1", "ADM2", etc.
#'   Each sf object contains administrative boundaries for that level with CRS 4326 (WGS84).
#'
#' @examples
#' \dontrun{
#' # Get all administrative levels for Somalia
#' somalia_all <- get_all_adm_levels("Somalia")
#'
#' # Access individual levels
#' somalia_adm1 <- somalia_all$ADM1
#' somalia_adm2 <- somalia_all$ADM2
#'
#' # Get all levels from open dataset
#' boundaries <- get_all_adm_levels("ETH", dataset = "open")
#' }
#'
#' @export
get_all_adm_levels <- function(country, dataset = "humanitarian", geom = "polygons", con = NULL) {
  iso3 <- validate_country(country)

  # Connection management
  manage_connection <- is.null(con)
  if (manage_connection) {
    con <- DBI::dbConnect(duckdb::duckdb())
    on.exit(DBI::dbDisconnect(con, shutdown = TRUE))
  } else {
    if (!inherits(con, "duckdb_connection")) {
      cli::cli_abort("{.arg con} must be a DuckDB connection")
    }
  }

  # ensure extensions are loaded
  load_extensions(con)

  # Get max admin level for country
  level_max <- get_max_level(iso3, dataset, con)
  cli::cli_alert_info("Requesting {level_max} {iso3} admin levels available in Field Maps.")
  levels <- 1:level_max

  # Use the single layer function with the shared connection
  shps <- lapply(
    levels,
    function(level) get_adm_level(iso3, level, con, dataset, geom, check_max_level = FALSE)
  )
  names(shps) <- paste0("ADM", levels)

  shps
}
