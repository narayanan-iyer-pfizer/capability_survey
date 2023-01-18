library(shinysurveys)
library(purrr)
library(dplyr)
library(shiny)
source("utils.R")
vg <- read.csv("questions.csv", check.names = FALSE,fileEncoding = "UTF-8")
option <- c("Not Trained","Novice",
  "Intermediate",
  "Advanced",
  "Expert",
  "No Change from Previous",
  "N/A")
 

df1 <- imap_dfr(vg,~ create_question_matrix(question =.x[.x != ""],
                                            question_name = .y,
                                            option = option,input_type = "matrix" )) |>
  add_row(question = "Select/Enter any new workstream/initiative you've worked on this semester",
          option = c("No new workstream/initiative",
                     "Global SPA Training (CDISC Education Series)", 
                     "Global SPA Training (P21 Training)",
                     "Global SPA Training (SPA Announcements-Monthly Lead for Sections)",
                     "Global SPA Training (R Education Series)",
                     "Global SPA Training (CDARS Education Series)",
                     "Global SPA Training (Lead Magnify Your Experience)",
                     "Global SPA Training (SPA Accelerator SharePoint)",
                     "Global SPA Training (eSub Education Series)",
                     "Global SPA Training (Lead SPA Education Forum)",
                     "Nurocor MDR",
                     "R COE",
                     "BeaconCure Verify",
                     "Automated aCRF Generation",
                     "SIGMA",
                     "Smart SDTM/Universal Translator",
                     "Smart Auto Mapper",
                     "Demotion Management System",
                     "Statistics for non-statisticians",
                     "Interns Training",
                     "QPC Initiative",
                     "Other")
                     ,
          input_id = "newworkstream_initiative",input_type ="mc" ,
          dependence = NA,
          dependence_value = NA,
          required = TRUE) |>
  add_row(question = "Enter new untagged workstream/Initiative exposure ",
  option = "Enter your Answer",
  input_id = "newworkstream_initiative_other",input_type ="text" ,
  dependence = "newworkstream_initiative",
  dependence_value = "Other",
  required = TRUE) |>
  add_row(question = c("Enter any new Therapeutic Area exposure (if any)",
                       "Enter any new topic you want to train/mentor newcomers in (if any)",
                       "Enter any other new experience/skillset you learned this semester that were not captured above (if any)"
                       ),
          option = "Enter your Answer",
          input_id = c(paste0("newopt",1:3)),input_type ="text" ,
          dependence = NA,
          dependence_value = NA,
          required = TRUE)

ui <- shiny::fluidPage(
  tags$head(
    # Note the wrapping of the string in HTML()
    tags$style(HTML("
      
      body {
        background-color: #006ABE;
        color: black;
      }
      th, td {
	vertical-align: bottom !important;
	text-align: left !important;
	width: 25px;
}
    body {
	font-family: Segoe UI,Segoe WP,Tahoma,Arial, sans-serif !important;
}
      .shiny-input-container {
        color: #474747;
      }"))),
  shinysurveys::surveyOutput(df  = df1,
                             survey_title = "Capability Headway",
                             survey_description = tags$div(
                                                            
"The Capability Questionnaire is a data collection tool to help evaluate and further build the strength, talent, and capabilities within the SPA India-Manila organization.",
tags$br(),
"Capabilities for which rating sought are pertinent to the roles and responsibilities in SPA. Please revisit your individual profile in the Capability Dashboard and evaluate yourself based on the knowledge gained from your recent work experience. Use 'No Change from Previous' when applicable.",
tags$br(),
tags$u(tags$b("Technical Scale for Items 1-14:")),
tags$br(),
tags$ul(
tags$li(tags$b("Not Trained"),": no technical know-how"), 
tags$li(tags$b("Novice"),": trained or knowledgeable with no hands on experience"),
tags$li(tags$b("Intermediate"),": limited exposure, can work with guidance"),
tags$li(tags$b("Advanced"),": mid-level exposure, can handle tasks independently"),
tags$li(tags$b("Expert"),": thoroughly skilled, can train/mentor other colleagues")),

tags$u("Soft Skill Scale for Item 15 (from ",tags$a(
  "learning.pfizer.com",
  target = "_blank",
  href = "learning.pfizer.com"
),"):"),
tags$br(),
tags$br(),
tags$b("1: "),"You have general knowledge about some aspects of the Skill. You are beginning to learn the tools associated with your Skill and how to use them to complete simple, routine tasks. Your best work is in a structured environment with supervision, predetermined processes, and established criteria to judge output against.",
tags$br(),
tags$br(),
tags$b("2: "),"You have extended your knowledge beyond the fundamentals and into the theory of your Skill domain. You are comfortable using the tools of the trade as you continue to develop your technical Skills. You can work independently on new challenges, know enough to be self-critical, and know the difference between good and great work. You are also good at setting goals and measuring progress",
tags$br(),
tags$br(),
tags$b("3: "),"You are a skilled practitioner that uses a broad range of methods to solve problems: From planning to execution. You can tackle specialized tasks and apply your Skills to complex problems that might require a new process or approach. You can work independently on complex projects, and when those projects are complete, you are able to look at your work and accurately evaluate whether it was successful or unsuccessful.",
tags$br(),
tags$br(),
tags$b("4: "),"You have robust and specialized knowledge about your Skill. You have a proven track record of success and bring a wide range of cognitive and practical Skills to the table to solve new and complex problems. You can lead an initiative and see it through to the end.",
tags$br(),
tags$br(),
tags$b("5: "),"You are a skilled practitioner that uses a broad range of methods to solve problems: From planning to execution. You can tackle specialized tasks and apply your Skills to complex problems that might require a new process or approach. You can work independently on complex projects, and when those projects are complete, you are able to look at your work and accurately evaluate whether it was successful or unsuccessful.",
tags$br(),
tags$br(),
tags$b("6: "),"You are an innovator and your work is highlighted as your industry's best. You use tools in such a complex and experimental way that others look to you for best practices. You are the one setting the trends that others will follow. You also likely have one or two areas of expertise that are highly specialized or advanced.",
tags$br(),
tags$br(),
tags$b("7: "),"Your knowledge and unique vision of the field are highly sought after. You have a grasp on what the future of your domain will hold and how it might affect people, tools, technology, processes, and the world as a whole. You are recognized as a world-class leader in your field. You are also developing new standards, practices, and innovating beyond the majority of your peers."
)
))

server <- function(input, output, session) {
  
  
  shinysurveys::renderSurvey()
  observeEvent(input$submit,{
    
     
  })
}

shiny::shinyApp(ui = ui, server = server)



  
