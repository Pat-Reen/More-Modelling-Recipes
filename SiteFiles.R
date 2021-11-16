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
    self_contained: false
    css: style.css 
    code_folding: hide
')

readr::write_lines(FileText, file = "docs/_site.yml")

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

readr::write_lines(FileText, file = "docs/style.css")

# Create other

FileText<- paste0('

---
title: "About This Website"
---

More about this website.

')

readr::write_lines(FileText, file = "docs/other.html")
