tabPanel(title = icon("project-diagram"), value = "2",
  div(h4("Joining datasets"), help_link("all", "join_help")),
  p(paste("Here is where you can join clinical, assay, and/or feature data, essentially merging the two datasets",
           "into one new dataset. Please note that the new dataset may be unwieldy and/or not able to be loaded into",
           "Excel.")),
  selectInput("data_to_join1", "Choose the first dataset to join:", choices = c("clinical", "assay", "feature")),
  uiOutput("col_to_join1_selector"),
  primary_button("add_dataset", "Add dataset"),
  disabled(secondary_button("remove_dataset", "Remove last", class = "right_align")),
  br(),
  br(),
  primary_button("join_columns", div(icon("project-diagram"), "Join")),
  hr(), navigation_set("1", "2", "3", "all_data_options", "all_data_options")
)
