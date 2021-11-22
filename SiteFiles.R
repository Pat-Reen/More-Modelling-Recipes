# Create site.yml

FileText <- paste0('
name: "More-recipes"
title: "More recipes"
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

.posts-list-caption {
    display: none;
}

.distill-site-header {
  --bkgd-color:     #010101;
  --title-size:     25px;
  --text-size:      20px;
}

.distill-site-header .logo img {
    float: left;
    width: 100px;
    height: 100px;
    max-height: 100px;
}

.distill-site-header .nav-right {
    float: right;
    display: flex;
    justify-content: space-around;
}

.distill-site-header .title {
    float: left;
    display: flex;

}


')

readr::write_lines(FileText, file = "main.css")
