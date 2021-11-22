# Create site.yml

FileText <- paste0('
name: "Modelling and data visualisation recipes"
title: "More recipes"
image: img/image.png
description: |
  Exploring a few simple and reproducible modelling and data visualisation recipes. Download the code from the github repository.
base_url: https://pat-reen.github.io/More-Modelling-Recipes/
theme: main.css 
navbar:
  logo: img/logo.png
  search: false
  right:
    - icon: fa-home
      href: index.html
    - icon: fab fa-linkedin
      href: https://www.linkedin.com/in/patrick-reen/
    - icon: fab fa-github
      href: https://github.com/Pat-Reen
output_dir: "docs"
output: distill::distill_article
collections:
  posts:
    share: [twitter, linkedin]
    citations: false
    categories: false
    categories_metadata: true
')

readr::write_lines(FileText, file = "_site.yml")

# Create main.css

FileText <- paste0('

.distill-site-header .logo img {
    display: inline-block;
    width: 100px;
    height: 100px;
    max-height: 100px;
}

.posts-list-caption {
    display: none;
}

.distill-site-header {
    height: 100px;
}

.distill-site-header .title {
position: relative;
transform: translateY(-70%);
}

.distill-site-header .nav-right {
    top: 25%;
    position: relative;
}

d-title{
  margin-top: 50px;
}

.distill-site-header {
  --bkgd-color:       #010101;
}

@media screen and (max-width: 768px) {
  .distill-site-header .nav-left {
    margin-left: 0;
  }
  .d-title{
  margin-top: 0px;
  }
}

')

readr::write_lines(FileText, file = "main.css")
