library(testthat)
library(dplyr)

# Sample data for testing
test_data <- tibble(
  group = c('A', 'A', 'B', 'B', 'B'),
  var1 = c(1, NA, 3, NA, 5),
  var2 = c(NA, 2, 3, 4, NA)
)

# Test 1: Basic functionality check
test_that("count_all_missing_by_group works correctly", {
  result <- count_all_missing_by_group(test_data, group)

  # Check the result matches expected output
  expect_equal(result, tibble(
    group = c('A', 'B'),
    var1 = c(1, 1),
    var2 = c(1, 1)
  ))
})

# Test 2: Edge case with no missing values
test_that("count_all_missing_by_group works with no missing values", {
  no_missing_data <- tibble(
    group = c('A', 'A', 'B', 'B'),
    var1 = c(1, 2, 3, 4),
    var2 = c(5, 6, 7, 8)
  )

  result <- count_all_missing_by_group(no_missing_data, group)

  expect_equal(result, tibble(
    group = c('A', 'B'),
    var1 = c(0, 0),
    var2 = c(0, 0)
  ))
})

# Test 3: Edge case with all missing values
test_that("count_all_missing_by_group works with all missing values", {
  all_missing_data <- tibble(
    group = c('A', 'B', 'C'),
    var1 = c(NA, NA, NA),
    var2 = c(NA, NA, NA)
  )

  result <- count_all_missing_by_group(all_missing_data, group)

  expect_equal(result, tibble(
    group = c('A', 'B', 'C'),
    var1 = c(1, 1, 1),
    var2 = c(1, 1, 1)
  ))
})

# Test 4: Check the effect of .groups argument
test_that("count_all_missing_by_group respects .groups argument", {
  result_drop <- count_all_missing_by_group(test_data, group, .groups = "drop")
  result_keep <- count_all_missing_by_group(test_data, group, .groups = "keep")

  expect_s3_class(result_drop, "data.frame")
  expect_s3_class(result_keep, "grouped_df")

  # Make sure the 'keep' version is grouped
  expect_true(is_grouped_df(result_keep))
})

# Test 5: Ensure proper error handling for invalid .groups argument
test_that("count_all_missing_by_group throws an error with invalid .groups", {
  expect_error(count_all_missing_by_group(test_data, group, .groups = "invalid"),
               ".groups needs to be one of NULL, 'drop_last', 'drop', 'keep', and 'rowwise'.")
})

# Test 6: Check behavior when 'group_col' is a factor variable
test_that("count_all_missing_by_group works with factor group column", {
  factor_group_data <- tibble(
    group = factor(c('A', 'A', 'B', 'B', 'B')),
    var1 = c(1, NA, 3, NA, 5),
    var2 = c(NA, 2, 3, 4, NA)
  )

  result <- count_all_missing_by_group(factor_group_data, group)

  expect_equal(result, tibble(
    group = factor(c('A', 'B')),
    var1 = c(1, 1),
    var2 = c(1, 1)
  ))
})

# Test 7: Edge case with an empty dataset
test_that("count_all_missing_by_group handles empty data", {
  empty_data <- tibble(
    group = character(0),
    var1 = numeric(0),
    var2 = numeric(0)
  )

  result <- count_all_missing_by_group(empty_data, group)

  expect_equal(result, tibble(group = character(0), var1 = integer(0), var2 = integer(0)))
})
