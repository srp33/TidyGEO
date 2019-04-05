tabPanel("Assay data",
         fluidRow(
           column(7,
                  h4("Assay Data"),
                  p("The abundance measurement of each element derived from each sample.")
                  ),
           column(2,
                  br(),
                  tipify(tertiary_button(id = "resetExpr", label = div(icon("history"), "Reset"), class = "right_align"),
                         title = "Reset the dataset to its original downloaded state.", placement = "bottom", trigger = "hover")
                  )
         ),
         br(),
         div(
           secondary_button(id = "expression_prev_cols", label = div(icon("arrow-left"), "Previous columns")),
           secondary_button(id = "expression_next_cols", label = "Next columns", icon = icon("arrow-right"), class = "right_align")
         ),
         br(),
         bsAlert("alpha_alert"),
         withSpinner(dataTableOutput("exprPreview"), type = 5)#,
         #primary_button("expression_evaluate_filters", label = "Evaluate filters")
)