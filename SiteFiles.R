# Create site.yml

FileText <- paste0('
name: "More modelling recipes"
title: "More recipes"
preview: img/logo.png
description: |
  Exploring simple reproducible modelling and visualisation recipes.
base_url: https://pat-reen.github.io/More-Modelling-Recipes/
theme: main.css 
navbar:
  logo: img/logo.png
  search: false
  right:
    - text: "Home"
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

')

readr::write_lines(FileText, file = "main.css")
