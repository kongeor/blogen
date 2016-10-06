{:title "Automating the deployment of a cryogen blog to github pages"
 :layout :post
 :tags  ["automation" "cryogen"]}

I like static site generators, `clojure` and [github pages][ghpages] and for those
three reasons I happen to like [cryogen][cryogen].

The only "issue" I encountered when I started playing around with [cryogen][cryogen]
was [deployment][deployment]. I could make a script to push the generated content
to `kongeor.github.io` but that was no fun. This process had to be automated and
why not using continuous integration platform like [circleci][circleci]?

### Removing the _blog-prefix_

The first thing to do is to remove the `/blog` prefix. We want blog content to be in the root. 
We need to edit the `resources/templates/config.edn` and remove the `:blog-prefix`.

### Enabling `circleci`

[Circleci][circleci] is going to deploy our blog to "production". 

Create a `circle.yml` in the root of the project which should looks something like this:

```yml
deployment:
  production:
    branch: master
    commands:
      - ./deploy.sh

test:
  override:
    - lein run
```

We are overriding the default task which is to run tests to compile the blog which will be
thrown in `resources/public` (hacky! I know ...). Then the `deploy.sh` script is going to 
run which looks something like this:

```bash
git config --global user.email "${GIT_EMAIL}"
git config --global user.name "${GIT_NAME}"

rm -rf build
git clone git@github.com:kongeor/kongeor.github.io.git build
cp -rf resources/public/* build
cd build
git add *
git commit -a -m "build"
git push -u origin master
cd ..
```

We are configuring `git` because each build is a fresh new start. `GIT_EMAIL` and `GIT_NAME` are
pulled from the environmental variables which can be configured in `circleci`'s project settings.
Go to [dashboard][cidash] and click the _gear_ near the project.

Then we remove the `build` directory in case it exist - this is done mostly for convenience for
local testing. Then `foo`.github.io is cloned to `build` directory. This repo will have
only the built static site. The fresh compiled site is copied over it, and with the 
convenvience of `git` we add all the files which essentially will have only the diffences, and 
push the changes.

In order for this thing to work, [circleci][circleci]  needs to have permissions to push to that
repo.

### Setup SSH keys

You need to generate an [ssh key][genkeys]. Most probably you already have one, but I
don't think that it's a good idea to use that one, because you will need to add you private
key to [circleci].

Go to project settings under your `foo.github.io` repo and add your public key.

You need to go once again to project settings in [dashboard][cidash], 
find the `SSH Permissions` settings
and add you private `SSH` key there. Check [this][cikeys] guide.

### Test it!

You should be good to test this setup. Create a post, commit and push. [Circleci][circleci]
should fire up the build and when ready it should push the compiled blog to "production".


[jekyll]: https://jekyllrb.com/
[octopress]: http://octopress.org/
[ghpages]: https://pages.github.com/
[cryogen]: http://cryogenweb.org/
[circleci]: https://circleci.com/
[cidash]: https://circleci.com/dashboard
[genkeys]: https://help.github.com/articles/generating-an-ssh-key/
[cikeys]: https://circleci.com/docs/github-security-ssh-keys/
[post]: http://cryogenweb.org/docs/writing-posts.html
[deployment]: http://cryogenweb.org/docs/deploying-to-github-pages.html

