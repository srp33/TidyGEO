output$sliderExclude <- renderUI({
  
  output <- tagList()
  #browser()
  if (!is.null(input$col_valsToExclude) && input$col_valsToExclude %in% colnames(clinical_vals[[dataname("clinical")]])) {
        if (isAllNum(clinical_vals[[dataname("clinical")]][input$col_valsToExclude])) {
          currCol <- as.numeric(as.character(clinical_vals[[dataname("clinical")]][!is.na(clinical_vals[[dataname("clinical")]][,input$col_valsToExclude]),input$col_valsToExclude]))
          output[[1]] <- radioButtons("excludeToKeep", label = "I would like to:", 
                                      choices = list("exclude the values within the range." = "exclude", 
                                                     "include the values within the range." = "keep"))
          output[[2]] <- sliderInput(inputId = "sliderExclude", label = "Please choose a range of values (inclusive)", min = min(currCol), max = max(currCol), value = c(quantile(currCol)[2], quantile(currCol)[3]))
        }
        else {
          #p(style = "color:red", "Looks like this column isn't numeric!")
          output[[1]] <- div(tags$b("Which values would you like to exclude?"), 
                             help_button("Excluding a value will remove the entire row that contains that value."))
          output[[2]] <- checkboxInput(inputId = "select_all_exclude", label = tags$i("Select all"))
          #browser()
          #if (!is.null(input$col_valsToExclude)) {
            #valNames <- unique(as.character(clinical_vals[[dataname("clinical")]][,input$col_valsToExclude]))
            #valNames[which(is.na(valNames))] <- "NA"
          output[[3]] <- checkboxGroupInput(inputId = "valsToExclude", 
                                            label = NULL,
                                            choices = to_exclude_options())
          #}
        }
    output
  }
  
})

output$display_cols_for_exclude <- renderUI({
  #colNames <- colnames(clinical_vals[[dataname("clinical")]][-which(colnames(clinical_vals[[dataname("clinical")]]) == "evalSame")])
  colNames <- colnames(clinical_vals[[dataname("clinical")]])
  setNames(colNames, colNames)
  selectInput(inputId = "col_valsToExclude", label = div("Column to use as filtering criteria: ", 
                                                         help_link("clinical", "exclude_help")), 
              choices = colNames,
              selected = clinical_vals$last_selected_exclude)
})

to_exclude_options <- reactive({
  if (!is.null(input$col_valsToExclude) && input$col_valsToExclude %in% colnames(clinical_vals[[dataname("clinical")]])) {
    valNames <- unique(as.character(clinical_vals[[dataname("clinical")]][,input$col_valsToExclude]))
    valNames[which(is.na(valNames))] <- "NA"
    valNames
    
  }
})

observe({
  if (!is.null(input$select_all_exclude)) {
    updateCheckboxGroupInput(
      session, 'valsToExclude', choices = to_exclude_options(),
      selected = if (input$select_all_exclude) to_exclude_options()
    )
  }
})

#output$display_vals_to_exclude <- renderUI({
#  if (!is.null(input$col_valsToExclude)) {
#    valNames <- unique(as.character(clinical_vals[[dataname("clinical")]][,input$col_valsToExclude]))
#    valNames[which(is.na(valNames))] <- "NA"
#    checkboxGroupInput(inputId = "valsToExclude", 
#                       label = NULL,
#                       choices = to_exclude_options())
#  }
#})

observeEvent(input$clinical_evaluate_exclude, {
  
  if (!is.null(input$col_valsToExclude) && (!is.null(input$valsToExclude) || !is.null(input$sliderExclude))) {
    #if (input$exclude_isrange && isAllNum(clinical_vals[[dataname("clinical")]][input$col_valsToExclude])) {
    if (isAllNum(clinical_vals[[dataname("clinical")]][input$col_valsToExclude])) {
      to_exclude <- paste(input$excludeToKeep, paste(input$sliderExclude, collapse = " - "), sep = ": ")
    } 
    else {
      to_exclude <- input$valsToExclude
    }
    clinical_vals$last_selected_exclude <- input$col_valsToExclude
    status <- withProgress(
      eval_function("clinical", "excludeVars", list(input$col_valsToExclude, to_exclude), "exclude undesired samples"), 
      message = "Filtering rows"
      )
    if (status != SUCCESS) {
      showModal(
        error_modal("Error in exclude values", "No values excluded.", status)
      )
    }
  }
})

observeEvent(input$undo_filter, {
  undo_last_action("clinical")
})

navigation_set_server("6", "7", "8", "clinical_side_panel", "clinical_side_panel")
