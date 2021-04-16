#outputs resources modal
resourcesModal <- function(){
  modal <- fluidPage(
    img(src="mentalhealth.jpg", height = "50%", width = "50%", style="display: block; margin-left: auto; margin-right: auto;", alt="found on google"),
    tags$h6(tags$a(href="https://api.hub.jhu.edu/factory/sites/default/files/styles/soft_crop_2400/public/mental_health_040620.jpg?itok=eObhgWGI", "image credit"), align="center"), 
  
    tags$h4("Here are some resources to learn more about mental health:"), 
    
    tags$hr(),
    tags$h5("Helplines and Available Services in Singapore"),
    tags$ul(
      tags$li(tags$a(href="https://www.ncss.gov.sg/NCSS/media/NCSS-Documents-and-Forms/NCSS%20Internal%20Documents/Directory-on-Mental-Health-Services.pdf", "Mental Health Services Resource Directory"))
    ),
    
    tags$br(),
    tags$h5("Resources for Depression"),
    tags$ul(
      tags$li(tags$a(href="https://www.uofmhealth.org/health-library/ug4843", "Myths and Facts about Depression")),
      tags$li(tags$a(href="https://www.mayoclinic.org/diseases-conditions/depression/in-depth/depression/art-20045943", "Supporting a Family Member or Friend with Depression"))
    ),
    
    tags$br(),
    tags$h5("Resources for Anxiety"),
    tags$ul(
      tags$li(tags$a(href="https://www.banyanmentalhealth.com/2018/08/02/common-misconceptions-about-anxiety-disorders/", "Common Misconceptions about Anxiety Disorders")),
      tags$li(tags$a(href="https://www.hopkinsmedicine.org/health/treatment-tests-and-therapies/how-to-help-someone-with-anxiety", "How to Help Someone with Anxiety"))
    ),
    
    tags$br(),
    tags$h5("Resources for Eating Disorders"),
    tags$ul(
      tags$li(tags$a(href="https://www.aware.org.sg/information/eating-disorders/", "Information about Eating Disorders")),
      tags$li(tags$a(href="https://www.nationaleatingdisorders.org/toolkit/parent-toolkit/eating-disorder-myths", "Eating Disorder Myths")),
      tags$li(tags$a(href="https://au.reachout.com/articles/how-to-help-a-friend-with-an-eating-disorder", "How to Help a Friend with an Eating Disorder"))
    )
  ) 
  return(modal)
}











