### Run via Docker
If you do not want to pollute your machine with packages you will not use, you can run the project via Docker.
_Obviously, you should have Docker installed for this part_
1. `git clone` the repo
1. `cd` in
1. Build the image: `docker build -t kuaaaly/backend-engineer-test:0.1 .`
1. Run the image & and start bash `docker run -it kuaaaly/backend-engineer-test:0.1 /bin/bash`
1. Once you are here you can run the exercise with `cd /root/` then `exercice.sh`

### Run via Unix (not tested)
You need to install `git` & `jq`.
- On macOS:
```
brew install git jq
```
- On Ubuntu:
```
apt-get install git jq
```
You can then `git clone` this repo then `cd backend-engineer-test` and run it with `./exercise.sh`
