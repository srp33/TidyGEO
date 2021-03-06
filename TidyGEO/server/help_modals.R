# helper functions --------------------------------------------------------


#' Create a pop-up box with instructions.
#'
#' @param help_file .
#' @param images_id .
#' @return .
#' @examples
#' help_modal("My_Help_File.md", "my_images_id")
help_modal <- function(help_file, images = NULL, image_names = NULL) {
  #start_time <- Sys.time()
  showModal(
    modalDialog(
      includeMarkdown(help_file),
      conditionalPanel(
        condition = !is.null(images),
        #uiOutput(images_id)
        create_image_grid(images, image_names)
      ),
      footer = modalButton("Close"),
      size = "l",
      easyClose = TRUE
    )
  )
  #end_time <- Sys.time()
  #print(paste("Creating help modal", end_time - start_time))
}

#help_modal_server <- function() {
#  toggleModal(session, 'columnModal', toggle = "open")
#}

# help_modal_ui <- function(trigger, title, help_file, images = NULL, image_names = NULL) {
#   bsModal(
#     id = paste(trigger, "modal", "ui", sep = SEP),
#     title = title,
#     trigger = trigger,
#     includeMarkdown(help_file),
#     conditionalPanel(
#       condition = !is.null(images),
#       create_image_grid(images, image_names)
#     )
#   )
# }

#' .
#'
#' @param images .
#' @param image_names .
#' @return .
#' @examples
#' create_image_grid(c("image.gif", "image2.gif"), c("Image", "Image 2"))
img_sep <- "%%%"
create_image_grid <- function(images, image_names) {
  #start_time <- Sys.time()
  image_grid <- fluidRow(
    mapply(function(my_image, img_name) {
      column(3, 
             div(tags$img(src = my_image, width = "200px", class = "clickimg", "data-value" = paste(my_image, img_name, sep = img_sep)), img_name)
      )
    }, images, image_names, SIMPLIFY = FALSE, USE.NAMES = FALSE)
  )
  #end_time <- Sys.time()
  #print(paste("Creating image grid", end_time - start_time))
  return(image_grid)
}

# listeners ---------------------------------------------------------------

observeEvent(input$shift_help_clicked, {
  images <- c("shift_cells_example.gif", "shift_cells_example_part2.gif", "shift_cells_example_part3.gif")
  image_names <- c("Demo - Cells to Shift", 'Demo - "From" vs "Into"', "Demo - Cell Shift Result")

  help_modal("help_docs/Shift_Cells_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "shift_help_clicked")
})

observeEvent(input$split_help_clicked, {
  images <- c("split_pairs1.gif", "split_pairs2.gif", "split_pairs3.gif")
  image_names <- c("Demo - Key/Value Pairs", "Demo - Delimiter", "Demo - Split Result")

  help_modal("help_docs/Split_Vars_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "split_help_clicked")
})

observeEvent(input$divide_help_clicked, {
  images <- c("split_cols1.gif", "split_cols2.gif", "split_cols3.gif")
  image_names <- c("Demo - Different Values", "Demo - Delimiter", "Demo - Split Result")

  help_modal("help_docs/Divide_Vars_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "divide_help_clicked")
})

observeEvent(input$substitute_help_clicked, {
  images <- c("substitute_letter.gif", "substitute_numeric.gif", "substitute_nothing.gif")
  image_names <- c("Demo - Substitute", "Demo - Substitute Range", "Demo - Delete Letter")

  help_modal("help_docs/Substitute_Vals_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "substitute_help_clicked")
})

observeEvent(input$regex_help_clicked, {
  values$regex_dt <- ALLOWED_DATATYPES[which(str_detect(input$regex_help_clicked, ALLOWED_DATATYPES))]
  if (identical(values$regex_dt, character(0))) {
    stop("Error in opening regex modal. The button that called the modal is not tagged with a valid datatype.")
  } else {
    source(file.path("server", "regex_modal.R"), local = TRUE)$value
  }
  session$sendCustomMessage("resetValue", "regex_help_clicked")
})

observeEvent(input$exclude_help_clicked, {
  images <- c("exclude_na.gif", "exclude_numeric.gif")
  image_names <- c("Demo - Exclude Blank Values", "Demo - Exclude Range")

  help_modal("help_docs/Exclude_Vals_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "exclude_help_clicked")
})

observeEvent(input$download_help_clicked, {
  images <- c("download_data_example_part1.gif", "download_example_part2.gif", "download_example_part3.gif")
  image_names <- c("Demo - Load Series and View Publication Info", "Demo - Import Series from GEO", "Demo - Next Steps")

  help_modal("help_docs/Download_Data_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "download_help_clicked")
})

observeEvent(input$r_help_clicked, {
  help_modal("help_docs/R_Help_Documentation.md")
  session$sendCustomMessage("resetValue", "r_help_clicked")
})

observeEvent(input$replace_id_help_clicked, {
  images <- c("different_id_example2.gif")
  image_names <- c("Demo - Replacing the ID Column")

  help_modal("help_docs/Different_ID_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "replace_id_help_clicked")
})

observeEvent(input$transpose_help_clicked, {
  images <- c("transpose_example2.gif")
  image_names <- c("Demo - Transpose Columns and Rows")

  help_modal("help_docs/Transpose_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "transpose_help_clicked")
})

observeEvent(input$match_help_clicked, {
  images <- c("matching_datasets_example.gif")
  image_names <- c("Demo - Matching up datasets")
  
  help_modal("help_docs/Match_Dataset_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "match_help_clicked")
})

observeEvent(input$join_help_clicked, {
  images <- c("joining_datasets_example.gif")
  image_names <- c("Demo - Joining datasets")
  
  help_modal("help_docs/Join_Dataset_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "join_help_clicked")
})

observeEvent(input$filter_help_clicked, {
 images <- c("filter_allsame_example.gif", 
             "filter_unique_example.gif", 
             "filter_date_example.gif", 
             "filter_webaddress_example.gif", 
             "filter_presets_steps_example.gif", 
             "filter_columnname_example.gif")
 image_names <- c("Demo - Columns that are All the Same", 
                  "Demo - Columns that are All Unique",
                  "Demo - Columns that Contain a Date",
                  "Demo - Columns that are a Web Address",
                  "Demo - Filter Using Presets",
                  "Demo - Filter by Column Name")

 help_modal("help_docs/Filter_Data_Documentation.md", images, image_names)
 session$sendCustomMessage("resetValue", "filter_help_clicked")
})

observeEvent(input$evaluate_filters_help_clicked, {
  images <- c("apply_filters_example.gif")
  image_names <- c("Demo - Apply Filters")

  help_modal("help_docs/Apply_Filters_Documentation.md", images, image_names)
  session$sendCustomMessage("resetValue", "evaluate_filters_help_clicked")
})

observeEvent(input$files_help_clicked, {
  help_modal("help_docs/File_Types_Documentation.md")
  session$sendCustomMessage("resetValue", "files_help_clicked")
})

observeEvent(input$zip_files_help_clicked, {
  # https://file.org/extension/gz
  # https://www.google.com/search?q=how+to+open+tar.gz+on+windows+10&rlz=1C1SQJL_enUS777US777&oq=how+to+open+tar.gz+&aqs=chrome.3.0l2j69i57j0l3.7999j0j7&sourceid=chrome&ie=UTF-8
  # https://stackoverflow.com/questions/20762094/how-are-zlib-gzip-and-zip-related-what-do-they-have-in-common-and-how-are-they
})

# enlarge image listener --------------------------------------------------

observeEvent(input$clickimg, {
  #start_time <- Sys.time()
  img_data <- str_split(input$clickimg, img_sep)[[1]]
  showModal(
    modalDialog(
      title = img_data[2],
      tags$img(src = img_data[1], width = "100%", height = "100%"),
      # add logic for "next" and "back" buttons for addtl. images
      # add logic to return scrolling ability to bsModal upon closing (currently returns scrolling to main app)
      size = "l",
      easyClose = TRUE
    )
  )
  #end_time <- Sys.time()
  #print(paste("Creating enlarged image modal", end_time - start_time))
  session$sendCustomMessage("resetValue", "clickimg")
}, ignoreInit = TRUE)
