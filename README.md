    Place  delta3h     Score  Entries   Last Submission UTC  Entry
      124       -8   0.72821       11       17 Apr 00:05:50  RandomForest
       82       -6   0.72161        8       16 Apr 00:40:05  LinearRegressionAllVars
       79       -2   0.69257        4       15 Apr 19:30:02
       74       -5   0.69178        2       15 Apr 18:31:26
       55      new	 0.64140        1       15 Apr 12:38:05

To load your new project, you'll first need to `setwd()` into the directory
where this README file is located. Then you need to run the following two
lines of R code:

  library('ProjectTemplate')
	load.project()

After you enter the second line of code, you'll see a series of automated
messages as ProjectTemplate goes about doing its work. This work involves:
* Reading in the global configuration file contained in `config`.
* Loading any R packages you listed in he configuration file.
* Reading in any datasets stored in `data` or `cache`.
* Preprocessing your data using the files in the `munge` directory.

Once that's done, you can execute any code you'd like. For every analysis
you create, we'd recommend putting a separate file in the `src` directory.
If the files start with the two lines mentioned above:

	library('ProjectTemplate')
	load.project()

You'll have access to all of your data, already fully preprocessed, and
all of the libraries you want to use.

For more details about ProjectTemplate, see http://projecttemplate.net
