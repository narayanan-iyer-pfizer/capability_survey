create_question_matrix <- function(question ,question_name, option,input_type = "matrix",
                                   dependence = NA,
                                   dependence_value = NA,
                                   required = FALSE){
 
  cleaned_question_name <- gsub('[[:punct:] ]*\\s*','',question_name)
  input_id_calculated <- paste0(cleaned_question_name,"_matrix")
  dependence <- cleaned_question_name
  dependence_value <- "Yes"
  temp1 <- tibble(question,input_id = input_id_calculated,required )
  temp2 <- tibble(option,input_id =input_id_calculated,input_type,dependence,dependence_value)
  temp2 <- full_join(temp1,temp2,by ="input_id")
  temp2 <- temp2 |>
    add_row(question = paste0("From the baseline survey, have there been changes in your ",
                              question_name," ?"),
                         option = c("Yes","No"),input_id = cleaned_question_name,input_type ="y/n" ,
    dependence = NA,
                    dependence_value = NA,
                    required = TRUE,.before = 1)
  temp2
}

