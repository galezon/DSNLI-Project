# DSNLI-Project
Project for Data Science and Non-life insurance class by Dr. Antonio, where I follow [1]. Ultimately I chose to do GLM+GAM and random forest.

Throughout this project there are several notebooks, each represents a task that I had to do to complete the project. In each task-related subfolders, there is a file called *main* where I completed the task. You should read the *main* notebooks of each task-related subfolder in this order:
  * data_exploration/main.nb.html                  # Data exploration. I decided to remove postcodes and work with (LAT, LONG) instead.
  * gam_binning/main.nb.html                       # Built a simpler GAM so that I can bin AGEPH, and (LAT, LONG).
  * glm/main.nb.html                               # Where I built the GLM for frequency and severity.
  * random_trees/main.ipynb                        # Two random-forests for frequency and severity.
  * analyze_tariffs/main.ipynb                     # Analyzing the tariff structure made by random forest and glm.


References:

[1] Roel Henckaerts, Katrien Antonio, Maxime Clijsters & Roel Verbelen (2018): A
    data driven binning strategy for the construction of insurance tariff classes, Scandinavian Actuarial
    Journal, DOI: 10.1080/03461238.2018.1429300
