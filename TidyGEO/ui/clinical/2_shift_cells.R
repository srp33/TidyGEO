tabPanel(title = SHIFT_ICON, value = "2",
         h4("Shifting cells"),
         p('Sometimes, missing values can cause data from a single variable (such as "Sex" and "Freq" in ', 
           actionLink(inputId = "show_broken_cols_example", label = "this example)"),
           'to be scattered across multiple columns. This makes it difficult to extract data for the single variable.'),
         p("Here, you can identify a column whose values you would like to shift to a single column. Usually it is best
           to start at the rightmost column that has shifted values and work your way to the left.",
             help_link("clinical", "shift_help")),
         uiOutput("display_cols_to_shift"),
         uiOutput("display_destination_cols"),
         HTML('Here is a preview of the first 5 rows of the columns you have selected. Conflicts, where one value might
            be overwritten by another value, are shown in <font color="red">red.</font> You will be given an opportunity
              to resolve these conflicts when you click "Shift cells".'),
         wellPanel(DTOutput("shift_preview_table")),
         div(
           primary_button("evaluate_shift", div(SHIFT_ICON, "Shift cells")),
           undo_button("undo_shift")
         ),
         hr(), navigation_set("1", "2", "3", "clinical_side_panel", "clinical_side_panel")
         )