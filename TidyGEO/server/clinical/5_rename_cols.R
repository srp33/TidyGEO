output$display_cols_to_rename <- renderUI({
  selectInput(inputId = "colsToRename", 
              label = "Which column would you like to rename?", 
              choices = clinical_colnames(), 
              selected = clinical_vals$last_selected_rename)
})

observeEvent(input$rename, {
  if (data_loaded("clinical")) {
    if (!input$rename_new_name %in% clinical_colnames()) {
      set_x_equalto_y("last_selected_rename", input$rename_new_name, "clinical")
      
      invalid_chars <- str_extract_all(input$rename_new_name, INVALID_NAME_CHARS)[[1]]
      if (!identical(invalid_chars, character(0))) {
        showModal(
          error_modal("Warning", 
                      paste0('Input "', input$rename_new_name, '" changed to "', str_replace_all(input$rename_new_name, INVALID_NAME_CHARS, VALID_REPLACEMENT), '".'), 
                      paste0("Invalid characters (", paste0(unique(invalid_chars), collapse = ","), ") in new column name."))
        )
      }
      
      status <- eval_function("clinical", "renameCols", 
                              list(input$colsToRename, input$rename_new_name), "rename column")
      if (status != SUCCESS) {
        showModal(
          error_modal("Error in rename column", "Column not renamed.", status)
        )
      }
    } else {
      showModal(
        modalDialog(
          HTML(
            paste0('<font color="red"> Looks like  "', input$rename_new_name, 
                   '" is already taken. Please choose a different name to avoid duplicates. </font>')
          ),
          title = HTML('<font color="red">Whoops!</font>'), 
          footer = modalButton("OK")
        )
      )
    }
  }
})

observeEvent(input$undo_rename, {
  undo_last_action("clinical")
})

navigation_set_server("4", "5", "6", "clinical_side_panel", "clinical_side_panel")
