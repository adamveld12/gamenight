## Master Build and Publish Release `master_build_release.yml`

Builds, tags and pushes to semver tags to docker hub.


Only runs on push to mainline with an edit to [`versions.txt`](../../versions.txt).


## PR Build WIP `pr_build.yml`

Builds images for pull requests against mainline
