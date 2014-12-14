# How to contribute

I like to encourage you to contribute to the repository.
This should be as easy as possible for you but there are a few things to consider when contributing.
The following guidelines for contribution should be followed if you want to submit a pull request.

## How to prepare

* You need a [GitHub account](https://github.com/signup/free)
* Submit an [Assembly Bounty](https://assembly.com/mana/bounties) for your issue if there is not one yet.
	* Describe the issue and include steps to reproduce if it's a bug.
	* Ensure to mention the earliest version that you know is affected.
* If you are able and want to fix this, fork the repository on GitHub

## Make Changes

* In your forked repository, create a topic branch for your upcoming patch. (e.g. `feature--autoplay` or `bugfix--ios-crash`)
	* Usually this is based on the `develop` branch.
	* Create a branch based on `develop`; 
	```
	git branch fix/master/my_contribution develop
	``` 
	* then checkout the new branch with 
	```
	git	checkout fix/develop/my_contribution.
	```  
	* Please avoid working directly on the `master` or `develop` branch.
* Make sure you stick to the coding style that is used already.
* Squash your topic branch on `develop` in as few logical commits as possible.
   ```
   git rebase -i develop
   ```
* Check for unnecessary whitespace with `git diff --check` before committing.
* If possible, submit tests to your patch / new feature so it can be tested easily.
* Assure nothing is broken by running all the tests.
* If your changes are to the api be sure to reflect those changes with semver.
  * Read the [semver](http://semver.org/) spec
  * Learn how to use the [semver2](https://github.com/haf/semver) gem to increment semver.

## Submit Changes

* Push your changes to a topic branch in your fork of the repository.
* Open a pull request to the original repository and choose the right original branch you want to patch.
	_Advanced users may install the `hub` gem and use the [`hub pull-request` command](https://github.com/defunkt/hub#git-pull-request)._
* If not done in commit messages (which you really should do) please reference and update your issue with the code changes. But _please do not close the issue yourself_.
_Notice: You can [turn your previously filed issues into a pull-request here](http://issue2pr.herokuapp.com/)._
* Even if you have write access to the repository, do not directly push or merge pull-requests. Let another team member review your pull request and approve.
* If you have the authority to merge your a pull request ensure it passed the build test with Travis CI before merging the request.

# Additional Resources

* [General GitHub documentation](http://help.github.com/)
* [GitHub pull request documentation](http://help.github.com/send-pull-requests/)
* [Read the Issue Guidelines by @necolas](https://github.com/necolas/issue-guidelines/blob/master/CONTRIBUTING.md) for more details