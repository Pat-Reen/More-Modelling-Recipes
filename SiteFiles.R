# Create site.yml

FileText <- paste0('
name: "Recipes"
navbar:
  title: "Recipes"
  type: inverse
  left:
    - text: "Home"
      href: index.html
    - text: "Other"
      href: other.html
  right:
    - href: https://www.linkedin.com/in/patrick-reen/
      icon: fa-linkedin
    - href: https://github.com/Pat-Reen/
      icon: fa-github
output:
  rmdformats::downcute:
    self_contained: true
    css: style.css 
    code_folding: hide
out_dir: "docs"
')

readr::write_lines(FileText, file = "_site.yml")

# Create css

FileText <- paste0('
nav{
 padding-bottom:20px;
}

body{
 padding-top:20px;
}

#toc {
  margin: 40px 0px 40px 0px;
  background: url("img/image.png");
  background-size: contain 20%;
  padding-top: 200px;
  background-repeat: no-repeat;
}
')

readr::write_lines(FileText, file = "/style.css")

