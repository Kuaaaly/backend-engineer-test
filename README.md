## Run it

### Run via Docker
Running this code with Docker should simpler and faster. _Obviously, you should have Docker installed._
1. Build: `docker build -t kuaaaly/backend-engineer-test:0.1 https://github.com/Kuaaaly/backend-engineer-test.git`
1. Run: `docker run -it kuaaaly/backend-engineer-test:0.1 /bin/bash`
1. Once you are in you can run the code by typing :
```
cd /root/backend-engineer-test
./exercice.sh
```
The output should be the following:
```
{
  "freelance": {
    "id": 42,
    "computedSkills": [
      {
        "id": 400,
        "name": "Java",
        "durationInMonths": 40
      },
      {
        "id": 370,
        "name": "Javascript",
        "durationInMonths": 60
      },
      {
        "id": 241,
        "name": "React",
        "durationInMonths": 28
      },
      {
        "id": 270,
        "name": "Node.js",
        "durationInMonths": 28
      },
      {
        "id": 470,
        "name": "MySQL",
        "durationInMonths": 32
      }
    ]
  }
}
```

### Run via Linux / macOS (not tested)
The code requires:
- GNU bash, version 4.4.19
- jq-1.5-1

#### On macOS
```
brew install bash jq
```

#### On Ubuntu:
```
apt-get install git jq
```
You can then `git clone` this repo, `cd backend-engineer-test` and run it with `./exercise.sh`

## Criticize it

In progress...
