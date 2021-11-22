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

@media screen and (max-width: 768px) {
  .distill-site-header .nav-left {
    margin-left: 0;
  }
  .d-title{
  margin-top: 0px;
  }
}

@media screen and (max-width: 768px) {
  .distill-site-header a, .distill-site-header .nav-dropdown  {display: none;}
  .distill-site-header a.nav-toggle {
    float: right;
    display: block;
  }
  .distill-site-header .title {
    margin-left: 0;
  }
  .distill-site-header .nav-right {
    margin-right: 0;
  }
  .distill-site-header {
    overflow: hidden;
  }
  .nav-right .nav-dropdown-content {
    margin-left: 0;
  }
}

@media screen and (max-width: 768px) {
  .distill-site-header.responsive {position: relative; min-height: 500px; }
  .distill-site-header.responsive a.nav-toggle {
    position: absolute;
    right: 0;
    top: 0;
  }
  .distill-site-header.responsive a,
  .distill-site-header.responsive .nav-dropdown {
    display: block;
    text-align: left;
  }
  .distill-site-header.responsive .nav-left,
  .distill-site-header.responsive .nav-right {
    width: 100%;
  }
  .distill-site-header.responsive .nav-dropdown {float: none;}
  .distill-site-header.responsive .nav-dropdown-content {position: relative;}
  .distill-site-header.responsive .nav-dropdown .nav-dropbtn {
    display: block;
    width: 100%;
    text-align: left;
  }
}

')

readr::write_lines(FileText, file = "main.css")
